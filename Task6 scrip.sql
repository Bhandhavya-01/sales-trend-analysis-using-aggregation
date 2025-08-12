create database online_sales;
use online_sales;

CREATE TABLE orders (
  order_id VARCHAR(50) PRIMARY KEY,
  order_date DATE NOT NULL,
  amount NUMERIC(12,2) NOT NULL,
  product_id INTEGER,
  customer_id INTEGER,
  quantity INTEGER
);

INSERT INTO orders (order_id, order_date, amount, product_id, customer_id, quantity)
VALUES ('ORD1001', '2024-01-15', 349.99, 12, 201, 1);

SET GLOBAL local_infile = 1;

-- Create a temporary table
CREATE TABLE temp_orders LIKE orders;

-- Load CSV into temp table
LOAD DATA LOCAL INFILE 'C:\\Users\\ADMIN\\Downloads\\datascience\\Elevated Lab\\Task 6\\online_sales.csv'
INTO TABLE temp_orders
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(order_id, order_date, amount, product_id, customer_id, quantity);

-- Insert only rows that are not already in orders
INSERT INTO orders
SELECT * FROM temp_orders
WHERE order_id NOT IN (SELECT order_id FROM orders);

-- Drop temp table
DROP TABLE temp_orders;

SELECT 
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    SUM(amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM orders
GROUP BY order_year, order_month
ORDER BY order_year, order_month;

SELECT *
FROM (
    SELECT 
        DATE_FORMAT(order_date, '%Y-%m') AS `year_month`,
        SUM(amount) AS total_revenue,
        COUNT(DISTINCT order_id) AS total_orders
    FROM orders
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
) AS sub
ORDER BY `year_month`;

SELECT 
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    SUM(amount) AS total_revenue
FROM orders
GROUP BY order_year, order_month
ORDER BY order_year, order_month;

SELECT 
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    SUM(amount) AS total_revenue,                     
    COUNT(DISTINCT order_id) AS total_orders          
FROM orders
GROUP BY order_year, order_month
ORDER BY order_year, order_month; 

SELECT 
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    SUM(amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM orders
GROUP BY order_year, order_month
ORDER BY order_year ASC, order_month ASC;  

SELECT 
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    SUM(amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM orders
WHERE EXTRACT(YEAR FROM order_date) = 2024
GROUP BY order_year, order_month
ORDER BY order_year ASC, order_month ASC;








