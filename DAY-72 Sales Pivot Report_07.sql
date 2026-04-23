CREATE TABLE sales_07 (
    sale_id     INT PRIMARY KEY,
    emp_id      INT,
    region      VARCHAR(20),  -- 'North', 'South', 'East', 'West'
    category    VARCHAR(20),  -- 'Electronics', 'Clothing', 'Food', 'Sports'
    sale_date   DATE,
    amount      DECIMAL(10,2)
);

CREATE TABLE employees_07 (
    emp_id      INT PRIMARY KEY,
    name        VARCHAR(50),
    department  VARCHAR(30)
);

-- Employees
INSERT INTO employees_07 VALUES
(1, 'Arjun Sharma',  'Sales'),
(2, 'Priya Reddy',   'Sales'),
(3, 'Kiran Mehta',   'Marketing'),
(4, 'Sneha Iyer',    'Sales'),
(5, 'Ravi Kumar',    'Marketing'),
(6, 'Divya Nair',    'Sales');

-- Sales
INSERT INTO sales_07 VALUES
-- Arjun (1) - should be Elite (>50000)
(101, 1, 'North', 'Electronics', '2024-01-15', 18000.00),
(102, 1, 'North', 'Clothing',    '2024-02-20', 12000.00),
(103, 1, 'South', 'Electronics', '2024-04-10', 15000.00),
(104, 1, 'East',  'Food',        '2024-07-05', 8000.00),
(105, 1, 'North', 'Sports',      '2024-09-18', 10000.00),
(106, 1, 'West',  'Electronics', '2024-11-25', 9000.00),

-- Priya (2) - should be Good (>30000)
(107, 2, 'South', 'Clothing',    '2024-01-08', 14000.00),
(108, 2, 'East',  'Sports',      '2024-03-22', 9000.00),
(109, 2, 'North', 'Clothing',    '2024-06-14', 11000.00),
(110, 2, 'West',  'Food',        '2024-09-30', 6000.00),

-- Kiran (3) - should be Good (>30000)
(111, 3, 'East',  'Electronics', '2024-01-20', 12000.00),
(112, 3, 'North', 'Food',        '2024-04-15', 8000.00),
(113, 3, 'South', 'Sports',      '2024-07-28', 11000.00),
(114, 3, 'West',  'Clothing',    '2024-10-12', 7000.00),

-- Sneha (4) - should be Average (>15000)
(115, 4, 'West',  'Food',        '2024-02-05', 7000.00),
(116, 4, 'North', 'Sports',      '2024-05-19', 6000.00),
(117, 4, 'East',  'Clothing',    '2024-08-25', 5000.00),

-- Ravi (5) - should be Elite (>50000)
(118, 5, 'South', 'Electronics', '2024-01-12', 22000.00),
(119, 5, 'West',  'Electronics', '2024-03-08', 18000.00),
(120, 5, 'North', 'Sports',      '2024-05-25', 8000.00),
(121, 5, 'East',  'Food',        '2024-08-14', 6000.00),
(122, 5, 'South', 'Clothing',    '2024-10-30', 9000.00),
(123, 5, 'West',  'Electronics', '2024-12-05', 11000.00),

-- Divya (6) - should be Low (<15000)
(124, 6, 'East',  'Clothing',    '2024-02-18', 5000.00),
(125, 6, 'South', 'Food',        '2024-06-22', 4000.00),
(126, 6, 'West',  'Sports',      '2024-10-08', 3500.00);

--Part 1 — Basic CASE WHEN
--Write a query that classifies each sale into a performance bucket and returns:
--Column           Description
--emp_name         Employee name
--total_sales      Sum of all their sales
--performance      'Elite' if > 50000, 'Good' if > 30000, 'Average' if > 15000, else 'Low'
--sales_grade      'A' if > 50000, 'B' if > 30000, 'C' if > 15000, else 'D'

--Part 2 — Pivot using CASE WHEN
--Write a query that pivots sales by category, showing one column per category:
--emp_name    Electronics  Clothing  Food   Sports  
--Alice       25000        18000     5000   12000
--Bob         18000        22000     8000   9000

--Part 3 — Pivot by Quarter
--Write a query that shows sales broken down by quarter:
--emp_name  Q1      Q2       Q3      Q4
--Alice     15000   18000    22000   20000
------------------------------
SELECT * FROM employees_07;
SELECT * FROM sales_07;

--Part--1

WITH total_amount AS(
	SELECT e.emp_id,
    e.name AS emp_name,
    SUM(s.amount) AS total_sales
    FROM employees_07 e
    JOIN sales_07 s ON e.emp_id = s.emp_id
    GROUP BY e.emp_id,e.name
	),performance AS (
		SELECT emp_id,
		CASE WHEN total_sales > 50000 THEN 'Elite'
		     WHEN total_sales > 30000 THEN 'Good'
		     WHEN total_sales > 15000 THEN 'Average'
		ELSE 'Low'
		END AS performance,
		CASE WHEN total_sales > 50000 THEN 'A'
		     WHEN total_sales > 30000 THEN 'B'
		     WHEN total_sales > 15000 THEN 'C'
		ELSE 'D'
		END AS sales_grade
		FROM total_amount 
	)
SELECT t.emp_name,
t.total_sales,
p.performance,
p.sales_grade
FROM total_amount t
JOIN performance P ON t.emp_id = p.emp_id


---Part--2--

SELECT 
    e.name AS emp_name,
	SUM(CASE WHEN s.category = 'Electronics' THEN s.amount ELSE 0 END) AS Electronics ,
	SUM(CASE WHEN s.category = 'Clothing'   THEN s.amount ELSE 0 END) AS Clothing ,
	SUM(CASE WHEN s.category = 'Food'       THEN s.amount ELSE 0 END) AS Food,
	SUM(CASE WHEN s.category = 'Sports'      THEN s.amount ELSE 0 END) AS Sports
		 
FROM employees_07 e
JOIN sales_07 s ON e.emp_id = s.emp_id	
GROUP BY e.emp_id,e.name
ORDER BY e.name;

--Part--3--

SELECT 
    e.name AS emp_name,
	SUM(CASE WHEN EXTRACT(MONTH FROM s.sale_date) BETWEEN 1  AND 3   THEN s.amount ELSE 0 END) AS Q1,
    SUM(CASE WHEN EXTRACT(MONTH FROM s.sale_date) BETWEEN 4  AND 6   THEN s.amount ELSE 0 END) AS Q2,
    SUM(CASE WHEN EXTRACT(MONTH FROM s.sale_date) BETWEEN 7  AND 9   THEN s.amount ELSE 0 END) AS Q3,
	SUM(CASE WHEN EXTRACT(MONTH FROM s.sale_date) BETWEEN 10 AND 12  THEN s.amount ELSE 0 END) AS Q4
FROM employees_07 e
JOIN sales_07 s ON e.emp_id = s.emp_id	
GROUP BY e.emp_id,e.name	
ORDER BY e.name;
