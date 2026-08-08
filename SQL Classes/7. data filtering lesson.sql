-- Data Filtering Lesson - using where, having, comparison and logical operators
-- 
USE store_management;

-- Employees table
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    hire_date DATE,
    performance_rating INT,
    manager_id INT,
    region VARCHAR(50)
);

-- Table Values
INSERT INTO employees (employee_id, name, department, salary, hire_date, performance_rating, manager_id, region) VALUES
(1, 'Anku', 'HR', 50000, '2020-03-15', 4, 10, 'East'),
(2, 'Rajesh', 'IT', 75000, '2019-07-01', 5, 11, 'West'),
(3, 'Ronie', 'IT', 72000, '2018-09-20', 3, 11, 'North'),
(4, 'David', 'Sales', 60000, '2021-02-10', 4, 12, 'South'),
(5, 'Sam', 'HR', 52000, '2022-01-05', 5, 10, 'East'),
(6, 'Rushi', 'IT', 78000, '2020-06-30', 4, 11, 'West'),
(7, 'Yash', 'Marketing', 58000, '2019-11-25', 3, 13, 'East'),
(8, 'Shivam', 'Sales', 64000, '2017-08-10', 5, 12, 'South'),
(9, 'Gaytri', 'IT', 80000, '2021-04-17', 4, 11, 'North'),
(10, 'Abhi', 'HR', 51000, '2020-10-01', 2, 10, 'East'),
(11, 'Bhomika', 'IT', 77000, '2018-05-22', 5, 11, 'West'),
(12, 'Sejal', 'Marketing', 56000, '2019-07-15', 3, 13, 'South'),
(13, 'Pawan', 'Sales', 63000, '2020-12-05', 4, 12, 'North'),
(14, 'Vivek', 'IT', 74000, '2021-09-30', 4, 11, 'East'),
(15, 'Ratish', 'HR', 53000, '2020-02-20', 3, 10, 'West'),
(16, 'Anjali', 'Marketing', 59000, '2017-06-14', 5, 13, 'South'),
(17, 'Yuvraj', 'Sales', 62000, '2019-03-11', 4, 12, 'West'),
(18, 'Shree', 'IT', 76000, '2018-10-07', 2, 11, 'North'),
(19, 'Gopal', 'Sales', 65000, '2020-05-25', 5, 12, 'South'),
(20, 'Ashwini', 'Marketing', 57000, '2022-04-10', 3, 13, 'East');

SELECT * FROM Employees;

-- -------------------------------------------------------------------------
-- SQL is learnt using questions and answers
-- 1. write a query to retreive data of all employees in 'IT' department
SELECT * FROM Employees
WHERE department = 'IT';

-- 2. write a query to retreive data of all employees with salary > 60K
SELECT * FROM employees 
WHERE salary >60000;

-- 3. Find all IT employees earning more than 75K
SELECT * FROM Employees
WHERE department = 'IT' AND salary > 75000;

-- 4. Sort these employees by salary in descending order
SELECT * FROM Employees
WHERE department = 'IT' AND salary > 75000
ORDER BY salary DESC;

-- 5. Retrive department with more than 3 employees
SELECT 
	Department,
    COUNT(*) AS number_of_employees
FROM Employees
GROUP BY department
HAVING number_of_employees > 3;

-- 6. Find the departments with an average salary above 60K but only considering employees hired after 2019
-- Hint: WHERE and HAVING both will be used
SELECT 
	department, 
	AVG(salary) as average_salary 
FROM employees
WHERE hire_date > '2019-12-31'
GROUP BY department
HAVING average_salary > 60000;

-- 7. Retrieve employees with salary > 70K and performance rating >= 4
SELECT * 
FROM employees
WHERE salary > 70000 AND performance_rating >= 4;

-- 8. Get the top 5 highest paid employees
SELECT * FROM employees
ORDER BY Salary DESC
LIMIT 5;

-- USING LIKE in queries --
-- Pattern Matching 
-- we use it for pattern matching in text -- 
	-- % - means, 0 or 1 or more than 1 characters
	-- _ - means 1 character

-- Which employees have a name starting with R 
SELECT * FROM employees
WHERE name LIKE 'R%';

-- find employee names with sh anywhere inside
SELECT * FROM employees
WHERE name LIKE '%sh%';

-- pattern at the end
SELECT * FROM employees
WHERE name LIKE '%sh';

-- look for the second character
SELECT * FROM employees
WHERE name LIKE '_a%';

-- employees with names that are 4 letters
SELECT * FROM employees
WHERE name LIKE '____';

-- this works but WHHYYYY??? because like is for patterns generally
SELECT * FROM employees
WHERE department LIKE 'HR';

-- for pattern matching we use REGEX too
-- e.g. choosing employees with names 
	-- names beginning with Vowels
SELECT * FROM employees
WHERE department REGEXP '^[AEIOU]';

-- or this will work too
SELECT * FROM employees
WHERE name LIKE 'A%'
   OR name LIKE 'E%'
   OR name LIKE 'I%'
   OR name LIKE 'O%'
   OR name LIKE 'U%';
   
-- Ending with vowels - without duplicates
SELECT DISTINCT name 
FROM employees
WHERE name REGEXP '[AEIOU]$';

-- or this
SELECT DISTINCT name
FROM employees
WHERE name LIKE '%A'
   OR name LIKE '%E'
   OR name LIKE '%I'
   OR name LIKE '%O'
   OR name LIKE '%U';


-- IN
-- if you have list of things to choose from
SELECT * FROM employees
WHERE department IN ('HR','IT');

-- categories except the ones we mention
SELECT * FROM employees
WHERE department NOT IN ('HR','IT');

-- When dealing with missing values -- NULL
-- IS NULL or IS NOT NULL
SELECT * FROM employees
WHERE department IS NOT NULL;

-- Example from Sales table
SELECT * FROM SALES
WHERE quantity IS NULL;

SELECT * FROM SALES
WHERE Customer_Email IS NULL;

-- BETWEEN
-- BETWEEN or you can use NOT BETWEEN
-- when choosing from a range
SELECT name, salary
FROM employees
WHERE salary BETWEEN 50000 AND 70000;

-- CHAINED COMPARISONS in SQL
-- a < x < b ----- 50K < salary < 70K
-- 50K to 70K
SELECT * FROM employees
WHERE (Salary > 50000) 
	AND (Salary < 70000) 
    AND (department = 'IT');


-- new table with department as columns
SELECT 
    name, 
    department,
    ROW_NUMBER() OVER(PARTITION BY department ORDER BY name) AS row_num
FROM employees;

WITH NumberedEmployees AS (
    SELECT 
        name, 
        department,
        ROW_NUMBER() OVER(PARTITION BY department ORDER BY name) AS row_num
    FROM employees
)
SELECT 
    MAX(CASE WHEN department = 'HR' THEN name END) AS HR,
    MAX(CASE WHEN department = 'IT' THEN name END) AS IT,
    MAX(CASE WHEN department = 'Sales' THEN name END) AS Sales,
    MAX(CASE WHEN department = 'Marketing' THEN name END) AS Marketing
FROM NumberedEmployees
GROUP BY row_num
ORDER BY row_num;