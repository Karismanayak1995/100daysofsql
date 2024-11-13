--Please note below points about the data:

--1- First entry for each employee is “in”

--2- Every “in” is succeeded by an “out”

--3- Employee can work across days

--Write a SQL to find the number of employees inside the Office at “2019-04-01 19:05:00".


-- Create the employee_actions table
CREATE TABLE employee_actions (
    emp_id INT,
    action VARCHAR(3),
    created_at TIMESTAMP
);

-- Insert data into the employee_actions table
INSERT INTO employee_actions (emp_id, action, created_at) VALUES
(1, 'in', '2019-04-01 12:00:00'),
(1, 'out', '2019-04-01 15:00:00'),
(1, 'in', '2019-04-01 17:00:00'),
(1, 'out', '2019-04-01 21:00:00'),
(2, 'in', '2019-04-01 10:00:00'),
(2, 'out', '2019-04-01 16:00:00'),
(3, 'in', '2019-04-01 19:00:00'),
(3, 'out', '2019-04-02 05:00:00'),
(4, 'in', '2019-04-01 10:00:00'),
(4, 'out', '2019-04-01 20:00:00');

SELECT * FROM employee_actions

WITH CTE AS(
SELECT *
,LEAD(created_at ) OVER(PARTITION BY emp_id ORDER BY created_at) AS next_created_at
FROM employee_actions
	)
SELECT COUNT(*)
FROM CTE
WHERE action = 'in' and '2019-04-01 19:05:00'  BETWEEN created_at AND next_created_at











