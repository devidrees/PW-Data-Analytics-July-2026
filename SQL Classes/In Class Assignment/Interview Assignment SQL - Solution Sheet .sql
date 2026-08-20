-- Question 1: Customers from Srinagar - id, name, city
-- Select the specific columns requested
SELECT 
    customer_id, 
    customer_name, 
    city
FROM 
    customers
-- Filter the records to only include customers located in Srinagar
WHERE 
    city = 'Srinagar'
-- Sort the results alphabetically (A-Z) based on the customer's name
ORDER BY 
    customer_name ASC;
    
    
-- Question 2: High-value completed orders - id, customer_id, date, amount
-- Select the specific columns requested by the finance team
SELECT 
    order_id, 
    customer_id, 
    order_date, 
    amount
FROM 
    orders
-- Filter for orders that are both 'Completed' and have an amount strictly greater than 20,000
WHERE 
    status = 'Completed' 
    AND amount > 20000
-- Sort the results in descending order based on the amount (highest to lowest)
ORDER BY 
    amount DESC;
    
    
-- Question 3: Total revenue by customer - customer_id, total_spent
-- Select the customer ID and calculate the sum of their order amounts
SELECT 
    customer_id, 
    SUM(amount) AS total_spent
FROM 
    orders
-- Ensure we only calculate revenue from orders that were successfully completed
WHERE 
    status = 'Completed'
-- Group the results by customer so the sum is calculated individually for each customer
GROUP BY 
    customer_id;
    
-- Expected explanation:
-- Because we want one result row for each customer while calculating an aggregate value for that customer.
-- because we want to calculate the total amount per customer, not the grand total for the entire store.

-- Question 4: Customers who spent more than 50,000 - customer_id, total_spent
-- Select the customer ID and calculate the sum of their order amounts
SELECT 
    customer_id, 
    SUM(amount) AS total_spent
FROM 
    orders
-- Filter out any returned or cancelled orders before doing the math
WHERE 
    status = 'Completed'
-- Group the remaining orders by customer
GROUP BY 
    customer_id
-- Use the HAVING clause to filter the results *after* the aggregation is calculated
HAVING 
    SUM(amount) > 50000;
    
-- Expected answer:
-- WHERE filters rows before aggregation. HAVING filters groups after aggregation
-- WHERE clause runs before the rows are grouped together, the database hasn't calculated the SUM(amount) yet. 
-- If you put an aggregate function in the WHERE clause, SQL gets confused because it is being asked to check 
-- a total that doesn't exist at that stage of the process.


-- Question 5: Customer names in order report - customer_name, order_id, order_date, amount
-- Select the required columns from both tables, using aliases (c and o) for clarity
SELECT 
    c.customer_name,
    o.order_id,
    o.order_date,
    o.amount
FROM 
    orders o
-- Use INNER JOIN to connect the orders to the specific customers who placed them
JOIN 
    customers c 
    ON o.customer_id = c.customer_id;
    
    
-- Question 6: Products being sold - product_name, category, order_id, quantity, amount
-- Select product details from the products table and order details from the orders table
SELECT 
    p.product_name,
    p.category,
    o.order_id,
    o.quantity,
    o.amount
FROM 
    orders o
-- Use INNER JOIN to link the orders to the specific products sold using product_id
JOIN 
    products p 
    ON o.product_id = p.product_id
-- Filter the results to only include orders that were successfully completed
WHERE 
    o.status = 'Completed';
    
    
-- Question 7: All products including unsold - product_id, product_name, category, order_id
-- Select product details alongside the order ID to easily spot which products lack orders
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    o.order_id
FROM 
    products p
-- A LEFT JOIN ensures that ALL rows from the 'products' table (the left table) are returned.
-- If a product has never been ordered, there will be no match in the 'orders' table, 
-- and the database will simply return NULL for the order_id.
LEFT JOIN 
    orders o 
    ON p.product_id = o.product_id;
    
-- Expected answer:
-- Because we want to keep products even when there is no matching order.
-- An INNER JOIN requires a match in both tables, which would completely hide any products that have never been ordered.
-- A LEFT JOIN guarantees that all items from the products table are returned, regardless of sales history. 
-- If a product has no matching record in the orders table, the database simply leaves the order details blank (NULL), 
-- allowing us to identify exactly what hasn't sold.   

 -- Question 8: Employees and their managers - employee_name, department, manager_name, manager_salary
-- Select the employee's details and alias the manager's details for clarity
SELECT 
    e.employee_name,
    e.department,
    m.employee_name AS manager_name,
    m.salary AS manager_salary
FROM 
    employees e
-- Use a LEFT JOIN to join the employees table to itself (a self-join).
-- 'e' represents the subordinate, and 'm' represents their manager.
-- The LEFT JOIN ensures that employees with a NULL manager_id (top-level executives) are still included.
LEFT JOIN 
    employees m 
    ON e.manager_id = m.employee_id;

-- Expected answer:
-- Because we join the employees table to itself. One copy represents the employee and the other represents the manager.
-- This is called a Self-Join. Because both the employee and the manager reside in the exact same table
-- We treat the table as if it were two separate tables by giving it two different aliases (e for the employee, m for the manager)

-- Question 9: Employees earning more than their managers - employee name, employee salary, manager name, manager salary
-- Select the required details for both the employee and their corresponding manager
SELECT 
    e.employee_name,
    e.salary AS employee_salary,
    m.employee_name AS manager_name,
    m.salary AS manager_salary
FROM 
    employees e
-- Perform an INNER JOIN on the same table to link employees to their managers.
-- We use an INNER JOIN here because employees without managers cannot earn more than a non-existent manager.
JOIN 
    employees m 
    ON e.manager_id = m.employee_id
-- Filter the results to only include rows where the employee's salary exceeds their manager's salary
WHERE 
    e.salary < m.salary;
-- Notice that this does not return any results.
-- The SQL query is correct but since there are currently no employees who earn more than their managers, database
-- returns an empty table.
-- Test the query by filtering the JOIN results with < rather than >

-- Question 10: Simulate selling price at every discount level - product name, original price, discount, discounted price
-- Select the product details and calculate the new price based on the discount percentage
SELECT 
    p.product_name,
    p.price AS original_price,
    d.discount,
    -- Calculate the discounted price: Original Price - (Original Price * Discount %)
    p.price - (p.price * d.discount / 100) AS discounted_price
FROM 
    products p
-- Use a CROSS JOIN to create a Cartesian product. 
-- This pairs every single row in the products table with every single row in the discounts table.
CROSS JOIN 
    discounts d
-- Order the results    
ORDER BY
    p.product_name,
    d.discount;
    
-- Expected answer:
-- Because a CROSS JOIN combines every row from the first table with every row from the second table.
-- With 8 products and 3 discounts: 8 × 3 = 24 rows
-- A CROSS JOIN does not need an ON clause because it doesn't look for matching keys. 
-- Instead, it systematically combines every item from the first table with every item from the second table, 
-- making it the perfect tool for creating exhaustive combinations or simulations like this


-- Question 11: Rank employees by salary within department - employee name, department, salary, salary rank
-- Select employee details and calculate the rank using a window function
SELECT 
    employee_name,
    department,
    salary,
    -- RANK() assigns a ranking number based on the ORDER BY clause within each partition
    RANK() OVER (
        PARTITION BY department 
        ORDER BY salary DESC
    ) AS salary_rank
FROM 
    employees;

-- Expected answer:
-- ROW_NUMBER() gives every row a unique number, even when salaries are equal.
-- RANK() gives equal salaries the same rank and leaves gaps afterward.    
-- RANK() function automatically gives the same rank number to employees with identical salaries!

-- Question 12: Top two products in each category based on revenue - product_name, category, total_revenue, revenue_rank

-- Question 12 (Alternative): Top two products per category without CTE

SELECT 
    product_name,
    category,
    total_revenue,
    revenue_rank
FROM (
    -- This inner query does the math and the ranking all at once
    SELECT 
        p.product_name,
        p.category,
        SUM(o.quantity * p.price) AS total_revenue,
        -- We can apply the RANK function directly to the aggregated SUM
        RANK() OVER (
            PARTITION BY p.category 
            ORDER BY SUM(o.quantity * p.price) DESC
        ) AS revenue_rank
    FROM 
        products p
    JOIN 
        orders o 
        ON p.product_id = o.product_id
    WHERE 
        o.status = 'Completed'
    GROUP BY 
        p.product_id, 
        p.product_name, 
        p.category) AS RankedProducts  -- Every subquery needs an alias
-- The outer query simply filters the results of the inner query
WHERE 
    revenue_rank <= 2;

-- ALTERNATIVELY: Use CTEs
-- Step 1 & 2: Use a Common Table Expression (CTE) to calculate revenue and assign ranks.
-- We cannot use window functions directly in a WHERE clause, so we do it in a CTE first.
WITH ProductRevenue AS (
    SELECT 
        p.product_name,
        p.category,
        -- Calculate total revenue explicitly using quantity * product price
        SUM(o.quantity * p.price) AS total_revenue
    FROM products p
    JOIN 
        orders o 
        ON p.product_id = o.product_id
    -- Ensure we only count completed sales
    WHERE 
        o.status = 'Completed'
    -- Group by product details to get the total revenue per product
    GROUP BY 
        p.product_id, 
        p.product_name, 
        p.category
),
RankedProducts AS (
    SELECT 
        product_name,
        category,
        total_revenue,
        -- Rank products within their respective categories based on the calculated revenue
        RANK() OVER (
            PARTITION BY category 
            ORDER BY total_revenue DESC
        ) AS revenue_rank
    FROM ProductRevenue
)
-- Step 3: Select the final results and filter for only the top 2 products per category
SELECT 
    product_name,
    category,
    total_revenue,
    revenue_rank
FROM RankedProducts
WHERE revenue_rank <= 2;
    

-- Question 13: Customer return frequency - customer ID, order date, amount, previous order date, next order date
-- Select the required columns and use window functions to look backward and forward in time
SELECT 
    customer_id,
    order_date,
    amount,
    -- LAG() peeks at the previous row in the defined window
    LAG(order_date) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date
    ) AS previous_order_date,
    -- LEAD() peeks at the next row in the defined window
    LEAD(order_date) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date
    ) AS next_order_date
FROM orders
-- Order the final output so it's easy to read chronologically per customer
ORDER BY 
    customer_id, 
    order_date;
-- Expected answer:
-- It retrieves a value from a previous row within the window.
-- LAG() and LEAD() are powerful window functions that allow you to compare a row's values with the rows immediately before or after it, 
-- without needing complex self-joins. 

    
 -- Question 14: Total company revenue on every daily sales record - sale_date, daily_revenue, total_company_revenue

-- Select the daily sales information along with a newly calculated grand total
SELECT 
    sale_date,
    revenue AS daily_revenue,
    -- Using SUM() as a window function with an empty OVER() clause 
    -- calculates the grand total of all rows without collapsing them
    SUM(revenue) OVER () AS total_company_revenue
FROM daily_sales
-- Order chronologically for better readability
ORDER BY sale_date;


-- Question 14: Total company revenue on every daily sales record - sale_date, daily_revenue, total_company_revenue
-- Select the daily sales information along with a newly calculated grand total
SELECT 
    sale_date,
    revenue AS daily_revenue,
    -- Using SUM() as a window function with an empty OVER() clause 
    -- calculates the grand total of all rows without collapsing them
    SUM(revenue) OVER () AS total_company_revenue
FROM daily_sales
-- Order chronologically for better readability
ORDER BY sale_date;

-- Follow up question:
-- Simplest solution
-- Because there is no ORDER BY, the entire table is the window
SELECT
    sale_date,
    revenue,
    SUM(revenue) OVER () AS total_revenue
FROM daily_sales;
-- Alternatively
SELECT
    sale_date,
    revenue,
    SUM(revenue) OVER (
        ORDER BY sale_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS total_revenue
FROM daily_sales;

-- SUM(revenue) OVER () -- This gives the SAME grand total on every row
-- SUM(revenue) OVER (ORDER BY sale_date) -- This gives a RUNNING SUM (cumulative total)


-- Question 15: Latest order amount for every customer 

-- We can use subquery
-- We place the exact same window function logic inside a subquery (derived table)
SELECT 
    customer_id,
    order_date AS latest_order_date,
    amount AS latest_order_amount
FROM (
    -- The inner query assigns the row numbers based on date
    SELECT 
        customer_id,
        order_date,
        amount,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id 
            ORDER BY order_date DESC, order_id DESC
        ) AS rn
    FROM orders
) AS RankedOrders -- The subquery must be given an alias
-- The outer query filters for the #1 most recent order
WHERE 
    rn = 1;
    
-- Alternatively use CTE
-- Step 1: Assign a row number to every order, partitioned by customer and ordered backward by date
WITH RankedOrders AS (
    SELECT 
        customer_id,
        order_id,
        order_date,
        amount,
        -- ROW_NUMBER() creates a sequential integer for each row within its partition.
        -- By ordering descending by date, the newest order always gets row number 1.
        ROW_NUMBER() OVER (
            PARTITION BY customer_id 
            ORDER BY order_date DESC, order_id DESC -- Added order_id to break any potential ties on the same date
        ) AS rn
    FROM orders
)
-- Step 2: Filter the results to only show the #1 most recent order for each customer
SELECT 
    customer_id,
    order_date AS latest_order_date,
    amount AS latest_order_amount
FROM RankedOrders
WHERE 
    rn = 1;
    
    
-- Context for last question:
SELECT
    customer_id,
    order_date,
    amount,

    LAST_VALUE(amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS latest_order_amount
FROM orders;
-- this query behaves differently from our solution
-- returns every single order in the database
-- and SQL automatically applies a default "window frame" that looks like this: RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW


-- Expected Answer
-- The problem is the window frame. 
-- But the default frame does not necessarily mean: "all rows belonging to this customer."
-- It ends at the current row (with peer behavior around equal ordering values)

-- simple get around
-- But not as elegant as our initial solution using a subquery on this very table
SELECT
    customer_id,
    order_date,
    amount,

    LAST_VALUE(amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date

        ROWS BETWEEN
            UNBOUNDED PRECEDING
            AND UNBOUNDED FOLLOWING

    ) AS latest_order_amount
FROM orders
ORDER BY
    customer_id,
    order_date;