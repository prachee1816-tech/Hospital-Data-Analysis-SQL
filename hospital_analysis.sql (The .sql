SELECT * FROM Hospital_Data; 
DROP TABLE IF EXISTS hospital_data; 
CREATE TABLE hospital_data ( 
hospital_name VARCHAR(50), 
d_location VARCHAR(50), 
department VARCHAR(50), 
doctors_count NUMERIC(10,2) , 
patients_count NUMERIC(10,2), 
admission_date DATE, 
discharge_date DATE, 
medical_expenses DECIMAL(10,2) 
); 
COPY hospital_data(hospital_name, d_location, department, doctors_count, 
patients_count, admission_date, discharge_date, medical_expenses) 
FROM 'C:\sql\Hospital_Data (4) (1).csv' 
CSV HEADER; 
SELECT * FROM Hospital_Data; 

-- 1) TOTAL NUMBER OF PATIENTS  -- write an sql query to find the total number of patients across all hospitals. 

SELECT SUM(patients_count) AS total_patients 
FROM Hospital_Data;

-- 2) AVG NUMBER OF DOCTORS PER HOSPITAL  -- retrieve the avg count of the doctors available in each hospital  

SELECT hospital_name , AVG(doctors_count) AS total_doctors 
FROM Hospital_Data 
GROUP BY hospital_name;

-- 3) TOP 3 DEPARTMENTS WITH THE HIGHEST NUMBER OF PATIENTS  -- Find the top 3 hospital departments that have the highest number of patients  

SELECT department ,SUM(patients_count) AS total_patients 
FROM Hospital_Data 
GROUP BY department 
ORDER BY total_patients DESC LIMIT 3 ;

-- 4) HOSPITAL WITH MAX MEDICAL EXPENSES  -- Identify the hospital that recorded the highest medical expenses  

SELECT * FROM Hospital_Data; 
SELECT hospital_name , medical_expenses AS max_expense 
FROM Hospital_Data  
ORDER BY medical_expenses DESC LIMIT 1; 

-- 5) DAILTY AVG MEDICAL EXPENSES  --  Calculate the average medical expenses per day for each hospital.  

SELECT hospital_name, AVG(medical_expenses / NULLIF(discharge_date - 
admission_date, 0)) AS avg_daily_expenses 
FROM Hospital_Data 
GROUP BY hospital_name; 

-- 6) Longest Hospital Stay  -- Find the patient with the longest stay by calculating the difference between  Discharge Date and Admission Date.  

SELECT * , (discharge_date - admission_date) AS stay_duration 
FROM Hospital_Data 
ORDER BY stay_duration DESC LIMIT 1 ; 

-- 7)Total Patients Treated Per City  -- Count the total number of patients treated in each city. 

SELECT * FROM Hospital_Data; 
SELECT d_location , SUM(patients_count) AS total_patients  
FROM Hospital_Data 
GROUP BY d_location ;

-- 8)Average Length of Stay Per Department --  Calculate the average number of days patients spend in each department.  

SELECT department , AVG(discharge_date - admission_date) AS avg_len_stay 
FROM Hospital_Data 
GROUP BY department;

-- 9)Identify the Department with the Lowest Number of Patients  --  Find the department with the least number of patients.  

SELECT department , SUM(patients_count) AS total_patients 
FROM Hospital_Data  
GROUP BY department  
ORDER BY total_patients ASC LIMIT 1 ;

-- 10) Monthly Medical Expenses Report  -- Group the data by month and calculate the total medical expenses for each month. 

SELECT DATE_TRUNC('month', admission_date) AS month,  
SUM(medical_expenses) AS total_expenses 
FROM Hospital_Data 
GROUP BY DATE_TRUNC('month', admission_date) 
ORDER BY month;
