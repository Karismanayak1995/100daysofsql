CREATE TABLE customers_26 (
    customer_id   INT,
    name          VARCHAR(50),
    city          VARCHAR(50)
);

CREATE TABLE orders_26 (
    order_id      INT,
    customer_id   INT,
    order_date    DATE,
    amount        DECIMAL(10,2),
    status        VARCHAR(20)  -- 'delivered', 'cancelled', 'returned'
);


-- Customers
INSERT INTO customers_26 VALUES
(1,  'Arjun Sharma',  'Hyderabad'),
(2,  'Priya Reddy',   'Hyderabad'),
(3,  'Kiran Mehta',   'Mumbai'),
(4,  'Sneha Iyer',    'Mumbai'),
(5,  'Ravi Kumar',    'Bangalore'),
(6,  'Divya Nair',    'Bangalore'),
(7,  'Amit Joshi',    'Hyderabad'),
(8,  'Neha Gupta',    'Mumbai');

-- Orders
INSERT INTO orders_26 VALUES
-- Arjun (1) - 3 consecutive months ✅
(101, 1, '2024-01-10', 5000.00,  'delivered'),
(102, 1, '2024-02-15', 3000.00,  'delivered'),
(103, 1, '2024-03-20', 4000.00,  'delivered'),
(104, 1, '2024-05-10', 2000.00,  'delivered'),

-- Priya (2) - 3 consecutive months ✅
(105, 2, '2024-02-05', 6000.00,  'delivered'),
(106, 2, '2024-03-18', 4500.00,  'delivered'),
(107, 2, '2024-04-22', 3500.00,  'delivered'),
(108, 2, '2024-06-10', 2500.00,  'cancelled'),

-- Kiran (3) - NOT consecutive ❌ (Jan, Mar, May — gaps)
(109, 3, '2024-01-08', 4000.00,  'delivered'),
(110, 3, '2024-03-14', 3000.00,  'delivered'),
(111, 3, '2024-05-20', 5000.00,  'delivered'),

-- Sneha (4) - 3 consecutive months ✅
(112, 4, '2024-03-05', 7000.00,  'delivered'),
(113, 4, '2024-04-12', 5500.00,  'delivered'),
(114, 4, '2024-05-18', 4500.00,  'delivered'),
(115, 4, '2024-06-25', 3000.00,  'delivered'),

-- Ravi (5) - only 2 months ❌
(116, 5, '2024-01-15', 3500.00,  'delivered'),
(117, 5, '2024-02-20', 2500.00,  'delivered'),
(118, 5, '2024-05-10', 1500.00,  'cancelled'),

-- Divya (6) - 3 consecutive months ✅
(119, 6, '2024-04-08', 8000.00,  'delivered'),
(120, 6, '2024-05-15', 6000.00,  'delivered'),
(121, 6, '2024-06-22', 5000.00,  'delivered'),

-- Amit (7) - all cancelled ❌
(122, 7, '2024-01-10', 4000.00,  'cancelled'),
(123, 7, '2024-02-15', 3000.00,  'cancelled'),
(124, 7, '2024-03-20', 2000.00,  'cancelled'),

-- Neha (8) - only 1 delivered month ❌
(125, 8, '2024-01-05', 3000.00,  'delivered'),
(126, 8, '2024-02-10', 2000.00,  'cancelled'),
(127, 8, '2024-03-15', 1500.00,  'cancelled');


-- Question:

-- 1.Find the top 2 customers by total delivered order amount in each city. 
-- Show their name, city, total amount and rank.

-- 2.add a column showing each customer's % contribution to their city's total revenue?

WITH order_amount AS (
SELECT c.customer_id,c.name ,c.city,
SUM(o.amount) AS total_amount
FROM customers_26 c
JOIN orders_26 o
ON c.customer_id = o.customer_id
WHERE o.status = 'delivered'
GROUP BY c.customer_id,c.name ,c.city
),ranking AS (
	SELECT customer_id,
	DENSE_RANK() OVER ( PARTITION BY city ORDER BY total_amount DESC) AS rnk
	FROM order_amount
)
SELECT o.name,o.city,o.total_amount,r.rnk
FROM order_amount o 
JOIN ranking r
ON o.customer_id = r.customer_id
WHERE rnk<=2
ORDER BY rnk

-------------
