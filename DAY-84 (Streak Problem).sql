
-- Consecutive Successful Orders (Streak Problem)
-- 👉 Find users who have at least 3 consecutive successful orders

-- 👉 Output:

-- user_id
-- length of longest success streak

CREATE TABLE orders_08_05 (
    order_id INT,
    user_id INT,
    order_date DATE,
    status VARCHAR(20)
);

INSERT INTO orders_08_05 VALUES
(1, 101, '2024-01-01', 'success'),
(2, 101, '2024-01-02', 'success'),
(3, 101, '2024-01-03', 'failed'),
(4, 101, '2024-01-04', 'success'),
(5, 101, '2024-01-05', 'success'),
(6, 101, '2024-01-06', 'success'),
(7, 102, '2024-01-01', 'failed'),
(8, 102, '2024-01-02', 'success');


WITH success_orders AS (
	SELECT *,
	    ROW_NUMBER() OVER (PARTITION BY user_id
					       ORDER BY order_date) AS rn1,
	    ROW_NUMBER() OVER (PARTITION BY user_id,status
					       ORDER BY order_date) AS rn2
	FROM orders_08_05
)
,grouped_success AS (
	SELECT *,
	rn1-rn2 AS grp
	FROM success_orders
	WHERE status = 'success'
)
--SELECT * FROM grouped_success;
,streak AS (
	SELECT user_id,
	    grp,
	    COUNT(*) AS streak_length
	FROM grouped_success
	GROUP BY user_id,grp
)
--SELECT * FROM streak;
SELECT user_id,
MAX(streak_length) AS longest_success_streak
FROM streak
WHERE streak_length >= 3
GROUP BY user_id