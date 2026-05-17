4. Orders Without Payment BUT Later Paid (Retry Logic)

CREATE TABLE payments_17_05 (
    payment_id INT,
    order_id INT,
    status VARCHAR(20),
    payment_time TIMESTAMP
);

INSERT INTO payments_17_05 VALUES
(1, 101, 'failed', '2024-01-01 10:00:00'),
(2, 101, 'success', '2024-01-01 10:05:00'),
(3, 102, 'failed', '2024-01-02 11:00:00'),
(4, 103, 'success', '2024-01-03 12:00:00');

👉 Find orders where:

first payment = failed
later payment = success

👉 Output:

order_id 
first_attempt_time
success_time

WITH first_order AS (
	SELECT 
	order_id ,
    status ,
	payment_time,
	ROW_NUMBER()OVER(PARTITION BY order_id ORDER BY payment_time ) AS rnk
    FROM payments_17_05	
	)
	,first_failed AS (
		SELECT order_id ,
		payment_time AS first_attempt_time
		FROM first_order
		WHERE status = 'failed' AND rnk = 1
	)
--SELECT * FROM 	first_failed 
	, success_ranked AS (
		SELECT order_id,
			   payment_time,
			   ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY payment_time) AS s_rnk
		FROM   payments_17_05
		WHERE  status = 'success'
	)
	SELECT f.order_id,
		   f.first_attempt_time,
		   s.payment_time AS success_time
	FROM   first_failed f
	JOIN   success_ranked s ON f.order_id = s.order_id AND s.s_rnk = 1