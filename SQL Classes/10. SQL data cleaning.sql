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
    AVG(salary) OVER(
    PARTITION BY department 
    ORDER BY emp_id 
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) -- selects the whole partition (here department)
    ) AS Filled_salary
FROM employees_raw;

-- Removal of duplicates

-- CAST()
-- CONVERT()




