--Suppose you are working as a data analyst for Zomato . Zomato is planning to offer a premium membership to customers who have placed multiple orders in a single day.

--Your task is to write a SQL to find those customers who have placed multiple orders in a single day atleast once ,
--total order value generate by those customers and order value generated only by those orders. 
-- Create the orders table
CREATE TABLE orders_37 (
    order_id SERIAL PRIMARY KEY,
    order_date TIMESTAMP,
    customer_name VARCHAR(100),
    order_value INTEGER
);

-- Insert data into the orders table
INSERT INTO orders_37 (order_id, order_date, customer_name, order_value) VALUES
(1, '2023-01-13 12:30:00', 'Rahul', 250),
(2, '2023-01-13 08:30:00', 'Rahul', 350),
(3, '2023-01-13 09:00:00', 'Mudit', 230),
(4, '2023-01-14 08:30:00', 'Rahul', 150),
(5, '2023-01-14 12:03:00', 'Suresh', 130),
(6, '2023-01-15 09:34:00', 'Mudit', 250),
(7, '2023-01-15 12:30:00', 'Mudit', 300),
(8, '2023-01-15 09:30:00', 'Rahul', 250),
(9, '2023-01-15 12:35:00', 'Rahul', 300),
(10, '2023-01-15 12:03:00', 'Suresh', 130);

SELECT * FROM orders_37

WITH CTE AS(
SELECT DATE(order_date) AS order_day,customer_name	
,sum(order_value) AS order_value
FROM orders_37
GROUP BY customer_name,DATE(order_date)
HAVING COUNT (DATE(order_date)) >1	
)
SELECT o.customer_name
,SUM(o.order_value) AS total_order_value
,sum(case when c.customer_name is not null then o.order_value end) as order_value
FROM orders_37 o
LEFT JOIN CTE c
ON o.customer_name = c.customer_name
AND DATE(order_date) = c.order_day
WHERE o.customer_name IN (SELECT DISTINCT customer_name FROM CTE)
GROUP BY o.customer_name


