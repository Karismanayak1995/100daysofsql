
-- Create table
CREATE TABLE employees_48 (
    emp_id INT,
    emp_name VARCHAR(255),
    dept_id INT
);

-- Insert data
INSERT INTO employees_48 (emp_id, emp_name, dept_id) VALUES
(1, 'John', 1),
(2, 'Jane', 2),
(3, 'Alice', 1),
(4, 'Bob', 3),
(5, 'Emily', 2);
-----------------------------
DROP TABLE IF EXISTS dept_48
-- Create table to store department IDs and hourly rates
CREATE TABLE dept_48 (
    dept_id INT PRIMARY KEY,
    hourly_rate INT
);

-- Insert sample data into the table
INSERT INTO dept_48 (dept_id, hourly_rate) VALUES
(1, 10),
(2, 12),
(3, 15);
------------------------------
-- Create table to store employee entry and exit times
CREATE TABLE daily_time (
    emp_id INT,
    entry_time TIMESTAMP,
    exit_time TIMESTAMP
);

-- Insert data into the table
INSERT INTO daily_time (emp_id, entry_time, exit_time) VALUES
(1, '2023-01-01 09:00:00', '2023-01-01 17:00:00'),
(2, '2023-01-01 08:00:00', '2023-01-01 15:00:00'),
(3, '2023-01-01 08:30:00', '2023-01-01 18:30:00'),
(4, '2023-01-01 09:00:00', '2023-01-01 16:00:00'),
(5, '2023-01-01 08:00:00', '2023-01-01 18:00:00'),
(1, '2023-01-02 10:00:00', '2023-01-02 18:00:00'),
(2, '2023-01-02 08:00:00', '2023-01-02 19:00:00'),
(3, '2023-01-02 08:00:00', '2023-01-02 17:30:00'),
(4, '2023-01-02 10:00:00', '2023-01-02 17:00:00'),
(5, '2023-01-02 09:00:00', '2023-01-02 15:00:00');
-------------------------------------------------------
SELECT * FROM employees_48
SELECT * FROM dept_48
SELECT * FROM daily_time

------------------------------------------------------
--converting time into minutes
WITH time_diff AS (
    SELECT 
        emp_id, 
        EXTRACT(HOUR FROM exit_time - entry_time) AS hours_difference,
	    EXTRACT(MINUTE FROM exit_time - entry_time) AS minutes_difference
    FROM 
        daily_time
),payouts AS(
    SELECT 
        t.emp_id,e.emp_name,e.dept_id,
	    ROUND(CASE 
			  WHEN (hours_difference * 60 + minutes_difference) <= 480 
			  THEN (hours_difference * 60 + minutes_difference) * d.hourly_rate / 60 
              ELSE (480 * d.hourly_rate + ((hours_difference * 60 + minutes_difference) - 480) * d.hourly_rate * 1.5) / 60
              END,1) AS total_payout,
		ROUND(CASE 
			  WHEN (hours_difference * 60 + minutes_difference) > 480 
	          THEN ((hours_difference * 60 + minutes_difference) - 480) * d.hourly_rate * 1.5 / 60 
			  END,1) AS overtime_payout
       
    FROM 
     time_diff t
    INNER JOIN employees_48 e ON t.emp_id = e. emp_id
    INNER JOIN dept_48 d ON e.dept_id = d. dept_id	
  --GROUP BY e.emp_id		
	     )
--SELECT * FROM payouts
SELECT emp_name, SUM(total_payout) AS total_payout, SUM(overtime_payout) AS overtime_payout
FROM payouts
GROUP BY emp_name

------------------------------------------------------------
-- converting time into hours
WITH time_diff AS (
    SELECT 
        emp_id, 
        EXTRACT(HOUR FROM exit_time - entry_time) AS hours_difference,
	    EXTRACT(MINUTE FROM exit_time - entry_time) AS minutes_difference
    FROM 
        daily_time
),payouts AS(
    SELECT 
        t.emp_id,e.emp_name,e.dept_id,
	    ROUND(CASE 
                WHEN (hours_difference + (minutes_difference/60)) <= 8 THEN hours_difference * d.hourly_rate 
                ELSE 8 * d.hourly_rate + ((hours_difference + (minutes_difference/60)) - 8) * d.hourly_rate * 1.5 
                END , 1) AS total_payout , 
	    ROUND(CASE 
	            WHEN (hours_difference + (minutes_difference/60)) > 8 
	            THEN ((hours_difference + (minutes_difference/60)) - 8) * d.hourly_rate * 1.5  END,1) AS overtime_payout

    FROM 
     time_diff t
    INNER JOIN employees_48 e ON t.emp_id = e. emp_id
    INNER JOIN dept_48 d ON e.dept_id = d. dept_id	
  	
	     )
--SELECT * FROM payouts
SELECT emp_name, SUM(total_payout) AS total_payout, SUM(overtime_payout) AS overtime_payout
FROM payouts
GROUP BY emp_name






