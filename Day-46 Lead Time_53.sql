--You are given orders data of an online ecommerce company. Dataset contains order_id , order_date and ship_date.
--Your task is to find lead time in days between order date and ship date using below rules:

--1- Exclude holidays. List of holidays present in holiday table. 

--2- If the order date is on weekends then consider it as order placed on immediate next monday 
--and if the ship date is on weekends then consider it as immediate previous Friday to do calculations.

--For example if order date is March 14th 2024 and ship date is March 20th 2024. 
--Consider March 18th is a holiday then lead time will be (20-14) -1 holiday = 5 days.
---------------------------------------------------------------------------
-- Create the table
CREATE TABLE orders_53 (
    order_id INT PRIMARY KEY,
    order_date DATE,
    ship_date DATE
);

-- Insert the data
INSERT INTO orders_53 (order_id, order_date, ship_date) VALUES
(1, '2024-03-14', '2024-03-20'),
(2, '2024-03-10', '2024-03-16'),
(3, '2024-03-04', '2024-03-12'),
(4, '2024-03-05', '2024-03-07'),
(5, '2024-03-03', '2024-03-08'),
(6, '2024-03-07', '2024-03-24');
----------------------------------------------------
-- Create the table for holidays
CREATE TABLE holidays_53 (
    holiday_id INT PRIMARY KEY,
    holiday_date DATE
);

-- Insert the holiday data
INSERT INTO holidays_53 (holiday_id, holiday_date) VALUES
(1, '2024-03-10'),
(2, '2024-03-18'),
(3, '2024-03-21');


SELECT * FROM orders_53
SELECT * FROM holidays_53

WITH CTE_1 AS(
	SELECT *,
	       CASE WHEN EXTRACT(DOW FROM order_date) = '0' THEN (order_date + INTERVAL '1 day')
	            WHEN EXTRACT(DOW FROM order_date) = '6' THEN (order_date + INTERVAL '2 day')
	            ELSE order_date END AS order_date_new,
	       CASE WHEN EXTRACT(DOW FROM ship_date) = '0' THEN (ship_date + INTERVAL '-2 day')
	            WHEN EXTRACT(DOW FROM ship_date) = '6' THEN (ship_date + INTERVAL '-1 day')
	            ELSE ship_date END AS ship_date_new
	FROM orders_53
   ),CTE_2 AS(
	SELECT order_id, order_date_new, ship_date_new,
	       EXTRACT(EPOCH FROM (ship_date_new - order_date_new)) / 86400 AS no_of_days
	FROM CTE_1
	   )
--SELECT * FROM CTE_2	
SELECT order_id, ROUND(no_of_days - COUNT(holiday_date),1) AS lead_time
FROM CTE_2 LEFT JOIN holidays_53
ON holiday_date BETWEEN order_date_new AND ship_date_new
GROUP BY order_id,no_of_days
ORDER BY order_id
		
	
	
	