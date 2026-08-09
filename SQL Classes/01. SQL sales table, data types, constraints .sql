-- 
DROP DATABASE IF EXISTS store_management;
CREATE DATABASE store_management;

USE store_management;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales(
	Sales_ID INT PRIMARY KEY AUTO_INCREMENT,
    Customer_Name VARCHAR(50) NOT NULL, -- not null means you have to put in some value
    Customer_Email VARCHAR(50) UNIQUE, -- will prevent two customers from having same email
    Product_Category ENUM('Electronics', 'Furniture', 'Office Supplies', 'Appliances', 'Other') NOT NULL,
    Product VARCHAR(50) NOT NULL CHECK(
		Product IN ('Laptop','Mouse','Monitor','Keyboard','Printer', 'Paper','Chair', 'Table', 'Stapler')
        ),
    Quantity INT CHECK(Quantity > 0) DEFAULT 1, -- should be positive, not 0 -- check makes sure every entry follows a condition
    Unit_Price DECIMAL(10, 2) CHECK(Unit_Price > 0), -- 10 total digits, 2 after decimal
    Payment_Done BOOLEAN DEFAULT FALSE, 
    Order_Date DATE DEFAULT (CURRENT_DATE),
    Review TEXT DEFAULT ('No Review')
);

SELECT * FROM sales;

INSERT INTO sales(Sales_ID, Customer_Name, Customer_Email,  Product_Category, Product, Quantity, Unit_Price, Payment_Done, Order_Date, Review) VALUES
(101, 'Amit', 'Amit@gmail.com','Electronics', 'Laptop', 1, 50000, TRUE,  '2026-01-10', 'Great'),
(102, 'Neha', 'Neha@gmail.com', 'Electronics', 'Laptop', 2, 50000, TRUE,'2026-01-12', 'Great'),
(103, 'Ravi', 'Ravi@gmail.com', 'Office Supplies', 'Paper', 4, 150, TRUE ,'2026-01-15', 'Great'),
(104, 'Priya', 'Priya@gmail.com', 'Electronics', 'Mouse', 2, 1000, TRUE ,'2026-01-18', 'Great'),
(105, 'Karan', 'Karan@gmail.com', 'Electronics', 'Printer', 1, 2000, TRUE, '2026-01-20', 'Great'),
(106, 'Simran', 'Simran@gmail.com', 'Furniture', 'Chair', 3, 2500, TRUE, '2026-01-22', 'Great'),
(107, 'Ankit', 'Ankit@gmail.com', 'Furniture', 'Table', 5, 7000, TRUE, '2026-01-25', 'Great'),
(108, 'Pooja', 'Pooja@gmail.com', 'Electronics', 'Keyboard', 1, 1500, TRUE, '2026-01-28', 'Great'),
(109, 'Rahul', 'Rahul@gmail.com', 'Furniture', 'Chair', 1, 25000, TRUE, '2026-02-01', 'Great'),
(110, 'Sneha', 'Sneha@gmail.com', 'Electronics', 'Keyboard', 2, 1500, TRUE, '2026-02-03', 'Great');


INSERT INTO sales(Customer_Name, Customer_Email, Product_Category, Product, Unit_Price) 
VALUES ('Idrees', 'idrees@gmail.com', 'Electronics', 'Laptop', 55000);

INSERT INTO sales(Customer_Name, Customer_Email, Product_Category,  Product, Unit_Price) 
VALUES ('Yohan','yohan@gmail.com', 'Electronics', 'Laptop', 55000);

SELECT * FROM sales;