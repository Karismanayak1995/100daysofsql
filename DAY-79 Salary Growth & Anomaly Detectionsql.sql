-- Part 4 — Salary Growth & Anomaly Detection
-- Using payroll data, find employees whose bonus in any single month exceeds 50% of their basic pay that month. Return:
-- Column                     Description
--full_name                   Employee name
--dept_name                   Department
--pay_month                   The month it happened
--basic_pay                   Basic pay that month
--bonus                       Bonus that month
--bonus_pct                   bonus / basic_pay * 100
--anomaly_rank                Rank by bonus_pct DESC across all anomalies

SELECT * FROM departments_20;
SELECT * FROM employees_20 ;
SELECT * FROM payroll_20;
SELECT * FROM performance_20;

WITH employee_bonus AS (
	SELECT e.emp_id,
    e.full_name,
    d.dept_name,
    p.pay_month,
    p.basic_pay,
    p.bonus,
    ROUND(
		(p.bonus * 100.0) / NULLIF(p.basic_pay, 0) 
		,2
	) AS bonus_pct
    FROM employees_20 e
	JOIN departments_20 d ON  e.dept_id = d.dept_id
    JOIN payroll_20 p ON e.emp_id = p.emp_id
    WHERE p.bonus > (p.basic_pay * .5) 
	)
SELECT 	
     full_name,
	 dept_name,
	 pay_month,
	 basic_pay,
     bonus,
	 bonus_pct,
	 DENSE_RANK ( ) OVER (ORDER BY bonus_pct DESC ) AS anomaly_rank
FROM employee_bonus
ORDER BY anomaly_rank;
	 




