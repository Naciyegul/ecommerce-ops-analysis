# E-Commerce Operations Analysis
**SQL • Power BI • Multi-Platform Marketplace**

> A data analysis portfolio project covering sales performance, process bottlenecks, and supplier evaluation for an occupational safety equipment business operating across Trendyol, Hepsiburada, and GuvenliCalis.

---

## Dashboard Preview

### 📊 Sales Overview
![Sales Overview](powerbi/Sales%20Overview.png)

### ⚙️ Process & Operations
![Process & Operations](powerbi/Process%20%26%20Operations.png)

### 🏭 Supplier Scorecard
![Supplier Scorecard](powerbi/Supplier%20Scorecard.png)

---

## Business Context

A mid-size occupational safety equipment company processes **200+ daily orders** across three online marketplaces, managing **150+ SKUs** and coordinating with **6 departments** (Procurement, Sales, Accounting, Product Management, Import, Certification).

**Key business questions this analysis answers:**
- Which platforms and categories drive the most net revenue?
- Where are the bottlenecks in order fulfillment and returns?
- Which suppliers perform best on quality, compliance, and delivery?
- What data supports better pricing, inventory, and procurement decisions?

---

## Key Findings

| Area | Finding |
|------|---------|
| 📦 Platform | Trendyol drives ~50% of volume but commission structure affects net revenue per order |
| 💰 Category | Safety shoes and fall protection equipment generate the highest average order values |
| 🔄 Returns | Categories with fit requirements (shoes, overalls) show highest return rates |
| 🚚 Shipping | Average delivery time is ~3 days across platforms |
| 🏭 Suppliers | On-time delivery ranges from 71% to 89% — clear performance tiers exist |

---

## Project Structure
ecommerce-ops-analysis/
├── data/
│   ├── orders.csv                    # 105K+ orders across 3 platforms
│   ├── products.csv                  # 104 SKUs with CE/TSE compliance flags
│   └── supplier_performance.csv      # 18 months of monthly supplier KPIs
├── sql/
│   ├── 01_schema.sql                 # Table definitions
│   ├── 02_sales_analysis.sql         # Revenue, platform, category queries
│   └── 03_process_analysis.sql       # Returns, shipping, supplier evaluation
├── powerbi/
│   ├── DASHBOARD_GUIDE.md            # Step-by-step build guide
│   └── (screenshots)                 # Dashboard page exports
└── docs/
└── FINDINGS.md                   # Full findings and recommendations

---

## Tools Used

| Tool | Purpose |
|------|---------|
| **SQL (SQLite)** | Data querying, joins, aggregations, window functions |
| **Power BI** | 3-page interactive dashboard |
| **DB Browser for SQLite** | Local query execution |
| **MS Excel** | Initial data exploration |

---

## How to Run the SQL Queries

1. Download [DB Browser for SQLite](https://sqlitebrowser.org/) — free
2. Create a new database
3. Import the 3 CSV files from `/data` as tables
4. Run `sql/01_schema.sql` to verify structure
5. Execute queries from `sql/02_sales_analysis.sql` and `sql/03_process_analysis.sql`

---

## About

This project was created as a portfolio case study to demonstrate practical business analysis skills: data querying, operational reporting, process gap identification, and data-driven recommendations.

**Author:** Naciye Gul Aydogan
**LinkedIn:** [linkedin.com/in/naciyegulaydogan](https://linkedin.com/in/naciyegulaydogan)

---

*Dataset is synthetic but modeled on realistic operational patterns from Turkish e-commerce marketplace operations.*
