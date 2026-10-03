-- SQLite database setup for Hospital_Data.csv

DROP TABLE IF EXISTS hospital_data;

CREATE TABLE hospital_data (
    hospital_name TEXT NOT NULL,
    location TEXT NOT NULL,
    department TEXT NOT NULL,
    doctors_count INTEGER NOT NULL,
    patients_count INTEGER NOT NULL,
    admission_date TEXT NOT NULL,
    discharge_date TEXT NOT NULL,
    medical_expenses DECIMAL(12, 2) NOT NULL
);

.mode csv
.import --skip 1 Hospital_Data.csv hospital_data

-- Total number of patients across all hospitals.
SELECT SUM(patients_count) AS total_number_of_patients
FROM hospital_data;

-- 2. Average number of doctors per hospital.
SELECT hospital_name,
       AVG(doctors_count) AS average_doctors
FROM hospital_data
GROUP BY hospital_name
ORDER BY hospital_name;

-- 3. Top 3 departments with the highest number of patients.
SELECT department,
       SUM(patients_count) AS total_patients
FROM hospital_data
GROUP BY department
ORDER BY total_patients DESC
LIMIT 3;

-- 4. Hospital with the maximum recorded medical expenses.
SELECT hospital_name,
       medical_expenses,
       location,
       department
FROM hospital_data
ORDER BY medical_expenses DESC
LIMIT 1;

-- 5. Daily average medical expenses for each hospital.
WITH stay_data AS (
    SELECT hospital_name,
           medical_expenses,
           julianday(
               substr(discharge_date, 7, 4) || '-' ||
               substr(discharge_date, 4, 2) || '-' ||
               substr(discharge_date, 1, 2)
           ) - julianday(
               substr(admission_date, 7, 4) || '-' ||
               substr(admission_date, 4, 2) || '-' ||
               substr(admission_date, 1, 2)
           ) AS stay_days
    FROM hospital_data
)
SELECT hospital_name,
       SUM(medical_expenses) / NULLIF(SUM(stay_days), 0) AS average_expenses_per_day
FROM stay_data
GROUP BY hospital_name
ORDER BY hospital_name;

-- 6. Longest hospital stay.
WITH stay_data AS (
    SELECT hospital_name,
           location,
           department,
           admission_date,
           discharge_date,
           julianday(
               substr(discharge_date, 7, 4) || '-' ||
               substr(discharge_date, 4, 2) || '-' ||
               substr(discharge_date, 1, 2)
           ) - julianday(
               substr(admission_date, 7, 4) || '-' ||
               substr(admission_date, 4, 2) || '-' ||
               substr(admission_date, 1, 2)
           ) AS stay_days
    FROM hospital_data
)
SELECT hospital_name,
       location,
       department,
       admission_date,
       discharge_date,
       stay_days
FROM stay_data
ORDER BY stay_days DESC
LIMIT 1;

-- 7. Total patients treated per city.
SELECT location AS city,
       SUM(patients_count) AS total_patients
FROM hospital_data
GROUP BY location
ORDER BY total_patients DESC;

-- 8. Average length of stay per department.
WITH stay_data AS (
    SELECT department,
           julianday(
               substr(discharge_date, 7, 4) || '-' ||
               substr(discharge_date, 4, 2) || '-' ||
               substr(discharge_date, 1, 2)
           ) - julianday(
               substr(admission_date, 7, 4) || '-' ||
               substr(admission_date, 4, 2) || '-' ||
               substr(admission_date, 1, 2)
           ) AS stay_days
    FROM hospital_data
)
SELECT department,
       AVG(stay_days) AS average_stay_days
FROM stay_data
GROUP BY department
ORDER BY department;

-- 9. Department with the lowest number of patients.
SELECT department,
       SUM(patients_count) AS total_patients
FROM hospital_data
GROUP BY department
ORDER BY total_patients ASC
LIMIT 1;

-- 10. Monthly medical expenses report.
SELECT substr(admission_date, 7, 4) || '-' || substr(admission_date, 4, 2) AS month,
       SUM(medical_expenses) AS total_medical_expenses
FROM hospital_data
GROUP BY month
ORDER BY month;