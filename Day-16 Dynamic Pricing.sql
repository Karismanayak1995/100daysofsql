--You are given a products table where a new row is inserted every time the price of a product changes. 
--Additionally, there is a transaction table containing details such as order_date and product_ID for each order. 
--Write an SQL query to calculate the total sales value for each product,
--considering the cost of the product at the time of the order date.



CREATE TABLE products_ns 
(
    product_id	INT,
    price_date	DATE,
    price	INT
);
c
INSERT INTO products_ns (product_id, price_date, price) VALUES ('100', '2024-01-01', '150');
INSERT INTO products_ns (product_id, price_date, price) VALUES ('100', '2024-01-21', '170');
INSERT INTO products_ns (product_id, price_date, price) VALUES ('100', '2024-02-01', '190');
INSERT INTO products_ns (product_id, price_date, price) VALUES ('101', '2024-01-01', '1000');
INSERT INTO products_ns (product_id, price_date, price) VALUES ('101', '2024-01-27', '1200');
INSERT INTO products_ns (product_id, price_date, price) VALUES ('101', '2024-02-05', '1250');

CREATE TABLE orders_ns 
(
    order_id	INT,
    order_date	DATE,
    product_id	INT
);

INSERT INTO orders_ns (order_id, order_date, product_id) VALUES ('1', '2024-01-05', '100');
INSERT INTO orders_ns (order_id, order_date, product_id) VALUES ('2', '2024-01-21', '100');
INSERT INTO orders_ns (order_id, order_date, product_id) VALUES ('3', '2024-02-20', '100');
INSERT INTO orders_ns (order_id, order_date, product_id) VALUES ('4', '2024-01-07', '101');
INSERT INTO orders_ns (order_id, order_date, product_id) VALUES ('5', '2024-02-04', '101');
INSERT INTO orders_ns (order_id, order_date, product_id) VALUES ('6', '2024-02-05', '101');

WITH CTE_P AS (
SELECT product_id,price_date,price
,ROW_NUMBER() OVER (ORDER BY product_id) AS pn
FROM products_ns  
	)
--SELECT * FROM CTE_P
SELECT c.product_id
,SUM(c.price) AS total_sales 
FROM CTE_P c
INNER JOIN orders_ns o
ON c.product_id = o.product_id AND c.pn = o.order_id
WHERE c.price_date <= o.order_date
GROUP BY c.product_id

------------------------------------------------
WITH CTE_P AS (
SELECT product_id,price_date,price
,date(LEAD(price_date,1,'9999-12-30') OVER (PARTITION BY product_id ORDER BY product_id) + INTERVAL'-1 day')AS price_end_date
FROM products_ns  
	)
--SELECT * FROM CTE_P
SELECT c.product_id,SUM(c.price)
FROM CTE_P c
INNER JOIN orders_ns o
ON c.product_id = o.product_id 
WHERE o.order_date BETWEEN c.price_date AND c.price_end_date
GROUP BY c.product_id