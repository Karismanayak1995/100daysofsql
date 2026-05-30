🔥 3. Highest Salary Per Department

CREATE TABLE departments_20_05 (
    dept_id INT,
    dept_name VARCHAR(50)
);

CREATE TABLE employees_20_05 (
    emp_id INT,
    emp_name VARCHAR(50),
    dept_id INT,
    salary INT
);

INSERT INTO departments_20_05 VALUES
(1, 'Engineering'),
(2, 'HR'),
(3, 'Finance');

INSERT INTO employees_20_05 VALUES
(101, 'Asha', 1, 90000),
(102, 'Ravi', 1, 95000),
(103, 'John', 1, 95000),
(104, 'Priya', 2, 70000),
(105, 'Kiran', 3, 80000); 

Problem

👉 Find highest paid employee in each department.

⚠️ Handle ties.

WITH ranking AS (
	SELECT d.dept_name,
    e.emp_name,
	e.salary,
    DENSE_RANK()OVER(
		PARTITION BY d.dept_id 
		ORDER BY salary DESC 
	) AS rnk
   FROM departments_20_05 d
   JOIN employees_20_05 e ON d.dept_id = e.dept_id
	)
SELECT 	dept_name,
emp_name,
salary
FROM ranking
WHERE rnk=1

