/* 

DIABETES PREDICTION INTERNSHIP PROJECT [PSYLIQ]

INTRODUCTION:- This dataset is provided by PSYLIQ , In this project, 
I will use the Diabetes Prediction data set to explore various aspects  
Diabetes and how they affect patients. The data set contains information 
about 100000 patients  which are diabetes patients and their details such as
EmployeeName,Patient_id,gender,D.O.B, hypertension, heart_disease,smoking_history, Age, bmi, HbA1c_level, blood_glucose_level, diabetes.

*/

-- 1. Retrieve the Patient_id and ages of all patients.
select patient_id,age from diabetes_prediction;


-- 2. Select all female patients who are older than 40.
select * from diabetes_prediction where gender="female" and age>40;


-- 3. Calculate the average BMI of patients.
select avg(bmi) as AVG_BMI from diabetes_prediction ;


-- 4. List patients in descending order of blood glucose levels.
select * from diabetes_prediction order by blood_glucose_level desc;


-- 5. Find patients who have hypertension and diabetes.
select * from diabetes_prediction where hypertension="1" and diabetes="1";


-- 6. Determine the number of patients with heart disease.
select count(patient_id) from diabetes_prediction where heart_disease=1;


-- 7. Group patients by smoking history and count how many smokers and nonsmokers there are.
select smoking_history,count(patient_id) from diabetes_prediction group by smoking_history;


-- 8. Retrieve the Patient_ids of patients who have a BMI greater than the average BMI.
select patient_id,bmi from diabetes_prediction where bmi> (select avg(bmi) from diabetes_prediction);


-- 9. Find the patient with the highest HbA1c level and the patient with the lowest.
(select patient_id,hba1c_level from diabetes_prediction order by HbA1c_level asc limit 1)
UNION 
(select Patient_id,HbA1c_level from diabetes_prediction order by HbA1c_level desc limit 1);


-- 10. Calculate the age of patients in years (assuming the current date as of now).
select patient_id, abs(age-year(now())) as Year_of_Birth from diabetes_prediction;


-- 11. Rank patients by blood glucose level within each gender group.
select patient_id,gender,blood_glucose_level, RANK() OVER (PARTITION BY gender order by blood_glucose_level) 
as Glucose_level_rank from diabetes_prediction ;


-- 12. Update the smoking history of patients who are older than 50 to "Ex-smoker."
SET SQL_SAFE_UPDATES = 0;
update diabetes_prediction set smoking_history="Ex-smoker" where age>50;


-- 13. Insert a new patient into the database with sample data.
insert into diabetes_prediction values("Vyas Kumar","PT101010","Male","30-03-1999",0,0,"never",25.5,6.1,120,0,24);


-- 14. Delete all patients with heart disease from the database.
delete from diabetes_prediction where heart_disease=1;


-- 15. Find patients who have hypertension but not diabetes using the EXCEPT operator.
select * from diabetes_prediction where hypertension=1
EXCEPT
select * from diabetes_prediction where diabetes=1;


-- 16. Define a unique constraint on the "patient_id" column to ensure its values are unique.
alter table diabetes_prediction modify Patient_id varchar(255) unique;


-- 17. Create a view that displays the Patient_ids, ages, and BMI of patients.
create view patient_info as select patient_id,age,bmi from diabetes_prediction;
select * from patient_info;


-- 18. Suggest improvements in the database schema to reduce data redundancy and improve data integrity?

/*
To reduce data redundancy and improve data integrity in a database schema, you can consider the following best practices:
1. Normalization: Break down large tables, apply normalization techniques (1NF, 2NF, 3NF).
2. Primary Keys: Ensure each table has a unique primary key.
3. Foreign Keys: Establish relationships between tables for referential integrity.
4. Avoid Redundant Columns: Refrain from duplicating data across multiple tables.
5. Data Types: Use appropriate data types for columns.
6. Default Values and Constraints: Set defaults, use constraints to enforce rules.
7. Indexes: Apply indexes for frequently queried columns (considering trade-offs).
8. Avoid Nulls: Minimize NULL values; use defaults or separate tables.
9. Data Validation: Enforce validation at both application and database levels.
10. Use of Views: Presents data from multiple tables without duplicating information, simplifying queries, and maintaining a consistent view.
 */

-- 19. Explain how you can optimize the performance of SQL queries on this dataset.

/*
Optimize SQL queries with these strategies:

1. Use Indexes:
- Create indexes on key columns.
- Avoid over-indexing to balance read and write performance.

2. Optimize Query Structure:
- Simplify queries, avoiding unnecessary joins and subqueries.
- Break down complex queries into manageable parts.

3. Limit Result Sets:
- Use LIMIT to restrict returned rows.
- Fetch only necessary columns; avoid SELECT *.

4. Use Stored Procedures:
- Encapsulate frequent queries in stored procedures.
- Reduce network traffic with single-call execution.

5. Avoid SELECT DISTINCT:
- Minimize use; consider GROUP BY or refined logic.

6. Update Statistics:
- Regularly update table statistics for accurate query optimization.

7. Consider Partitioning:
- Divide large tables into smaller partitions.
- Improves query performance by reducing scanned data.

8. Use Caching:
- Employ query or application-level caching.
- Reduces repeated database queries for improved overall performance.

/*
