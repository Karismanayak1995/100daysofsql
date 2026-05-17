--2. First vs Last Purchase Behavior

-- 👉 Find users whose last order value > first order value

-- 👉 Output:

-- user_id
-- first_amount
-- last_amount

CREATE TABLE purchases_12_05 (
    user_id INT,
    order_id INT,
    order_date DATE,
    amount INT
);

INSERT INTO purchases_12_05 VALUES
(1, 101, '2024-01-01', 100),
(1, 102, '2024-01-10', 500),
(2, 103, '2024-01-02', 300),
(2, 104, '2024-01-05', 200),
(3, 105, '2024-01-03', 400);

SELECT * FROM purchases_12_05;

--USING FIRST_VALUE() & LAST_VALUE()

WITH windowed AS (
	SELECT 
    DISTINCT user_id,
	FIRST_VALUE(amount) OVER (
		PARTITION BY user_id 
		ORDER BY order_date 
		ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
	) AS first_amount,
	LAST_VALUE(amount) OVER (
		PARTITION BY user_id 
		ORDER BY order_date  
		ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
	) AS last_amount
	FROM purchases_12_05
	)
SELECT user_id,
  first_amount,
  last_amount
FROM windowed  
WHERE last_amount > first_amount 


--USING ROW_NUMBER()

WITH ranked AS (
	SELECT user_id,amount,
	ROW_NUMBER()OVER(
		PARTITION BY user_id 
		ORDER BY order_date DESC
	)AS rn_desc,
	ROW_NUMBER()OVER(
		PARTITION BY user_id 
		ORDER BY order_date ASC
	)AS rn_asc
	FROM purchases_12_05
	)
SELECT f.user_id,
f.amount AS first_amount,
l.amount AS last_amount
FROM ranked f 
JOIN ranked l
ON f.user_id = l.user_id
AND l.rn_desc = 1
AND f.rn_asc = 1
AND l.amount > f.amount
ORDER BY f.user_id

-- Subquery approach using MIN/MAX date per user

WITH bounds AS (
  SELECT
    user_id,
    MIN(order_date) AS first_date,
    MAX(order_date) AS last_date
  FROM  purchases_12_05
  GROUP BY user_id
)
SELECT
  b.user_id,
  f.amount AS first_amount,
  l.amount AS last_amount
FROM  bounds b
JOIN  purchases_12_05 f ON f.user_id = b.user_id AND f.order_date = b.first_date
JOIN  purchases_12_05 l ON l.user_id = b.user_id AND l.order_date = b.last_date
WHERE l.amount > f.amount
ORDER BY b.user_id;
