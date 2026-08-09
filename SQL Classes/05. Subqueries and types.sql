-- SUB QUERRIES
-- 
USE store_management;

DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- Create the Departments table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50)
);

-- Create the Employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary DECIMAL(10, 2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Insert sample data into Departments
INSERT INTO departments (department_id, department_name, location) VALUES
(1, 'IT', 'NYC'),
(2, 'HR', 'London'),
(3, 'Sales', 'NYC');

-- Insert sample data into Employees
INSERT INTO employees (employee_id, name, salary, department_id) VALUES
(101, 'Alice', 95000, 1),
(102, 'Bob', 60000, 1),
(103, 'Charlie', 55000, 2),
(104, 'David', 75000, 3),
(105, 'Eve', 85000, 3);

SELECT * FROM employees;
SELECT * FROM departments;

-- AVERAGE salary of employees
SELECT 
	AVG(salary) 
FROM employees;
-- 74000.00

-- Fetch the employees and salaries which are above average: 
SELECT name, salary
FROM employees
WHERE salary > (
	SELECT 
		AVG(salary) 
	FROM employees
);

-- ---
SELECT name, salary
FROM employees
WHERE salary > (
	SELECT AVG(salary) FROM employees -- 74000.00
);

SELECT name 
FROM employees 
WHERE department_id IN (SELECT department_id FROM departments WHERE location = 'NYC');

SELECT department_id 
FROM departments 
WHERE location = 'NYC';

-- Corelated Queries
-- nested query will not execute independently
SELECT name 
FROM employees e1 
WHERE salary > (SELECT AVG(salary)
                FROM employees e2
                WHERE e1.department_id = e2.department_id);


-- subquery on FROM 
SELECT emp.name, salary_data.avg_salary
FROM (SELECT department_id, AVG(salary) AS avg_salary 
      FROM employees 
      GROUP BY department_id) salary_data
INNER JOIN employees emp 
	ON emp.department_id = salary_data.department_id;

-- Derived Table Part is in the Sub-Query
(SELECT department_id, AVG(salary) AS avg_salary 
      FROM employees 
      GROUP BY department_id)