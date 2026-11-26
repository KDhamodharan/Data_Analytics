# Novitech Manufacturing Analytics – Power BI Project

## Project Overview

Novitech Manufacturing Analytics is an end-to-end business intelligence project developed in Microsoft Power BI. The project is intended to give management a consolidated view of manufacturing performance, product quality, operational efficiency, finance and cost exposure, procurement, and supply-chain risk.

The project follows the **Novitech Manufacturing Revised Business Requirements Document (BRD), Version 2.0 – Finance Included**. Its central business question is:

> Where is Novitech Manufacturing losing operational efficiency and carrying financial exposure, and what production or supply-chain factors are contributing to those risks?

## Dashboard Preview

![Novitech Manufacturing Production Performance Dashboard](dashboard/NOVA_TECH_DASHBOARD.jpeg)

*Dashboard screenshot provided with the project files.*

## Key KPIs Shown in the Dashboard Screenshot

| KPI | Value shown |
|---|---:|
| Total Production | 10,296,992 |
| Defect Rate | 1.71% |
| Production Change | -16.92% |
| Supplier Delay Rate | 10.69% |

*Values are transcribed from the supplied dashboard screenshot. Refer to the Power BI report for interactive filtering and the underlying measure definitions.*

## Dashboard Features Visible in the Preview

- **Slicers:** Plant name, product name, supplier name, and period.
- **Production trend:** Monthly total production.
- **Plant comparison:** Production comparison for May 2025 and June 2025 across plants.
- **Downtime comparison:** Monthly downtime comparison.
- **Product quality:** Defect-rate comparison by product.
- **Supplier performance:** Purchase-order delay-rate comparison by supplier.

## Business Objectives

The revised BRD defines five major business domains:

1. **Production:** Understand output and production activity.
2. **Quality:** Identify defective production and quality-loss areas.
3. **Operations:** Analyze downtime, energy, operators, and shifts.
4. **Finance & Cost:** Understand cost exposure, procurement spending, product cost, and defect-related financial exposure.
5. **Supply Chain:** Analyze material dependencies, purchase orders, suppliers, lead time, and delays.

## Business Problems Addressed

The BRD identifies the following analytical requirements:

- Compare plant production output, defects, downtime, energy, and cost exposure.
- Measure production trends by date, plant, product, operator, and shift.
- Identify products and plants with high defective quantities and defect rates.
- Investigate downtime by plant, product, operator, and shift.
- Analyze total energy consumption and energy per unit produced.
- Compare operator, shift, and experience-level outcomes.
- Evaluate operational efficiency using production, defects, downtime, and energy together.
- Compare product performance with unit cost and target-price context.
- Analyze procurement spend by supplier, raw material, and time.
- Identify product unit-cost exposure and potential unit margin context.
- Estimate defect-related cost exposure.
- Identify critical raw-material dependencies and bill-of-materials complexity.
- Analyze purchase-order delays, delay rate, lead time, and supplier performance.
- Investigate potential supply-chain risks from material dependencies and procurement delays.

## Dataset and Data Model Scope

The BRD specifies the following tables and roles:

| Table | Role | Analysis area |
|---|---|---|
| `fact_production_runs` | Fact | Production, quality, downtime, energy, estimated cost exposure |
| `fact_purchase_orders` | Fact | Procurement, spending, lead time, delays |
| `dim_plants` | Dimension | Plant analysis |
| `dim_products` | Dimension | Product, category, unit cost, target price |
| `dim_operators` | Dimension | Operator, shift, experience |
| `dim_raw_materials` | Dimension | Material and standard cost |
| `dim_suppliers` | Dimension | Supplier and rating |
| `bridge_bill_of_materials` | Bridge | Product-material dependency |

The BRD recommends validating relationships and maintaining the correct fact-table grain when building the model.

## Key DAX Measures Referenced in the BRD

| Measure | Business logic / purpose |
|---|---|
| Total Production | Total quantity produced |
| Total Defects | Total defective units |
| Defect Rate | Defects ÷ production |
| Total Production Runs | Production activity volume |
| Total Downtime | Operational time loss |
| Average Downtime per Run | Downtime intensity |
| Total Energy | Total energy consumed |
| Energy per Unit | Energy efficiency |
| Total Procurement Spend | Raw-material purchasing expenditure |
| Total Purchase Orders | Procurement activity |
| Delayed Orders | Supply reliability issue volume |
| Delay Rate | Delayed orders ÷ total orders |
| Average Lead Time | Procurement speed |
| Potential Unit Margin | Target Price − Unit Cost |
| Estimated Defect Cost Exposure | Defective Quantity × Unit Cost |
| Estimated Production Cost Context | Produced Quantity × Unit Cost |
| Potential Production Value Context | Produced Quantity × Target Price |

## Dashboard Structure Defined in the BRD

The BRD describes a seven-page interactive Power BI report:

1. **Executive Overview** – production, defects, defect rate, downtime, energy, procurement spend, delayed orders, and estimated defect cost exposure.
2. **Production & Plant Performance** – production trend, plant comparison, product/category production, and plant KPIs.
3. **Quality & Operational Efficiency** – defect, downtime, energy, energy-per-unit, and efficiency analysis.
4. **Finance & Cost Analysis** – procurement spend, supplier/material spend, product unit cost, potential unit margin, and estimated cost exposure.
5. **Procurement & Supplier Performance** – purchase orders, delay rate, lead time, supplier rating, and procurement spend.
6. **Raw Materials & Supply Chain Risk** – material standard cost and product-material dependencies.
7. **Operator & Shift Performance** – operator output, shift comparison, defects, downtime, and experience context.

The attached screenshot is the supplied production performance dashboard preview; it should not be interpreted as proof that every BRD page is represented in that single screenshot.

## Technology

- **Microsoft Power BI** – interactive report and dashboard
- **Power Query** – data cleaning and transformation
- **DAX** – KPI calculations and analytical measures
- **Data model** – fact, dimension, and bridge tables as specified in the BRD

## Project Folder Structure

```text
NovaTech_Manufacturing_Project/
├── README.md
├── dashboard/
│   └── NOVA_TECH_DASHBOARD.jpeg
├── report/
│   └── NovaTech.pbix
└── documentation/
    └── Novitech_Manufacturing_BRD.docx
```

## How to Open the Project

1. Download and extract the project ZIP.
2. Open `report/NovaTech.pbix` in Microsoft Power BI Desktop.
3. If Power BI prompts for source locations, update the data-source paths to the locations of the original datasets.
4. Refresh the report after the source paths are configured.
5. Use the report slicers to explore plant, product, supplier, and period selections.

## Data Preparation Requirements

The BRD requires the following Power Query work:

- Validate data types.
- Investigate null and blank values.
- Check duplicates using business identifiers.
- Standardize categorical values.
- Validate quantity, cost, price, downtime, energy, lead-time, and rating fields.
- Confirm date fields.
- Create derived columns only where needed.
- Document cleaning decisions.

## Financial Assumptions and Limitations

The BRD explicitly states that:

- Actual sales transactions are not available.
- Actual revenue and actual profit cannot be calculated.
- Actual discounts, returns, tax, and customer-level sales are unavailable.
- Potential margin must not be labelled as profit.
- Estimated defect cost is a cost-exposure proxy, not confirmed scrap or rework cost.
- Estimated production cost context is not a formal accounting cost-of-goods-sold calculation.
- Potential production value context is based on target price and is not actual revenue.

These distinctions should be preserved in dashboard labels, analysis, and any business recommendations.

## Expected Deliverables

The BRD defines the expected deliverables as cleaned and transformed data, a validated data model, DAX measures, a seven-page interactive dashboard, evidence-based insights, prioritized recommendations, and documentation of assumptions, KPI definitions, and limitations.

## Reference

**Novitech Manufacturing – Revised Business Requirements Document (BRD), Version 2.0 – Finance Included.**

Project scope: Production, Quality, Finance, Operational Efficiency, and Supply Chain Analytics.
