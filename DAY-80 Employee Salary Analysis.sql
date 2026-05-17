-- | Column          | Description                                             |
-- | --------------- | ------------------------------------------------------- |
-- | full_name       | Employee name                                           |
-- | department      | Department                                              |
-- | salary          | Current salary                                          |
-- | dept_avg_salary | Average salary of that department                       |
-- | salary_diff     | salary - dept_avg_salary                                |
-- | dept_rank       | Rank of employee within department (highest salary = 1) |
-- | tenure_years    | Years since hire                                        |
-- | salary_category | 'High' if salary > dept avg, else 'Low'                 |


CREATE TABLE employees_24 (
    emp_id INT,
    full_name VARCHAR,
    department VARCHAR,
    salary INT,
    hire_date DATE
);

INSERT INTO employees_24 (emp_id, full_name, department, salary, hire_date)
VALUES
(1, 'Ravi Kumar', 'HR', 30000, '2022-01-15'),
(2, 'Anita Das', 'Finance', 45000, '2021-03-10'),
(3, 'Rahul Singh', 'IT', 50000, '2020-06-01'),
(4, 'Priya Sharma', 'HR', 42000, '2019-09-20'),
(5, 'Suman Patel', 'Finance', 38000, '2023-02-05'),
(6, 'Neha Reddy', 'IT', 60000, '2018-07-18'),
(7, 'Amit Verma', 'Management', 75000, '2017-12-25'),
(8, 'Kiran Nayak', 'IT', 52000, '2022-04-14'),
(9, 'Sneha Iyer', 'Finance', 47000, '2020-05-30'),
(10, 'Deepak Mishra', 'HR', 35000, '2021-08-12');

SELECT * FROM employees_24;



WITH dept_avg AS (
    SELECT department,
           ROUND(AVG(salary), 2) AS dept_avg_salary
    FROM employees_24
    GROUP BY department
),
employee_details AS (
    SELECT e.emp_id,
           e.full_name,
           e.department,
           e.salary,
           d.dept_avg_salary,
           ROUND(e.salary - d.dept_avg_salary, 2)          AS salary_diff,
           EXTRACT(YEAR FROM AGE(CURRENT_DATE, e.hire_date)) AS tenure_years,
           DENSE_RANK() OVER (
               PARTITION BY e.department
               ORDER BY e.salary DESC
           )                                                AS dept_rank,
           CASE
               WHEN e.salary > d.dept_avg_salary THEN 'High'
               ELSE 'Low'
           END                                              AS salary_category
    FROM employees_24 e
    JOIN dept_avg d ON e.department = d.department
)
SELECT emp_id,
       full_name,
       department,
       salary,
       dept_avg_salary,
       salary_diff,
       tenure_years,
       dept_rank,
       salary_category
FROM employee_details
ORDER BY department, dept_rank;