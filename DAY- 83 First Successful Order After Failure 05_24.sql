CREATE TABLE customers_05_24 (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO customers_05_24 VALUES
(1, 'Asha'),
(2, 'Ravi'),
(3, 'Neha');

CREATE TABLE orders_05_24 (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers_05_24(customer_id)
);

INSERT INTO orders_05_24 VALUES
(101, 1, '2024-01-01'),
(102, 1, '2024-01-05'),
(103, 2, '2024-01-02'),
(104, 3, '2024-01-03'),
(105, 3, '2024-01-06');

CREATE TABLE payments_05_24 (
    payment_id INT PRIMARY KEY,
    order_id INT,
    status VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES orders_05_24(order_id)
);

INSERT INTO payments_05_24 VALUES
(1, 101, 'failed'),
(2, 102, 'success'),
(3, 103, 'success'),
(4, 104, 'failed'),
(5, 105, 'failed');

-- PROBLEM: First Successful Order After Failure

-- 👉 You are given orders and payments.

-- 👉 Find customers whose first order payment FAILED but later they had a SUCCESSFUL payment.

-- 👉 Return:

-- 1.customer_id
-- 2.first_order_status
-- 3.first_successful_order_id

---------------------------------------------
SELECT * FROM customers_05_24;
SELECT * FROM orders_05_24;
SELECT * FROM payments_05_24;
----------------------------------------------

WITH first_order AS (
		SELECT o.customer_id,o.order_id,p.status,
        ROW_NUMBER() OVER (PARTITION BY o.customer_id ORDER BY o.order_date ASC) AS rnk1
        FROM orders_05_24 o 
        JOIN payments_05_24 p ON o.order_id = p.order_id
	
	),first_success AS (
		SELECT o.customer_id,
		o.order_id,
		ROW_NUMBER() OVER (PARTITION BY o.customer_id ORDER BY o.order_date ASC) AS rnk2
		FROM orders_05_24 o
		JOIN payments_05_24 p ON o.order_id = p.order_id
		WHERE p.status = 'success'
		)
SELECT f.customer_id,
f.status AS first_order_status,
s.order_id AS first_successful_order_id
FROM first_order f
JOIN first_success s
ON f.customer_id = s.customer_id
WHERE f.rnk1 = 1
AND s.rnk2 = 1
AND f.status = 'failed' ;

	
	
