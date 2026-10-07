🛍️ TrendKart Retail Analytics Project
📌 Project Overview
TrendKart Retail Analytics is a retail data analytics project developed to analyze sales performance, customer behavior, product performance, store performance, employees, and suppliers.
The project uses Excel for data cleaning, analysis, KPI calculations, Pivot Tables, and business reporting.
The main objective is to convert raw retail transaction data into meaningful business insights that can help management improve sales, profitability, customer engagement, product performance, and store operations.
🎯 Business Objective
TrendKart wants to understand:
- How much sales and profit the business generates
- Monthly and yearly sales performance
- Which products and categories perform best
- Which customers contribute the highest sales and profit
- Which stores perform better
- Whether stores are achieving their monthly targets
- Customer membership and purchasing behavior
- Payment and sales channel performance
- Profitability and profit margin
- Data quality issues in the retail transaction data
📊 Dataset Overview
The project contains multiple datasets representing different parts of the retail business.
Dataset	Records	Description
Sales Transactions	3,000	Customer purchases and sales transactions
Customers	850	Customer demographic and membership information
Products	250	Product, category, brand and pricing information
Stores	120	Store location, type and target information
Employees	300	Employee and performance information
Suppliers	90	Supplier and delivery information


Main Sales Transaction Fields
Important fields include:
- Invoice No
- Invoice Date
- Customer ID
- Product ID
- Store ID
- Employee ID
- Quantity
- Unit Price
- Discount
- GST
- Sales Amount
- Cost Amount
- Profit
- Payment Mode
- Sales Channel
- Return Status
- Order Time
- Day Type
🧹 Data Cleaning
Before performing analysis, the raw data was checked for data-quality problems.
Issues Identified
The project identified issues such as:
- Duplicate invoice numbers
- Blank Customer IDs
- Blank Product IDs
- Blank Employee IDs
- Mixed date formats
- Numbers stored as text
- Extra spaces in payment modes
- Negative profit values
- Zero quantities
- Inconsistent payment-mode casing
- Return-status spelling errors
- Duplicate customer phone numbers
- Invalid email addresses
- Inconsistent gender values
- Inconsistent membership values
- Extra spaces in customer names
- Duplicate product names
- Incorrect category spellings
- Missing product brands
- Missing store manager names
- Store status errors
- Employee name formatting issues
- Employee-status errors
Data Cleaning Approach
The data was cleaned using Excel techniques such as:
- Removing duplicate records
- Handling blank values
- Standardizing text values
- Removing unwanted spaces
- Correcting spelling inconsistencies
- Standardizing date formats
- Converting data types
- Validating IDs
- Checking invalid values
- Validating numerical fields
- Standardizing categorical values
A separate Data Quality Log was maintained to document the identified data issues and affected rows.
📈 Key Performance Indicators (KPIs)
The project calculates important retail KPIs including:
Sales KPIs
- Total Sales
- Total Profit
- Total Transactions
- Average Order Value
- Sales Growth %
- Profit Growth %
- Profit Margin %
Store KPIs
- Store Sales
- Monthly Target
- Target Achievement %
- Store-wise Profit
Customer KPIs
- Customer Sales
- Customer Profit
- Membership performance
- Top customers
Product KPIs
- Product Sales
- Product Profit
- Category performance
- Brand performance
💰 Key Project Metrics
Based on the project calculations:
KPI	Value
Total Sales	₹9,227,179.96
Total Profit	₹1,804,518.54
Total Transactions	3,000
Average Transaction Value	~₹3,075.73
Sales Growth	-0.08%
Profit Growth	-7.20%


Note: KPI values may change if the underlying data or cleaning rules are modified.

📊 Analysis Performed
1. Sales Analysis
Sales were analyzed based on:
- Year
- Month
- Date
- Store
- Customer
- Product
- Category
- Region
This helps identify sales trends and high-performing periods.
2. Profit Analysis
Profit was analyzed to identify:
- High-profit products
- Low-profit products
- High-profit customers
- Store profitability
- Monthly profit trends
- Profit margin performance
3. Customer Analysis
Customer-level analysis was performed to identify:
- Top customers by sales
- Top customers by profit
- Customer purchasing behavior
- Membership performance
- Customer contribution to revenue
4. Product Analysis
Product performance was analyzed using:
- Product sales
- Product profit
- Product category
- Subcategory
- Brand
- Selling price
- Cost price
This helps management identify products that generate high revenue and profit.
5. Store Performance Analysis
Stores were compared using:
- Total sales
- Profit
- Monthly target
- Target achievement %
- Store type
- Region
This helps identify high-performing and under-performing stores.
6. Customer Membership Analysis
Customers were segmented based on membership levels such as:
- Regular
- Silver
- Gold
- Platinum
This helps understand which membership groups contribute more to sales and profit.
7. Sales Channel Analysis
Sales were analyzed across:
- Online
- Offline
This helps management understand customer purchasing preferences and channel performance.
8. Payment Mode Analysis
Transactions were analyzed using different payment methods such as:
- UPI
- Credit Card
- Debit Card
- Other available payment modes
This provides insight into customer payment preferences.
📊 Excel Analysis Techniques Used
The project uses several Excel analytics techniques:
- Excel Tables
- Data Cleaning
- Sorting and Filtering
- Conditional Formatting
- Formulas
- Pivot Tables
- Pivot Charts
- KPI Calculations
- Percentage Calculations
- Growth Analysis
- Target Achievement Analysis
- Data Validation
- Business Reporting
📑 Project Workbook Structure
The main workbook contains different sheets for analysis and reporting.
Sales_Transactions
Contains the main retail transaction data.
Customers
Contains customer demographic and membership information.
Products
Contains product and pricing information.
Stores
Contains store details and monthly targets.
Employees
Contains employee information and performance ratings.
Suppliers
Contains supplier information, lead time and ratings.
Data_Quality_Log
Documents data-quality problems identified during the cleaning process.
Calculations
Contains KPI calculations such as:
- Total Sales
- Total Profit
- Average Transaction
- Sales Growth
- Profit Growth
- Average Order Value Growth
- Total Transactions
Pivot Analysis Sheets
Pivot tables are used to analyze:
- Sales and profit trends
- Customer performance
- Store performance
- Target achievement
- Transaction performance
