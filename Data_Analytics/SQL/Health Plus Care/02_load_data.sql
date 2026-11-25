-- Run after 01_schema.sql. Enable LOCAL INFILE in your MySQL client/Workbench if prompted.
USE HealthPlus_Care_DB;
-- Execute from the project root, or replace data/ with the absolute CSV folder path.

LOAD DATA LOCAL INFILE 'data/Clinics.csv' INTO TABLE `Clinics`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`clinic_id`, `clinic_name`, `clinic_type`, `city`, `state`, `established_year`, `contact_number`);

LOAD DATA LOCAL INFILE 'data/Specialists.csv' INTO TABLE `Specialists`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`specialist_id`, `first_name`, `last_name`, `gender`, `specialization`, `clinic_id`, `qualification`, `experience_years`, `consultation_fee`);

LOAD DATA LOCAL INFILE 'data/Members.csv' INTO TABLE `Members`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`member_id`, `first_name`, `last_name`, `gender`, `date_of_birth`, `age`, `city`, `membership_type`, `registration_date`, `phone_number`, `email`);

LOAD DATA LOCAL INFILE 'data/Corporates.csv' INTO TABLE `Corporates`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`corporate_id`, `company_name`, `industry`, `city`, `contract_start_date`, `contract_end_date`, `employee_count`);

LOAD DATA LOCAL INFILE 'data/Health_Packages.csv' INTO TABLE `Health_Packages`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`package_id`, `package_name`, `package_type`, `price`, `validity_days`, `tests_included`);

LOAD DATA LOCAL INFILE 'data/Corporate_Members.csv' INTO TABLE `Corporate_Members`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`corporate_member_id`, `corporate_id`, `member_id`, `designation`, `enrollment_date`);

LOAD DATA LOCAL INFILE 'data/Consultations.csv' INTO TABLE `Consultations`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`consultation_id`, `member_id`, `specialist_id`, `clinic_id`, `consultation_date`, `consultation_mode`, `status`, `reason_for_visit`);

LOAD DATA LOCAL INFILE 'data/Telemedicine_Sessions.csv' INTO TABLE `Telemedicine_Sessions`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`session_id`, `consultation_id`, `session_start_time`, `session_end_time`, `platform`, `connection_quality`, `session_status`);

LOAD DATA LOCAL INFILE 'data/Chronic_Care_Programs.csv' INTO TABLE `Chronic_Care_Programs`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`program_id`, `member_id`, `specialist_id`, `condition_name`, `enrollment_date`, `program_status`, `next_review_date`);

LOAD DATA LOCAL INFILE 'data/Package_Subscriptions.csv' INTO TABLE `Package_Subscriptions`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`subscription_id`, `member_id`, `package_id`, `subscription_date`, `expiry_date`, `payment_status`);

LOAD DATA LOCAL INFILE 'data/Prescriptions.csv' INTO TABLE `Prescriptions`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`prescription_id`, `consultation_id`, `member_id`, `specialist_id`, `medicine_name`, `dosage`, `duration_days`, `prescribed_date`);

LOAD DATA LOCAL INFILE 'data/Lab_Tests.csv' INTO TABLE `Lab_Tests`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`lab_test_id`, `member_id`, `clinic_id`, `test_name`, `test_date`, `test_result`, `test_cost`, `test_status`);

LOAD DATA LOCAL INFILE 'data/Claims.csv' INTO TABLE `Claims`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`claim_id`, `member_id`, `consultation_id`, `claim_amount`, `claim_date`, `claim_status`, `insurance_provider`);

LOAD DATA LOCAL INFILE 'data/Staff.csv' INTO TABLE `Staff`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`staff_id`, `clinic_id`, `first_name`, `last_name`, `designation`, `employment_type`, `salary`, `joining_date`);

LOAD DATA LOCAL INFILE 'data/Billing.csv' INTO TABLE `Billing`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`bill_id`, `member_id`, `consultation_id`, `bill_date`, `consultation_charges`, `lab_charges`, `medicine_charges`, `total_amount`, `bill_status`);

LOAD DATA LOCAL INFILE 'data/Payments.csv' INTO TABLE `Payments`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`payment_id`, `bill_id`, `member_id`, `payment_date`, `payment_amount`, `payment_mode`, `payment_status`);

LOAD DATA LOCAL INFILE 'data/Feedback.csv' INTO TABLE `Feedback`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`feedback_id`, `member_id`, `consultation_id`, `rating`, `feedback_text`, `feedback_date`);