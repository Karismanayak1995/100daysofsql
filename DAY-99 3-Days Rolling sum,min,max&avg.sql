Problem

👉 Calculate 3-days rolling sum,max ,min and avg.

CREATE TABLE sales_05_06 (
    sales_date DATE,
    sales INT
);

INSERT INTO sales_05_06 VALUES
('2024-01-01',100),
('2024-01-02',200),
('2024-01-03',300),
('2024-01-04',150),
('2024-01-05',400);

SELECT
    sales_date,
    sales,

    ROUND(AVG(sales) OVER (
        ORDER BY sales_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
		),2
    ) AS rolling_avg,

    SUM(sales) OVER (
        ORDER BY sales_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS rolling_sum,

    MAX(sales) OVER (
        ORDER BY sales_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS rolling_max,

    MIN(sales) OVER (
        ORDER BY sales_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS rolling_min

FROM sales_05_06;