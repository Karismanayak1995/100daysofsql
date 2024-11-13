--1.You are given the table of employee details. Write an SQL to find details of employee with 
--salary more than their manager salary but they joined the company after the manager joined.
--2.Please note that manager_id in the employee table refering to emp_id of the same table.
CREATE TABLE employee_manager 
(
    emp_id	INT,
    emp_name	VARCHAR(512),
    joining_date	DATE,
    salary	INT,
    manager_id	INT
);

INSERT INTO employee_manager (emp_id, emp_name, joining_date, salary, manager_id) VALUES ('1', 'Ankit', '2021-01-01', '10000', '4');
INSERT INTO employee_manager (emp_id, emp_name, joining_date, salary, manager_id) VALUES ('2', 'Mohit', '2022-05-01', '15000', '5');
INSERT INTO employee_manager (emp_id, emp_name, joining_date, salary, manager_id) VALUES ('3', 'Vikas', '2023-06-01', '10000', '4');
INSERT INTO employee_manager (emp_id, emp_name, joining_date, salary, manager_id) VALUES ('4', 'Rohit', '2022-02-01', '5000', '2');
INSERT INTO employee_manager (emp_id, emp_name, joining_date, salary, manager_id) VALUES ('5', 'Mudit', '2021-03-01', '12000', '6');
INSERT INTO employee_manager (emp_id, emp_name, joining_date, salary, manager_id) VALUES ('6', 'Agam', '2024-02-01', '12000', '2');
INSERT INTO employee_manager (emp_id, emp_name, joining_date, salary, manager_id) VALUES ('7', 'Sanjay', '2024-02-21', '9000', '2');
INSERT INTO employee_manager (emp_id, emp_name, joining_date, salary, manager_id) VALUES ('8', 'Ashish', '2023-01-05', '5000', '2');
INSERT INTO employee_manager (emp_id, emp_name, joining_date, salary, manager_id) VALUES ('9', 'Mukesh', '2020-02-03', '6000', '6');
INSERT INTO employee_manager (emp_id, emp_name, joining_date, salary, manager_id) VALUES ('10', 'Rakesh', '2022-08-01', '7000', '6');

 SELECT * FROM employee_manager
 
 SELECT e.emp_name,e.salary,e.joining_date,m.salary AS manager_salary,m.joining_date AS manager_joining_date
 FROM employee_manager e
 INNER JOIN employee_manager M
 ON m.emp_id = e.manager_id
 WHERE m.joining_date < e.joining_date AND e.salary > m.salary
 