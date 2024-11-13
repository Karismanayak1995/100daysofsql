--Zomato is interested in analyzing customer food ordering behavior and wants to identify customers who have exhibited inconsistent patterns over time.
-- write an SQL query to identify customers who have placed orders on both weekdays and weekends,
--but with a significant difference in the average order amount between weekdays and weekends.
--Specifically, you need to identify customers who have a minimum of 3 orders placed both on weekdays and weekends each,
--and where the average order amount on weekends is at least 20% higher than the average order amount on weekdays.

CREATE TABLE orders_32 
(
    order_id	INT,
    customer_id	INT,
    order_date	DATE,
    order_amount INT
);

INSERT INTO orders_32 (order_id, customer_id, order_date, order_amount) VALUES ('1', '101', '2023-01-04', '100');
INSERT INTO orders_32 (order_id, customer_id, order_date, order_amount) VALUES ('2', '101', '2023-01-05', '200');
INSERT INTO orders_32 (order_id, customer_id, order_date, order_amount) VALUES ('3', '101', '2023-01-06', '80');
INSERT INTO orders_32 (order_id, customer_id, order_date, order_amount) VALUES ('4', '101', '2023-01-07', '110');
INSERT INTO orders_32 (order_id, customer_id, order_date, order_amount) VALUES ('5', '101', '2023-01-08', '90');
INSERT INTO orders_32 (order_id, customer_id, order_date, order_amount) VALUES ('6', '101', '2023-01-14', '130');
INSERT INTO orders_32 (order_id, customer_id, order_date, order_amount) VALUES ('7', '101', '2023-01-15', '150');
INSERT INTO orders_32 (order_id, customer_id, order_date, order_amount) VALUES ('8', '101', '2023-01-21', '100');
INSERT INTO orders_32 (order_id, customer_id, order_date, order_amount) VALUES ('9', '101', '2023-01-22', '120');
INSERT INTO orders_32 (order_id, customer_id, order_date, order_amount) VALUES ('10', '101', '2023-01-28', '90');
INSERT INTO orders_32 (order_id, customer_id, order_date, order_amount) VALUES ('11', '102', '2023-01-29', '110');
INSERT INTO orders_32 (order_id, customer_id, order_date, order_amount) VALUES ('12', '102', '2023-02-04', '80');
INSERT INTO orders_32 (order_id, customer_id, order_date, order_amount) VALUES ('13', '102', '2023-02-05', '100');
INSERT INTO orders_32 (order_id, customer_id, order_date, order_amount) VALUES ('14', '102', '2023-02-11', '120');
INSERT INTO orders_32 (order_id, customer_id, order_date, order_amount) VALUES ('15', '102', '2023-02-15', '140');
INSERT INTO orders_32 (order_id, customer_id, order_date, order_amount) VALUES ('16', '102', '2023-02-18', '80');
INSERT INTO orders_32 (order_id, customer_id, order_date, order_amount) VALUES ('17', '102', '2023-02-19', '100');
INSERT INTO orders_32 (order_id, customer_id, order_date, order_amount) VALUES ('18', '102', '2023-02-25', '120');
INSERT INTO orders_32 (order_id, customer_id, order_date, order_amount) VALUES ('19', '102', '2023-02-28', '140');
INSERT INTO orders_32 (order_id, customer_id, order_date, order_amount) VALUES ('20', '102', '2023-03-04', '80');
INSERT INTO orders_32 (order_id, customer_id, order_date, order_amount) VALUES ('21', '104', '2023-04-09', '140');
INSERT INTO orders_32 (order_id, customer_id, order_date, order_amount) VALUES ('22', '104', '2023-04-13', '80');
INSERT INTO orders_32 (order_id, customer_id, order_date, order_amount) VALUES ('23', '104', '2023-04-16', '100');
INSERT INTO orders_32 (order_id, customer_id, order_date, order_amount) VALUES ('24', '104', '2023-04-22', '200');
INSERT INTO orders_32 (order_id, customer_id, order_date, order_amount) VALUES ('25', '104', '2023-04-27', '140');
INSERT INTO orders_32 (order_id, customer_id, order_date, order_amount) VALUES ('26', '104', '2023-04-28', '80');
INSERT INTO orders_32 (order_id, customer_id, order_date, order_amount) VALUES ('27', '104', '2023-04-30', '100');


SELECT * FROM orders_32


WITH weekdays_orders AS (
SELECT customer_id
,ROUND(AVG(order_amount),1) AS weekdays_avg_amount
FROM orders_32
WHERE EXTRACT(ISODOW FROM order_date) BETWEEN 1 AND 5	--1 FOR MON AND 5 FOR FRI
GROUP BY customer_id
HAVING COUNT(order_date) >= 3	
	) 
, weekends_orders AS (
SELECT customer_id
,ROUND(AVG(order_amount),1) AS weekends_avg_amount
FROM orders_32
WHERE EXTRACT(ISODOW FROM order_date) IN(6,7)--6 FOR SAT,7 FOR SUN	
GROUP BY customer_id
HAVING COUNT(order_date) >= 3
	) 
SELECT wd.customer_id, wd.weekdays_avg_amount, we.weekends_avg_amount
,ROUND(((we.weekends_avg_amount - wd.weekdays_avg_amount )/wd.weekdays_avg_amount),2) AS percent_diff
FROM weekdays_orders wd
INNER JOIN weekends_orders we
ON wd.customer_id = we.customer_id
WHERE we.weekends_avg_amount > 1.2 * wd.weekdays_avg_amount  
