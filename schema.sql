
-- Project: Brain Tumour Healthcare & Research Analytics
-- File: schema.sql
-- Database: project_schema
-- Description: Database schema creation for healthcare
-- analytics using brain tumour datasets


-- Create Database
-- -------------------------
CREATE DATABASE IF NOT EXISTS project_schema;
USE project_schema;


-- Verify Table Structures
-- -------------------------
DESCRIBE patients;
DESCRIBE imaging;
DESCRIBE genomics;
DESCRIBE treatments;
DESCRIBE trials;

-- Preview Data from Each Table
-- --------------------------------

SELECT * FROM patients;
SELECT * FROM imaging;
SELECT * FROM genomics;
SELECT * FROM treatments;
SELECT * FROM trials;

-- Patients (PK: patient_id)
-- Imaging (FK: patient_id)        → One-to-Many (imaging)
-- Genomics (FK: patient_id)       → One-to-One (Genomics)
-- Treatments (FK: patient_id)     → One-to-Many (Treatments)
-- Clinical_Trials (FK: patient_id)→ One-to-Many (Trials)


-- Patients Table (Master)
-- -------------------------
CREATE TABLE IF NOT EXISTS patients (
    patient_id VARCHAR(20) PRIMARY KEY,
    age INT,
    gender VARCHAR(10),
    tumor_type VARCHAR(50),
    diagnosis_date DATE,
    hospital VARCHAR(100),
    country VARCHAR(50)
);

-- Imaging Table
-- One-to-Many with Patients
-- -------------------------
CREATE TABLE IF NOT EXISTS imaging (
    imaging_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id VARCHAR(20),
    tumor_volume_cc DOUBLE,
    radiomic_score DOUBLE,
    contrast_enhancement BOOLEAN,
    peritumoral_edema_cc DOUBLE,
    FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id)
);

-- Genomics Table
-- One-to-One with Patients
-- -------------------------
CREATE TABLE IF NOT EXISTS genomics (
    patient_id VARCHAR(20) PRIMARY KEY,
    MGMT_methylation VARCHAR(20),
    EGFR_status VARCHAR(20),
    IDH_status VARCHAR(20),
    TMB DOUBLE,
    immune_biomarker_score DOUBLE,
    FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id)
);

-- Treatments Table
-- One-to-Many with Patients
-- -------------------------
CREATE TABLE IF NOT EXISTS treatments (
    treatment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id VARCHAR(20),
    treatment_type VARCHAR(50),
    response VARCHAR(50),
    survival_months DOUBLE,
    FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id)
);

-- Clinical Trials Table
-- One-to-Many with Patients
-- -------------------------
CREATE TABLE IF NOT EXISTS trials (
    trial_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id VARCHAR(20),
    trial_name VARCHAR(100),
    trial_phase INT,
    enrolled VARCHAR(10),
    enroll_date DATE,
    trial_outcome VARCHAR(50),
    FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id)
);


