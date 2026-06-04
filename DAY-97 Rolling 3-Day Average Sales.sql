-- 🔥 9. Rolling 3-Day Average Sales

-- Table

CREATE TABLE sales_03_06 (
    sale_date DATE,
    revenue INT
);

INSERT INTO sales_03_06 VALUES
('2024-01-01', 100),
('2024-01-02', 200),
('2024-01-03', 300),
('2024-01-04', 400),
('2024-01-05', 500);


-- Problem

-- 👉 Calculate rolling 3-day average revenue.

SELECT * FROM sales_03_06;

SELECT sale_date,revenue,
ROUND(AVG(revenue) OVER (
	ORDER BY sale_date 
	ROWS BETWEEN 2 PRECEDING AND CURRENT ROW 
)
	  ,2) AS rolling_3days_avg
FROM sales_03_06

----IN PANDAS-------

-- import pandas as pd

-- df = pd.DataFrame({
--     'date': pd.to_datetime([
--         '2024-01-01',
--         '2024-01-02',
--         '2024-01-03',
--         '2024-01-04',
--         '2024-01-05'
--     ]),
--     'sales': [100, 200, 300, 400, 500]
-- })

-- print(df)

-- df['rolling_avg'] = df['sales'].rolling(window=3).mean()
-- df
