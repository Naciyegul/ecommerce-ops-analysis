# Power BI Dashboard Guide

## Overview
This guide explains how to build the **E-Commerce Operations Dashboard** in Power BI Desktop using the CSV files in the `/data` folder.

## Step 1: Import Data
1. Open Power BI Desktop
2. Click **Get Data → Text/CSV**
3. Import all 3 files:
   - `orders.csv`
   - `products.csv`
   - `supplier_performance.csv`

## Step 2: Data Model (Relationships)
In **Model View**, create these relationships:
- `orders.sku_id` → `products.sku_id` (Many to One)
- `orders.supplier_name` → `supplier_performance.supplier_name` (Many to Many, filter direction: Both)

## Step 3: Calculated Columns & Measures

### Calculated Columns (in orders table)
```
Order Month = FORMAT(orders[order_date], "YYYY-MM")
Is Returned = IF(orders[order_status] = "Returned", 1, 0)
Is Cancelled = IF(orders[order_status] = "Cancelled", 1, 0)
```

### DAX Measures
```
Total Orders = COUNTROWS(orders)
Total Revenue = SUM(orders[total_revenue])
Net Revenue = SUM(orders[net_revenue])
Return Rate % = DIVIDE(CALCULATE(COUNTROWS(orders), orders[order_status] = "Returned"), COUNTROWS(orders)) * 100
Avg Shipping Days = AVERAGE(orders[shipping_days])
Avg Order Value = DIVIDE([Total Revenue], [Total Orders])
```

## Step 4: Dashboard Pages

### Page 1: Sales Overview
| Visual | Fields | Type |
|--------|--------|------|
| KPI Cards (top row) | Total Orders, Net Revenue, Avg Order Value, Return Rate % | Card |
| Monthly Revenue Trend | Order Month (X), Net Revenue (Y), Platform (Legend) | Line Chart |
| Revenue by Category | Category, Net Revenue | Horizontal Bar Chart |
| Platform Comparison | Platform, Total Orders, Net Revenue | Clustered Bar |
| City Distribution | Customer City, Total Orders | Filled Map or Bar |

### Page 2: Process & Operations
| Visual | Fields | Type |
|--------|--------|------|
| KPI Cards | Return Rate %, Avg Shipping Days, Late Shipment % | Card |
| Return Rate Trend | Order Month (X), Return Rate % (Y) | Line Chart |
| Return Rate by Category | Category, Return Rate % | Bar Chart |
| Shipping Days by Platform | Platform, Avg Shipping Days | Clustered Bar |
| Order Status Funnel | Order Status, Count | Funnel Chart |

### Page 3: Supplier Scorecard
| Visual | Fields | Type |
|--------|--------|------|
| Supplier Table | Supplier Name, Avg OTD %, Defect Rate %, Quality Score, Lead Days | Table |
| Quality Score Comparison | Supplier Name, Quality Score | Bar Chart |
| CE/TSE Compliance | Supplier Name, CE Coverage %, TSE Coverage % | Stacked Bar |
| On-Time Delivery Trend | Month, Supplier Name (Legend), OTD % (Y) | Line Chart |

## Step 5: Formatting Tips
- Use a consistent color palette (e.g., dark blue #1F3864 as primary)
- Add slicers for: Platform, Category, Date Range
- Add a title bar on each page
- Use conditional formatting on Return Rate (red > 5%) and Quality Score (red < 3.5)

## Step 6: Export
- Save as `.pbix` file
- Export each page as PNG for the GitHub README
- Place screenshots in `/powerbi/screenshots/` folder
