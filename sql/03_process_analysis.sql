-- ============================================================
-- PART 2: Process & Operations Analysis
-- Author: Naciye Gul Aydogan
-- Purpose: Workflow bottleneck identification & process improvement
-- ============================================================


-- 2.1 Return & Cancellation Analysis by Category
-- Used for: Identifying product quality issues, process gaps
SELECT 
    category,
    COUNT(order_id) AS total_orders,
    COUNT(CASE WHEN order_status = 'Returned' THEN 1 END) AS returns,
    COUNT(CASE WHEN order_status = 'Cancelled' THEN 1 END) AS cancellations,
    ROUND(COUNT(CASE WHEN order_status = 'Returned' THEN 1 END) * 100.0 / COUNT(*), 2) AS return_rate_pct,
    ROUND(COUNT(CASE WHEN order_status = 'Cancelled' THEN 1 END) * 100.0 / COUNT(*), 2) AS cancel_rate_pct,
    ROUND(SUM(CASE WHEN order_status = 'Returned' THEN total_revenue ELSE 0 END), 2) AS revenue_lost_returns
FROM orders
GROUP BY category
ORDER BY return_rate_pct DESC;


-- 2.2 Shipping Performance Analysis by Platform
-- Used for: Cargo partner evaluation, SLA monitoring
SELECT 
    platform,
    COUNT(order_id) AS delivered_orders,
    ROUND(AVG(shipping_days), 1) AS avg_shipping_days,
    MIN(shipping_days) AS min_days,
    MAX(shipping_days) AS max_days,
    COUNT(CASE WHEN shipping_days > 3 THEN 1 END) AS late_shipments,
    ROUND(COUNT(CASE WHEN shipping_days > 3 THEN 1 END) * 100.0 / COUNT(*), 1) AS late_pct
FROM orders
WHERE order_status = 'Delivered' AND shipping_days IS NOT NULL
GROUP BY platform
ORDER BY avg_shipping_days;


-- 2.3 Supplier Performance Scorecard
-- Used for: Supplier evaluation, procurement decisions
SELECT 
    supplier_name,
    supplier_city,
    ROUND(AVG(on_time_delivery_pct) * 100, 1) AS avg_otd_pct,
    ROUND(AVG(defect_rate_pct) * 100, 2) AS avg_defect_pct,
    ROUND(AVG(avg_lead_days), 1) AS avg_lead_days,
    ROUND(AVG(quality_score), 1) AS avg_quality_score,
    SUM(orders_fulfilled) AS total_orders_fulfilled,
    -- Simple composite score: higher is better
    ROUND(
        (AVG(on_time_delivery_pct) * 40) + 
        ((1 - AVG(defect_rate_pct)) * 30) + 
        (AVG(quality_score) / 5 * 30), 1
    ) AS composite_score
FROM supplier_performance
GROUP BY supplier_name, supplier_city
ORDER BY composite_score DESC;


-- 2.4 Monthly Return Trend (Process Improvement Tracking)
-- Used for: Measuring impact of workflow changes over time
SELECT 
    strftime('%Y-%m', order_date) AS month,
    COUNT(order_id) AS total_orders,
    COUNT(CASE WHEN order_status = 'Returned' THEN 1 END) AS returns,
    ROUND(COUNT(CASE WHEN order_status = 'Returned' THEN 1 END) * 100.0 / COUNT(*), 2) AS return_rate_pct,
    COUNT(CASE WHEN order_status = 'Cancelled' THEN 1 END) AS cancellations,
    ROUND(SUM(CASE WHEN order_status IN ('Returned', 'Cancelled') THEN total_revenue ELSE 0 END), 2) AS revenue_at_risk
FROM orders
GROUP BY month
ORDER BY month;


-- 2.5 Supplier Compliance Gap Analysis
-- Used for: CE/TSE audit readiness, certification tracking
SELECT 
    p.supplier_name,
    COUNT(p.sku_id) AS total_skus,
    COUNT(CASE WHEN p.has_ce = 'Yes' THEN 1 END) AS ce_certified,
    COUNT(CASE WHEN p.has_tse = 'Yes' THEN 1 END) AS tse_certified,
    ROUND(COUNT(CASE WHEN p.has_ce = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 1) AS ce_coverage_pct,
    ROUND(COUNT(CASE WHEN p.has_tse = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 1) AS tse_coverage_pct,
    COUNT(CASE WHEN p.has_ce = 'No' OR p.has_tse = 'No' THEN 1 END) AS compliance_gaps
FROM products p
GROUP BY p.supplier_name
ORDER BY compliance_gaps DESC;


-- 2.6 Order Fulfillment Funnel
-- Used for: End-to-end process visibility, bottleneck identification
SELECT 
    order_status,
    COUNT(order_id) AS order_count,
    ROUND(COUNT(order_id) * 100.0 / (SELECT COUNT(*) FROM orders), 1) AS pct_of_total,
    ROUND(SUM(total_revenue), 2) AS total_revenue,
    ROUND(AVG(quantity), 1) AS avg_quantity
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;


-- 2.7 High-Risk Products: High Return Rate + Low Compliance
-- Used for: Priority action list for quality & procurement team
SELECT 
    p.sku_id,
    p.product_name,
    p.category,
    p.supplier_name,
    p.has_ce,
    p.has_tse,
    COUNT(o.order_id) AS total_orders,
    COUNT(CASE WHEN o.order_status = 'Returned' THEN 1 END) AS returns,
    ROUND(COUNT(CASE WHEN o.order_status = 'Returned' THEN 1 END) * 100.0 / COUNT(*), 2) AS return_rate_pct
FROM products p
JOIN orders o ON p.sku_id = o.sku_id
GROUP BY p.sku_id
HAVING return_rate_pct > 4.0 OR p.has_ce = 'No' OR p.has_tse = 'No'
ORDER BY return_rate_pct DESC
LIMIT 20;
