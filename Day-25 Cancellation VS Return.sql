--You are given orders data of an ecommerce website with order date, delivery date and cancel date information.
--If the order is cancelled after it is delivered then it will be considered as a return order else cancelled order. 

--Write an SQL to calculate cancellation rate and return rate for each month (as per order date). 
--Round the rates to 2 decimal places.

--cancellation rate = (no of orders cancelled / total orders placed but not returned ) * 100 

--return rate = (no of orders returned/ total orders placed but not cancelled) * 100 

--Sort the output by increasing order of yearmonth('YYYYMM')
drop table if exists order_ns2 
CREATE TABLE order_ns2 
(
    rder_id	INT,
    customer_id	INT,
    order_date	VARCHAR(512),
    delivery_date VARCHAR(512),	
    cancel_date	VARCHAR(512)
);

INSERT INTO order_ns2 (rder_id, customer_id, order_date, delivery_date, cancel_date) VALUES ('1', '101', '2023-01-05', '2023-01-10', 'null');
INSERT INTO order_ns2 (rder_id, customer_id, order_date, delivery_date, cancel_date) VALUES ('2', '102', '2023-01-10', '2023-01-15', '2023-01-16');
INSERT INTO order_ns2 (rder_id, customer_id, order_date, delivery_date, cancel_date) VALUES ('3', '103', '2023-01-15', 'null', '2023-01-20');
INSERT INTO order_ns2 (rder_id, customer_id, order_date, delivery_date, cancel_date) VALUES ('4', '104', '2023-01-07', '2023-01-10', 'null');
INSERT INTO order_ns2 (rder_id, customer_id, order_date, delivery_date, cancel_date) VALUES ('5', '105', '2023-01-13', '2023-01-17', '2023-01-19');
INSERT INTO order_ns2 (rder_id, customer_id, order_date, delivery_date, cancel_date) VALUES ('6', '106', '2023-02-15', '2023-02-20', 'null');
INSERT INTO order_ns2 (rder_id, customer_id, order_date, delivery_date, cancel_date) VALUES ('7', '107', '2023-02-05', '2023-02-05', '2023-02-08');
INSERT INTO order_ns2 (rder_id, customer_id, order_date, delivery_date, cancel_date) VALUES ('8', '108', '2023-02-10', 'null', '2023-02-15');

SELECT * FROM order_ns2 

SELECT DATE_PART('year',order_date)
,CASE WHEN delivery_date IS NULL AND cancel_date IS NOT NULL THEN 1 ELSE 0 END AS cancel_flag
,CASE WHEN delivery_date IS NOT NULL AND cancel_date IS NOT NULL THEN 1 ELSE 0 END AS return_flag
FROM order_ns2	  