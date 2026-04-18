-- ============================================================
-- PART 1: Sales & Revenue Analysis
-- Author: Naciye Gul Aydogan
-- Purpose: Weekly management reporting support
-- ============================================================


-- 1.1 Monthly Revenue by Platform
-- Used for: Weekly management reports, platform performance comparison
SELECT 
    strftime('%Y-%m', order_date) AS month,
    platform,
    COUNT(order_id) AS total_orders,
    SUM(quantity) AS units_sold,
    ROUND(SUM(total_revenue), 2) AS gross_revenue,
    ROUND(SUM(commission), 2) AS total_commission,
    ROUND(SUM(net_revenue), 2) AS net_revenue,
    ROUND(AVG(total_revenue), 2) AS avg_order_value
FROM orders
WHERE order_status = 'Delivered'
GROUP BY month, platform
ORDER BY month DESC, net_revenue DESC;


-- 1.2 Top 10 Categories by Net Revenue
-- Used for: Inventory and procurement planning
SELECT 
    category,
    COUNT(order_id) AS total_orders,
    SUM(quantity) AS units_sold,
    ROUND(SUM(net_revenue), 2) AS net_revenue,
    ROUND(AVG(unit_price), 2) AS avg_unit_price,
    ROUND(SUM(net_revenue) * 100.0 / (SELECT SUM(net_revenue) FROM orders WHERE order_status = 'Delivered'), 1) AS revenue_share_pct
FROM orders
WHERE order_status = 'Delivered'
GROUP BY category
ORDER BY net_revenue DESC
LIMIT 10;


-- 1.3 Daily Order Volume Trend (Last 30 Days)
-- Used for: Identifying demand patterns, staffing decisions
SELECT 
    order_date,
    COUNT(order_id) AS order_count,
    ROUND(SUM(total_revenue), 2) AS daily_revenue,
    COUNT(DISTINCT platform) AS active_platforms
FROM orders
WHERE order_date >= DATE('2025-12-01')
GROUP BY order_date
ORDER BY order_date;


-- 1.4 Customer City Distribution - Top 15
-- Used for: Logistics planning, cargo partner evaluation
SELECT 
    customer_city,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(net_revenue), 2) AS net_revenue,
    ROUND(AVG(shipping_days), 1) AS avg_shipping_days,
    ROUND(COUNT(CASE WHEN order_status = 'Returned' THEN 1 END) * 100.0 / COUNT(*), 1) AS return_rate_pct
FROM orders
GROUP BY customer_city
ORDER BY total_orders DESC
LIMIT 15;


-- 1.5 Platform Commission Comparison
-- Used for: Pricing strategy, platform profitability assessment
SELECT 
    platform,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(total_revenue), 2) AS gross_revenue,
    ROUND(SUM(commission), 2) AS total_commission,
    ROUND(SUM(commission) * 100.0 / SUM(total_revenue), 2) AS effective_commission_rate,
    ROUND(SUM(net_revenue), 2) AS net_revenue,
    ROUND(SUM(net_revenue) / COUNT(order_id), 2) AS net_revenue_per_order
FROM orders
WHERE order_status = 'Delivered'
GROUP BY platform
ORDER BY net_revenue DESC;


-- 1.6 Month-over-Month Growth Rate
-- Used for: Trend analysis for management reporting
WITH monthly AS (
    SELECT 
        strftime('%Y-%m', order_date) AS month,
        ROUND(SUM(net_revenue), 2) AS net_revenue
    FROM orders
    WHERE order_status = 'Delivered'
    GROUP BY month
)
SELECT 
    month,
    net_revenue,
    LAG(net_revenue) OVER (ORDER BY month) AS prev_month_revenue,
    ROUND((net_revenue - LAG(net_revenue) OVER (ORDER BY month)) * 100.0 
          / LAG(net_revenue) OVER (ORDER BY month), 1) AS growth_rate_pct
FROM monthly
ORDER BY month;
