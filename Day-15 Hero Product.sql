--NamasteKart an ecommerce company wants to find out its top most selling product by quanity in each category. 
--In case of a tie when quantities sold are same for more than 1 product 
--than we need to give preference to the product with higher sales value.



CREATE TABLE orders_nkart 
(
    order_id	INT,
    product_id	VARCHAR(512),
    category	VARCHAR(512),
    unit_price	INT,
    quantity	INT
);

INSERT INTO orders_nkart (order_id, product_id, category, unit_price, quantity) VALUES ('100', 'Chair-1221', 'Furniture', '1500', '1');
INSERT INTO orders_nkart (order_id, product_id, category, unit_price, quantity) VALUES ('101', 'Table-3421', 'Furniture', '2000', '3');
INSERT INTO orders_nkart (order_id, product_id, category, unit_price, quantity) VALUES ('102', 'Chair-1221', 'Furniture', '1500', '2');
INSERT INTO orders_nkart (order_id, product_id, category, unit_price, quantity) VALUES ('103', 'Table-9762', 'Furniture', '7000', '2');
INSERT INTO orders_nkart (order_id, product_id, category, unit_price, quantity) VALUES ('104', 'Shoes-1221', 'Footwear', '1700', '1');
INSERT INTO orders_nkart (order_id, product_id, category, unit_price, quantity) VALUES ('105', 'floaters-3421', 'Footwear', '2000', '1');
INSERT INTO orders_nkart (order_id, product_id, category, unit_price, quantity) VALUES ('106', 'floaters-3421', 'Footwear', '2000', '1');

SELECT * FROM orders_nkart

WITH total_count AS(
SELECT product_id,category,SUM(quantity) AS quantity_sold, SUM(unit_price * quantity) AS total_sales
FROM orders_nkart
GROUP BY product_id,category
	),
--SELECT * FROM total_count
top_product AS (
SELECT *
,DENSE_RANK( ) OVER (PARTITION BY category ORDER BY quantity_sold DESC,total_sales DESC) AS rn
FROM total_count
	)
--SELECT * FROM top_product
SELECT category,product_id 
FROM top_product
WHERE  rn = 1
GROUP BY category,product_id 
