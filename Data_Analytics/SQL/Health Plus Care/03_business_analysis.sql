-- HealthPlus Care | Business analysis queries | MySQL 8.0+
USE HealthPlus_Care_DB;

-- SECTION A: CORE SERVICE UTILIZATION
-- Q01. Overall registered member base
SELECT COUNT(*) AS total_members FROM Members;

-- Q02. Total consultations and status distribution
SELECT status, COUNT(*) AS consultation_count
FROM Consultations GROUP BY status ORDER BY consultation_count DESC;

-- Q03. Clinics with highest consultation volume
SELECT c.clinic_id, c.clinic_name, c.city, COUNT(co.consultation_id) AS consultation_count
FROM Clinics c LEFT JOIN Consultations co ON c.clinic_id=co.clinic_id
GROUP BY c.clinic_id,c.clinic_name,c.city
ORDER BY consultation_count DESC;

-- Q04. Specialist workload
SELECT s.specialist_id, CONCAT(s.first_name,' ',s.last_name) AS specialist_name,
       s.specialization, COUNT(co.consultation_id) AS consultation_count
FROM Specialists s LEFT JOIN Consultations co ON s.specialist_id=co.specialist_id
GROUP BY s.specialist_id,specialist_name,s.specialization
ORDER BY consultation_count DESC LIMIT 20;

-- Q05. Specializations with highest activity
SELECT s.specialization, COUNT(co.consultation_id) AS consultation_count
FROM Specialists s JOIN Consultations co ON s.specialist_id=co.specialist_id
GROUP BY s.specialization ORDER BY consultation_count DESC;

-- Q06. Most active members
SELECT m.member_id, CONCAT(m.first_name,' ',m.last_name) AS member_name,
       m.membership_type, COUNT(c.consultation_id) AS consultations
FROM Members m JOIN Consultations c ON m.member_id=c.member_id
GROUP BY m.member_id,member_name,m.membership_type
ORDER BY consultations DESC LIMIT 20;

-- Q07. Consultation mode comparison
SELECT consultation_mode, COUNT(*) AS consultations,
       ROUND(100*COUNT(*)/(SELECT COUNT(*) FROM Consultations),2) AS percentage
FROM Consultations GROUP BY consultation_mode ORDER BY consultations DESC;

-- Q08. Most common reasons for visit
SELECT reason_for_visit, COUNT(*) AS visit_count
FROM Consultations GROUP BY reason_for_visit ORDER BY visit_count DESC LIMIT 15;

-- Q09. Consultation status by clinic
SELECT cl.clinic_name, c.status, COUNT(*) AS status_count
FROM Consultations c JOIN Clinics cl ON c.clinic_id=cl.clinic_id
GROUP BY cl.clinic_name,c.status ORDER BY cl.clinic_name,status_count DESC;

-- Q10. Registered members with no consultations (LEFT JOIN)
SELECT m.member_id, CONCAT(m.first_name,' ',m.last_name) AS member_name
FROM Members m LEFT JOIN Consultations c ON m.member_id=c.member_id
WHERE c.consultation_id IS NULL ORDER BY m.member_id;

-- Q11. Consultations without feedback
SELECT c.consultation_id,c.member_id,c.consultation_date,c.consultation_mode
FROM Consultations c LEFT JOIN Feedback f ON c.consultation_id=f.consultation_id
WHERE f.feedback_id IS NULL ORDER BY c.consultation_date DESC;

-- SECTION B: TELEMEDICINE
-- Q12. Telemedicine session count and session status
SELECT session_status,COUNT(*) AS sessions
FROM Telemedicine_Sessions GROUP BY session_status ORDER BY sessions DESC;

-- Q13. Platform adoption and connection quality
SELECT platform,connection_quality,COUNT(*) AS session_count
FROM Telemedicine_Sessions GROUP BY platform,connection_quality
ORDER BY session_count DESC;

-- Q14. Average session duration in minutes (negative/invalid durations excluded)
SELECT ROUND(AVG(TIMESTAMPDIFF(MINUTE,session_start_time,session_end_time)),2) AS avg_duration_minutes,
       MIN(TIMESTAMPDIFF(MINUTE,session_start_time,session_end_time)) AS min_duration_minutes,
       MAX(TIMESTAMPDIFF(MINUTE,session_start_time,session_end_time)) AS max_duration_minutes
FROM Telemedicine_Sessions
WHERE session_end_time >= session_start_time;

-- Q15. Clinics with most telemedicine sessions
SELECT cl.clinic_name,COUNT(ts.session_id) AS telemedicine_sessions
FROM Clinics cl JOIN Consultations c ON cl.clinic_id=c.clinic_id
JOIN Telemedicine_Sessions ts ON c.consultation_id=ts.consultation_id
GROUP BY cl.clinic_name ORDER BY telemedicine_sessions DESC;

-- SECTION C: CHRONIC CARE AND PACKAGES
-- Q16. Chronic care enrollment by condition
SELECT condition_name,COUNT(*) AS program_count
FROM Chronic_Care_Programs GROUP BY condition_name ORDER BY program_count DESC;

-- Q17. Chronic care program status mix
SELECT program_status,COUNT(*) AS program_count
FROM Chronic_Care_Programs GROUP BY program_status ORDER BY program_count DESC;

-- Q18. Specialists managing the most chronic care programs
SELECT s.specialist_id,CONCAT(s.first_name,' ',s.last_name) AS specialist_name,
       s.specialization,COUNT(cc.program_id) AS program_count
FROM Specialists s JOIN Chronic_Care_Programs cc ON s.specialist_id=cc.specialist_id
GROUP BY s.specialist_id,specialist_name,s.specialization
ORDER BY program_count DESC LIMIT 20;

-- Q19. Reviews due in the next 30 days (relative to execution date)
SELECT cc.program_id,cc.member_id,cc.condition_name,cc.next_review_date,
       DATEDIFF(cc.next_review_date,CURDATE()) AS days_until_review
FROM Chronic_Care_Programs cc
WHERE cc.next_review_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(),INTERVAL 30 DAY)
ORDER BY cc.next_review_date;

-- Q20. Packages with highest subscription volume
SELECT hp.package_id,hp.package_name,hp.package_type,hp.price,hp.validity_days,
       COUNT(ps.subscription_id) AS subscriptions
FROM Health_Packages hp LEFT JOIN Package_Subscriptions ps ON hp.package_id=ps.package_id
GROUP BY hp.package_id,hp.package_name,hp.package_type,hp.price,hp.validity_days
ORDER BY subscriptions DESC;

-- Q21. Subscription lifecycle and payment status
SELECT CASE WHEN expiry_date<CURDATE() THEN 'Expired' ELSE 'Not yet expired' END AS expiry_group,
       payment_status,COUNT(*) AS subscriptions
FROM Package_Subscriptions GROUP BY expiry_group,payment_status
ORDER BY expiry_group,payment_status;

-- Q22. Subscriptions expiring in next 30 days
SELECT subscription_id,member_id,package_id,expiry_date,payment_status
FROM Package_Subscriptions
WHERE expiry_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(),INTERVAL 30 DAY)
ORDER BY expiry_date;

-- SECTION D: CORPORATE HEALTHCARE
-- Q23. Corporates contributing the most enrolled members
SELECT co.corporate_id,co.company_name,co.industry,co.employee_count,
       COUNT(cm.corporate_member_id) AS enrolled_members,
       ROUND(100*COUNT(cm.corporate_member_id)/NULLIF(co.employee_count,0),2) AS enrollment_vs_employee_count_pct
FROM Corporates co LEFT JOIN Corporate_Members cm ON co.corporate_id=cm.corporate_id
GROUP BY co.corporate_id,co.company_name,co.industry,co.employee_count
ORDER BY enrolled_members DESC;

-- Q24. Corporate enrollment by industry
SELECT co.industry,COUNT(cm.corporate_member_id) AS enrolled_members,
       COUNT(DISTINCT co.corporate_id) AS corporate_clients
FROM Corporates co LEFT JOIN Corporate_Members cm ON co.corporate_id=cm.corporate_id
GROUP BY co.industry ORDER BY enrolled_members DESC;

-- Q25. Corporate-enrolled members who have used consultations
SELECT COUNT(DISTINCT cm.member_id) AS corporate_members_with_consultations
FROM Corporate_Members cm JOIN Consultations c ON cm.member_id=c.member_id;

-- SECTION E: PRESCRIPTIONS AND LABORATORY
-- Q26. Most frequently prescribed medicines
SELECT medicine_name,COUNT(*) AS prescription_count,
       ROUND(AVG(duration_days),1) AS avg_duration_days
FROM Prescriptions GROUP BY medicine_name ORDER BY prescription_count DESC LIMIT 20;

-- Q27. Specialists generating the highest prescription volume
SELECT s.specialist_id,CONCAT(s.first_name,' ',s.last_name) AS specialist_name,
       s.specialization,COUNT(p.prescription_id) AS prescription_count
FROM Specialists s LEFT JOIN Prescriptions p ON s.specialist_id=p.specialist_id
GROUP BY s.specialist_id,specialist_name,s.specialization
ORDER BY prescription_count DESC LIMIT 20;

-- Q28. Lab tests with highest total diagnostic cost
SELECT test_name,COUNT(*) AS test_count,ROUND(SUM(test_cost),2) AS total_test_cost,
       ROUND(AVG(test_cost),2) AS avg_test_cost
FROM Lab_Tests GROUP BY test_name ORDER BY total_test_cost DESC LIMIT 20;

-- Q29. Clinic laboratory workload
SELECT cl.clinic_id,cl.clinic_name,COUNT(lt.lab_test_id) AS lab_test_count,
       ROUND(SUM(lt.test_cost),2) AS total_lab_cost
FROM Clinics cl LEFT JOIN Lab_Tests lt ON cl.clinic_id=lt.clinic_id
GROUP BY cl.clinic_id,cl.clinic_name ORDER BY lab_test_count DESC;

-- Q30. Laboratory test status mix
SELECT test_status,COUNT(*) AS test_count,
       ROUND(100*COUNT(*)/(SELECT COUNT(*) FROM Lab_Tests),2) AS percentage
FROM Lab_Tests GROUP BY test_status ORDER BY test_count DESC;

-- SECTION F: INSURANCE CLAIMS
-- Q31. Claim status distribution
SELECT claim_status,COUNT(*) AS claim_count,ROUND(SUM(claim_amount),2) AS claim_value
FROM Claims GROUP BY claim_status ORDER BY claim_count DESC;

-- Q32. Insurance providers by claim amount
SELECT insurance_provider,COUNT(*) AS claim_count,
       ROUND(SUM(claim_amount),2) AS total_claim_amount,
       ROUND(AVG(claim_amount),2) AS avg_claim_amount
FROM Claims GROUP BY insurance_provider ORDER BY total_claim_amount DESC;

-- Q33. Claims without a linked consultation (allowed nullable relationship)
SELECT claim_id,member_id,claim_amount,claim_status,claim_date
FROM Claims WHERE consultation_id IS NULL;

-- SECTION G: BILLING AND COLLECTION
-- Q34. Total billing and charge components
SELECT COUNT(*) AS bill_count,ROUND(SUM(total_amount),2) AS total_billed,
       ROUND(SUM(consultation_charges),2) AS consultation_charges,
       ROUND(SUM(lab_charges),2) AS lab_charges,
       ROUND(SUM(medicine_charges),2) AS medicine_charges
FROM Billing;

-- Q35. Payments by status and mode
SELECT payment_status,COALESCE(payment_mode,'Not recorded') AS payment_mode,
       COUNT(*) AS payment_records,ROUND(SUM(payment_amount),2) AS payment_amount
FROM Payments GROUP BY payment_status,payment_mode ORDER BY payment_status,payment_amount DESC;

-- Q36. Validate bill/payment grain before calculating collection gap
SELECT COUNT(*) AS payment_rows,COUNT(DISTINCT bill_id) AS distinct_bills,
       COUNT(*)-COUNT(DISTINCT bill_id) AS extra_payment_rows
FROM Payments;

-- Q37. Collection gap using one aggregated payment total per bill
WITH payment_by_bill AS (
    SELECT bill_id,SUM(CASE WHEN payment_status='Success' THEN payment_amount ELSE 0 END) AS successful_paid
    FROM Payments GROUP BY bill_id
)
SELECT ROUND(SUM(b.total_amount),2) AS total_billed,
       ROUND(SUM(COALESCE(p.successful_paid,0)),2) AS successful_payments,
       ROUND(SUM(b.total_amount-COALESCE(p.successful_paid,0)),2) AS collection_gap
FROM Billing b LEFT JOIN payment_by_bill p ON b.bill_id=p.bill_id;

-- Q38. Bills with amount mismatch against successful payment amount
WITH payment_by_bill AS (
    SELECT bill_id,SUM(CASE WHEN payment_status='Success' THEN payment_amount ELSE 0 END) AS successful_paid
    FROM Payments GROUP BY bill_id
)
SELECT b.bill_id,b.total_amount,COALESCE(p.successful_paid,0) AS successful_paid,
       ROUND(b.total_amount-COALESCE(p.successful_paid,0),2) AS difference
FROM Billing b LEFT JOIN payment_by_bill p ON b.bill_id=p.bill_id
WHERE ABS(b.total_amount-COALESCE(p.successful_paid,0))>0.01
ORDER BY ABS(difference) DESC;

-- SECTION H: MEMBER EXPERIENCE AND WORKFORCE
-- Q39. Average feedback rating overall
SELECT ROUND(AVG(rating),2) AS average_rating,COUNT(*) AS feedback_count
FROM Feedback;

-- Q40. Average rating by clinic
SELECT cl.clinic_name,ROUND(AVG(f.rating),2) AS avg_rating,COUNT(f.feedback_id) AS feedback_count
FROM Clinics cl JOIN Consultations c ON cl.clinic_id=c.clinic_id
JOIN Feedback f ON c.consultation_id=f.consultation_id
GROUP BY cl.clinic_name ORDER BY avg_rating DESC;

-- Q41. Average rating by specialist
SELECT s.specialist_id,CONCAT(s.first_name,' ',s.last_name) AS specialist_name,
       s.specialization,ROUND(AVG(f.rating),2) AS avg_rating,COUNT(f.feedback_id) AS feedback_count
FROM Specialists s JOIN Consultations c ON s.specialist_id=c.specialist_id
JOIN Feedback f ON c.consultation_id=f.consultation_id
GROUP BY s.specialist_id,specialist_name,s.specialization
HAVING COUNT(f.feedback_id)>=5 ORDER BY avg_rating DESC;

-- Q42. Satisfaction by consultation mode
SELECT c.consultation_mode,ROUND(AVG(f.rating),2) AS avg_rating,COUNT(*) AS feedback_count
FROM Consultations c JOIN Feedback f ON c.consultation_id=f.consultation_id
GROUP BY c.consultation_mode ORDER BY avg_rating DESC;

-- Q43. Staff distribution by clinic and designation
SELECT cl.clinic_name,s.designation,COUNT(*) AS staff_count
FROM Staff s JOIN Clinics cl ON s.clinic_id=cl.clinic_id
GROUP BY cl.clinic_name,s.designation ORDER BY cl.clinic_name,staff_count DESC;

-- Q44. Average salary by clinic and employment type
SELECT cl.clinic_name,s.employment_type,COUNT(*) AS staff_count,
       ROUND(AVG(s.salary),2) AS avg_salary
FROM Staff s JOIN Clinics cl ON s.clinic_id=cl.clinic_id
GROUP BY cl.clinic_name,s.employment_type ORDER BY cl.clinic_name,avg_salary DESC;

-- Q45. Workforce joining trend by year
SELECT YEAR(joining_date) AS joining_year,COUNT(*) AS staff_joined
FROM Staff GROUP BY YEAR(joining_date) ORDER BY joining_year;

-- SECTION I: WINDOW FUNCTIONS
-- Q46. ROW_NUMBER: sequence each member's consultations by date
SELECT member_id,consultation_id,consultation_date,
       ROW_NUMBER() OVER(PARTITION BY member_id ORDER BY consultation_date,consultation_id) AS visit_number
FROM Consultations;

-- Q47. RANK: rank clinics by consultation activity (ties receive same rank)
WITH clinic_activity AS (
    SELECT cl.clinic_id,cl.clinic_name,COUNT(c.consultation_id) AS consultations
    FROM Clinics cl LEFT JOIN Consultations c ON cl.clinic_id=c.clinic_id
    GROUP BY cl.clinic_id,cl.clinic_name
)
SELECT clinic_id,clinic_name,consultations,
       RANK() OVER(ORDER BY consultations DESC) AS activity_rank
FROM clinic_activity;

-- Q48. LAG: compare each member's consultation date with previous visit
WITH member_visits AS (
    SELECT member_id,consultation_id,consultation_date,
           LAG(consultation_date) OVER(PARTITION BY member_id ORDER BY consultation_date,consultation_id) AS previous_visit_date
    FROM Consultations
)
SELECT *,DATEDIFF(consultation_date,previous_visit_date) AS days_since_previous_visit
FROM member_visits;

-- Q49. LEAD: identify the next consultation date for each member
SELECT member_id,consultation_id,consultation_date,
       LEAD(consultation_date) OVER(PARTITION BY member_id ORDER BY consultation_date,consultation_id) AS next_visit_date
FROM Consultations;

-- Q50. RIGHT JOIN: retain all clinics and show matching specialists (including clinics with none)
SELECT cl.clinic_id,cl.clinic_name,s.specialist_id,
       CONCAT(s.first_name,' ',s.last_name) AS specialist_name
FROM Specialists s RIGHT JOIN Clinics cl ON s.clinic_id=cl.clinic_id
ORDER BY cl.clinic_id,s.specialist_id;

-- Q51. Members with consultations but no feedback, grouped by membership type
SELECT m.membership_type,COUNT(DISTINCT c.member_id) AS members_without_feedback
FROM Members m JOIN Consultations c ON m.member_id=c.member_id
LEFT JOIN Feedback f ON c.consultation_id=f.consultation_id
WHERE f.feedback_id IS NULL
GROUP BY m.membership_type ORDER BY members_without_feedback DESC;

-- Q52. Combined management scorecard (core volumes and experience)
SELECT
 (SELECT COUNT(*) FROM Members) AS total_members,
 (SELECT COUNT(*) FROM Consultations) AS total_consultations,
 (SELECT COUNT(*) FROM Telemedicine_Sessions) AS telemedicine_sessions,
 (SELECT COUNT(*) FROM Chronic_Care_Programs WHERE program_status='Active') AS active_chronic_programs,
 (SELECT COUNT(*) FROM Package_Subscriptions) AS package_subscriptions,
 (SELECT COUNT(*) FROM Lab_Tests) AS total_lab_tests,
 (SELECT ROUND(SUM(total_amount),2) FROM Billing) AS total_billed_amount,
 (SELECT ROUND(SUM(payment_amount),2) FROM Payments WHERE payment_status='Success') AS successful_payment_amount,
 (SELECT ROUND(AVG(rating),2) FROM Feedback) AS average_feedback_rating;
