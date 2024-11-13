--NamasteKart an ecommerce company wants to build a very imporant business metrics where 
--they want to track on daily basis how many new and repeat customers are purchasing products from their website. 
--A new customer is defined when he purchased anything for the first time from the website 
--and repeat customer is someone who has done atleast one purchase in the past.


CREATE TABLE customer_orders 
(
    order_id	INT,
    customer_id	INT,
    order_date	DATE,
    order_amount	INT
);

INSERT INTO customer_orders (order_id, customer_id, order_date, order_amount) VALUES ('1', '100', '2022-01-01', '2000');
INSERT INTO customer_orders (order_id, customer_id, order_date, order_amount) VALUES ('2', '200', '2022-01-01', '2500');
INSERT INTO customer_orders (order_id, customer_id, order_date, order_amount) VALUES ('3', '300', '2022-01-01', '2100');
INSERT INTO customer_orders (order_id, customer_id, order_date, order_amount) VALUES ('4', '100', '2022-01-02', '2000');
INSERT INTO customer_orders (order_id, customer_id, order_date, order_amount) VALUES ('5', '400', '2022-01-02', '2200');
INSERT INTO customer_orders (order_id, customer_id, order_date, order_amount) VALUES ('6', '500', '2022-01-02', '2700');
INSERT INTO customer_orders (order_id, customer_id, order_date, order_amount) VALUES ('7', '100', '2022-01-03', '3000');
INSERT INTO customer_orders (order_id, customer_id, order_date, order_amount) VALUES ('8', '400', '2022-01-03', '1000');
INSERT INTO customer_orders (order_id, customer_id, order_date, order_amount) VALUES ('9', '600', '2022-01-03', '3000');


SELECT * FROM customer_orders

WITH first_order_date AS(
SELECT customer_id ,min(order_date) AS first_order
FROM  customer_orders
GROUP BY customer_id
	)
--SELECT * FROM CTE_S
SELECT order_date
,SUM(CASE WHEN co.order_date = fod.first_order THEN 1 ELSE 0 END ) AS new_customers
,SUM(CASE WHEN co.order_date > fod.first_order THEN 1 ELSE 0 END ) AS repeat_customers
FROM  customer_orders co
INNER JOIN first_order_date fod
ON co.customer_id = fod.customer_id
GROUP BY co.order_date
