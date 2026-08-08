USE store_management;

DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;

CREATE TABLE Customers(
	CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100)
);

CREATE TABLE Orders(
	OrderID INT PRIMARY KEY,
    CustomerID INT,
    AMOUNT DECIMAL(10,2)
);

-- values into customers
INSERT INTO Customers (CustomerID, Name, Email) VALUES
(1, 'Alice', 'alice@example.com'),
(2, 'Bob', 'bob@example.com'),
(3, 'Charlie', 'charlie@example.com'),
(4, 'David', 'david@example.com');

-- values into orders
INSERT INTO Orders (OrderID, CustomerID, Amount) VALUES
(101, 1, 250.00),
(102, 2, 150.50),
(103, 5, 300.00),
(104, 6, 200.00),
(105, 1, 100.00),
(106, 1, 50.00);

SELECT * FROM Customers;
SELECT * FROM Orders;

SELECT Customers.Name, Orders.Amount
FROM Customers
LEFT OUTER JOIN Orders
	ON Customers.CustomerID = Orders.CustomerID

UNION
    
SELECT Customers.Name, Orders.Amount
FROM Customers
RIGHT JOIN Orders
	ON Customers.CustomerID = Orders.CustomerID;
        
-- CROSS JOIN
SELECT Customers.Name, Orders.Amount
FROM Customers
CROSS JOIN Orders;

-- SELF JOIN
SELECT 
	C1.Name AS Customer, 
    C2.Email AS Mail
FROM Customers C1
LEFT JOIN Customers C2 
	ON C1.CustomerID = C2.Email;


    