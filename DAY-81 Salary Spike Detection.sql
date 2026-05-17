-- Detect employees whose salary increased abnormally compared to their previous month.
-- | Column       | Description                              |
-- | ------------ | ---------------------------------------- |
-- | emp_id       | Employee ID                              |
-- | pay_month    | Current month                            |
-- | salary       | Current salary                           |
-- | prev_salary  | Previous month salary                    |
-- | growth_pct   | % increase from previous month           |
-- | anomaly_flag | 'Anomaly' if growth > 30%, else 'Normal' |
-- | anomaly_rank | Rank by growth_pct DESC                  |

CREATE TABLE payroll_26 (
    emp_id INT,
    pay_month DATE,
    salary INT
);
 
INSERT INTO payroll_26 (emp_id, pay_month, salary)
VALUES
-- Employee 1 (normal + spike)
(1, '2024-01-01', 30000),
(1, '2024-02-01', 31000),
(1, '2024-03-01', 45000),  -- anomaly (>30%)
(1, '2024-04-01', 46000),

-- Employee 2 (steady growth)
(2, '2024-01-01', 40000),
(2, '2024-02-01', 42000),
(2, '2024-03-01', 43000),
(2, '2024-04-01', 44000),

-- Employee 3 (drop + spike)
(3, '2024-01-01', 50000),
(3, '2024-02-01', 30000),  -- drop
(3, '2024-03-01', 42000),  -- anomaly (>30%)
(3, '2024-04-01', 41000),

-- Employee 4 (missing month)
(4, '2024-01-01', 35000),
(4, '2024-03-01', 50000),  -- jump (anomaly)
(4, '2024-04-01', 51000),

-- Employee 5 (no change)
(5, '2024-01-01', 60000),
(5, '2024-02-01', 60000),
(5, '2024-03-01', 60000); 

SELECT * FROM payroll_26;

WITH prev_month_salary AS (
	SELECT emp_id,
        pay_month,
        salary,
	    LAG(salary)OVER(PARTITION BY emp_id ORDER BY pay_month) AS prev_salary
    FROM payroll_26	
	),
	pct_diff AS (
		SELECT emp_id,
		pay_month,
		    COALESCE(ROUND((salary - prev_salary)*100/prev_salary,2),0) AS growth_pct
		FROM prev_month_salary
	)
--SELECT * FROM pct_diff	
SELECT p.emp_id,
    p.pay_month,
    p.salary,
	p.prev_salary,
	d.growth_pct,
	CASE 
	WHEN d.growth_pct > 30 THEN 'Anomaly'
	ELSE 'Normal'
	END AS anomaly_flag,
	DENSE_RANK() OVER (ORDER BY d.growth_pct DESC) AS anomaly_rank
FROM prev_month_salary p
JOIN pct_diff d
ON p.emp_id = d.emp_id
AND p.pay_month = d.pay_month
ORDER BY anomaly_rank;
	
	