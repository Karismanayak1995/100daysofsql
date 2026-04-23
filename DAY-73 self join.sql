CREATE TABLE employees_08 (
    emp_id      INT PRIMARY KEY,
    name        VARCHAR(50),
    manager_id  INT,          -- references emp_id (NULL for top-level)
    department  VARCHAR(30),
    salary      DECIMAL(10,2),
    hire_date   DATE
);

INSERT INTO employees_08 VALUES
(1, 'Arjun Sharma',  NULL, 'Sales',   85000.00, '2018-03-15'),  -- Top level, no manager
(2, 'Priya Reddy',   1,    'Sales',   55000.00, '2018-05-20'),  -- Manager: Arjun
(3, 'Kiran Mehta',   1,    'Sales',   60000.00, '2019-01-10'),  -- Manager: Arjun
(4, 'Sneha Iyer',    2,    'Sales',   95000.00, '2019-03-25'),  -- Manager: Priya (earns more!)
(5, 'Ravi Kumar',    NULL, 'Tech',    90000.00, '2017-11-05'),  -- Top level, no manager
(6, 'Divya Nair',    5,    'Tech',    70000.00, '2018-01-18'),  -- Manager: Ravi
(7, 'Amit Joshi',    5,    'Tech',    95000.00, '2018-03-30'),  -- Manager: Ravi (earns more!)
(8, 'Neha Gupta',    6,    'Tech',    65000.00, '2019-04-12'),  -- Manager: Divya
(9, 'Suresh Babu',   NULL, 'HR',      75000.00, '2019-06-01'),  -- Top level, no manager
(10,'Kavya Menon',   9,    'HR',      50000.00, '2019-08-15'),  -- Manager: Suresh
(11,'Rohit Verma',   9,    'HR',      55000.00, '2019-10-20'),  -- Manager: Suresh
(12,'Lakshmi Rao',   9,    'HR',      80000.00, '2020-01-05');  -- Manager: Suresh (earns more!)

-- Part 1 — Employee & their Manager
-- Write a query showing each employee with their manager's name:
-- emp_name     department     salary   manager_name
-- Priya        Sales          55000    Arjun
-- Kiran        Tech           70000    Ravi
-- Employees with no manager should show 'No Manager'.

-- Part 2 — Employees earning more than their Manager
-- Find all employees whose salary is higher than their manager's salary:
-- emp_name   emp_salary    manager_name    manager_salary
-- Sneh       95000         Priya           55000

-- Part 3 — Colleagues in same department
-- For each employee, list all colleagues (same department, different person):
-- emp_name    colleague_name     department
-- Arjun       Priya               Sales
-- Priya       Arjun               Sales

-- Part 4 — Employees hired within 90 days of each other
-- Find pairs of employees in the same department hired within 90 days of each other (show each pair once, not twice):
-- emp1_name     emp2_name     department  days_apart
-- Arjun         Priya         Sales        45


SELECT * FROM employees_08 ;
--part--1
SELECT e.name AS emp_name,
e.department,
e.salary,
coalesce(m.name,'No Manager') AS manager_name
FROM employees_08 e 
LEFT JOIN employees_08 m ON e.manager_id = m.emp_id
	   
--part--2
SELECT e.name AS emp_name,
e.salary AS emp_salary,
m.name AS manager_name,
m.salary AS manager_salary
FROM employees_08 e 
JOIN employees_08 m ON e.manager_id = m.emp_id
WHERE e.salary > m.salary

--part--3
SELECT e1.name AS emp_name,
e2.name AS colleague_name,
e1.department 
FROM employees_08 e1 
JOIN employees_08 e2 ON e1.department = e2.department
AND e1.emp_id <> e2.emp_id
ORDER BY e1.name

--part--4
SELECT e1.name AS emp1_name,
e2.name AS emp2_name,
e1.department,
ABS(e1.hire_date - e2.hire_date) AS days_apart
FROM employees_08 e1 
JOIN employees_08 e2 ON e1.department = e2.department
AND e1.emp_id < e2.emp_id
WHERE ABS(e1.hire_date- e2.hire_date) <= 90

