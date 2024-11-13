--Your task is to write a SQL query to find the third highest salaried employee's details in each department. 
--In case of a tie in salary, select the younger employee. 
--If there are fewer than three employees in a department, provide details of the lowest salaried employee.
--sort the result by department name.
-----------------------------------------------------------------
-- Create the Employee table
CREATE TABLE Employee_72 (
    EmployeeID INT PRIMARY KEY,
    Department VARCHAR(50),
    Salary INT,
    DateOfBirth DATE
);

-- Insert data into the Employee table
INSERT INTO Employee_72 (EmployeeID, Department, Salary, DateOfBirth) VALUES
(1, 'Sales', 50000, '1990-05-15'),
(2, 'Sales', 60000, '1985-03-20'),
(3, 'Sales', 55000, '1992-07-10'),
(4, 'Sales', 48000, '1988-10-25'),
(5, 'IT', 52000, '1993-01-12'),
(6, 'IT', 52000, '1995-08-05'),
(7, 'IT', 65000, '1989-12-30'),
(8, 'Finance', 55000, '1995-09-22'),
(9, 'Finance', 60000, '1990-04-03');
-----------------------------------------------------------------
SELECT * FROM Employee_72

-------------------------------------------------------------------
WITH ranking AS
(
	SELECT EmployeeID, 
           Department,
	       salary,
	       DENSE_RANK() OVER (PARTITION BY Department ORDER BY salary DESC,DateOfBirth) AS rn,
	       COUNT(*) OVER (PARTITION BY Department) AS cnt_of_member
    FROM Employee_72
)
SELECT EmployeeID,Department,salary
FROM ranking 
WHERE rn = 3 OR (cnt_of_member<3 AND rn=cnt_of_member)
	  
	  



