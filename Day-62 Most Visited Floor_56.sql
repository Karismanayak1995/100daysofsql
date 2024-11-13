--You are a facilities manager at a corporate office building, responsible for tracking employee visits, floor preferences, and resource usage within the premises. 
--The office building has multiple floors, each equipped with various resources such as desks, computers, monitors, and other office supplies.

--You have a database table named entries that stores information about employee visits to the office building. 
--Each record in the table represents a visit by an employee and includes details such as their name, the floor they visited, and the resources they used during their visit.
--Write an SQL query to retrieve the total visits, most visited floor, and resources used by each employee.

--------------------------------------------------------------

-- Create the table
CREATE TABLE entries_56 (
    emp_name VARCHAR(50),
    address VARCHAR(100),
    floor INT,
    resources VARCHAR(50)
);

-- Insert data into the table
INSERT INTO entries_56 (emp_name, address, floor, resources) VALUES
('Ankit', 'Bangalore', 1, 'CPU'),
('Ankit', 'Bangalore', 1, 'CPU'),
('Ankit', 'Bangalore', 2, 'DESKTOP'),
('Bikaas', 'Bangalore', 2, 'DESKTOP'),
('Bikaas', 'Bangalore', 2, 'DESKTOP'),
('Bikaas', 'Bangalore', 1, 'MONITOR');


SELECT * FROM entries_56

WITH CTE AS (
SELECT emp_name,floor
FROM entries_56
GROUP BY emp_name,floor
HAVING COUNT(*) > 1
	)
SELECT e.emp_name, COUNT(address) AS total_visits, MAX(c.floor) AS floor,
       STRING_AGG(DISTINCT resources,',') AS resources_used
FROM entries_56 e INNER JOIN CTE c
ON e.emp_name = c.emp_name
GROUP BY e.emp_name
ORDER BY e.emp_name
