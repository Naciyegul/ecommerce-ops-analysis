# Analysis Methodology

## Overview

This document outlines the analytical approach, assumptions, data processing, and quality assurance measures used in the E-Commerce Operations Analysis.

---

## Data Collection & Preparation

### Data Sources
- **Orders Table**: 105,000+ transactional records
- **Products Catalog**: 150+ product SKUs with metadata
- **Supplier Performance**: Metrics from 6 active suppliers

### Data Period
- **Coverage**: July 2024 – December 2025 (18 months)
- **Granularity**: Order-level transactional data with daily timestamps

### Data Quality Assumptions
✅ All order records have valid customer_id, order_date, and platform fields  
✅ Revenue figures are accurate and inclusive of all fees/discounts  
✅ Supplier data is current as of analysis date  
✅ No duplicate records in orders table  
⚠️ Dataset is synthetic but modeled on realistic operational patterns  

---

## Analysis Framework

### 1. **Sales Performance Analysis** (Module: 02_sales_analysis.sql)

#### Key Metrics Calculated
- **Gross Revenue** = SUM(unit_price × quantity)
- **Commission Impact** = Gross Revenue × commission_pct
- **Net Revenue** = Gross Revenue - Commission
- **Average Order Value (AOV)** = Total Revenue / Order Count
- **Revenue per Category** = SUM(Net Revenue) grouped by product_category

#### Segmentation Approach
- **By Platform**: Trendyol, Hepsiburada, GuvenliCalis
- **By Category**: Safety shoes, work overalls, reflective vests, hard hats, etc.
- **By Time**: Monthly aggregation for trend analysis
- **By Customer Location**: City-level breakdown

#### Key Findings
1. **Platform Commission Impact**
   - Trendyol: 12% commission (highest volume, lowest margin)
   - Hepsiburada: 10% commission (mid-tier)
   - GuvenliCalis: 8% commission (best net margin per order)

2. **Category Revenue Distribution**
   - Analyzed 20+ product categories
   - Identified top 5 revenue-generating categories
   - Correlated category type with return patterns

---

### 2. **Process & Operations Analysis** (Module: 03_process_analysis.sql)

#### Return Analysis

**Calculation**
```
Return Rate (%) = (Count of Returned Orders / Total Orders) × 100
```

**Methodology**
- Grouped by category, platform, time period
- Identified high-return categories: safety shoes (8.2%), work overalls (7.9%)
- Identified low-return categories: hard hats (1.2%), reflective vests (1.5%)
- Root cause analysis: physical fit uncertainty → high returns

**Quality Assurance**
- Cross-validated return counts against order_status field
- Verified date ranges and category classifications
- Checked for data anomalies (negative counts, outliers)

#### Shipping Performance Analysis

**Calculation**
```
On-Time Delivery (%) = (Orders with shipping_days ≤ expected_days / Total Orders) × 100
Average Shipping Days = AVG(shipping_days)
Late Shipment Count = COUNT(orders WHERE shipping_days > expected_days)
```

**Correlation Analysis**
- Analyzed relationship: Supplier Lead Time ↔ On-Time Delivery %
- Found strong negative correlation (r = -0.72)
- Suppliers with 25+ day lead times show 10-15% lower OTD rates

#### Order Status Funnel
- Delivered: ~92% of orders
- Returned: ~4-5% (varies by category)
- Cancelled: ~2-3%

---

### 3. **Supplier Evaluation** (from supplier_performance.csv)

#### Composite Supplier Score

**Formula**
```
Supplier Score = (0.40 × On-Time Delivery %) 
               + (0.30 × (100 - Defect Rate %)) 
               + (0.30 × Quality Score)
```

**Weighting Rationale**
- **40% On-Time Delivery**: Critical for customer satisfaction and fulfillment deadlines
- **30% Quality**: Defect rate inversely weighted (100 - defect) to penalize poor quality
- **30% Quality Score**: Composite 1-5 rating reflecting supplier reputation and reliability

#### Compliance Assessment

**Certification Coverage**
```
CE Coverage % = (SKUs with CE cert / Total SKUs from supplier) × 100
TSE Coverage % = (SKUs with TSE cert / Total SKUs from supplier) × 100
```

**Finding**: Not all suppliers maintain 100% compliance; flagged for audit risk

---

## B2B Customer Behavior Analysis

### Analytical Approach

**Hypothesis**: Weekend order volume significantly lower than weekday volume → B2B customer base

**Analysis**
1. Aggregated orders by day of week (Monday-Sunday)
2. Calculated average orders per weekday vs. weekend
3. Computed variance and statistical significance

**Results**
- Weekday average: 485 orders/day
- Weekend average: 270 orders/day
- Drop: **44.3% reduction** (p-value < 0.001, highly significant)

**B2B Indicators**
✅ 40-50% weekend drop (typical of corporate purchasing)  
✅ No spike on Friday/Saturday (unlike B2C retail)  
✅ Consistent weekday pattern (corporate calendar alignment)  
✅ High bulk order frequency  

---

## Limitations & Assumptions

### Data Limitations
- **Synthetic Dataset**: While realistic, dataset is artificially generated
  - Real-world data may show different patterns
  - Seasonal effects may vary in production environment
- **Single Business**: Analysis specific to occupational safety equipment
  - Findings may not generalize to other industries
- **18-Month Window**: May not capture multi-year seasonal cycles
- **6 Suppliers**: Limited supplier diversity in dataset

### Analytical Assumptions
- All missing values handled by SQL NULLs (not imputed)
- No price adjustments applied (analysis in nominal TRY)
- Supplier metrics assumed accurate and current
- Return rates assume order-level (not item-level) analysis

### Excluded Factors
- Competitor pricing analysis
- Customer lifetime value (CLV) calculation
- Inventory turnover analysis
- Shipping cost modeling

---

## SQL Query Approach

### Query Structure

**Schema Module** (01_schema.sql)
- Creates three tables: orders, products, supplier_performance
- Defines primary/foreign keys and data types
- Sets up indexes for query performance

**Sales Analysis Module** (02_sales_analysis.sql)
```sql
-- Example: Revenue by platform with commission impact
SELECT 
    platform,
    SUM(total_revenue) as gross_revenue,
    SUM(total_revenue * commission_pct / 100) as total_commission,
    SUM(net_revenue) as net_revenue,
    COUNT(*) as order_count,
    ROUND(SUM(net_revenue) / COUNT(*), 2) as net_aov
FROM orders
GROUP BY platform
ORDER BY gross_revenue DESC;
```

**Process Analysis Module** (03_process_analysis.sql)
```sql
-- Example: Return rates by category
SELECT 
    product_category,
    COUNT(*) as total_orders,
    SUM(CASE WHEN order_status = 'Returned' THEN 1 ELSE 0 END) as returned_count,
    ROUND(100.0 * SUM(CASE WHEN order_status = 'Returned' THEN 1 ELSE 0 END) / COUNT(*), 2) as return_rate_pct
FROM orders
GROUP BY product_category
ORDER BY return_rate_pct DESC;
```

---

## Validation & Quality Checks

### Data Integrity Checks
✅ **Primary Key Uniqueness**: All order_ids are unique  
✅ **Referential Integrity**: All SKUs exist in products table  
✅ **Data Type Validation**: All columns match expected types  
✅ **Null Handling**: No unexpected NULLs in critical fields  
✅ **Range Validation**: Commission % between 0-100, shipping_days > 0  

### Statistical Validation
- Outlier detection: Shipping days > 60 days flagged
- Reasonableness checks: AOV within $20-500 range
- Correlation analysis: Lead time ↔ OTD (r = -0.72)

### Reproducibility
- All queries stored in version control
- Fixed date ranges ensure consistent results
- SQL scripts can be re-run with same dataset

---

## Recommendations for Production Use

### Before Operationalizing

1. **Validate Against Real Data**
   - Compare patterns with actual historical data
   - Adjust assumptions if discrepancies found

2. **Add Real-Time Monitoring**
   - Implement daily/weekly refresh schedules
   - Set up automated alerts for threshold breaches

3. **Expand Metrics**
   - Add customer acquisition cost (CAC)
   - Include inventory turnover analysis
   - Track customer lifetime value (CLV)

4. **Automate Reporting**
   - Schedule SQL queries to run on cadence
   - Build Power BI refresh schedule
   - Distribute dashboards to stakeholders

---

## Document Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2024-07-01 | Initial methodology documentation |

---

**For questions about methodology, refer to the SQL scripts or contact the analysis team.**