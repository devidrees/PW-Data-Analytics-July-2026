-- Total quantity of items -- all the elements of quantity -- aggregates - count, sum, min, max, avg
SELECT SUM(quantity) AS Total_items_sold
FROM Sales;

-- Total Orders in the table sales
SELECT COUNT(Sales_ID) AS Total_Orders
FROM Sales;

-- Which were the cheapest and the most expensive prices in the orders
SELECT
	MIN(unit_price) AS Cheapest_Price,
    MAX(unit_price) AS Most_Expensive_Price
FROM Sales;

-- What is the total revenue earned from all sales - quantity * unit_price
SELECT SUM(quantity * unit_price) AS Total_revenue
FROM Sales;


-- GROUP BY -- works on simple categorical columns
SELECT Product 
FROM SALES
GROUP BY Product;


-- Group by with Aggregate
-- Give me the contribution of sales quantities, for all product categories
-- show me the revenue per category
SELECT 
	Product_Category, 
    SUM(Quantity) AS Total_items_sold_per_category,
    SUM(quantity * unit_price) AS Total_revenue    
FROM SALES
GROUP BY Product_Category
ORDER BY Total_items_sold_per_category DESC;

-- How many orders have been placed for each product?
SELECT 
	Product,
    -- Product_Category,
    COUNT(Sales_ID) AS product_Sales,
	SUM(Quantity) AS total_quantity
FROM Sales
GROUP BY Product
ORDER BY product_Sales DESC;


-- Group by with mulitple categories
SELECT 
	Product,
    Product_Category,
    COUNT(Sales_ID) AS product_Sales,
	SUM(Quantity) AS total_quantity
FROM Sales
GROUP BY Product, Product_Category
ORDER BY product_Sales DESC;

-- groupby with respect to numeric data which is repetitive
SELECT 
	Quantity,
    COUNT(Sales_ID) AS Repeated_Orders
FROM Sales
GROUP BY Quantity;

-- HAVING CLAUSE
-- Group by with mulitple categories
SELECT 
	Product,
    Product_Category,
    COUNT(Sales_ID) AS product_Sales,
	SUM(Quantity * unit_price) AS total_revenue
FROM Sales
GROUP BY Product, Product_Category
HAVING product_Sales = 2
ORDER BY product_Sales DESC;

-- which categories are giving revenue more than 20000
SELECT 
	Product_Category,
    SUM(quantity * unit_Price) AS Revenue
FROM Sales
GROUP BY Product_Category
HAVING revenue > 20000;


SELECT 
	Product_Category,
    SUM(quantity * unit_Price) AS Revenue
FROM Sales
GROUP BY Product_Category
HAVING Product_Category = 'Electronics'





