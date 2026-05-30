🔥 7. Employees Earning More Than Their Manager

Table

CREATE TABLE employees_mgr_29_05 (
    emp_id INT,
    emp_name VARCHAR(50),
    manager_id INT,
    salary INT
);

INSERT INTO employees_mgr_29_05 VALUES
(1, 'Alice', NULL, 100000),
(2, 'Bob', 1, 90000),
(3, 'Charlie', 1, 120000),
(4, 'David', 2, 80000);

👉 Find employees earning more than their managers.


SELECT * FROM employees_mgr_29_05;


SELECT e.emp_name,
e.salary,
m.emp_name AS manager_name ,
m.salary AS mgr_salary
FROM employees_mgr_29_05 e
JOIN employees_mgr_29_05 m
ON e.manager_id = m.emp_id
WHERE e.salary > m.salary

