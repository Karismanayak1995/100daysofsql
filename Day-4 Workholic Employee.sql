--Write a query to find workaholics employees.  
--Workaholics employees are those who satisfy atleast one of the given criterion:

--1- Employees who work for more than 8 hours a day for atleast 3 days in a week. 

--2- Employees who work for more than 10 hours a day for atleast 2 days in a week. 

--Write a SQL to find all the workaholic employees along with the criterion that they are satisfying (1,2 or both).

CREATE TABLE employee_work 
(
    emp_id	INT,
    login	TIMESTAMP,
    logout 	TIMESTAMP
);

INSERT INTO employee_work (emp_id, login, logout ) VALUES
	('100', '2024-02-19 09:15:00', '2024-02-19 18:20:00'),
	('100','2024-02-20 09:05:00','2024-02-20 17:00:00'),
	('100', '2024-02-21 09:00:00', '2024-02-21 17:10:00 '),
	('100', '2024-02-22 10:00:00', '2024-02-22 16:55:00 '),
	('100', '2024-02-23 10:30:00', '2024-02-23 19:15:00 '),
	('200', '2024-02-19 08:00:00', '2024-02-19 18:20:00 '),
	('200', '2024-02-20 09:00:00', '2024-02-20 16:30:00 '),
	('200', '2024-02-21 09:15:00', '2024-02-21 19:20:00 '),
	('200', '2024-02-22 11:00:00', '2024-02-22 17:05:00 '),
	('200', '2024-02-23 09:30:00', '2024-02-23 17:20:00 '),
    ('300', '2024-02-19 07:00:00', '2024-02-19 18:15:00 '),
    ('300', '2024-02-20 09:00:00',	'2024-02-20 19:10:00'),
    ('300', '2024-02-21 09:15:00',	'2024-02-21 18:20:00'),
    ('300', '2024-02-22 11:00:00',	'2024-02-22 17:00:00'),
    ('300', '2024-02-23 09:30:00',	'2024-02-23 16:30:00');


SELECT * FROM employee_work

WITH cte_a AS (
SELECT emp_id
,( logout - login ) AS working_hour
,CASE WHEN ( logout - login ) >= '10:00:00' THEN '10+'
	  WHEN ( logout - login ) >= '08:00:00' THEN '8+'
	  ELSE '8-'
	END AS time_window	
FROM employee_work
),time_window AS(
SELECT emp_id
--,COUNT(time_window) AS days_8
,SUM(CASE WHEN time_window = '10+' THEN 1
	  ELSE 0
	  END) AS days_10
,SUM(CASE WHEN time_window = '8+' THEN 1
	  ELSE 0
	  END) AS days_8
FROM cte_a	
WHERE time_window IN('8+','10+')	
GROUP BY emp_id
	)
--SELECT * FROM time_window	
select emp_id, case when days_8 >= 3 and days_10 >= 2 then 'both'
when days_8 >=3 then '1'
else '2' end as criterian
from time_window
where days_8>=3 or days_10>=2 
 