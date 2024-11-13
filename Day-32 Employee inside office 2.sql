--Please note below points about the data:

--1- First entry for each employee is “in”

--2- Every “in” is succeeded by an “out”

--3- Employee can work across days
--Write an SQL to measure the amount of hours spent by each employee inside the office between “2019-04-01 14:00:00” and “2019-04-02 10:00:00"  in minutes. 

 
DROP TABLE IF EXISTS employee_actions_39
-- Create the employee_actions table
CREATE TABLE employee_actions_39 (
    emp_id INT,
    action VARCHAR(3),
    created_at TIMESTAMP
);

-- Insert data into the employee_actions table
INSERT INTO employee_actions_39 (emp_id, action, created_at) VALUES
(1, 'in', '2019-04-01 12:00:00'),
(1, 'out', '2019-04-01 15:00:00'),
(1, 'in', '2019-04-01 17:00:00'),
(1, 'out', '2019-04-01 21:00:00'),
(2, 'in', '2019-04-01 10:00:00'),
(2, 'out', '2019-04-01 13:00:00'),
(3, 'in', '2019-04-01 19:00:00'),
(3, 'out', '2019-04-02 05:00:00'),
(4, 'in', '2019-04-01 18:00:00'),
(4, 'out', '2019-04-02 20:00:00'),
(5, 'in', '2019-04-01 10:00:00'),
(5, 'out', '2019-04-02 11:00:00'),
(6, 'in', '2019-04-02 11:00:00'),
(6, 'out', '2019-04-02 16:00:00');

WITH CTE_X AS(
SELECT *
,LEAD(created_at ) OVER(PARTITION BY emp_id ORDER BY created_at) AS next_created_at
FROM employee_actions_39
	)
,CTE_Y	AS(
SELECT emp_id
,CASE WHEN created_at < '2019-04-01 14:00:00' THEN '2019-04-01 14:00:00' ELSE created_at END AS in_time
,CASE WHEN next_created_at > '2019-04-02 10:00:00' THEN '2019-04-02 10:00:00' ELSE next_created_at END AS out_time
FROM CTE_X	
WHERE action = 'in'	
	)
--SELECT * FROM CTE_Y
SELECT emp_id
,ROUND(SUM(CASE WHEN in_time >= out_time THEN 0 
                   ELSE (EXTRACT(EPOCH FROM (out_time - in_time)) / 60) END), 1) AS time_spent
FROM CTE_Y
GROUP BY emp_id
