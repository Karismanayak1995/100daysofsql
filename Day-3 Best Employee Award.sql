  Write an SQL to find best employee for each month along with number of projects completed by him/her in that month .



DROP TABLE IF EXISTS  ncs_tb 
CREATE TABLE ncs_tb 
(
    project_id	INT,
    employee_name	VARCHAR(512),
    project_completion_date 	DATE
);

INSERT INTO ncs_tb (project_id, employee_name, project_completion_date ) VALUES ('101', 'Shilpa', '2023-01-03 ');
INSERT INTO ncs_tb (project_id, employee_name, project_completion_date ) VALUES ('102', 'Shilpa', '2023-01-15 ');
INSERT INTO ncs_tb (project_id, employee_name, project_completion_date ) VALUES ('103', 'Shilpa', '2023-01-22 ');
INSERT INTO ncs_tb (project_id, employee_name, project_completion_date ) VALUES ('104', 'Rahul', '2023-01-05');

SELECT * FROM ncs_tb;

WITH CTE_A AS(
SELECT employee_name,
CONCAT(DATE_PART('YEAR',project_completion_date),DATE_PART('MONTH',project_completion_date)) AS year_month
FROM ncs_tb
	)
SELECT CTE_A.employee_name,CTE_A.year_month,
COUNT(employee_name) AS no_of_completed_projects FROM  CTE_A
GROUP BY employee_name,CTE_A.year_month
HAVING COUNT(employee_name)>1