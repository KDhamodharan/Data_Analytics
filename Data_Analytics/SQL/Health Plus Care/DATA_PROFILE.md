# Dataset profile and validation notes

Source: `HealthPlus_Care_DB_dataset.xlsx` (17 business sheets plus README). The counts below were inspected directly from the uploaded workbook.

## Table inventory

| Table | Rows | Null cells | Duplicate rows | Duplicate primary keys |
|---|---:|---:|---:|---:|
| Clinics | 18 | 0 | 0 | 0 |
| Specialists | 220 | 0 | 0 | 0 |
| Members | 2,500 | 75 | 0 | 0 |
| Corporates | 60 | 0 | 0 | 0 |
| Corporate_Members | 615 | 0 | 0 | 0 |
| Consultations | 6,000 | 0 | 0 | 0 |
| Telemedicine_Sessions | 2,200 | 0 | 0 | 0 |
| Chronic_Care_Programs | 900 | 0 | 0 | 0 |
| Health_Packages | 40 | 0 | 0 | 0 |
| Package_Subscriptions | 3,000 | 0 | 0 | 0 |
| Prescriptions | 5,000 | 0 | 0 | 0 |
| Lab_Tests | 3,500 | 0 | 0 | 0 |
| Claims | 1,800 | 402 | 0 | 0 |
| Staff | 450 | 0 | 0 | 0 |
| Billing | 6,000 | 889 | 0 | 0 |
| Payments | 6,000 | 283 | 0 | 0 |
| Feedback | 2,500 | 0 | 0 | 0 |

**Total business rows:** 40,803 across 17 tables.
**Total null cells:** 1,649.
**Duplicate check:** no full duplicate rows and no duplicate values in the proposed primary-key columns were found in the source workbook.

## Null values retained

| Table | Column | Null count |
|---|---|---:|
| Members | email | 75 |
| Claims | consultation_id | 330 |
| Claims | insurance_provider | 72 |
| Billing | consultation_id | 889 |
| Payments | payment_mode | 283 |

These missing values are not automatically errors. They are preserved as SQL `NULL` and surfaced for analysis. In particular, some Claims and Billing rows do not have a consultation reference; the BRD's relationship design permits those links to be nullable.

## Relationship checks

- All non-null foreign-key values checked against their parent identifier columns were found in the parent table.
- `Claims.consultation_id` is NULL in 330 rows; the remaining non-null values match Consultations.
- `Billing.consultation_id` is NULL in 889 rows; the remaining non-null values match Consultations.
- Payments contains 6,000 rows and 6,000 distinct `bill_id` values in this workbook. Each bill therefore has one payment row in this extract; the analysis nevertheless aggregates payments by bill before joining.

## Financial and operational checks

- Billing total across the 6,000 source rows: **₹18,690,854.89** (currency symbol is used for display; the workbook itself does not explicitly define a currency field).
- Successful payment amount across Payments: **₹16,895,590.20**.
- **84 Billing rows** have `total_amount` differing from `consultation_charges + lab_charges + medicine_charges` by more than ₹0.01. The maximum absolute difference is **₹10,285.74**. This is an important reconciliation issue to investigate; source amounts are not altered.
- Feedback ratings in the source range from **1 to 5**.
- The supplied workbook does not establish the reason for billing discrepancies, missing values, or payment status outcomes. Do not infer causes without business confirmation.

## Date ranges (selected)

| Table / field | Earliest | Latest |
|---|---|---|
| Members.date_of_birth | 1955-01-27 | 2005-12-26 |
| Members.registration_date | 2020-01-01 | 2025-12-29 |
| Corporates.contract_start_date | 2021-02-03 | 2024-12-30 |
| Corporates.contract_end_date | 2023-02-03 | 2026-12-30 |
| Corporate_Members.enrollment_date | 2021-01-01 | 2025-12-28 |
| Consultations.consultation_date | 2024-01-01 | 2025-12-31 |
| Chronic_Care_Programs.enrollment_date | 2023-01-01 | 2025-12-31 |
| Chronic_Care_Programs.next_review_date | 2023-04-01 | 2026-03-31 |
| Package_Subscriptions.subscription_date | 2024-01-01 | 2025-12-29 |
| Package_Subscriptions.expiry_date | 2024-06-29 | 2026-12-29 |
| Prescriptions.prescribed_date | 2024-01-01 | 2025-12-31 |
| Lab_Tests.test_date | 2024-01-01 | 2025-12-31 |
| Claims.claim_date | 2024-01-01 | 2025-12-31 |
| Staff.joining_date | 2015-01-02 | 2025-12-29 |
| Billing.bill_date | 2024-01-01 | 2025-12-31 |
| Payments.payment_date | 2024-01-01 | 2025-12-31 |
| Feedback.feedback_date | 2024-01-01 | 2025-12-31 |

## Notes for interpretation

- Consultation, prescription, laboratory, claims, billing, payment and feedback activity dates mainly span 2024–2025.
- Subscription status should be derived from `expiry_date` relative to the date of analysis, not assumed from payment status.
- Session duration should use `TIMESTAMPDIFF` only when end time is not earlier than start time.
- The workbook's README sheet is metadata, not an 18th business entity.