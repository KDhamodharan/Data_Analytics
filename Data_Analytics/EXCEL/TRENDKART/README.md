# TrendMart – Profitability Leakage Analysis Dashboard

> **Excel-based business intelligence project** focused on understanding where sales activity is translating into profit—and where potential profitability leakage may require management attention.

## Project Dashboard

The dashboard below is the supplied TrendMart Excel dashboard snapshot.

![TrendMart Dashboard](assets/DASHBOARD.jpeg)

## Project Overview

TrendMart is a fashion retail enterprise operating across multiple products, categories, stores, regions, customers, and sales channels. The purpose of this project is to build an interactive Microsoft Excel dashboard that helps management assess overall commercial performance and investigate areas where high sales may not be delivering proportionate profitability.

The project follows the supplied **TrendMart Business Requirements Document (BRD), Version 1.0**. Its central business question is:

**Where is TrendMart losing potential profitability despite generating sales, and which business areas require management attention?**

## Business Objectives

- Monitor total sales, cost, profit, profit margin, transactions, and quantity sold.
- Identify high-sales products or segments with comparatively weak profitability.
- Examine discount levels alongside profitability.
- Review return patterns that may affect commercial performance.
- Compare store, regional, product, customer-segment, and sales-channel performance.
- Highlight business segments that may require further management investigation.
- Present evidence-based findings and recommendations.

## Dashboard Highlights

The supplied dashboard snapshot contains the following KPI cards and analysis views.

### Executive KPI cards

| KPI | Value shown in dashboard |
|---|---:|
| Total Sales | ₹92,27,179.96 |
| Total Profit | ₹18,04,518.54 |
| Profit Margin % | 19.56% |
| Total Cost | ₹65,96,441.12 |
| Total Orders | 3,000 |
| Total Quantity | 6,118 |
| Returns Rate % | 4.87% |

*Values above are transcribed from the supplied dashboard image. Refresh the workbook and validate KPI definitions before using them for formal reporting.*

### Analysis views

- **Monthly Wise Trend** – monthly sales trend.
- **Sales by Membership** – sales mix across Platinum, Gold, Regular, and Silver members.
- **Sales by State** – state-level sales comparison.
- **Sales by Payment Mode** – payment-method mix.
- **Top 10 Stores by Sales** – store ranking by sales.
- **Top 10 Products by Sales** – product ranking by sales.
- **Category Sales & Profit** – comparison of sales and profit by category.
- **Sales by Channel** – Online versus Offline contribution.
- **Return Analysis** – returned versus non-returned mix.
- **High Sales – Low Profits Products** – products with high sales and comparatively low profit.
- **Top 5 Brands by Profit Margin** – brand-level profitability comparison.
- **Interactive filters** – Region and Membership slicers are visible in the dashboard.

## Data Sources and Workbook Structure

The supplied Excel files contain the following business domains:

| Dataset / worksheet | Approximate records in BRD | Purpose |
|---|---:|---|
| Sales Transactions | 3,000 | Sales, cost, profit, discounts, tax/GST, returns, payment mode, channel, and quantity |
| Customers | 850 | Customer profile, geography, and membership |
| Products | 250 | Product hierarchy, brand, size, color, material, and pricing |
| Stores | 120 | Store location, region, type, target, manager, and status |
| Employees | 300 | Employee and store association |
| Suppliers | 90 | Supplier context, rating, lead time, and status |
| Data Quality Log | Documented issues | Data validation and cleaning reference |

### Files supplied

- `TrendKart Project.xlsx` – main analysis workbook, including the dashboard, PivotTable/supporting analysis sheets, calculations, source tables, and Data Quality Log.
- `TrendKart_Data_Cleaning.xlsx` – data-cleaning workbook containing the cleaned/prepared versions of the business-domain sheets and the Data Quality Log.
- `TrendMart_BRD.docx` – Business Requirements Document used to define the project scope and requirements.
- `DASHBOARD.jpeg` – supplied dashboard image used in this README.

> **Naming note:** The BRD and dashboard use the name **TrendMart**, while the two supplied Excel workbooks use the prefix **TrendKart**. This README retains TrendMart as the project name to match the BRD and dashboard.

## Data Preparation and Quality Checks

The BRD identifies data preparation as a mandatory project activity. The supplied Data Quality Log records issues such as:

- Duplicate invoice / transaction identifiers.
- Blank customer, product, or employee identifiers.
- Mixed date formats and numeric values stored as text.
- Leading/trailing spaces and inconsistent casing or status values.
- Invalid or inconsistent customer attributes.
- Duplicate product/customer attributes.
- Negative-profit and zero-quantity records requiring business-context review.

Cleaning decisions should be documented and should preserve valid business events. Negative-profit and zero-quantity records should not be removed automatically. The cleaning workbook is provided as a separate prepared-data artifact; validate its transformations against the original data and Data Quality Log before relying on the results.

## KPI Framework

The BRD identifies these measures for the analysis:

| KPI / measure | Business purpose |
|---|---|
| Total Sales | Measure total commercial revenue / sales amount |
| Total Cost | Measure cost associated with transactions |
| Total Profit | Measure overall profitability |
| Profit Margin % | Evaluate profit relative to sales using the agreed calculation |
| Total Transactions | Measure transaction volume after validating transaction identifiers |
| Total Quantity Sold | Measure product volume sold |
| Average Transaction Value | Measure average sales value per transaction |
| Total Discount | Measure discount value applied |
| Average Discount % | Compare discount intensity across business segments |
| Return Rate | Measure the proportion of transactions or records affected by returns, based on the available definition |
| Store Performance | Compare store sales, profit, margin, and targets where period alignment is valid |
| Product Profitability | Compare product revenue and profit contribution |
| Channel Performance | Compare commercial performance across sales channels |

**Calculation note:** Confirm the exact formula and denominator used for each KPI in the workbook before comparing results. In particular, validate the transaction identifier logic and the Return Status definition used for Return Rate.

## Suggested Workflow

1. Review the BRD, source workbook, and Data Quality Log.
2. Profile the source tables and investigate documented quality issues.
3. Prepare and standardize data while preserving business meaning.
4. Validate common identifiers and relationships across datasets.
5. Create and validate calculated fields and KPIs.
6. Build PivotTables or equivalent supporting analysis.
7. Use the dashboard to investigate sales, profitability, products, stores, regions, customers, and channels.
8. Validate findings and document assumptions, limitations, and recommendations.

## Tools and Techniques

- **Microsoft Excel**
- Data cleaning and standardization
- Excel formulas and calculated fields
- PivotTables / supporting analytical summaries
- Interactive dashboard filters (slicers)
- KPI reporting and comparative analysis

## Scope and Limitations

### In scope

- Data cleaning and preparation.
- KPI calculations and validation.
- Pivot-based or equivalent analysis.
- Interactive management dashboard.
- Business insights and recommendations supported by the data.

### Out of scope / cautions

- Predictive forecasting unless separately requested.
- Unsupported causal conclusions.
- Changing source records without documented data-quality justification.
- Treating an observed relationship as proof of a business cause.
- Supplier impact on profitability unless transactional procurement or inventory data supports the claim.

Additional BRD assumptions to retain:

- Store monthly targets must be aligned to the transaction period before target-achievement conclusions are made.
- Negative profit may represent genuine loss-making transactions.
- Return Rate depends on the precise definition available in Return Status.
- Analysis is limited to information available in the supplied datasets.

## Expected Deliverables

- Prepared / cleaned data with documented transformations.
- Excel analysis sheets, formulas, and PivotTables.
- Interactive management dashboard.
- KPI definitions.
- Data quality summary.
- Evidence-based business insights.
- Practical recommendations or investigation priorities.
- Project methodology, assumptions, and limitations.

## Repository Contents

When sharing the project, keep the dashboard image in the `assets` folder so that the image above renders correctly in GitHub or other Markdown viewers.

```text
.
├── README.md
└── assets/
    └── DASHBOARD.jpeg
```

The Excel workbooks and BRD can be added alongside the README when distributing the complete project.

---
**Project:** TrendMart Profitability Leakage Analysis  
**Platform:** Microsoft Excel  
**Reference:** TrendMart Business Requirements Document, Version 1.0
