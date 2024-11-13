--You are given the data of employees along with their salary and department . 
--Write an SQL to find list of employees who has salary greater than average employee salary of the company.  
--However , While calculating the company average salary to compare with an employee salary.
--do not consider salaries of that employee's department.

CREATE TABLE employee_ns 
(
    emp_id	INT,
    salary	INT,
    department	VARCHAR(512)
);

INSERT INTO employee_ns (emp_id, salary, department) VALUES ('100', '40000', 'Analytics');
INSERT INTO employee_ns (emp_id, salary, department) VALUES ('101', '30000', 'Analytics');
INSERT INTO employee_ns (emp_id, salary, department) VALUES ('102', '50000', 'Analytics');
INSERT INTO employee_ns (emp_id, salary, department) VALUES ('103', '45000', 'Engineering');
INSERT INTO employee_ns (emp_id, salary, department) VALUES ('104', '48000', 'Engineering');
INSERT INTO employee_ns (emp_id, salary, department) VALUES ('105', '51000', 'Engineering');
INSERT INTO employee_ns (emp_id, salary, department) VALUES ('106', '46000', 'Science');
INSERT INTO employee_ns (emp_id, salary, department) VALUES ('107', '38000', 'Science');
INSERT INTO employee_ns (emp_id, salary, department) VALUES ('108', '37000', 'Science');


SELECT * FROM employee_ns

SELECT emp_id,salary,department
FROM employee_ns e  
WHERE e.salary > (SELECT AVG(salary) AS avg_salary FROM employee_ns B )--WHERE B.department!=e.department)

