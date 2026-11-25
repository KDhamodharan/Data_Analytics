# MediCare Healthcare Operations & Revenue Analytics — SQL Project

## Project objective
Build a relational MySQL database and analyze healthcare operations and revenue performance across the MediCare hospital network, following the supplied BRD.

## Dataset
Source workbook: `Hospital_Analytics_DB_dataset.xlsx`  
Database: `Hospital_Analytics_DB`  
Tables: 15  
Rows: 32,920

| Table | Rows |
|---|---:|
| Hospitals | 30 |
| Departments | 40 |
| Doctors | 450 |
| Patients | 2,000 |
| Rooms | 800 |
| Appointments | 5,100 |
| Admissions | 2,500 |
| Treatments | 3,500 |
| Insurance | 1,500 |
| Medicines | 300 |
| Pharmacy | 2,500 |
| Laboratory | 3,000 |
| Employees | 1,200 |
| Billing | 5,000 |
| Payments | 5,000 |

## Files and execution order
Run these files in MySQL Workbench (MySQL 8.0+), in this order:

1. `01_create_database_and_tables.sql` — creates the database and 15 tables with primary keys.
2. `02_load_dataset.sql` — loads all rows from the supplied Excel dataset. Date values are normalized to ISO format for SQL loading.
3. `03_add_foreign_keys.sql` — applies foreign-key relationships after loading, including the circular Departments/Doctors reference.
4. `04_data_validation.sql` — row counts, NULL checks, duplicate checks, orphan checks, formatting checks and billing consistency checks.
5. `05_business_analysis_queries.sql` — core SQL, aggregations, joins, operational analysis, service analysis, billing/payment analysis, window functions and KPI summary.

## Main relationships
- Hospitals 1—many Departments, Doctors, Rooms, Appointments, Admissions, Employees, Pharmacy sales and Laboratory tests.
- Departments 1—many Doctors, Employees and Admissions.
- Doctors 1—many Appointments, Admissions, Treatments and Laboratory tests.
- Patients 1—many Appointments, Admissions, Treatments, Insurance policies, Pharmacy sales, Laboratory tests, Bills and Payments.
- Admissions 1—many Treatments and may be referenced by Billing.
- Appointments may be referenced by Billing.
- Medicines 1—many Pharmacy sales.
- Billing 1—many Payments.

The `Departments.head_doctor_id` to `Doctors.doctor_id` relationship is circular with `Doctors.department_id`; therefore all foreign keys are added after data loading.

## Important data preparation decisions
- Source rows are retained; NULL values are not automatically changed to zero.
- IDs and telephone numbers are stored as text to preserve leading zeros and identifier formatting.
- Date columns are loaded as DATE (and `created_at` as DATETIME) in ISO format.
- Optional relationships remain nullable where the source workbook has NULLs.
- Foreign keys are added only after all source rows are loaded. The supplied data was checked for orphan IDs before constraints were generated.
- No duplicate source rows were found by full-row duplicate checks in the supplied workbook.
- Gender casing, trailing spaces and invalid-looking emails are surfaced for review in the validation script; source values are not silently rewritten.

## Financial calculation rules
- `total_billed_amount` is based on `Billing.total_amount`.
- Payment transactions are aggregated to one row per bill before joining to Billing to prevent one-to-many duplication.
- Successful payments and refunded payments are shown separately. The analysis pack calculates net collected as successful payments less refunded payments.
- Collection gap = total billed amount − net collected.
- Collection rate = net collected / total billed amount × 100.
- Review payment status definitions with the business owner before treating any status other than `Success` or `Refunded` as a collected amount.

## BRD coverage
The query pack addresses hospital activity, department workload, doctor workload, admission patterns and length of stay, room utilization, treatment activity and cost, laboratory activity and cost, pharmacy sales, billing components, payment status/mode, collection gap, KPIs and window functions (`ROW_NUMBER`, `RANK`, `LAG`, `LEAD`).

## Limitations
- The dataset is synthetic/project data and should not be interpreted as actual hospital performance.
- Operational volume is not a measure of clinical quality.
- The BRD does not authorize diagnosis or clinical decision-making.
- SQL findings should be described only after running the scripts and reviewing query outputs.
