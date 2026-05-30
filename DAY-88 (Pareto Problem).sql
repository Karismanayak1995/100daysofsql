5. Top 20% Revenue Customers (Pareto Problem)

CREATE TABLE orders_18_05 (
    order_id INT,
    customer_id INT,
    amount INT
);

INSERT INTO orders_18_05 VALUES
(1, 1, 100),
(2, 1, 200),
(3, 2, 500),
(4, 3, 300),
(5, 4, 50),
(6, 5, 400);

👉 Find customers who contribute to top 80% of total revenue

👉 Output:

customer_id
cumulative revenue %


SELECT * FROM orders_18_05;

WITH customer_revenue AS (
	SELECT customer_id,
	   SUM(amount) AS revenue
    FROM orders_18_05
    GROUP BY customer_id
),revenue_calc AS (
	SELECT customer_id,
	   revenue,
	   SUM(revenue)OVER(ORDER BY revenue DESC) AS cumulative_revenue,
	   SUM(revenue)OVER() AS total_revenue
	FROM customer_revenue
)
SELECT  customer_id,
	   revenue,
	   ROUND(
		   cumulative_revenue*100.0/total_revenue,2
	   ) AS cumulative_pct
FROM revenue_calc
WHERE cumulative_revenue*100.0/total_revenue <= 80
ORDER BY revenue DESC