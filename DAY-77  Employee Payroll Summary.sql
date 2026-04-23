-- Part 2 — Employee Payroll Summary (2024)
-- For each employee write a query returning:
-- Column                          Description
--full_name                        Employee name
--dept_name                        Department
--total_basic                      Sum of basic_pay for 2024
--total_bonus                      Sum of bonus for 2024
--total_deductions                 Sum of deductions for 2024
--net_pay                          total_basic + total_bonus - total_deductions
--avg_monthly_net                  Average monthly net pay
--highest_pay_month                Month where net pay was highest
--dept_rank                        Rank by net_pay within department
--net_vs_dept_avg                  Their net_pay minus dept average net_pay

SELECT * FROM departments_20;
SELECT * FROM employees_20 ;
SELECT * FROM payroll_20;
SELECT * FROM performance_20;


WITH employee_details AS (
    SELECT 
        e.emp_id,
        e.full_name,
        d.dept_name,
        SUM(p.basic_pay) AS total_basic,
        SUM(p.bonus) AS total_bonus,
        SUM(p.deductions) AS total_deductions,
        SUM(p.basic_pay + p.bonus - p.deductions) AS net_pay
    FROM employees_20 e
    JOIN payroll_20 p ON e.emp_id = p.emp_id
    JOIN departments_20 d ON e.dept_id = d.dept_id
    WHERE EXTRACT(YEAR FROM p.pay_month) = 2024
    GROUP BY e.emp_id, e.full_name, d.dept_name
),

monthly_pay AS (
    SELECT 
        emp_id,
        ROUND(AVG(basic_pay + bonus - deductions), 2) AS avg_monthly_net
    FROM payroll_20
    WHERE EXTRACT(YEAR FROM pay_month) = 2024
    GROUP BY emp_id
),

highest_paymonth AS (
    SELECT emp_id, mnth
    FROM (
        SELECT 
            p.emp_id,
            EXTRACT(MONTH FROM p.pay_month) AS mnth,
            (p.basic_pay + p.bonus - p.deductions) AS net_pay,
            ROW_NUMBER() OVER (
                PARTITION BY p.emp_id 
                ORDER BY (p.basic_pay + p.bonus - p.deductions) DESC
            ) AS rnk
        FROM payroll_20 p
        WHERE EXTRACT(YEAR FROM p.pay_month) = 2024
    ) t
    WHERE rnk = 1
)

SELECT 
    e.emp_id,
    e.full_name,
    e.dept_name,
    e.total_basic,
    e.total_bonus,
    e.total_deductions,
    e.net_pay,
    m.avg_monthly_net,
    h.mnth AS highest_pay_month,
    DENSE_RANK() OVER (PARTITION BY e.dept_name ORDER BY e.net_pay DESC) AS dept_rank,
    ROUND(
        e.net_pay - AVG(e.net_pay) OVER (PARTITION BY e.dept_name), 
        2
    ) AS net_vs_dept_avg
FROM employee_details e
JOIN monthly_pay m ON e.emp_id = m.emp_id
JOIN highest_paymonth h ON e.emp_id = h.emp_id
ORDER BY e.emp_id, dept_rank;	 
		