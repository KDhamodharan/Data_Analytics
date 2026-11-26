# AeroHome Manufacturing Analytics – Power BI Dashboard

## Project Overview

AeroHome Manufacturing Analytics is an end-to-end business intelligence project designed to help management monitor manufacturing performance and investigate operational inefficiencies across production, quality, machine downtime, finance, procurement, and supply chain operations.

The solution is built around the business requirements defined in the **AeroHome Manufacturing Business Requirements Document (BRD), Version 1.0**. It aims to provide a centralized analytical view of planned versus actual production, production shortfalls, defects, downtime causes, supplier delivery performance, and material dependencies.

## Dashboard Preview

![AeroHome Manufacturing Power BI Dashboard](dashboard/AERO_HOME_DASHBOARD.jpeg)

*Dashboard screenshot supplied with the project.*

## Key KPIs Shown in the Dashboard Preview

The supplied dashboard screenshot displays the following headline indicators:

| KPI | Value shown |
|---|---:|
| Total Downtime | 122,329 |
| Production Attainment % | 96.26% |
| Defect Rate % | 1.71% |
| Production Shortfall | -41,425 |
| Supplier Delay % | 16.55% |

*These values are transcribed from the supplied dashboard image. Their units and calculation definitions should be confirmed in the Power BI model before being used in formal reporting.*

## Dashboard Features Visible in the Preview

- **Filters / slicers:** Plant name, product name, supplier name, and period.
- **Production trend:** Monthly production attainment percentage.
- **Downtime analysis:** Downtime by reason.
- **Supplier performance:** Supplier delivery delay and purchase-related comparison.
- **Quality analysis:** Defect rate by product.
- **Production shortfall:** Product-level shortfall breakdown.
- **Machine performance:** Machine-level production attainment and downtime table.

## Business Objectives

The BRD defines the following objectives for the analytics solution:

1. Evaluate whether planned production targets are being achieved.
2. Identify plants, products, machines, operators, and shifts associated with production shortfalls.
3. Analyze product quality, defect types, inspection outcomes, and rework.
4. Identify major downtime causes and machines with high downtime.
5. Evaluate operational efficiency using production, defects, downtime, and energy.
6. Estimate financial exposure associated with defects and production cost context.
7. Analyze procurement spending, supplier performance, and delivery reliability.
8. Identify critical raw-material dependencies and potential supply-chain risks.
9. Deliver management-ready dashboards, insights, and recommendations.

## Dataset Scope

The BRD describes the following source tables:

| Dataset | Type | Business purpose |
|---|---|---|
| `dim_plants` | Dimension | Plant location and daily production capacity |
| `dim_products` | Dimension | Product, category, unit cost, and target price |
| `dim_machines` | Dimension | Machine type, plant assignment, and installation year |
| `dim_operators` | Dimension | Operator, plant, shift, experience, and hourly rate |
| `dim_suppliers` | Dimension | Supplier, country, and supplier rating |
| `dim_materials` | Dimension | Raw material, type, unit of measure, and standard cost |
| `bridge_bill_of_materials` | Bridge | Product-to-material dependency and required quantity |
| `fact_production` | Fact | Planned and actual production, defects, downtime, and energy |
| `fact_quality` | Fact | Inspections, inspected units, defects, defect type, and status |
| `fact_downtime` | Fact | Downtime events, reasons, categories, duration, and status |
| `fact_purchase_orders` | Fact | Material purchases, suppliers, quantities, prices, lead times, and delivery status |

## Analytical Areas in the BRD

The business requirements cover these analytical areas:

- Production target achievement and production shortfall
- Plant performance
- Machine performance and downtime root-cause analysis
- Quality performance, defect types, and inspection outcomes
- Operational and energy efficiency
- Operator and shift performance
- Product cost context and estimated defect cost exposure
- Procurement spending
- Supplier delivery performance and supplier ratings
- Raw-material dependency and supply-chain risk

## KPI Definitions Referenced in the BRD

| Measure | Business logic |
|---|---|
| Production Achievement % | Produced Units ÷ Planned Units |
| Production Shortfall | Planned Units − Produced Units |
| Defect Rate | Defective Units ÷ relevant production / inspection denominator |
| Total Downtime | Sum of downtime minutes |
| Energy per Unit Produced | Total Energy ÷ Total Produced Units |
| Quality Pass Rate | Passed inspections ÷ total inspections |
| Quality Fail Rate | Failed inspections ÷ total inspections |
| Rework Rate | Rework inspections ÷ total inspections |
| Total Procurement Spend | Quantity Ordered × Unit Price |
| Delivery Delay Difference | Actual Lead Days − Expected Lead Days |
| Potential Unit Margin | Target Price − Unit Cost |
| Estimated Defect Cost Exposure | Defective Units × Product Unit Cost |

## Recommended Data Model

The BRD recommends a fact-and-dimension model. Production, quality, downtime, and purchase orders represent separate analytical processes and should retain their appropriate data grain.

Key modeling considerations:

- Use dimension tables for descriptive filtering and grouping.
- Validate relationship cardinality using the actual keys.
- Use the Bill of Materials table as a bridge between products and materials.
- Avoid unnecessary many-to-many relationships.
- Do not directly combine fact tables at different grains without appropriate measure or model logic.
- Create a Date table if required for time intelligence and trend analysis.

## Technology

- **Microsoft Power BI** – report development and interactive dashboard
- **Power Query** – data validation, cleaning, and transformation requirements
- **DAX** – business measures and KPI calculations
- **Source data** – AeroHome manufacturing datasets described in the BRD

## Project Files

```text
AeroHome_Manufacturing_Project/
├── README.md
├── dashboard/
│   └── AERO_HOME_DASHBOARD.jpeg
├── report/
│   └── Cleaned_Aero_home.pbix
└── documentation/
    └── AeroHome_Manufacturing_BRD.docx
```

## How to Use

1. Download or clone this project folder.
2. Open `report/Cleaned_Aero_home.pbix` using Microsoft Power BI Desktop.
3. If Power BI requests source-file locations, update the data source paths to match the location of the supplied datasets.
4. Refresh the data if the source files are available.
5. Use the dashboard slicers to filter the report by plant, product, supplier, and period.

## Assumptions and Limitations

The BRD specifies several important interpretation limits:

- The dataset does not contain actual sales transactions, customer orders, actual revenue, discounts, returns, or confirmed profit.
- Target Price must not be treated as actual selling price.
- Potential Unit Margin is contextual and must not be described as actual profit.
- Estimated Defect Cost Exposure is an estimate, not confirmed scrap or rework cost.
- Material-shortage downtime and supplier delays may be compared as risk indicators, but direct causation should not be claimed unless supported by a direct relationship.
- Different fact tables may have different grains; calculations must respect those grains.
- Machine installation year may provide context but does not prove that machine age causes downtime.

## Expected Business Value

The intended outcome is to help management identify where production targets are missed, understand patterns in downtime and quality losses, monitor supplier delivery reliability, and investigate cost and material dependencies. Recommendations should be prioritized using evidence from the underlying data and should not claim unsupported causation.

## Reference

**AeroHome Manufacturing – Business Requirements Document (BRD), Version 1.0**  
Project scope: Production, Quality, Machine, Finance, and Supply Chain Analytics.
