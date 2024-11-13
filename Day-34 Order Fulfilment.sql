--Write an SQL query to generate a report listing the orders that can be fulfilled based on the available inventory in the warehouse, 
--following a first-come-first-serve approach based on the order date. 
--Each row in the report should include the order ID, product name, quantity requested by the customer, quantity actually fulfilled, and a comments column as below:

--If the order can be completely fulfilled then 'Full Order',If the order can be partially fullfilled then 'Partial Order',If order can not be fulfilled at all then 'No Order'.

CREATE TABLE products_35 
(
    product_id	INT,
    product_name	VARCHAR(512),
    available_quantity	INT
);

INSERT INTO products_35 (product_id, product_name, available_quantity) VALUES ('1', 'Product A', '10');
INSERT INTO products_35 (product_id, product_name, available_quantity) VALUES ('2', 'Product B', '20');
INSERT INTO products_35 (product_id, product_name, available_quantity) VALUES ('3', 'Product C', '15');
INSERT INTO products_35 (product_id, product_name, available_quantity) VALUES ('4', 'Product D', '10');


CREATE TABLE orders_35 
(
    order_id	INT,
    product_id	INT,
    order_date	DATE,
    quantity_requested	INT
);

INSERT INTO orders_35 (order_id, product_id, order_date, quantity_requested) VALUES ('1', '1', '2024-01-01', '5');
INSERT INTO orders_35 (order_id, product_id, order_date, quantity_requested) VALUES ('2', '1', '2024-01-02', '7');
INSERT INTO orders_35 (order_id, product_id, order_date, quantity_requested) VALUES ('3', '2', '2024-01-03', '10');
INSERT INTO orders_35 (order_id, product_id, order_date, quantity_requested) VALUES ('4', '2', '2024-01-04', '10');
INSERT INTO orders_35 (order_id, product_id, order_date, quantity_requested) VALUES ('5', '2', '2024-01-05', '5');
INSERT INTO orders_35 (order_id, product_id, order_date, quantity_requested) VALUES ('6', '3', '2024-01-06', '4');
INSERT INTO orders_35 (order_id, product_id, order_date, quantity_requested) VALUES ('7', '3', '2024-01-07', '5');
INSERT INTO orders_35 (order_id, product_id, order_date, quantity_requested) VALUES ('8', '4', '2024-01-08', '4');
INSERT INTO orders_35 (order_id, product_id, order_date, quantity_requested) VALUES ('9', '4', '2024-01-09', '5');
INSERT INTO orders_35 (order_id, product_id, order_date, quantity_requested) VALUES ('10', '4', '2024-01-10', '8');
INSERT INTO orders_35 (order_id, product_id, order_date, quantity_requested) VALUES ('11', '4', '2024-01-11', '5');

Select * from orders_35
Select * from products_35

WITH running_quantity AS(
SELECT o.*
,SUM(quantity_requested) OVER (PARTITION BY o.product_id ORDER BY order_date) AS running_requested_quantity
,p.product_name
,p.available_quantity

FROM orders_35 o
INNER JOIN products_35 p
ON o.product_id = p.product_id
	)
SELECT order_id,product_name,quantity_requested AS requested_quantity
,CASE WHEN  running_requested_quantity <= available_quantity THEN quantity_requested
WHEN available_quantity - (running_requested_quantity - quantity_requested) > 0 
THEN available_quantity - (running_requested_quantity - quantity_requested)
ELSE 0 END AS qty_fulfilled 
,CASE WHEN  running_requested_quantity <= available_quantity then 'Full Order'
WHEN available_quantity - (running_requested_quantity - quantity_requested) > 0 then 'Partial Order'
ELSE 'No Order' END AS comments  
FROM running_quantity

