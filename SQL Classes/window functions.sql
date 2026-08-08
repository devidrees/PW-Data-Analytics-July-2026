USE store_management;

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
	emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);

INSERT INTO employees (emp_id, name, department, salary) VALUES
(1, 'Alice', 'Sales', 60000),
(2, 'Bob', 'Sales', 65000),
(3, 'Charlie', 'Sales', 68000),
(4, 'Diana', 'IT', 80000),
(5, 'Evan', 'IT', 75000),
(6, 'Fiona', 'HR', 55000),
(7, 'George', 'HR', 60000),
(8, 'Derek', 'Sales', 70000),
(9, 'Elena', 'Sales', 55000),
(10, 'Felix', 'Sales', 50000);

SELECT * FROM employees;

-- Aggregates with GROUP BY
SELECT 
    SUM(salary) AS total_salary
FROM employees;

-- Aggregates always work with Groups of data
SELECT 
	department,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department;
-- Data Rows are grouped by department
-- and every group of rows is aggregated
-- This gives the summary of the rows
-- Data rows are collapsed and summarised

-- WINDOW FUNCTIONS
-- 
-- what does the OVER() function do
SELECT 
	department,
    SUM(salary) OVER() AS total_company_payroll
FROM employees;
-- unlike the group by, which would collapse data into single rows

-- every single row will be displayed
-- showing the aggregate as well


-- use of PARTITION BY and ORDER BY in OVER()
SELECT 
	department,
    salary,
    SUM(salary) OVER(PARTITION BY department) AS total_company_payroll
FROM employees;
-- 

SELECT 
	department,
    salary,
    SUM(salary) OVER(PARTITION BY department ORDER BY salary DESC) AS total_company_payroll
FROM employees;


-- Sorting the Window -
-- RANKING FUNCTIONS 
	-- 1. ROW_NUMBER(): gives unique integer to each row. ties are broken randomly
    -- 2. RANK(): gives same rank to ties, but skips the next number - 1, 2, 2, 4 ..
    -- 3. DENSE_RANK(): gives same rank to ties, but does not skip - 1, 2, 2, 3, 4 ..
    -- 4. NTILE(): divide data in buckets - Quantiles -  
SELECT 
	name,
    department,
    salary,
    -- ROW_NUMBER() OVER(PARTITION BY department) as row_num_random, -- Row number is assigned by the row order
    ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) as row_num_salary,
    RANK() OVER(PARTITION BY department ORDER BY salary DESC) as Rank_salary,
    DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) as Dense_rank_salary-- ,
    -- NTILE(3) OVER(PARTITION BY department ORDER BY salary DESC) as salary_tier
FROM employees;

SELECT
	name,
    department,
    salary,
    NTILE(3) OVER(ORDER BY Salary ASC) as salary_tier
FROM employees;


-- Value Functions = reach into other rows in the window
-- LAG(): look backward (Up the table)
-- LEAD(): look forward (Down the table)
-- FIRST_VALUE(): grab the very first value 
-- LAST_VALUE(): grab the very last value

SELECT 
	name,
    department,
    salary,
    LAG(salary) OVER(PARTITION BY department ORDER BY salary DESC) as prev_higher_salary,
    LEAD(salary) OVER(PARTITION BY department ORDER BY salary DESC) as next_salary
FROM employees;

-- we will try to find the top earners and lowest earners
SELECT 
	name,
    department,
    salary,
    FIRST_VALUE(name) OVER(PARTITION BY department ORDER BY salary DESC) as top_earner,
    FIRST_VALUE(salary) OVER(PARTITION BY department ORDER BY salary DESC) as top_salary
FROM employees
WHERE department = 'sales';

SELECT 
	name,
    department,
    salary,
    LAST_VALUE(name) OVER(PARTITION BY department ORDER BY salary DESC) as lowest_earner,
    LAST_VALUE(salary) OVER(PARTITION BY department ORDER BY salary DESC) as lowest_salary
FROM employees;

-- mySQL  by default defines the window as:
	-- start at the the first row of the partition
    -- end at the current row
SELECT 
	name,
    department,
    salary,
    LAST_VALUE(name) OVER(
    PARTITION BY department 
    ORDER BY salary DESC 
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) as lowest_earner,
    LAST_VALUE(salary) OVER(PARTITION BY department ORDER BY salary DESC
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as lowest_salary
FROM employees;

-- FRAME CLAUSES 
-- these are anchors or clauses that define
-- starting row and ending rows of your window
-- ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
	-- from the first row to the last row
    
-- FRAME CLAUSES    
	-- 1. UNBOUNDED PRECEDING: Starts at the first row 
	-- 2. UNBOUNDED FOLLOWING: Ends at the last row
	-- 3. CURRENT ROW: Row currently being evaluated
	-- 4. N PRECEDING: N rows before the current row
	-- 5. N FOLLOWING: N rows after the current row

-- ROWS: physically count the number of rows up or down
    -- guarantee that your consistent number of rows - if data is missing the number of rows will still be there
    -- e.g. ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    -- 3 rows in all intervals
    
-- RANGE: logical 
	-- it groups up duplicate values as one
    -- guarantee consistent interval - if data is missing it can contain fewer rows
    -- For repetitions, RANGE combines the rows

-- Cumulative Sum - Or RUNNING TOTAL
SELECT 
	department,
    salary,
    SUM(salary) OVER() AS grand_total_payroll,
    SUM(salary) OVER(PARTITION BY department) AS departmentwise_grand_total_payroll,
    SUM(salary) OVER(ORDER BY salary DESC) AS Running_total_payroll,
    SUM(salary) OVER(PARTITION BY department ORDER BY salary DESC) AS departmentwise_Running_total_payroll
FROM employees;

-- DEFAULT FRAME: RANGE BETWEEN UNBOUNDED PRECEEDING AND CURRENT ROW

-- Moving Average - Rolling Average
-- we will observe average of salary of current employee and the two employees ranked above 
SELECT 
	name,
    salary,
    department,
    SUM(salary) OVER(
		PARTITION BY department
        ORDER BY salary ASC
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING -- CURRENT ROW        
    ) AS 3_person_sliding_average
FROM employees;

-- Example: 7 day moving average - Rolling average
SELECT 
	name,
    salary,
    AVG(salary) OVER(
		PARTITION BY department
        ORDER BY date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW        
    ) AS 3_person_sliding_average
FROM employees;

-- 5 day rolling sum
-- percent of the total

SELECT 
	name,
    salary,
    ROUND(salary * 100.00 / SUM(salary) OVER(), 2) AS pct_of_total,
    ROUND(SUM(salary) OVER()/1000, 2) AS salary_in_1000s,
    SUM(salary) OVER() AS total
FROM employees;
