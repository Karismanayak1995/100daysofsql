CREATE TABLE departments_20 (
    dept_id      INT PRIMARY KEY,
    dept_name    VARCHAR(50),
    location     VARCHAR(30),
    budget       DECIMAL(15,2)
);

CREATE TABLE employees_20 (
    emp_id       INT PRIMARY KEY,
    full_name    VARCHAR(50),
    dept_id      INT,
    manager_id   INT,          -- self reference
    hire_date    DATE,
    salary       DECIMAL(10,2),
    job_level    VARCHAR(20)   -- 'Junior', 'Mid', 'Senior', 'Lead', 'Manager'
);

CREATE TABLE payroll_20 (
    payroll_id   INT PRIMARY KEY,
    emp_id       INT,
    pay_month    DATE,          -- first day of month e.g. '2024-01-01'
    basic_pay    DECIMAL(10,2),
    bonus        DECIMAL(10,2),
    deductions   DECIMAL(10,2)
);

CREATE TABLE performance_20 (
    perf_id      INT PRIMARY KEY,
    emp_id       INT,
    review_year  INT,
    rating       INT,           -- 1 to 5
    promoted     BOOLEAN
);

-- Departments
INSERT INTO departments_20 VALUES
(1, 'Engineering',  'Hyderabad', 5000000.00),
(2, 'Sales',        'Mumbai',    3000000.00),
(3, 'HR',           'Bangalore', 1500000.00),
(4, 'Finance',      'Delhi',     2000000.00),
(5, 'Marketing',    'Hyderabad', 1800000.00);

-- Employees
INSERT INTO employees_20 VALUES
(1,  'Arjun Sharma',   1, NULL, '2018-03-15', 120000.00, 'Manager'),
(2,  'Priya Reddy',    1, 1,    '2019-07-22', 85000.00,  'Senior'),
(3,  'Kiran Mehta',    1, 1,    '2020-01-10', 75000.00,  'Senior'),
(4,  'Sneha Iyer',     1, 2,    '2021-03-25', 60000.00,  'Mid'),
(5,  'Ravi Kumar',     2, NULL, '2017-11-05', 110000.00, 'Manager'),
(6,  'Divya Nair',     2, 5,    '2019-09-30', 80000.00,  'Senior'),
(7,  'Amit Joshi',     2, 5,    '2020-02-14', 65000.00,  'Mid'),
(8,  'Neha Gupta',     2, 6,    '2022-06-25', 45000.00,  'Junior'),
(9,  'Suresh Babu',    3, NULL, '2016-08-11', 95000.00,  'Manager'),
(10, 'Kavya Menon',    3, 9,    '2020-04-05', 55000.00,  'Mid'),
(11, 'Rohit Verma',    4, NULL, '2018-12-01', 105000.00, 'Manager'),
(12, 'Lakshmi Rao',    4, 11,   '2019-03-18', 78000.00,  'Senior'),
(13, 'Vikram Singh',   4, 11,   '2021-07-10', 58000.00,  'Mid'),
(14, 'Anita Desai',    5, NULL, '2019-05-20', 98000.00,  'Manager'),
(15, 'Raj Patel',      5, 14,   '2020-11-15', 70000.00,  'Senior');

-- Payroll (Jan - Jun 2024)
INSERT INTO payroll_20 VALUES
-- Arjun (1)
(1001, 1,  '2024-01-01', 120000, 20000, 15000),
(1002, 1,  '2024-02-01', 120000, 15000, 15000),
(1003, 1,  '2024-03-01', 120000, 80000, 15000),  -- anomaly: bonus > 50%
(1004, 1,  '2024-04-01', 120000, 18000, 15000),
(1005, 1,  '2024-05-01', 120000, 22000, 15000),
(1006, 1,  '2024-06-01', 120000, 19000, 15000),

-- Priya (2)
(1007, 2,  '2024-01-01', 85000,  10000, 10000),
(1008, 2,  '2024-02-01', 85000,  12000, 10000),
(1009, 2,  '2024-03-01', 85000,  50000, 10000),  -- anomaly: bonus > 50%
(1010, 2,  '2024-04-01', 85000,  11000, 10000),
(1011, 2,  '2024-05-01', 85000,  13000, 10000),
(1012, 2,  '2024-06-01', 85000,  10000, 10000),

-- Kiran (3)
(1013, 3,  '2024-01-01', 75000,  8000,  9000),
(1014, 3,  '2024-02-01', 75000,  9000,  9000),
(1015, 3,  '2024-03-01', 75000,  7000,  9000),
(1016, 3,  '2024-04-01', 75000,  8500,  9000),
(1017, 3,  '2024-05-01', 75000,  9500,  9000),
(1018, 3,  '2024-06-01', 75000,  8000,  9000),

-- Sneha (4)
(1019, 4,  '2024-01-01', 60000,  5000,  7000),
(1020, 4,  '2024-02-01', 60000,  6000,  7000),
(1021, 4,  '2024-03-01', 60000,  35000, 7000),  -- anomaly: bonus > 50%
(1022, 4,  '2024-04-01', 60000,  5500,  7000),
(1023, 4,  '2024-05-01', 60000,  6500,  7000),
(1024, 4,  '2024-06-01', 60000,  5000,  7000),

-- Ravi (5)
(1025, 5,  '2024-01-01', 110000, 18000, 13000),
(1026, 5,  '2024-02-01', 110000, 16000, 13000),
(1027, 5,  '2024-03-01', 110000, 17000, 13000),
(1028, 5,  '2024-04-01', 110000, 70000, 13000),  -- anomaly: bonus > 50%
(1029, 5,  '2024-05-01', 110000, 19000, 13000),
(1030, 5,  '2024-06-01', 110000, 20000, 13000),

-- Divya (6)
(1031, 6,  '2024-01-01', 80000,  9000,  9500),
(1032, 6,  '2024-02-01', 80000,  10000, 9500),
(1033, 6,  '2024-03-01', 80000,  8500,  9500),
(1034, 6,  '2024-04-01', 80000,  11000, 9500),
(1035, 6,  '2024-05-01', 80000,  9500,  9500),
(1036, 6,  '2024-06-01', 80000,  10000, 9500),

-- Amit (7)
(1037, 7,  '2024-01-01', 65000,  6000,  8000),
(1038, 7,  '2024-02-01', 65000,  7000,  8000),
(1039, 7,  '2024-03-01', 65000,  6500,  8000),
(1040, 7,  '2024-04-01', 65000,  7500,  8000),
(1041, 7,  '2024-05-01', 65000,  6000,  8000),
(1042, 7,  '2024-06-01', 65000,  6500,  8000),

-- Neha (8)
(1043, 8,  '2024-01-01', 45000,  3000,  5500),
(1044, 8,  '2024-02-01', 45000,  3500,  5500),
(1045, 8,  '2024-03-01', 45000,  4000,  5500),
(1046, 8,  '2024-04-01', 45000,  3000,  5500),
(1047, 8,  '2024-05-01', 45000,  3500,  5500),
(1048, 8,  '2024-06-01', 45000,  3000,  5500),

-- Suresh (9)
(1049, 9,  '2024-01-01', 95000,  12000, 11000),
(1050, 9,  '2024-02-01', 95000,  13000, 11000),
(1051, 9,  '2024-03-01', 95000,  11000, 11000),
(1052, 9,  '2024-04-01', 95000,  14000, 11000),
(1053, 9,  '2024-05-01', 95000,  12500, 11000),
(1054, 9,  '2024-06-01', 95000,  13500, 11000),

-- Kavya (10)
(1055, 10, '2024-01-01', 55000,  5000,  6500),
(1056, 10, '2024-02-01', 55000,  5500,  6500),
(1057, 10, '2024-03-01', 55000,  6000,  6500),
(1058, 10, '2024-04-01', 55000,  5000,  6500),
(1059, 10, '2024-05-01', 55000,  5500,  6500),
(1060, 10, '2024-06-01', 55000,  6000,  6500),

-- Rohit (11)
(1061, 11, '2024-01-01', 105000, 15000, 12000),
(1062, 11, '2024-02-01', 105000, 16000, 12000),
(1063, 11, '2024-03-01', 105000, 14000, 12000),
(1064, 11, '2024-04-01', 105000, 60000, 12000),  -- anomaly: bonus > 50%
(1065, 11, '2024-05-01', 105000, 17000, 12000),
(1066, 11, '2024-06-01', 105000, 16000, 12000),

-- Lakshmi (12)
(1067, 12, '2024-01-01', 78000,  8000,  9200),
(1068, 12, '2024-02-01', 78000,  9000,  9200),
(1069, 12, '2024-03-01', 78000,  8500,  9200),
(1070, 12, '2024-04-01', 78000,  9500,  9200),
(1071, 12, '2024-05-01', 78000,  8000,  9200),
(1072, 12, '2024-06-01', 78000,  9000,  9200),

-- Vikram (13)
(1073, 13, '2024-01-01', 58000,  5500,  7000),
(1074, 13, '2024-02-01', 58000,  6000,  7000),
(1075, 13, '2024-03-01', 58000,  5000,  7000),
(1076, 13, '2024-04-01', 58000,  6500,  7000),
(1077, 13, '2024-05-01', 58000,  5500,  7000),
(1078, 13, '2024-06-01', 58000,  6000,  7000),

-- Anita (14)
(1079, 14, '2024-01-01', 98000,  13000, 11500),
(1080, 14, '2024-02-01', 98000,  14000, 11500),
(1081, 14, '2024-03-01', 98000,  12000, 11500),
(1082, 14, '2024-04-01', 98000,  15000, 11500),
(1083, 14, '2024-05-01', 98000,  13500, 11500),
(1084, 14, '2024-06-01', 98000,  14000, 11500),

-- Raj (15)
(1085, 15, '2024-01-01', 70000,  7000,  8500),
(1086, 15, '2024-02-01', 70000,  7500,  8500),
(1087, 15, '2024-03-01', 70000,  6500,  8500),
(1088, 15, '2024-04-01', 70000,  8000,  8500),
(1089, 15, '2024-05-01', 70000,  7000,  8500),
(1090, 15, '2024-06-01', 70000,  7500,  8500);

-- Performance
INSERT INTO performance_20 VALUES
(1,  1,  2022, 5, true),
(2,  1,  2023, 4, false),
(3,  2,  2022, 4, true),
(4,  2,  2023, 5, true),
(5,  3,  2022, 3, false),
(6,  3,  2023, 4, true),
(7,  4,  2022, 4, false),
(8,  4,  2023, 4, true),
(9,  5,  2022, 5, true),
(10, 5,  2023, 5, false),
(11, 6,  2022, 3, false),
(12, 6,  2023, 4, true),
(13, 7,  2022, 3, false),
(14, 7,  2023, 3, false),
(15, 8,  2022, 2, false),
(16, 8,  2023, 3, false),
(17, 9,  2022, 5, true),
(18, 9,  2023, 4, true),
(19, 10, 2022, 3, false),
(20, 10, 2023, 4, true),
(21, 11, 2022, 4, true),
(22, 11, 2023, 5, true),
(23, 12, 2022, 4, false),
(24, 12, 2023, 4, true),
(25, 13, 2022, 3, false),
(26, 13, 2023, 3, false),
(27, 14, 2022, 5, true),
(28, 14, 2023, 4, true),
(29, 15, 2022, 3, false),
(30, 15, 2023, 4, true);

-- Part 1 — Department Budget Utilisation

-- For each department write a query returning:
-- Column                       Description
--dept_name                     Department name
--location                      Location
--budget                        Total budget
--total_salary_cost             Sum of all employee salaries
--budget_utilisation_pct        total_salary_cost / budget * 100
--headcount                     Number of employees
--avg_salary                    Average salary in dept
--budget_status                 'Over Budget' if >100%, 'Critical' if >80%, 'Healthy' if <=80%
--salary_rank                   Rank dept by total_salary_cost across all depts


SELECT * FROM departments_20;
SELECT * FROM employees_20 ;
SELECT * FROM payroll_20;
SELECT * FROM performance_20;

WITH salary_details AS (
		SELECT dept_id,
		COUNT(*) AS headcount,
		SUM(salary) AS total_salary_cost,
		ROUND(AVG(salary),2) AS avg_salary
		FROM employees_20
		GROUP BY dept_id
	),dept_details AS (
	SELECT d.dept_id,
	d.dept_name,
	d.location,
    d.budget,
	s.headcount,
	s.total_salary_cost,
    s.avg_salary,
	ROUND(s.total_salary_cost/d.budget*100,2) AS budget_utilisation_pct	
    FROM departments_20 d
    JOIN salary_details s
    ON d.dept_id = s.dept_id
	)
--SELECT * FROM dept_details;
SELECT 
    dept_name,
	location,
    budget,
	headcount,
	budget_utilisation_pct,
	total_salary_cost,
	avg_salary,
	CASE 
	WHEN budget_utilisation_pct > 100 THEN 'Over Budget'
	WHEN budget_utilisation_pct > 80 THEN 'Critical'
	ELSE 'Healthy' 
	END AS budget_status ,
	DENSE_RANK()OVER (ORDER BY total_salary_cost ) AS salary_rank
	FROM dept_details