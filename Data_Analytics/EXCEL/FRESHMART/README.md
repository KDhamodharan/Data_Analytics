# FreshMart – Sales Dashboard & Business Performance Analysis

An interactive **Microsoft Excel dashboard** designed to help FreshMart management monitor sales performance, profitability, order activity, and monthly trends.

<img width="1321" height="504" alt="DASHBOARD" src="https://github.com/user-attachments/assets/5086bb16-1509-4e1d-98c3-8d8e61921302" />


## 1. Project Overview

FreshMart is a multi-location retail business that sells products across different categories, brands, stores, regions, and sales channels. Its business information is maintained across customer, product, store, employee, supplier, and sales transaction datasets.

This project brings the supplied data together into an Excel-based analytical workbook and presents key business performance indicators through an interactive dashboard.

**Project type:** Retail Business Performance Analysis  
**Platform:** Microsoft Excel  
**Primary stakeholder:** Sales Manager  
**Business domain:** Retail / Sales Analytics

## 2. Business Problem

Management needs a consolidated view of business performance. When information is spread across multiple datasets, it becomes difficult to identify the regions, categories, and products contributing to sales and profit.

High revenue alone does not necessarily mean strong performance. Discounts, costs, and returns can affect profitability. The dashboard therefore presents sales and profit measures together to support better business monitoring and investigation.

## 3. Project Objectives

- Monitor overall sales, profit, order volume, customer count, and average order value.
- Understand sales movement across months.
- Compare monthly sales and profit.
- Review average sales by month.
- Filter dashboard information by region, product category, and transaction date.
- Support management decisions with a consolidated and easy-to-read visual summary.

## 4. Dataset Overview

The supplied project data contains the following business datasets:

| Dataset | Records (excluding header) | Key field | Purpose |
|---|---:|---|---|
| Sales Transactions | 2,500 | `Invoice_Number` | Transaction, quantity, sales, cost, profit, discount, return, payment, and channel details |
| Customers | 700 | `Customer_ID` | Customer profile, geography, membership, and registration details |
| Products | 150 | `Product_ID` | Product category, subcategory, brand, pricing, supplier, season, and status |
| Stores | 180 | `Store_ID` | Store, region, city, type, target, and status information |
| Employees | 350 | `Employee_ID` | Employee, department, store assignment, and employment information |
| Suppliers | 85 | `Supplier_ID` | Supplier details, location, lead time, rating, and status |

The main Excel workbook also contains prepared data and analysis sheets, including sales transaction data, PivotTable summaries, and the dashboard.

## 5. Dashboard Features

### KPI Cards

The dashboard screenshot displays these headline measures:

| KPI | Value shown |
|---|---:|
| Total Sales | ₹28,68,432.60 |
| Total Profit | ₹7,37,358.89 |
| Total Orders | 2,500 |
| Total Customers | 700 |
| Average Order Value | ₹1,147.37 |

The dashboard also displays a comparison against last year on selected KPI cards. The percentages shown are reproduced from the dashboard view and should be interpreted using the workbook's underlying calculation definitions.

### Interactive Filters

- **Region:** East, North, South, and West.
- **Category:** Filter the view by product category.
- **Transaction Date:** Select the reporting period using the date timeline.

### Charts

- **Sales Trend Month Wise:** Shows the monthly sales trend.
- **Sales With Profit Monthly Wise:** Compares monthly sales and profit.
- **Avg Sales By Month:** Compares average sales across months.

## 6. Tools & Excel Features

- Microsoft Excel
- Data preparation and cleaning
- PivotTables / PivotTable summaries
- Excel charts
- Slicers and date timeline filters
- KPI calculations and dashboard formatting

## 7. Data Model & Relationships

The BRD identifies these logical relationships between the datasets:

- Sales Transactions → Customers using `Customer_ID`
- Sales Transactions → Products using `Product_ID`
- Sales Transactions → Stores using `Store_ID`
- Sales Transactions → Employees using `Employee_ID`
- Products → Suppliers using `Supplier_ID`
- Employees → Stores using `Store_ID`

These keys provide the structure for combining transaction measures with customer, product, store, employee, and supplier context.

## 8. Methodology

1. **Understand requirements:** Review the business problem, stakeholder needs, and analytical questions in the Business Requirements Document.
2. **Inspect datasets:** Review each supplied worksheet, its columns, record counts, and key fields.
3. **Prepare data:** Check data types, missing values, duplicates, inconsistent text, and key-field validity.
4. **Organize related data:** Use common identifiers to connect transaction records with the relevant business datasets.
5. **Build analysis:** Prepare summary calculations and PivotTable-based monthly views.
6. **Create dashboard:** Arrange KPI cards, filters, and charts in a management-friendly layout.
7. **Review results:** Validate KPI calculations against the underlying data before using them for business decisions.

## 9. Key Business Questions

The wider BRD defines these questions for business analysis:

- How is FreshMart performing in sales, cost, profit, transaction volume, and units sold?
- Which stores and regions contribute most to sales and profit?
- Which products and categories drive revenue and profitability?
- Are the highest-selling products also the most profitable?
- How are discounts associated with sales and profitability?
- What patterns are visible in returned versus non-returned transactions?
- Which customers and membership segments contribute most to business value?
- How does performance differ across sales channels and payment modes?
- Which employees contribute most to transaction or sales activity?

The dashboard screenshot included above focuses on the executive sales summary and monthly trend views. The broader questions are part of the BRD's analytical scope and should only be reported as completed where supported by the corresponding workbook analysis.

## 10. Important Assumptions & Limitations

- KPI values shown in this README are the values visible in the supplied dashboard screenshot.
- The reporting period and comparison logic should be confirmed from the workbook before presenting year-over-year conclusions.
- `Invoice_Number` should be checked for uniqueness before it is treated as a transaction count.
- Return-related metrics require a clear interpretation of `Return_Status`.
- Store target comparisons require validation of the target period against transaction dates.
- Supplier lead time and rating provide supplier context; they do not, by themselves, prove an impact on sales.
- The analysis identifies patterns and associations. It should not claim causation without additional evidence.
- The dashboard screenshot shows the currently supplied dashboard view; it does not demonstrate every analysis area listed in the BRD.

## 11. How to Use the Workbook

1. Open the FreshMart Excel workbook in Microsoft Excel.
2. Go to the **Dashboard** sheet (the supplied workbook labels this sheet `Dashbaord`).
3. Use the Region and Category slicers to filter the report.
4. Use the Transaction Date timeline to select the required reporting period.
5. Review the KPI cards and monthly charts after applying filters.
6. To inspect the supporting analysis, review the sales transaction and PivotTable summary sheets.

## 12. Suggested Repository Structure

```text
FreshMart/
├── README.md
├── assets/
│   └── freshmart-dashboard.jpeg
└── data/
    ├── customer-cleaned.xlsx
    ├── product-cleaned.xlsx
    ├── store-cleaned.xlsx
    ├── employee-cleaned.xlsx
    ├── supplier-cleaned.xlsx
    └── sales-transactions-cleaned.xlsx
```

> The structure above is a suggested GitHub repository layout. Add your Excel workbooks under `data/` if you intend to publish the complete project. Review and remove personal or confidential information before making datasets public.

## 13. Expected Outcome

A consolidated Excel dashboard that makes key sales and profitability measures easier to monitor, supports month-wise performance review, and allows users to explore results by region, category, and date.

---

**Project:** FreshMart Business Performance Dashboard  
**Prepared using:** Microsoft Excel  
