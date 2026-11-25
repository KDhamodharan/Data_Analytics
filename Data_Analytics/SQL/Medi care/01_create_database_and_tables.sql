-- MediCare Healthcare Operations & Revenue Analytics
-- MySQL 8.0+ | Generated from the supplied Hospital_Analytics_DB_dataset.xlsx
CREATE DATABASE IF NOT EXISTS Hospital_Analytics_DB CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE Hospital_Analytics_DB;
SET NAMES utf8mb4;

DROP TABLE IF EXISTS `Hospitals`;
CREATE TABLE `Hospitals` (
  `hospital_id` VARCHAR(30) NOT NULL,
  `hospital_name` VARCHAR(500) NULL,
  `hospital_type` VARCHAR(150) NULL,
  `city` VARCHAR(150) NULL,
  `state` VARCHAR(150) NULL,
  `region` VARCHAR(150) NULL,
  `bed_capacity` INT NULL,
  `established_year` INT NULL,
  `contact_number` VARCHAR(25) NULL,
  `email` VARCHAR(255) NULL,
  PRIMARY KEY (`hospital_id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `Departments`;
CREATE TABLE `Departments` (
  `department_id` VARCHAR(30) NOT NULL,
  `department_name` VARCHAR(150) NULL,
  `hospital_id` VARCHAR(30) NULL,
  `floor_number` INT NULL,
  `head_doctor_id` VARCHAR(30) NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `Doctors`;
CREATE TABLE `Doctors` (
  `doctor_id` VARCHAR(30) NOT NULL,
  `first_name` VARCHAR(150) NULL,
  `last_name` VARCHAR(150) NULL,
  `gender` VARCHAR(150) NULL,
  `specialization` VARCHAR(150) NULL,
  `department_id` VARCHAR(30) NULL,
  `hospital_id` VARCHAR(30) NULL,
  `qualification` VARCHAR(500) NULL,
  `experience_years` INT NULL,
  `consultation_fee` DECIMAL(14,2) NULL,
  `phone_number` VARCHAR(25) NULL,
  `email` VARCHAR(255) NULL,
  `joining_date` DATE NULL,
  PRIMARY KEY (`doctor_id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `Patients`;
CREATE TABLE `Patients` (
  `patient_id` VARCHAR(30) NOT NULL,
  `first_name` VARCHAR(150) NULL,
  `last_name` VARCHAR(150) NULL,
  `gender` VARCHAR(150) NULL,
  `date_of_birth` DATE NULL,
  `age` INT NULL,
  `city` VARCHAR(150) NULL,
  `state` VARCHAR(150) NULL,
  `phone_number` VARCHAR(25) NULL,
  `email` VARCHAR(255) NULL,
  `blood_group` VARCHAR(150) NULL,
  `registration_date` DATE NULL,
  PRIMARY KEY (`patient_id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `Rooms`;
CREATE TABLE `Rooms` (
  `room_id` VARCHAR(30) NOT NULL,
  `hospital_id` VARCHAR(30) NULL,
  `room_number` INT NULL,
  `room_type` VARCHAR(150) NULL,
  `floor_number` INT NULL,
  `daily_charge` DECIMAL(14,2) NULL,
  `room_status` VARCHAR(150) NULL,
  PRIMARY KEY (`room_id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `Appointments`;
CREATE TABLE `Appointments` (
  `appointment_id` VARCHAR(30) NOT NULL,
  `patient_id` VARCHAR(30) NULL,
  `doctor_id` VARCHAR(30) NULL,
  `hospital_id` VARCHAR(30) NULL,
  `appointment_date` DATE NULL,
  `appointment_time` TIME NULL,
  `status` VARCHAR(150) NULL,
  `reason_for_visit` VARCHAR(500) NULL,
  `created_at` DATETIME NULL,
  PRIMARY KEY (`appointment_id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `Admissions`;
CREATE TABLE `Admissions` (
  `admission_id` VARCHAR(30) NOT NULL,
  `patient_id` VARCHAR(30) NULL,
  `hospital_id` VARCHAR(30) NULL,
  `department_id` VARCHAR(30) NULL,
  `admitting_doctor_id` VARCHAR(30) NULL,
  `room_id` VARCHAR(30) NULL,
  `admission_date` DATE NULL,
  `discharge_date` DATE NULL,
  `admission_type` VARCHAR(150) NULL,
  `admission_status` VARCHAR(150) NULL,
  PRIMARY KEY (`admission_id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `Treatments`;
CREATE TABLE `Treatments` (
  `treatment_id` VARCHAR(30) NOT NULL,
  `admission_id` VARCHAR(30) NULL,
  `patient_id` VARCHAR(30) NULL,
  `doctor_id` VARCHAR(30) NULL,
  `treatment_name` VARCHAR(500) NULL,
  `treatment_date` DATE NULL,
  `treatment_cost` DECIMAL(14,2) NULL,
  `treatment_status` VARCHAR(150) NULL,
  PRIMARY KEY (`treatment_id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `Insurance`;
CREATE TABLE `Insurance` (
  `insurance_id` VARCHAR(30) NOT NULL,
  `patient_id` VARCHAR(30) NULL,
  `insurance_provider` VARCHAR(150) NULL,
  `policy_number` VARCHAR(150) NULL,
  `coverage_amount` DECIMAL(14,2) NULL,
  `policy_start_date` DATE NULL,
  `policy_end_date` DATE NULL,
  `claim_status` VARCHAR(150) NULL,
  PRIMARY KEY (`insurance_id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `Medicines`;
CREATE TABLE `Medicines` (
  `medicine_id` VARCHAR(30) NOT NULL,
  `medicine_name` VARCHAR(500) NULL,
  `category` VARCHAR(150) NULL,
  `manufacturer` VARCHAR(150) NULL,
  `unit_price` DECIMAL(14,2) NULL,
  `stock_quantity` INT NULL,
  PRIMARY KEY (`medicine_id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `Pharmacy`;
CREATE TABLE `Pharmacy` (
  `pharmacy_sale_id` VARCHAR(30) NOT NULL,
  `patient_id` VARCHAR(30) NULL,
  `medicine_id` VARCHAR(30) NULL,
  `hospital_id` VARCHAR(30) NULL,
  `quantity` INT NULL,
  `sale_date` DATE NULL,
  `total_price` DECIMAL(14,2) NULL,
  PRIMARY KEY (`pharmacy_sale_id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `Laboratory`;
CREATE TABLE `Laboratory` (
  `lab_test_id` VARCHAR(30) NOT NULL,
  `patient_id` VARCHAR(30) NULL,
  `doctor_id` VARCHAR(30) NULL,
  `hospital_id` VARCHAR(30) NULL,
  `test_name` VARCHAR(150) NULL,
  `test_date` DATE NULL,
  `test_result` VARCHAR(150) NULL,
  `test_cost` DECIMAL(14,2) NULL,
  `test_status` VARCHAR(150) NULL,
  PRIMARY KEY (`lab_test_id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `Employees`;
CREATE TABLE `Employees` (
  `employee_id` VARCHAR(30) NOT NULL,
  `first_name` VARCHAR(150) NULL,
  `last_name` VARCHAR(150) NULL,
  `gender` VARCHAR(150) NULL,
  `hospital_id` VARCHAR(30) NULL,
  `department_id` VARCHAR(30) NULL,
  `designation` VARCHAR(150) NULL,
  `employment_type` VARCHAR(150) NULL,
  `salary` DECIMAL(14,2) NULL,
  `joining_date` DATE NULL,
  `phone_number` VARCHAR(25) NULL,
  `email` VARCHAR(255) NULL,
  PRIMARY KEY (`employee_id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `Billing`;
CREATE TABLE `Billing` (
  `bill_id` VARCHAR(30) NOT NULL,
  `patient_id` VARCHAR(30) NULL,
  `admission_id` VARCHAR(30) NULL,
  `appointment_id` VARCHAR(30) NULL,
  `bill_date` DATE NULL,
  `room_charges` DECIMAL(14,2) NULL,
  `doctor_charges` DECIMAL(14,2) NULL,
  `medicine_charges` DECIMAL(14,2) NULL,
  `lab_charges` DECIMAL(14,2) NULL,
  `other_charges` DECIMAL(14,2) NULL,
  `total_amount` DECIMAL(14,2) NULL,
  `bill_status` VARCHAR(150) NULL,
  PRIMARY KEY (`bill_id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `Payments`;
CREATE TABLE `Payments` (
  `payment_id` VARCHAR(30) NOT NULL,
  `bill_id` VARCHAR(30) NULL,
  `patient_id` VARCHAR(30) NULL,
  `payment_date` DATE NULL,
  `payment_amount` DECIMAL(14,2) NULL,
  `payment_mode` VARCHAR(150) NULL,
  `payment_status` VARCHAR(150) NULL,
  PRIMARY KEY (`payment_id`)
) ENGINE=InnoDB;
