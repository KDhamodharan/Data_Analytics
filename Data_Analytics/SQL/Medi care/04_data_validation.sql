-- MediCare data quality and referential integrity checks | MySQL 8.0+
USE Hospital_Analytics_DB;

-- 1. Source row counts
SELECT 'Hospitals' AS table_name, COUNT(*) AS row_count FROM Hospitals
UNION ALL SELECT 'Departments', COUNT(*) FROM Departments
UNION ALL SELECT 'Doctors', COUNT(*) FROM Doctors
UNION ALL SELECT 'Patients', COUNT(*) FROM Patients
UNION ALL SELECT 'Rooms', COUNT(*) FROM Rooms
UNION ALL SELECT 'Appointments', COUNT(*) FROM Appointments
UNION ALL SELECT 'Admissions', COUNT(*) FROM Admissions
UNION ALL SELECT 'Treatments', COUNT(*) FROM Treatments
UNION ALL SELECT 'Insurance', COUNT(*) FROM Insurance
UNION ALL SELECT 'Medicines', COUNT(*) FROM Medicines
UNION ALL SELECT 'Pharmacy', COUNT(*) FROM Pharmacy
UNION ALL SELECT 'Laboratory', COUNT(*) FROM Laboratory
UNION ALL SELECT 'Employees', COUNT(*) FROM Employees
UNION ALL SELECT 'Billing', COUNT(*) FROM Billing
UNION ALL SELECT 'Payments', COUNT(*) FROM Payments;

-- 2. NULL checks for important fields
SELECT
  SUM(hospital_name IS NULL OR TRIM(hospital_name)='') AS invalid_hospital_names
FROM Hospitals;
SELECT
  SUM(first_name IS NULL OR TRIM(first_name)='') AS missing_doctor_first_names,
  SUM(email IS NULL) AS doctors_without_email
FROM Doctors;
SELECT
  SUM(discharge_date IS NULL) AS admissions_without_discharge_date,
  SUM(discharge_date < admission_date) AS discharge_before_admission
FROM Admissions;

-- 3. Duplicate primary-key checks (should return zero rows)
SELECT hospital_id, COUNT(*) AS duplicate_count FROM Hospitals GROUP BY hospital_id HAVING COUNT(*) > 1;
SELECT doctor_id, COUNT(*) AS duplicate_count FROM Doctors GROUP BY doctor_id HAVING COUNT(*) > 1;
SELECT patient_id, COUNT(*) AS duplicate_count FROM Patients GROUP BY patient_id HAVING COUNT(*) > 1;

-- 4. Foreign-key orphan checks (each query should return zero rows)
SELECT d.department_id FROM Departments d LEFT JOIN Hospitals h ON d.hospital_id=h.hospital_id WHERE h.hospital_id IS NULL;
SELECT doc.doctor_id FROM Doctors doc LEFT JOIN Departments d ON doc.department_id=d.department_id WHERE doc.department_id IS NOT NULL AND d.department_id IS NULL;
SELECT a.appointment_id FROM Appointments a LEFT JOIN Patients p ON a.patient_id=p.patient_id WHERE p.patient_id IS NULL;
SELECT ad.admission_id FROM Admissions ad LEFT JOIN Rooms r ON ad.room_id=r.room_id WHERE r.room_id IS NULL;
SELECT b.bill_id FROM Billing b LEFT JOIN Patients p ON b.patient_id=p.patient_id WHERE p.patient_id IS NULL;
SELECT p.payment_id FROM Payments p LEFT JOIN Billing b ON p.bill_id=b.bill_id WHERE b.bill_id IS NULL;

-- 5. Standardization checks: gender and department-name whitespace
SELECT DISTINCT gender FROM Doctors ORDER BY gender;
SELECT department_id, department_name
FROM Departments
WHERE department_name <> TRIM(department_name);

-- 6. Email format investigation (review; do not silently overwrite source values)
SELECT doctor_id, email
FROM Doctors
WHERE email IS NOT NULL
  AND email NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$';

-- 7. Financial consistency: compare components with stored total
SELECT bill_id, room_charges + doctor_charges + medicine_charges + lab_charges + other_charges AS recomputed_total,
       total_amount
FROM Billing
WHERE ABS((room_charges + doctor_charges + medicine_charges + lab_charges + other_charges) - total_amount) > 0.02;

-- 8. Payment records with non-success status; keep separate from collections
SELECT payment_status, COUNT(*) AS transaction_count, ROUND(SUM(payment_amount),2) AS amount
FROM Payments
GROUP BY payment_status;

-- 9. Date range checks
SELECT MIN(appointment_date) AS first_appointment, MAX(appointment_date) AS last_appointment FROM Appointments;
SELECT MIN(bill_date) AS first_bill, MAX(bill_date) AS last_bill FROM Billing;
