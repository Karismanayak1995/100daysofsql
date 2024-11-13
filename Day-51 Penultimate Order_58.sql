--You are a data analyst working for an e-commerce company, responsible for analyzing customer orders to gain insights into their purchasing behavior. 
--Your task is to write a SQL query to retrieve the details of the penultimate order for each customer. 
--However, if a customer has placed only one order, you need to retrieve the details of that order instead.

--PENULTIMATE means : next to the last.
--------------------------------------------------------
DROP TABLE IF EXISTS orders_58 
-- Create the orders table
CREATE TABLE orders_58 (
    order_id INT,
    order_date DATE,
    customer_name VARCHAR(50),
    product_name VARCHAR(50),
    sales INT
);

-- Insert data into the orders table
INSERT INTO orders_58 (order_id, order_date, customer_name, product_name, sales) VALUES
(1, '2023-01-01', 'Alexa', 'iphone', 100),
(2, '2023-01-02', 'Alexa', 'boAt', 300),
(3, '2023-01-03', 'Alexa', 'Rolex', 400),
(4, '2023-01-01', 'Ramesh', 'Titan', 200),
(4, '2023-01-02', 'Ramesh', 'Shirt', 300),
(6, '2023-01-03', 'Neha', 'Dress', 100);

SELECT * FROM Orders_58

WITH order_rank AS(
	SELECT *,
	       ROW_NUMBER() OVER (PARTITION BY customer_name ORDER BY order_date DESC ) AS rn,
	       COUNT(*) OVER (PARTITION BY customer_name) AS order_count
	FROM Orders_58
	)
SELECT 	order_id,order_date,customer_name, product_name
FROM order_rank
WHERE (order_count >  1 AND rn = 2) OR (order_count = 1 AND rn = 1) 

------------------------------------------
with cte as (
select * 
,row_number() over(partition by customer_name order by order_date desc) as rn 
,count(*) over(partition by customer_name) as cnt_of_orders
from orders_58
)
select order_id, order_date, customer_name, product_name
from cte 
where rn = 2 or cnt_of_orders = 1;