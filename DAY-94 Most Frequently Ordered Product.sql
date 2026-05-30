🔥 6. Most Frequently Ordered Product

CREATE TABLE orders_28_05 (
    order_id INT,
    user_id INT
);

CREATE TABLE order_items_28_05 (
    order_id INT,
    product_id INT,
    quantity INT
);

CREATE TABLE products_28_05 (
    product_id INT,
    product_name VARCHAR(50)
);

INSERT INTO orders_28_05 VALUES
(1, 101),
(2, 102),
(3, 103);

INSERT INTO order_items_28_05 VALUES
(1, 1, 2),
(1, 2, 1),
(2, 1, 3),
(3, 3, 5);

INSERT INTO products_28_05 VALUES
(1, 'Laptop'),
(2, 'Mouse'),
(3, 'Keyboard');

Problem

👉 Find top-selling product by quantity.

SELECT * FROM orders_28_05;
SELECT * FROM order_items_28_05;
SELECT * FROM products_28_05;

WITH product_quantity AS (
	SELECT p.product_id,
    p.product_name,
    SUM(o.quantity) AS total_quantity,
	DENSE_RANK() OVER (ORDER BY SUM(o.quantity) DESC ) AS rnk
    FROM products_28_05 p
    JOIN order_items_28_05 o
    ON p.product_id = o.product_id
    GROUP BY p.product_id,p.product_name
	)
SELECT 	product_id,product_name, total_quantity
FROM product_quantity
WHERE rnk = 1;
