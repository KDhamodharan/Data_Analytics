# HealthPlus Care — SQL / MySQL Analytics Project

## 1. Project overview
A relational MySQL database and business analysis project built from the supplied `HealthPlus_Care_DB_dataset.xlsx` and `HealthPlus_Care_BRD.docx`.

**Business question:** How effectively is HealthPlus Care delivering and monetizing its healthcare services while maintaining member engagement and service satisfaction?

The work follows the BRD's actual integrated healthcare service model. It does **not** invent inpatient admissions, rooms, or pharmacy inventory entities, because those are not present in the workbook.

## 2. Technology
- MySQL 8.0+ (CTEs and window functions are used)
- SQL / MySQL Workbench
- CSV files exported from the supplied Excel workbook

## 3. Project files
| File | Purpose |
|---|---|
| `01_schema.sql` | Creates the database, 17 tables, primary keys and foreign keys |
| `02_load_data.sql` | Loads the supplied CSV data using `LOAD DATA LOCAL INFILE` |
| `03_business_analysis.sql` | 52 business analysis queries covering the BRD and SQL syllabus |
| `04_data_quality.sql` | Row counts, nulls, duplicate checks, orphan checks and reconciliation checks |
| `data/` | One CSV file for each of the 17 source business tables |
| `DATA_PROFILE.md` | Actual source workbook profile and data-quality observations |
| `HealthPlus_Care_ERD.mmd` | Mermaid entity-relationship overview |

## 4. Database tables
Clinics, Specialists, Members, Corporates, Corporate_Members, Consultations, Telemedicine_Sessions, Chronic_Care_Programs, Health_Packages, Package_Subscriptions, Prescriptions, Lab_Tests, Claims, Staff, Billing, Payments and Feedback.

## 5. How to run in MySQL Workbench

### Step 1 — Extract the ZIP
Extract the project folder. Keep the `data` folder and all SQL files together.

### Step 2 — Create the schema
Open `01_schema.sql` in MySQL Workbench and execute it. This creates `HealthPlus_Care_DB` and its tables.

### Step 3 — Load the CSV files
Open `02_load_data.sql` and execute it from the project root. The script expects the relative paths `data/Clinics.csv`, `data/Specialists.csv`, etc.

If Workbench cannot find a relative path:
1. Replace `data/<table>.csv` in the script with the full path to that CSV file, for example `C:/.../HealthPlus_Care_SQL_Project/data/Clinics.csv`.
2. Enable `LOAD DATA LOCAL INFILE` in the MySQL client/Workbench connection settings if the client requests it.
3. Execute the load script.

Alternative: use Workbench's **Table Data Import Wizard** to import each CSV into its matching, already-created table. Import parent tables before child tables, following the order in `02_load_data.sql`.

### Step 4 — Validate the load
Run `04_data_quality.sql`. Confirm row counts match `DATA_PROFILE.md`. Review the nullable fields and billing reconciliation exceptions; do not delete valid records simply because a status is Pending, Cancelled, Failed or otherwise non-final.

### Step 5 — Run the analysis
Run `03_business_analysis.sql` section by section. It contains 52 queries, with business question comments before each query. Save important result grids or export them as CSV for your final report.

## 6. Relationship design
- Clinics → Specialists, Consultations, Lab_Tests, Staff
- Members → Consultations, Chronic_Care_Programs, Package_Subscriptions, Prescriptions, Lab_Tests, Claims, Billing, Payments, Feedback, Corporate_Members
- Specialists → Consultations, Chronic_Care_Programs, Prescriptions
- Consultations → Telemedicine_Sessions, Prescriptions, Claims, Billing, Feedback
- Corporates → Corporate_Members
- Health_Packages → Package_Subscriptions
- Billing → Payments

Nullable consultation references in Claims and Billing are retained as nullable foreign keys. They represent records without a consultation link in the source dataset.

## 7. Important analytical controls
1. **Billing vs payments:** the supplied workbook contains 6,000 billing rows and 6,000 payment rows. The payment data has 6,000 distinct `bill_id` values (one payment row per bill in this extract). The analysis still aggregates payments by bill before joining to Billing, so it remains safe if the source later contains multiple payments per bill.
2. **Payment status:** the collection-gap query counts only `payment_status = 'Success'` as successful collection. Failed and Refunded amounts are not counted as successful collection.
3. **Billing component reconciliation:** the supplied data has rows where `total_amount` does not equal the sum of consultation, lab and medicine charges. The data-quality script exposes these rows; investigate them rather than overwriting source values.
4. **Missing values:** null email, insurance provider, consultation reference and payment mode values are retained and documented.
5. **Time-sensitive queries:** active/expired subscriptions and upcoming reviews use `CURDATE()`, so their output changes depending on the date when you execute them.
6. **Feedback:** satisfaction analysis uses the numeric `rating`. Feedback text is not presented as sentiment analysis.
7. **Business recommendations:** do not write performance claims until you have executed the queries and reviewed their result sets.

## 8. SQL topics covered
CREATE DATABASE, CREATE TABLE, data types, PRIMARY KEY, FOREIGN KEY, LOAD DATA, SELECT, WHERE, ORDER BY, LIMIT, COUNT, SUM, AVG, GROUP BY, HAVING, INNER JOIN, LEFT JOIN, RIGHT JOIN, CTEs, ROW_NUMBER, RANK, LAG, LEAD, CASE, date functions and financial reconciliation.

## 9. Final submission checklist
- [ ] Execute schema and load scripts successfully.
- [ ] Verify all 17 row counts.
- [ ] Run the data-quality checks and document exceptions.
- [ ] Execute the analysis queries and save the key result grids.
- [ ] Prepare 5–10 evidence-based business insights from actual outputs.
- [ ] Prepare recommendations tied to those findings.
- [ ] Include screenshots of schema, table data, and selected query outputs in the final college/recruiter presentation.

## 10. Limitations
This project is limited to the fields in the supplied workbook. It does not establish clinical outcomes, medical effectiveness, patient safety, sentiment scores, or causal explanations. The dataset's nulls and billing inconsistencies require business-owner review. The SQL scripts have been generated against the actual workbook structure; execute them in your MySQL environment to verify client-specific CSV import permissions.
