CREATE DATABASE superstore;

CREATE TABLE products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    sub_category VARCHAR(50)
);

CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    region VARCHAR(50)
);

CREATE TABLE orders (
    order_id VARCHAR(10) PRIMARY KEY,
    order_date DATE,
    customer_id VARCHAR(10),
    ship_mode VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE sales (
    sales_id VARCHAR(10) PRIMARY KEY,
    order_id VARCHAR(10),
    product_id VARCHAR(10),
    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(4,2),
    profit DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);



-- total sales and total profit for each category, ordered from highest to lowest total sales.
SELECT 
    p.category,
    SUM(s.sales) AS total_sales,
    SUM(s.profit) AS profit
FROM
    sales s
        JOIN
    products p ON s.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sales DESC
;

--  top 5 customers by total profit
SELECT 
    c.customer_name AS customer_name,
    SUM(s.profit) AS total_profit
FROM
    sales s
        JOIN
    orders o ON s.order_id = o.order_id
        JOIN
    customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_profit DESC
LIMIT 5;

-- Find total sales and total profit broken down by region, but only include regions where total profit exceeds $30,000.
SELECT 
    c.region,
    SUM(s.sales) AS total_sales,
    SUM(s.profit) AS total_profit
FROM
    customers c
        JOIN
    orders o ON c.customer_id = o.customer_id
        JOIN
    sales s ON o.order_id = s.order_id
GROUP BY c.region
HAVING total_profit > 30000
ORDER BY total_profit DESC;

-- Find the monthly sales trend — total sales for each month across all years, 
-- ordered chronologically (earliest month first).
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
    SUM(s.sales) AS total_sales
FROM
    sales s
        JOIN
    orders o ON s.order_id = o.order_id
GROUP BY sales_month
ORDER BY sales_month;

-- Find the top 5 products by total profit,
-- but also show what percentage of overall total profit each one represents.
SELECT 
    p.product_name,
    SUM(s.profit) AS total_profit,
    ROUND(100 * SUM(s.profit) / (SELECT 
                    SUM(profit)
                FROM
                    sales),
            2) AS pct_of_total
FROM
    products p
        JOIN
    sales s ON p.product_id = s.product_id
GROUP BY product_name
ORDER BY total_profit
LIMIT 5;

-- find the average discount and average profit for each category
SELECT 
    ROUND(AVG(s.discount), 2) AS avg_discount,
    ROUND(AVG(s.profit), 2) AS avg_profit,
    p.category
FROM
    products p
        JOIN
    sales s ON p.product_id = s.product_id
GROUP BY category;

-- Find orders that had more than one product in them 
-- (i.e., order_ids that appear more than once in the sales table).
SELECT 
    o.order_id, COUNT(s.order_id)
FROM
    orders o
        JOIN
    sales s ON o.order_id = s.order_id
GROUP BY order_id
HAVING COUNT(s.order_id) > 1;

-- Rank products within each category by total profit
SELECT category, product_name, total_profit,
       RANK() OVER (PARTITION BY category ORDER BY total_profit DESC) AS profit_rank
FROM (
   SELECT p.category, p.product_name, SUM(s.profit) AS total_profit
FROM products p
JOIN sales s ON p.product_id = s.product_id
GROUP BY p.category, p.product_name
) AS product_totals;

-- categorize each sale into a profit tier: 'High' if profit is greater than 100
-- 'Medium' if profit is between 0 and 100 (inclusive), 
-- and 'Low' if profit is negative.
SELECT 
    CASE
        WHEN profit > 100 THEN 'High'
        WHEN profit BETWEEN 0 AND 100 THEN 'Medium'
        ELSE 'Low'
    END AS profit_tier,
    COUNT(*) AS number_of_sales
FROM
    sales
GROUP BY profit_tier;





























