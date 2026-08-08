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


-- 1. Write the query to find orderID and amount of the order that has the lowest amount in the database
SELECT OrderID, amount
FROM Orders
WHERE amount = (SELECT MIN(amount) FROM Orders); -- 106 50

-- 2. list every customer's name and on the side show also show the overall SUM of the amount of orders
SELECT
	Name, 
    (SELECT SUM(Amount) FROM Orders) AS Amount_Sum
FROM Customers;

-- 3. Get the names of all the active customers -- that exist in the orders table
-- Customer Name WHERE customerID IN (CustomerID Orders)
SELECT name
FROM Customers
WHERE CustomerID IN (SELECT CustomerID FROM Orders);

-- 4. Names of customers that have signed up, but did not make any orders
SELECT name
FROM Customers
WHERE CustomerID NOT IN (SELECT CustomerID FROM Orders);

-- Show me a list of all customer names, and their specific total amount spent right next to the name
SELECT 
	name,
    (SELECT 
		SUM(amount)
     FROM Orders
     WHERE Orders.CustomerID = Customers.CustomerID) AS TotalSpent
FROM Customers; 

-- Show me a list of customer names who placed more than one order, and their specific total amount spent right next to the name
SELECT name
FROM Customers C
WHERE (
	SELECT COUNT(*)
    FROM Orders O 
    WHERE O.customerID = C.customerID
) > 1;





