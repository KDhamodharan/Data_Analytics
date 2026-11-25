-- HealthPlus Care | Data quality and validation checks | MySQL 8.0+
USE HealthPlus_Care_DB;

-- 1. Row counts
SELECT 'Clinics' AS table_name,COUNT(*) AS row_count FROM Clinics
UNION ALL SELECT 'Specialists',COUNT(*) FROM Specialists
UNION ALL SELECT 'Members',COUNT(*) FROM Members
UNION ALL SELECT 'Corporates',COUNT(*) FROM Corporates
UNION ALL SELECT 'Corporate_Members',COUNT(*) FROM Corporate_Members
UNION ALL SELECT 'Consultations',COUNT(*) FROM Consultations
UNION ALL SELECT 'Telemedicine_Sessions',COUNT(*) FROM Telemedicine_Sessions
UNION ALL SELECT 'Chronic_Care_Programs',COUNT(*) FROM Chronic_Care_Programs
UNION ALL SELECT 'Health_Packages',COUNT(*) FROM Health_Packages
UNION ALL SELECT 'Package_Subscriptions',COUNT(*) FROM Package_Subscriptions
UNION ALL SELECT 'Prescriptions',COUNT(*) FROM Prescriptions
UNION ALL SELECT 'Lab_Tests',COUNT(*) FROM Lab_Tests
UNION ALL SELECT 'Claims',COUNT(*) FROM Claims
UNION ALL SELECT 'Staff',COUNT(*) FROM Staff
UNION ALL SELECT 'Billing',COUNT(*) FROM Billing
UNION ALL SELECT 'Payments',COUNT(*) FROM Payments
UNION ALL SELECT 'Feedback',COUNT(*) FROM Feedback;

-- 2. Primary-key duplicate check examples (expect zero rows)
SELECT member_id,COUNT(*) AS occurrences FROM Members GROUP BY member_id HAVING COUNT(*)>1;
SELECT consultation_id,COUNT(*) AS occurrences FROM Consultations GROUP BY consultation_id HAVING COUNT(*)>1;

-- 3. Important nullable fields (NULLs are retained, not deleted)
SELECT
 (SELECT COUNT(*) FROM Members WHERE email IS NULL) AS members_without_email,
 (SELECT COUNT(*) FROM Claims WHERE consultation_id IS NULL) AS claims_without_consultation,
 (SELECT COUNT(*) FROM Claims WHERE insurance_provider IS NULL) AS claims_without_provider,
 (SELECT COUNT(*) FROM Billing WHERE consultation_id IS NULL) AS bills_without_consultation,
 (SELECT COUNT(*) FROM Payments WHERE payment_mode IS NULL) AS payments_without_mode;

-- 4. Orphan checks for key relationships (expect zero rows for each query)
SELECT c.* FROM Consultations c LEFT JOIN Members m ON c.member_id=m.member_id WHERE m.member_id IS NULL;
SELECT c.* FROM Consultations c LEFT JOIN Specialists s ON c.specialist_id=s.specialist_id WHERE s.specialist_id IS NULL;
SELECT c.* FROM Consultations c LEFT JOIN Clinics cl ON c.clinic_id=cl.clinic_id WHERE cl.clinic_id IS NULL;
SELECT p.* FROM Payments p LEFT JOIN Billing b ON p.bill_id=b.bill_id WHERE b.bill_id IS NULL;

-- 5. Billing arithmetic validation; investigate differences rather than silently changing source values
SELECT bill_id,consultation_charges,lab_charges,medicine_charges,total_amount,
       ROUND(total_amount-(consultation_charges+lab_charges+medicine_charges),2) AS difference
FROM Billing
WHERE ABS(total_amount-(consultation_charges+lab_charges+medicine_charges))>0.01
ORDER BY ABS(difference) DESC;

-- 6. Confirm payment record grain before collection calculations
SELECT COUNT(*) AS payment_rows,COUNT(DISTINCT bill_id) AS unique_bill_ids
FROM Payments;

-- 7. Check telemedicine duration validity
SELECT COUNT(*) AS invalid_or_negative_duration_rows
FROM Telemedicine_Sessions
WHERE session_end_time<session_start_time;

-- 8. Feedback rating domain
SELECT rating,COUNT(*) AS response_count
FROM Feedback GROUP BY rating ORDER BY rating;

-- 9. Date range and invalid dates are protected by DATE/DATETIME columns after loading.
