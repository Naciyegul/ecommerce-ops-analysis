# E-Commerce Operations Analysis: Sales Performance & Process Improvement

> A data-driven case study analyzing e-commerce operations across Trendyol, Hepsiburada, and GuvenliCalis — covering sales performance, order fulfillment, return analysis, and supplier evaluation for an occupational safety equipment business.

## Business Context

A mid-size occupational safety equipment company operates across three online marketplaces, managing **150+ product SKUs** and processing **200+ orders per day**. This analysis covers **105,000+ orders** over an **18-month period** (July 2024 – December 2025).

The operations team coordinates with 6 departments (Procurement, Sales, Accounting, Product Management, Import, Certification) to ensure smooth order fulfillment, compliance, and supplier management.

**Business questions this analysis answers:**

1. Which platforms and categories drive the most revenue?
2. Where are the bottlenecks in the order fulfillment process?
3. Which suppliers have compliance gaps or quality issues?
4. How do return rates vary across categories, and what causes them?
5. What data supports better pricing, inventory, and procurement decisions?

## Project Structure

```
ecommerce-ops-analysis/
├── README.md
├── data/
│   ├── orders.csv              # 105K+ orders across 3 platforms
│   ├── products.csv            # 104 SKUs with compliance flags
│   └── supplier_performance.csv # Monthly supplier KPIs
├── sql/
│   ├── 01_schema.sql           # Table definitions
│   ├── 02_sales_analysis.sql   # Revenue, platform, category analysis
│   └── 03_process_analysis.sql # Returns, shipping, supplier evaluation
├── powerbi/
│   └── DASHBOARD_GUIDE.md      # Step-by-step Power BI build guide
└── docs/
    └── FINDINGS.md             # Key findings and recommendations
```

## Tools Used

| Tool | Purpose |
|------|---------|
| **SQL (SQLite)** | Data querying, joins, aggregations, window functions |
| **Power BI** | Interactive dashboards and visual reporting |
| **DB Browser for SQLite** | Local database management and query execution |
| **Excel** | Initial data exploration and quick pivot analysis |

## How to Run

### SQL Queries
1. Download and install [DB Browser for SQLite](https://sqlitebrowser.org/)
2. Create a new database
3. Import the 3 CSV files from `/data` as tables
4. Run `sql/01_schema.sql` to verify table structure
5. Execute queries from `sql/02_sales_analysis.sql` and `sql/03_process_analysis.sql`

### Power BI Dashboard
1. Open Power BI Desktop
2. Follow the step-by-step guide in `powerbi/DASHBOARD_GUIDE.md`
3. Import CSV files, create relationships, and build the 3-page dashboard

## Key Findings
## Dashboard Preview

### Sales Overview
![Sales Overview](powerbi/Sales%20Overview.png)

### Process & Operations
![Process & Operations](powerbi/Process%20%26%20Operations.png)

### Supplier Scorecard
![Supplier Scorecard](powerbi/Supplier%20Scorecard.png)

### Sales Performance
- **Trendyol** drives approximately 50% of order volume but platform commission rates vary — net revenue per order analysis reveals which platform is most profitable after fees.
- **Guvenlik Ayakkabisi** (safety shoes) and **Dusme Onleyici** (fall protection) are high-value categories with the highest average order values.
- Weekend order volume drops ~40-50% compared to weekdays, suggesting B2B-heavy customer base.

### Process & Operations
- **Return rates** vary significantly by category — categories with higher price points (safety shoes, work overalls) show higher return rates, likely driven by sizing issues.
- **Shipping performance** averages 1-5 days across platforms, with late shipments (>3 days) representing a measurable portion of deliveries.
- The **order fulfillment funnel** shows that Returns + Cancellations combined represent the primary revenue leakage point.

### Supplier Evaluation
- A **composite supplier scorecard** (weighted: 40% on-time delivery, 30% defect rate, 30% quality score) reveals clear performance tiers across 6 suppliers.
- **CE/TSE compliance gaps** exist — some suppliers have SKUs lacking full certification, creating audit risk.
- Suppliers with longer lead times correlate with lower on-time delivery rates, supporting the case for closer procurement coordination.

## Recommendations

1. **Focus return reduction efforts** on high-value categories (safety shoes, work overalls) — adding size guides or product specification detail to marketplace listings could reduce size-related returns.
2. **Review low-compliance suppliers** — products without CE or TSE certification should be flagged and escalated to the certification department.
3. **Evaluate platform profitability** beyond gross revenue — commission structure differences mean the highest-volume platform is not necessarily the most profitable.
4. **Optimize shipping workflows** — late shipment analysis by platform and city can guide cargo partner negotiations.

## About

This project was created as a portfolio case study to demonstrate practical business analysis skills — data querying, operational reporting, process gap identification, and data-driven recommendations — applied to a real-world e-commerce operations context.

---

*Dataset is synthetic but modeled on realistic operational patterns from Turkish e-commerce marketplace operations.*
# E-Commerce Operations Analysis: Sales Performance & Process Improvement

> A data-driven case study analyzing e-commerce operations across Trendyol, Hepsiburada, and GuvenliCalis — covering sales performance, order fulfillment, return analysis, and supplier evaluation for an occupational safety equipment business.

## Business Context

A mid-size occupational safety equipment company operates across three online marketplaces, managing **150+ product SKUs** and processing **200+ orders per day**. This analysis covers **105,000+ orders** over an **18-month period** (July 2024 – December 2025).

The operations team coordinates with 6 departments (Procurement, Sales, Accounting, Product Management, Import, Certification) to ensure smooth order fulfillment, compliance, and supplier management.

**Business questions this analysis answers:**

1. Which platforms and categories drive the most revenue?
2. Where are the bottlenecks in the order fulfillment process?
3. Which suppliers have compliance gaps or quality issues?
4. How do return rates vary across categories, and what causes them?
5. What data supports better pricing, inventory, and procurement decisions?

## Project Structure

```
ecommerce-ops-analysis/
├── README.md
├── data/
│   ├── orders.csv              # 105K+ orders across 3 platforms
│   ├── products.csv            # 104 SKUs with compliance flags
│   └── supplier_performance.csv # Monthly supplier KPIs
├── sql/
│   ├── 01_schema.sql           # Table definitions
│   ├── 02_sales_analysis.sql   # Revenue, platform, category analysis
│   └── 03_process_analysis.sql # Returns, shipping, supplier evaluation
├── powerbi/
│   └── DASHBOARD_GUIDE.md      # Step-by-step Power BI build guide
└── docs/
    └── FINDINGS.md             # Key findings and recommendations
```

## Tools Used

| Tool | Purpose |
|------|---------|
| **SQL (SQLite)** | Data querying, joins, aggregations, window functions |
| **Power BI** | Interactive dashboards and visual reporting |
| **DB Browser for SQLite** | Local database management and query execution |
| **Excel** | Initial data exploration and quick pivot analysis |

## How to Run

### SQL Queries
1. Download and install [DB Browser for SQLite](https://sqlitebrowser.org/)
2. Create a new database
3. Import the 3 CSV files from `/data` as tables
4. Run `sql/01_schema.sql` to verify table structure
5. Execute queries from `sql/02_sales_analysis.sql` and `sql/03_process_analysis.sql`

### Power BI Dashboard
1. Open Power BI Desktop
2. Follow the step-by-step guide in `powerbi/DASHBOARD_GUIDE.md`
3. Import CSV files, create relationships, and build the 3-page dashboard

## Key Findings

### Sales Performance
- **Trendyol** drives approximately 50% of order volume but platform commission rates vary — net revenue per order analysis reveals which platform is most profitable after fees.
- **Guvenlik Ayakkabisi** (safety shoes) and **Dusme Onleyici** (fall protection) are high-value categories with the highest average order values.
- Weekend order volume drops ~40-50% compared to weekdays, suggesting B2B-heavy customer base.

### Process & Operations
- **Return rates** vary significantly by category — categories with higher price points (safety shoes, work overalls) show higher return rates, likely driven by sizing issues.
- **Shipping performance** averages 1-5 days across platforms, with late shipments (>3 days) representing a measurable portion of deliveries.
- The **order fulfillment funnel** shows that Returns + Cancellations combined represent the primary revenue leakage point.

### Supplier Evaluation
- A **composite supplier scorecard** (weighted: 40% on-time delivery, 30% defect rate, 30% quality score) reveals clear performance tiers across 6 suppliers.
- **CE/TSE compliance gaps** exist — some suppliers have SKUs lacking full certification, creating audit risk.
- Suppliers with longer lead times correlate with lower on-time delivery rates, supporting the case for closer procurement coordination.

## Recommendations

1. **Focus return reduction efforts** on high-value categories (safety shoes, work overalls) — adding size guides or product specification detail to marketplace listings could reduce size-related returns.
2. **Review low-compliance suppliers** — products without CE or TSE certification should be flagged and escalated to the certification department.
3. **Evaluate platform profitability** beyond gross revenue — commission structure differences mean the highest-volume platform is not necessarily the most profitable.
4. **Optimize shipping workflows** — late shipment analysis by platform and city can guide cargo partner negotiations.

## About

This project was created as a portfolio case study to demonstrate practical business analysis skills — data querying, operational reporting, process gap identification, and data-driven recommendations — applied to a real-world e-commerce operations context.

**Author:** Naciye Gul Aydogan  
**LinkedIn:** [linkedin.com/in/naciyegulaydogan](https://linkedin.com/in/naciyegulaydogan)

---

*Dataset is synthetic but modeled on realistic operational patterns from Turkish e-commerce marketplace operations.*
#   e c o m m e r c e - o p s - a n a l y s i s 
 
 
