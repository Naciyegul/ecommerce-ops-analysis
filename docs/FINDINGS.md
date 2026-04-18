# Key Findings & Recommendations

## Executive Summary

This analysis covers 105,000+ orders across Trendyol, Hepsiburada, and GuvenliCalis marketplaces over an 18-month period (July 2024 – December 2025) for an occupational safety equipment business managing 150+ SKUs with 6 active suppliers.

---

## Finding 1: Platform Profitability Varies After Commission

**Observation:** Trendyol handles the highest volume (~50%) but charges 12% commission. Hepsiburada at 10% and GuvenliCalis at 8% offer better net margins per order.

**Recommendation:** Evaluate whether shifting marketing spend toward lower-commission platforms could improve overall net revenue, especially for high-volume, low-margin product categories.

---

## Finding 2: Return Rates Cluster Around Specific Categories

**Observation:** Categories with physical fit requirements (safety shoes, work overalls) show return rates above the overall average. Lower-risk categories (reflective vests, hard hats) have significantly lower return rates.

**Recommendation:** Prioritize adding detailed size guides, product dimension tables, and comparison photos to high-return-rate product listings. This is a process change that does not require additional inventory investment.

---

## Finding 3: Supplier Compliance Gaps Create Audit Risk

**Observation:** Not all SKUs from every supplier carry both CE and TSE certifications. This creates potential compliance gaps during audits.

**Recommendation:** Generate a monthly compliance gap report and share with the Certification department. Flag non-compliant SKUs for review before the next audit cycle.

---

## Finding 4: Shipping Delays Correlate with Supplier Lead Times

**Observation:** Suppliers with longer average lead times also show lower on-time delivery percentages, creating a compounding delay effect on the order fulfillment process.

**Recommendation:** Include lead time as a weighted factor in supplier evaluation scorecard. Consider buffer stock for products from high-lead-time suppliers during peak demand periods.

---

## Finding 5: Weekend Volume Drop Suggests B2B Customer Base

**Observation:** Order volumes drop 40-50% on weekends compared to weekdays, which is a pattern typical of B2B purchasing behavior rather than consumer retail.

**Recommendation:** If the customer base is primarily B2B, consider adjusting pricing strategy, bulk discount tiers, and customer communication to align with corporate procurement cycles (monthly/quarterly).

---

## Methodology Notes

- All analysis performed using SQL (SQLite) and Power BI
- Dataset is synthetic but modeled on realistic operational patterns
- Composite supplier score weighted as: 40% on-time delivery, 30% defect rate (inverted), 30% quality score
- Return rate calculated as: (Returned orders / Total orders) × 100
