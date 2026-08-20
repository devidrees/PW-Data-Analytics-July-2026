-- SHOPSPHERE 
-- MySQL Database Setup

-- CREATE DATABASE
DROP DATABASE IF EXISTS shopsphere;
CREATE DATABASE shopsphere;

USE shopsphere;


-- 1. CUSTOMERS TABLE
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    signup_date DATE
);

-- Insert customer data
INSERT INTO customers
(customer_id, customer_name, city, signup_date)
VALUES
(101, 'Aamir Khan', 'Srinagar', '2024-01-10'),
(102, 'Sara Ali', 'Anantnag', '2024-01-15'),
(103, 'Rahul Sharma', 'Delhi', '2024-02-01'),
(104, 'Priya Singh', 'Mumbai', '2024-02-05'),
(105, 'Zainab Bhat', 'Srinagar', '2024-02-20'),
(106, 'Arjun Mehta', 'Jammu', '2024-03-01'),
(107, 'Neha Kapoor', 'Delhi', '2024-03-10'),
(108, 'Danish Mir', 'Srinagar', '2024-03-15');


-- 2. PRODUCTS TABLE
DROP TABLE IF EXISTS products;
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

-- Insert product data
INSERT INTO products
(product_id, product_name, category, price)
VALUES
(201, 'Laptop', 'Electronics', 70000),
(202, 'Smartphone', 'Electronics', 40000),
(203, 'Headphones', 'Electronics', 5000),
(204, 'Office Chair', 'Furniture', 12000),
(205, 'Desk', 'Furniture', 18000),
(206, 'Running Shoes', 'Sports', 6000),
(207, 'Football', 'Sports', 2000),
(208, 'Cricket Bat', 'Sports', 4000);


-- 3. ORDERS TABLE
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    amount DECIMAL(10,2),
    status VARCHAR(20),
    -- Relationships with other tables
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

-- Insert order data
INSERT INTO orders
(order_id, customer_id, product_id, order_date, quantity, amount, status)
VALUES
(1001, 101, 201, '2024-03-01', 1, 70000, 'Completed'),
(1002, 102, 203, '2024-03-02', 2, 10000, 'Completed'),
(1003, 101, 203, '2024-03-05', 1, 5000, 'Completed'),
(1004, 103, 202, '2024-03-06', 1, 40000, 'Completed'),
(1005, 104, 204, '2024-03-07', 1, 12000, 'Completed'),
(1006, 105, 206, '2024-03-08', 2, 12000, 'Completed'),
(1007, 101, 205, '2024-03-10', 1, 18000, 'Completed'),
(1008, 102, 207, '2024-03-11', 2, 4000, 'Returned'),
(1009, 103, 203, '2024-03-12', 2, 10000, 'Completed'),
(1010, 104, 205, '2024-03-15', 1, 18000, 'Completed'),
(1011, 105, 207, '2024-03-16', 3, 6000, 'Completed'),
(1012, 106, 208, '2024-03-17', 1, 4000, 'Completed'),
(1013, 101, 202, '2024-03-20', 1, 40000, 'Completed'),
(1014, 107, 201, '2024-03-21', 1, 70000, 'Completed'),
(1015, 108, 206, '2024-03-22', 1, 6000, 'Completed'),
(1016, 102, 203, '2024-03-25', 1, 5000, 'Completed'),
(1017, 103, 202, '2024-03-25', 1, 40000, 'Completed'),
(1018, 104, 204, '2024-03-26', 1, 12000, 'Completed'),
(1019, 101, 203, '2024-03-28', 2, 10000, 'Completed'),
(1020, 105, 206, '2024-03-30', 1, 6000, 'Completed');


-- 4. EMPLOYEES TABLE
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(50),
    manager_id INT,
    salary DECIMAL(10,2),

    -- Self-referencing foreign key
    FOREIGN KEY (manager_id)
        REFERENCES employees(employee_id)
);

-- Insert managers first because manager_id refers to another employee in the same table.
INSERT INTO employees
(employee_id, employee_name, department, manager_id, salary)
VALUES
(1, 'Arif Malik', 'Sales', NULL, 90000),
(4, 'Fatima Khan', 'HR', NULL, 85000),
(7, 'Rahul Verma', 'IT', NULL, 120000);


-- Insert employees who report to managers
INSERT INTO employees
(employee_id, employee_name, department, manager_id, salary)
VALUES
(2, 'Bilal Ahmed', 'Sales', 1, 60000),
(3, 'Danish Shah', 'Sales', 1, 65000),
(5, 'Imran Dar', 'HR', 4, 55000),
(6, 'Neha Gupta', 'HR', 4, 60000),
(8, 'Sameer Singh', 'IT', 7, 80000),
(9, 'Tariq Bhat', 'IT', 7, 90000);


-- 6. DAILY SALES TABLE

CREATE TABLE daily_sales (
    sale_date DATE PRIMARY KEY,
    revenue DECIMAL(10,2)
);

-- Insert daily sales data
INSERT INTO daily_sales
(sale_date, revenue)
VALUES
('2024-03-01', 70000),
('2024-03-02', 10000),
('2024-03-03', 15000),
('2024-03-04', 12000),
('2024-03-05', 5000),
('2024-03-06', 40000),
('2024-03-07', 12000),
('2024-03-08', 12000),
('2024-03-09', 8000),
('2024-03-10', 18000);

--  DISCOUNTS TABLE
CREATE TABLE discounts (
    discount INT
);

INSERT INTO discounts
(discount)
VALUES
(10),
(20),
(30);


-- Verify tables using these
SELECT * FROM customers;
-- SELECT * FROM products;
-- SELECT * FROM orders;
-- SELECT * FROM employees;
-- SELECT * FROM daily_sales;