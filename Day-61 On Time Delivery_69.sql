--Zomato introduced an "on-time delivery" policy where they refund the total order amount or 200 rupees, whichever is lower, in case of late delivery. 
--Additionally, customers have the option to choose whether they want the refund for late orders or if they are okay with the delay and do not want any refund.

--Write a SQL query to calculate the return percent revenue and on time order delivery percent for Zomato for each city, considering the refund policy and customer preferences. 
--Round the percentages to 2 decimal places.
----------------------------------------------------------
-- Create the orders table
CREATE TABLE orders_69 (
    order_id INT PRIMARY KEY,
    city VARCHAR(50),
    actual_delivery_time INT,
    expected_delivery_time INT,
    order_amount DECIMAL(10, 2),
    customer_preference VARCHAR(50)
);

-- Insert data into the orders table
INSERT INTO orders_69 (order_id, city, actual_delivery_time, expected_delivery_time, order_amount, customer_preference) VALUES
(1, 'Delhi', 28, 30, 300, 'no_refund'),
(2, 'Delhi', 45, 40, 400, 'refund'),
(3, 'Delhi', 25, 20, 450, 'no_refund'),
(4, 'Delhi', 30, 25, 250, 'no_refund'),
(5, 'Delhi', 20, 15, 200, 'refund'),
(6, 'Mumbai', 35, 30, 300, 'refund'),
(7, 'Mumbai', 45, 40, 400, 'no_refund'),
(8, 'Mumbai', 18, 20, 150, 'no_refund'),
(9, 'Mumbai', 25, 25, 250, 'no_refund'),
(10, 'Mumbai', 20, 15, 190, 'refund');
--------------------------------------
SELECT * FROM orders_69

------------------

WITH CTE AS (
    SELECT city,
           COUNT(*) AS total_order,
	       COUNT(CASE WHEN actual_delivery_time <= expected_delivery_time THEN 1 ELSE NULL END ) AS total_ontime_orders,
	       SUM(CASE WHEN actual_delivery_time > expected_delivery_time AND customer_preference = 'refund' 
			   THEN (CASE WHEN order_amount>200 THEN 200 ELSE order_amount END) ELSE 0 END ) AS refund_amount,
		   SUM(order_amount) AS total_order_amount																								
    FROM orders_69	   
    GROUP BY city
	ORDER BY city
	     )
SELECT city,
       ROUND((refund_amount :: numeric / total_order_amount)*100,2) AS return_amount_percent,
	   ROUND((total_ontime_orders :: numeric / total_order)*100,2) AS ontime_orders_percent
FROM CTE	   
----------------------------------------------

with cte as (
select city
,sum(case when actual_delivery_time>expected_delivery_time 
and customer_preference='refund' then 
(case when order_amount>200 then 200 else order_amount end)
else 0
end) as refund_amount
,sum(order_amount) as total_order_amount
,count(case when actual_delivery_time<=expected_delivery_time 
then order_id end) as on_time_orders
,count(*) as total_orders
 from orders_69
 group by city
)
select city
, max(round((refund_amount*100.0/total_order_amount),2)) as return_amount_percent
, max(round((on_time_orders*100.0/total_orders),2)) as ontime_orders_percent
from cte
group by city;
	   