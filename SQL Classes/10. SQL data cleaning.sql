-- Data Cleaning
-- 
-- Identify the missing values

-- how many rows are are missing a salary
-- IS NULL is a condition that returns TRUE for NULL values
SELECT *
	-- COUNT(*) AS missing_salaries
FROM employees_raw
WHERE salary IS NULL;

-- Find the exact Duplicates
	-- Example: accidently a company ran the payroll script twice
	-- some employees might be inserted in data twice

SELECT 
	emp_id, name, department,
	COUNT(*) AS count
FROM employees_raw
GROUP BY emp_id, name, department
HAVING count > 1;

-- IFNULL(): used in mySQL and SQLite
-- COALESCE(): 
-- Imputation: Fill the missing values with some values
SELECT 
	name, department, salary,
    COALESCE(salary, 10) AS Filled_salary
FROM employees_raw;

-- Imputation Strategies:
	-- Forward Fill: Fill the null with the previous
    -- Backward Fill: Fill the null with the 
    -- Central Tendency: Mean Imputation - mean value

-- LAG() - Forward Fill
-- LEAD() - Back Fill
-- Running average? 
SELECT 
	name, department, salary,
    COALESCE(salary, 
    -- LAG(salary) OVER(PARTITION BY department ORDER BY emp_id)
    -- LEAD(salary) OVER(PARTITION BY department ORDER BY emp_id)
    -- here we are imputing the 7 people average into the null value
    AVG(salary) OVER(PARTITION BY department ORDER BY emp_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) -- selects the whole partition (here department)
    
	) AS Filled_salary
FROM employees_raw;

-- Removal of duplicates
-- if you want to check the uniques in a table
SELECT DISTINCT 
	emp_id, name, department
FROM employees_raw;


SELECT 
	emp_id, name, department,
	COUNT(*) AS count
FROM employees_raw
GROUP BY emp_id, name, department
HAVING count > 1;

-- Common Table Expressions (CTE)
-- CTE is a temporary named result set  -- 
	-- imagine: you write a query, stick it to the wall
    -- then you query that sticky note directly
-- we use the keyword WITH to create a CTE
WITH IT_wala_department AS (
	SELECT * FROM employees_raw
    WHERE department = 'IT'
)
SELECT * FROM
IT_wala_department
WHERE salary > 80000;


-- we want to delete the duplicate rows and keep the originals
WITH DuplicateFinder AS (
	SELECT 
		emp_id, name, department,
        ROW_NUMBER() OVER(
        PARTITION BY emp_id, name, department
        ORDER BY emp_id
        ) AS row_num
	FROM employees_raw
)
DELETE FROM DuplicateFinder -- CTE expresson to remove duplicates
WHERE row_num > 1;

-- Data tables -- 
-- Fixing the Types, Formats of the data columns
SHOW COLUMNS FROM employees_raw;

DESCRIBE employees_raw;

SELECT 
	column_name, data_type
FROM information_schema.columns
WHERE table_name = 'employees_raw';

-- CAST - is used to change the data types
-- if data is stored as text (VARCHAR) 
-- 

SELECT * FROM employees_raw;

-- CAST()
SELECT 
	name, department, join_date,
    CAST(join_date AS DATE) AS real_date
FROM employees_raw;

-- CONVERT(data, target_type)
-- convert will let you change type and reformat
-- allows you to reformat the output as well
-- 
SELECT 
    name, 
    join_date,
    -- Formats the date as mm/dd/yyyy
    DATE_FORMAT(join_date, '%m-%d-%Y') AS format_date
FROM employees_raw;


-- 
SELECT
	STR_TO_DATE(join_date, '%d%m%Y');
    
    
-- duplicate removal -- convert function (style code) -- date formats
-- 



