-- MediCare SQL Analysis Pack | MySQL 8.0+
USE Hospital_Analytics_DB;

-- =========================================================
-- A. BASIC SQL: SELECT, WHERE, ORDER BY, LIMIT
-- =========================================================
-- A1. View hospitals
SELECT * FROM Hospitals ORDER BY hospital_name;

-- A2. Hospitals with bed capacity greater than 300
SELECT hospital_name, city, bed_capacity
FROM Hospitals
WHERE bed_capacity > 300
ORDER BY bed_capacity DESC;

-- A3. Doctors with consultation fee above 1,000
SELECT doctor_id, CONCAT(first_name, ' ', last_name) AS doctor_name,
       specialization, consultation_fee
FROM Doctors
WHERE consultation_fee > 1000
ORDER BY consultation_fee DESC
LIMIT 20;

-- A4. Patients registered during 2025
SELECT patient_id, first_name, last_name, registration_date
FROM Patients
WHERE registration_date >= '2025-01-01'
  AND registration_date < '2026-01-01'
ORDER BY registration_date;

-- =========================================================
-- B. AGGREGATION: COUNT, SUM, AVG, GROUP BY, HAVING
-- =========================================================
-- B1. Total hospitals, doctors and patients
SELECT (SELECT COUNT(*) FROM Hospitals) AS total_hospitals,
       (SELECT COUNT(*) FROM Doctors) AS total_doctors,
       (SELECT COUNT(*) FROM Patients) AS total_patients;

-- B2. Doctors by hospital
SELECT h.hospital_name, COUNT(d.doctor_id) AS total_doctors
FROM Hospitals h
LEFT JOIN Doctors d ON h.hospital_id = d.hospital_id
GROUP BY h.hospital_id, h.hospital_name
ORDER BY total_doctors DESC;

-- B3. Average consultation fee by specialization
SELECT specialization, COUNT(*) AS doctor_count,
       ROUND(AVG(consultation_fee), 2) AS avg_consultation_fee
FROM Doctors
GROUP BY specialization
ORDER BY avg_consultation_fee DESC;

-- B4. Departments with more than 100 appointments
SELECT d.department_id, d.department_name, COUNT(a.appointment_id) AS appointment_count
FROM Departments d
JOIN Doctors doc ON doc.department_id = d.department_id
JOIN Appointments a ON a.doctor_id = doc.doctor_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(a.appointment_id) > 100
ORDER BY appointment_count DESC;

-- B5. Pharmacy sales by medicine category
SELECT m.category, SUM(p.quantity) AS units_sold,
       ROUND(SUM(p.total_price), 2) AS pharmacy_revenue
FROM Pharmacy p
JOIN Medicines m ON p.medicine_id = m.medicine_id
GROUP BY m.category
ORDER BY pharmacy_revenue DESC;

-- =========================================================
-- C. JOINS: INNER, LEFT, RIGHT
-- =========================================================
-- C1. INNER JOIN: doctor and hospital details
SELECT d.doctor_id, CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
       d.specialization, h.hospital_name, h.city
FROM Doctors d
INNER JOIN Hospitals h ON d.hospital_id = h.hospital_id
ORDER BY h.hospital_name, doctor_name;

-- C2. LEFT JOIN: all hospitals, including those with no appointments
SELECT h.hospital_name, COUNT(a.appointment_id) AS appointment_count
FROM Hospitals h
LEFT JOIN Appointments a ON h.hospital_id = a.hospital_id
GROUP BY h.hospital_id, h.hospital_name
ORDER BY appointment_count DESC;

-- C3. RIGHT JOIN: show all hospitals with their departments
SELECT h.hospital_name, d.department_id, d.department_name
FROM Departments d
RIGHT JOIN Hospitals h ON d.hospital_id = h.hospital_id
ORDER BY h.hospital_name, d.department_name;

-- C4. Patient appointment history
SELECT p.patient_id, CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
       a.appointment_id, a.appointment_date, a.status,
       CONCAT(d.first_name, ' ', d.last_name) AS doctor_name
FROM Patients p
JOIN Appointments a ON p.patient_id = a.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id
ORDER BY p.patient_id, a.appointment_date;

-- =========================================================
-- D. HOSPITAL / DEPARTMENT / DOCTOR OPERATIONS
-- =========================================================
-- D1. Hospital operational activity: patients, appointments, admissions
-- DISTINCT patient counts prevent repeated activity from inflating patient totals.
SELECT h.hospital_id, h.hospital_name,
       COUNT(DISTINCT a.patient_id) AS patients_with_appointments,
       COUNT(DISTINCT a.appointment_id) AS appointments,
       COUNT(DISTINCT ad.admission_id) AS admissions
FROM Hospitals h
LEFT JOIN Appointments a ON h.hospital_id = a.hospital_id
LEFT JOIN Admissions ad ON h.hospital_id = ad.hospital_id
GROUP BY h.hospital_id, h.hospital_name
ORDER BY appointments DESC;

-- D2. Department appointment workload
SELECT d.department_name, h.hospital_name,
       COUNT(a.appointment_id) AS appointments
FROM Departments d
JOIN Hospitals h ON d.hospital_id = h.hospital_id
LEFT JOIN Doctors doc ON d.department_id = doc.department_id
LEFT JOIN Appointments a ON doc.doctor_id = a.doctor_id
GROUP BY d.department_id, d.department_name, h.hospital_name
ORDER BY appointments DESC;

-- D3. Doctor workload by appointments
SELECT doc.doctor_id, CONCAT(doc.first_name, ' ', doc.last_name) AS doctor_name,
       doc.specialization, COUNT(a.appointment_id) AS appointment_count
FROM Doctors doc
LEFT JOIN Appointments a ON doc.doctor_id = a.doctor_id
GROUP BY doc.doctor_id, doctor_name, doc.specialization
ORDER BY appointment_count DESC;

-- D4. Admissions by hospital and admission status
SELECT h.hospital_name, ad.admission_status, COUNT(*) AS admission_count
FROM Admissions ad
JOIN Hospitals h ON ad.hospital_id = h.hospital_id
GROUP BY h.hospital_id, h.hospital_name, ad.admission_status
ORDER BY h.hospital_name, admission_count DESC;

-- D5. Average length of stay for valid discharged admissions
SELECT h.hospital_name,
       ROUND(AVG(DATEDIFF(ad.discharge_date, ad.admission_date)), 2) AS avg_length_of_stay_days
FROM Admissions ad
JOIN Hospitals h ON ad.hospital_id = h.hospital_id
WHERE ad.discharge_date IS NOT NULL
  AND ad.discharge_date >= ad.admission_date
GROUP BY h.hospital_id, h.hospital_name
ORDER BY avg_length_of_stay_days DESC;

-- D6. Room distribution by hospital, type and status
SELECT h.hospital_name, r.room_type, r.room_status, COUNT(*) AS room_count
FROM Rooms r
JOIN Hospitals h ON r.hospital_id = h.hospital_id
GROUP BY h.hospital_id, h.hospital_name, r.room_type, r.room_status
ORDER BY h.hospital_name, room_count DESC;

-- D7. Occupied room percentage by hospital
SELECT h.hospital_name,
       COUNT(r.room_id) AS total_rooms,
       SUM(CASE WHEN LOWER(r.room_status) = 'occupied' THEN 1 ELSE 0 END) AS occupied_rooms,
       ROUND(100 * SUM(CASE WHEN LOWER(r.room_status) = 'occupied' THEN 1 ELSE 0 END)
             / NULLIF(COUNT(r.room_id), 0), 2) AS occupied_room_pct
FROM Hospitals h
LEFT JOIN Rooms r ON h.hospital_id = r.hospital_id
GROUP BY h.hospital_id, h.hospital_name
ORDER BY occupied_room_pct DESC;

-- =========================================================
-- E. HEALTHCARE SERVICE ANALYSIS
-- =========================================================
-- E1. Treatment volume and cost by treatment
SELECT treatment_name, COUNT(*) AS treatment_count,
       ROUND(SUM(treatment_cost), 2) AS total_treatment_cost,
       ROUND(AVG(treatment_cost), 2) AS avg_treatment_cost
FROM Treatments
GROUP BY treatment_name
ORDER BY treatment_count DESC;

-- E2. Laboratory volume, cost and status
SELECT test_name, test_status, COUNT(*) AS test_count,
       ROUND(SUM(test_cost), 2) AS total_test_cost
FROM Laboratory
GROUP BY test_name, test_status
ORDER BY test_count DESC;

-- E3. Top medicines by quantity and sales
SELECT m.medicine_name, m.category, SUM(p.quantity) AS quantity_sold,
       ROUND(SUM(p.total_price), 2) AS sales_amount
FROM Pharmacy p
JOIN Medicines m ON p.medicine_id = m.medicine_id
GROUP BY m.medicine_id, m.medicine_name, m.category
ORDER BY sales_amount DESC
LIMIT 15;

-- E4. Pharmacy stock attention: medicines with stock below 100
SELECT medicine_id, medicine_name, category, stock_quantity
FROM Medicines
WHERE stock_quantity < 100
ORDER BY stock_quantity;

-- =========================================================
-- F. BILLING AND PAYMENT ANALYSIS
-- =========================================================
-- F1. Total billed amount and bill status
SELECT bill_status, COUNT(*) AS bill_count,
       ROUND(SUM(total_amount), 2) AS billed_amount
FROM Billing
GROUP BY bill_status
ORDER BY billed_amount DESC;

-- F2. Revenue components
SELECT ROUND(SUM(room_charges),2) AS room_charges,
       ROUND(SUM(doctor_charges),2) AS doctor_charges,
       ROUND(SUM(medicine_charges),2) AS medicine_charges,
       ROUND(SUM(lab_charges),2) AS lab_charges,
       ROUND(SUM(other_charges),2) AS other_charges,
       ROUND(SUM(total_amount),2) AS total_billed
FROM Billing;

-- F3. Payment status and payment mode
SELECT payment_status, payment_mode, COUNT(*) AS payment_count,
       ROUND(SUM(payment_amount), 2) AS payment_value
FROM Payments
GROUP BY payment_status, payment_mode
ORDER BY payment_value DESC;

-- F4. Payment amount by bill, aggregated before joining to Billing.
-- This prevents one-to-many payment rows from duplicating bill totals.
WITH payment_by_bill AS (
    SELECT bill_id,
           SUM(CASE WHEN LOWER(payment_status) = 'success' THEN payment_amount ELSE 0 END) AS successful_payments,
           SUM(CASE WHEN LOWER(payment_status) = 'refunded' THEN payment_amount ELSE 0 END) AS refunds,
           COUNT(*) AS payment_transactions
    FROM Payments
    GROUP BY bill_id
)
SELECT b.bill_id, b.patient_id, b.total_amount AS billed_amount,
       COALESCE(p.successful_payments, 0) AS successful_payments,
       COALESCE(p.refunds, 0) AS refunded_amount,
       COALESCE(p.successful_payments, 0) - COALESCE(p.refunds, 0) AS net_collected,
       b.total_amount - (COALESCE(p.successful_payments, 0) - COALESCE(p.refunds, 0)) AS collection_gap
FROM Billing b
LEFT JOIN payment_by_bill p ON b.bill_id = p.bill_id
ORDER BY collection_gap DESC;

-- F5. Network-level collection KPIs, using payment-by-bill grain.
WITH payment_by_bill AS (
    SELECT bill_id,
           SUM(CASE WHEN LOWER(payment_status) = 'success' THEN payment_amount ELSE 0 END) AS successful_payments,
           SUM(CASE WHEN LOWER(payment_status) = 'refunded' THEN payment_amount ELSE 0 END) AS refunds
    FROM Payments
    GROUP BY bill_id
),
bill_collection AS (
    SELECT b.bill_id, b.total_amount,
           COALESCE(p.successful_payments,0) - COALESCE(p.refunds,0) AS net_collected
    FROM Billing b
    LEFT JOIN payment_by_bill p ON b.bill_id = p.bill_id
)
SELECT ROUND(SUM(total_amount),2) AS total_billed,
       ROUND(SUM(net_collected),2) AS net_collected,
       ROUND(SUM(total_amount - net_collected),2) AS collection_gap,
       ROUND(100 * SUM(net_collected) / NULLIF(SUM(total_amount),0),2) AS collection_rate_pct
FROM bill_collection;

-- F6. Top patients by billed amount
SELECT p.patient_id, CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
       ROUND(SUM(b.total_amount),2) AS total_billed
FROM Patients p
JOIN Billing b ON p.patient_id = b.patient_id
GROUP BY p.patient_id, patient_name
ORDER BY total_billed DESC
LIMIT 20;

-- =========================================================
-- G. WINDOW FUNCTIONS: ROW_NUMBER, RANK, LAG, LEAD
-- =========================================================
-- G1. ROW_NUMBER: rank doctors within each hospital by appointment workload
WITH doctor_workload AS (
    SELECT d.hospital_id, d.doctor_id,
           CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
           COUNT(a.appointment_id) AS appointments
    FROM Doctors d
    LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id
    GROUP BY d.hospital_id, d.doctor_id, doctor_name
)
SELECT hospital_id, doctor_id, doctor_name, appointments,
       ROW_NUMBER() OVER (PARTITION BY hospital_id ORDER BY appointments DESC, doctor_id) AS row_num
FROM doctor_workload;

-- G2. RANK: rank hospitals by appointment volume
WITH hospital_activity AS (
    SELECT h.hospital_id, h.hospital_name, COUNT(a.appointment_id) AS appointments
    FROM Hospitals h
    LEFT JOIN Appointments a ON h.hospital_id = a.hospital_id
    GROUP BY h.hospital_id, h.hospital_name
)
SELECT hospital_id, hospital_name, appointments,
       RANK() OVER (ORDER BY appointments DESC) AS hospital_rank
FROM hospital_activity;

-- G3. LAG: compare monthly appointment activity with previous month
WITH monthly_appointments AS (
    SELECT DATE_FORMAT(appointment_date, '%Y-%m-01') AS month_start,
           COUNT(*) AS appointment_count
    FROM Appointments
    GROUP BY DATE_FORMAT(appointment_date, '%Y-%m-01')
)
SELECT month_start, appointment_count,
       LAG(appointment_count) OVER (ORDER BY month_start) AS previous_month_count,
       appointment_count - LAG(appointment_count) OVER (ORDER BY month_start) AS month_over_month_change
FROM monthly_appointments
ORDER BY month_start;

-- G4. LEAD: compare current month's billing with next month
WITH monthly_billing AS (
    SELECT DATE_FORMAT(bill_date, '%Y-%m-01') AS month_start,
           SUM(total_amount) AS billed_amount
    FROM Billing
    GROUP BY DATE_FORMAT(bill_date, '%Y-%m-01')
)
SELECT month_start, ROUND(billed_amount,2) AS billed_amount,
       ROUND(LEAD(billed_amount) OVER (ORDER BY month_start),2) AS next_month_billed_amount
FROM monthly_billing
ORDER BY month_start;

-- =========================================================
-- H. KPI SUMMARY
-- =========================================================
SELECT
  (SELECT COUNT(*) FROM Patients) AS total_patients,
  (SELECT COUNT(*) FROM Appointments) AS total_appointments,
  (SELECT COUNT(*) FROM Admissions) AS total_admissions,
  (SELECT COUNT(*) FROM Treatments) AS total_treatments,
  (SELECT COUNT(*) FROM Laboratory) AS total_lab_activity,
  (SELECT COUNT(*) FROM Pharmacy) AS total_pharmacy_transactions,
  (SELECT ROUND(SUM(total_amount),2) FROM Billing) AS total_billed_amount,
  (SELECT ROUND(SUM(CASE WHEN LOWER(payment_status)='success' THEN payment_amount ELSE 0 END),2)
     FROM Payments) AS successful_payment_amount;
