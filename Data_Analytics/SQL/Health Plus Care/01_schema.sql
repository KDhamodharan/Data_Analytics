-- HealthPlus Care | MySQL 8.0+ schema
-- Source: HealthPlus_Care_DB_dataset.xlsx
CREATE DATABASE IF NOT EXISTS HealthPlus_Care_DB;
USE HealthPlus_Care_DB;
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `Clinics`;
DROP TABLE IF EXISTS `Specialists`;
DROP TABLE IF EXISTS `Members`;
DROP TABLE IF EXISTS `Corporates`;
DROP TABLE IF EXISTS `Corporate_Members`;
DROP TABLE IF EXISTS `Consultations`;
DROP TABLE IF EXISTS `Telemedicine_Sessions`;
DROP TABLE IF EXISTS `Chronic_Care_Programs`;
DROP TABLE IF EXISTS `Health_Packages`;
DROP TABLE IF EXISTS `Package_Subscriptions`;
DROP TABLE IF EXISTS `Prescriptions`;
DROP TABLE IF EXISTS `Lab_Tests`;
DROP TABLE IF EXISTS `Claims`;
DROP TABLE IF EXISTS `Staff`;
DROP TABLE IF EXISTS `Billing`;
DROP TABLE IF EXISTS `Payments`;
DROP TABLE IF EXISTS `Feedback`;

CREATE TABLE `Clinics` (
  `clinic_id` VARCHAR(10) NOT NULL,
  `clinic_name` VARCHAR(150) NULL,
  `clinic_type` VARCHAR(50) NULL,
  `city` VARCHAR(80) NULL,
  `state` VARCHAR(80) NULL,
  `established_year` SMALLINT NULL,
  `contact_number` VARCHAR(20) NULL,
  PRIMARY KEY (`clinic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Specialists` (
  `specialist_id` VARCHAR(10) NOT NULL,
  `first_name` VARCHAR(80) NULL,
  `last_name` VARCHAR(80) NULL,
  `gender` VARCHAR(20) NULL,
  `specialization` VARCHAR(100) NULL,
  `clinic_id` VARCHAR(10) NULL,
  `qualification` VARCHAR(100) NULL,
  `experience_years` TINYINT UNSIGNED NULL,
  `consultation_fee` DECIMAL(10,2) NULL,
  PRIMARY KEY (`specialist_id`),
  CONSTRAINT `fk_specialists_clinic_id` FOREIGN KEY (`clinic_id`) REFERENCES `Clinics` (`clinic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Members` (
  `member_id` VARCHAR(12) NOT NULL,
  `first_name` VARCHAR(80) NULL,
  `last_name` VARCHAR(80) NULL,
  `gender` VARCHAR(20) NULL,
  `date_of_birth` DATE NULL,
  `age` TINYINT UNSIGNED NULL,
  `city` VARCHAR(80) NULL,
  `membership_type` VARCHAR(40) NULL,
  `registration_date` DATE NULL,
  `phone_number` VARCHAR(20) NULL,
  `email` VARCHAR(150) NULL,
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Corporates` (
  `corporate_id` VARCHAR(10) NOT NULL,
  `company_name` VARCHAR(150) NULL,
  `industry` VARCHAR(100) NULL,
  `city` VARCHAR(80) NULL,
  `contract_start_date` DATE NULL,
  `contract_end_date` DATE NULL,
  `employee_count` INT UNSIGNED NULL,
  PRIMARY KEY (`corporate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Corporate_Members` (
  `corporate_member_id` VARCHAR(12) NOT NULL,
  `corporate_id` VARCHAR(10) NULL,
  `member_id` VARCHAR(12) NULL,
  `designation` VARCHAR(80) NULL,
  `enrollment_date` DATE NULL,
  PRIMARY KEY (`corporate_member_id`),
  CONSTRAINT `fk_corporate_members_corporate_id` FOREIGN KEY (`corporate_id`) REFERENCES `Corporates` (`corporate_id`),
  CONSTRAINT `fk_corporate_members_member_id` FOREIGN KEY (`member_id`) REFERENCES `Members` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Consultations` (
  `consultation_id` VARCHAR(12) NOT NULL,
  `member_id` VARCHAR(12) NULL,
  `specialist_id` VARCHAR(10) NULL,
  `clinic_id` VARCHAR(10) NULL,
  `consultation_date` DATE NULL,
  `consultation_mode` VARCHAR(30) NULL,
  `status` VARCHAR(30) NULL,
  `reason_for_visit` VARCHAR(120) NULL,
  PRIMARY KEY (`consultation_id`),
  CONSTRAINT `fk_consultations_member_id` FOREIGN KEY (`member_id`) REFERENCES `Members` (`member_id`),
  CONSTRAINT `fk_consultations_specialist_id` FOREIGN KEY (`specialist_id`) REFERENCES `Specialists` (`specialist_id`),
  CONSTRAINT `fk_consultations_clinic_id` FOREIGN KEY (`clinic_id`) REFERENCES `Clinics` (`clinic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Telemedicine_Sessions` (
  `session_id` VARCHAR(12) NOT NULL,
  `consultation_id` VARCHAR(12) NULL,
  `session_start_time` DATETIME NULL,
  `session_end_time` DATETIME NULL,
  `platform` VARCHAR(40) NULL,
  `connection_quality` VARCHAR(30) NULL,
  `session_status` VARCHAR(30) NULL,
  PRIMARY KEY (`session_id`),
  CONSTRAINT `fk_telemedicine_sessions_consultation_id` FOREIGN KEY (`consultation_id`) REFERENCES `Consultations` (`consultation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Chronic_Care_Programs` (
  `program_id` VARCHAR(12) NOT NULL,
  `member_id` VARCHAR(12) NULL,
  `specialist_id` VARCHAR(10) NULL,
  `condition_name` VARCHAR(100) NULL,
  `enrollment_date` DATE NULL,
  `program_status` VARCHAR(30) NULL,
  `next_review_date` DATE NULL,
  PRIMARY KEY (`program_id`),
  CONSTRAINT `fk_chronic_care_programs_member_id` FOREIGN KEY (`member_id`) REFERENCES `Members` (`member_id`),
  CONSTRAINT `fk_chronic_care_programs_specialist_id` FOREIGN KEY (`specialist_id`) REFERENCES `Specialists` (`specialist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Health_Packages` (
  `package_id` VARCHAR(10) NOT NULL,
  `package_name` VARCHAR(150) NULL,
  `package_type` VARCHAR(50) NULL,
  `price` DECIMAL(10,2) NULL,
  `validity_days` SMALLINT UNSIGNED NULL,
  `tests_included` SMALLINT UNSIGNED NULL,
  PRIMARY KEY (`package_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Package_Subscriptions` (
  `subscription_id` VARCHAR(12) NOT NULL,
  `member_id` VARCHAR(12) NULL,
  `package_id` VARCHAR(10) NULL,
  `subscription_date` DATE NULL,
  `expiry_date` DATE NULL,
  `payment_status` VARCHAR(30) NULL,
  PRIMARY KEY (`subscription_id`),
  CONSTRAINT `fk_package_subscriptions_member_id` FOREIGN KEY (`member_id`) REFERENCES `Members` (`member_id`),
  CONSTRAINT `fk_package_subscriptions_package_id` FOREIGN KEY (`package_id`) REFERENCES `Health_Packages` (`package_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Prescriptions` (
  `prescription_id` VARCHAR(12) NOT NULL,
  `consultation_id` VARCHAR(12) NULL,
  `member_id` VARCHAR(12) NULL,
  `specialist_id` VARCHAR(10) NULL,
  `medicine_name` VARCHAR(150) NULL,
  `dosage` VARCHAR(80) NULL,
  `duration_days` SMALLINT UNSIGNED NULL,
  `prescribed_date` DATE NULL,
  PRIMARY KEY (`prescription_id`),
  CONSTRAINT `fk_prescriptions_consultation_id` FOREIGN KEY (`consultation_id`) REFERENCES `Consultations` (`consultation_id`),
  CONSTRAINT `fk_prescriptions_member_id` FOREIGN KEY (`member_id`) REFERENCES `Members` (`member_id`),
  CONSTRAINT `fk_prescriptions_specialist_id` FOREIGN KEY (`specialist_id`) REFERENCES `Specialists` (`specialist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Lab_Tests` (
  `lab_test_id` VARCHAR(12) NOT NULL,
  `member_id` VARCHAR(12) NULL,
  `clinic_id` VARCHAR(10) NULL,
  `test_name` VARCHAR(120) NULL,
  `test_date` DATE NULL,
  `test_result` VARCHAR(80) NULL,
  `test_cost` DECIMAL(10,2) NULL,
  `test_status` VARCHAR(30) NULL,
  PRIMARY KEY (`lab_test_id`),
  CONSTRAINT `fk_lab_tests_member_id` FOREIGN KEY (`member_id`) REFERENCES `Members` (`member_id`),
  CONSTRAINT `fk_lab_tests_clinic_id` FOREIGN KEY (`clinic_id`) REFERENCES `Clinics` (`clinic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Claims` (
  `claim_id` VARCHAR(12) NOT NULL,
  `member_id` VARCHAR(12) NULL,
  `consultation_id` VARCHAR(12) NULL,
  `claim_amount` DECIMAL(12,2) NULL,
  `claim_date` DATE NULL,
  `claim_status` VARCHAR(30) NULL,
  `insurance_provider` VARCHAR(150) NULL,
  PRIMARY KEY (`claim_id`),
  CONSTRAINT `fk_claims_member_id` FOREIGN KEY (`member_id`) REFERENCES `Members` (`member_id`),
  CONSTRAINT `fk_claims_consultation_id` FOREIGN KEY (`consultation_id`) REFERENCES `Consultations` (`consultation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Staff` (
  `staff_id` VARCHAR(10) NOT NULL,
  `clinic_id` VARCHAR(10) NULL,
  `first_name` VARCHAR(80) NULL,
  `last_name` VARCHAR(80) NULL,
  `designation` VARCHAR(100) NULL,
  `employment_type` VARCHAR(40) NULL,
  `salary` DECIMAL(12,2) NULL,
  `joining_date` DATE NULL,
  PRIMARY KEY (`staff_id`),
  CONSTRAINT `fk_staff_clinic_id` FOREIGN KEY (`clinic_id`) REFERENCES `Clinics` (`clinic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Billing` (
  `bill_id` VARCHAR(12) NOT NULL,
  `member_id` VARCHAR(12) NULL,
  `consultation_id` VARCHAR(12) NULL,
  `bill_date` DATE NULL,
  `consultation_charges` DECIMAL(12,2) NULL,
  `lab_charges` DECIMAL(12,2) NULL,
  `medicine_charges` DECIMAL(12,2) NULL,
  `total_amount` DECIMAL(12,2) NULL,
  `bill_status` VARCHAR(30) NULL,
  PRIMARY KEY (`bill_id`),
  CONSTRAINT `fk_billing_member_id` FOREIGN KEY (`member_id`) REFERENCES `Members` (`member_id`),
  CONSTRAINT `fk_billing_consultation_id` FOREIGN KEY (`consultation_id`) REFERENCES `Consultations` (`consultation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Payments` (
  `payment_id` VARCHAR(12) NOT NULL,
  `bill_id` VARCHAR(12) NULL,
  `member_id` VARCHAR(12) NULL,
  `payment_date` DATE NULL,
  `payment_amount` DECIMAL(12,2) NULL,
  `payment_mode` VARCHAR(40) NULL,
  `payment_status` VARCHAR(30) NULL,
  PRIMARY KEY (`payment_id`),
  CONSTRAINT `fk_payments_bill_id` FOREIGN KEY (`bill_id`) REFERENCES `Billing` (`bill_id`),
  CONSTRAINT `fk_payments_member_id` FOREIGN KEY (`member_id`) REFERENCES `Members` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Feedback` (
  `feedback_id` VARCHAR(12) NOT NULL,
  `member_id` VARCHAR(12) NULL,
  `consultation_id` VARCHAR(12) NULL,
  `rating` TINYINT UNSIGNED NULL,
  `feedback_text` TEXT NULL,
  `feedback_date` DATE NULL,
  PRIMARY KEY (`feedback_id`),
  CONSTRAINT `fk_feedback_member_id` FOREIGN KEY (`member_id`) REFERENCES `Members` (`member_id`),
  CONSTRAINT `fk_feedback_consultation_id` FOREIGN KEY (`consultation_id`) REFERENCES `Consultations` (`consultation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
SET FOREIGN_KEY_CHECKS = 1;