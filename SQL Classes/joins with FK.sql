-- Customers: CustomerID int PK, Name varchar, email varchar;
-- Orders: OrderID int PK, CustomerID int, Amount Decimal, 
-- FK (CustomerID) REFERENCES Customers(CustomerID);
-- 

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
    AMOUNT DECIMAL(10,2),
--  adding a new constraint foreign key
	FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
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
(103, 2, 300.00),
(104, 2, 200.00);



SELECT * FROM Customers;
SELECT * FROM Orders;

-- will not be allowed
INSERT INTO Orders (OrderID, CustomerID, Amount) VALUES
(105, 6, 250.00);

SELECT * FROM Orders;

-- INNER JOIN -- LEFT JOIN -- RIGHT -- FULL OUTER JOIN
SELECT Customers.Name, Orders.Amount
FROM Customers
INNER JOIN Orders
	ON Customers.CustomerID = Orders.CustomerID;

    
-- FULL OUTER JOIN in mySQL doesn't really support FULL OUTER JOIN
-- Other database software do!
SELECT Customers.Name, Orders.Amount
FROM Customers
LEFT JOIN Orders
	ON Customers.CustomerID = Orders.CustomerID
    
UNION

SELECT Customers.Name, Orders.Amount
FROM Customers
RIGHT JOIN Orders
	ON Customers.CustomerID = Orders.CustomerID;


-- JOINS with Aliases
SELECT C.Name, O.Amount, C.CustomerID
FROM Customers AS C
LEFT JOIN Orders AS O
	ON C.CustomerID = O.CustomerID;
    
-- JOINS with Aliases
SELECT C.Name, O.Amount, C.CustomerID
FROM Customers C
LEFT JOIN Orders O
	ON C.CustomerID = O.CustomerID;
    
-- We are using the Foreign Key Constraint







