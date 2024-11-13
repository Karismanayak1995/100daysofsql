--You are a DevOps engineer responsible for monitoring the health and status of various services in your organization's infrastructure. 
--Your team conducts canary tests on each service every minute to ensure their reliability and performance.
--As part of your responsibilities, you need to develop a SQL to identify any service that experiences continuous 
--downtime for atleast 5 minutes so that team can find the root cause and fix the issue.


-- Create the service_status table
CREATE TABLE service_status_59 (
    service_name VARCHAR(50),
    updated_time TIMESTAMP,
    status VARCHAR(10)
);

-- Insert data into the service_status table
INSERT INTO service_status_59 (service_name, updated_time, status) VALUES
('hdfs', '2024-03-06 10:01:00', 'up'),
('hdfs', '2024-03-06 10:02:00', 'down'),
('hdfs', '2024-03-06 10:03:00', 'down'),
('hdfs', '2024-03-06 10:04:00', 'down'),
('hdfs', '2024-03-06 10:05:00', 'down'),
('hdfs', '2024-03-06 10:06:00', 'down'),
('hdfs', '2024-03-06 10:07:00', 'down'),
('hdfs', '2024-03-06 10:08:00', 'up'),
('hdfs', '2024-03-06 10:09:00', 'down'),
('hive', '2024-03-06 10:01:00', 'down'),
('hive', '2024-03-06 10:02:00', 'up'),
('hive', '2024-03-06 10:03:00', 'down'),
('hive', '2024-03-06 10:04:00', 'down'),
('hive', '2024-03-06 10:05:00', 'down'),
('hive', '2024-03-06 10:06:00', 'down'),
('hive', '2024-03-06 10:07:00', 'down'),
('hive', '2024-03-06 10:08:00', 'up'),
('hive', '2024-03-06 10:09:00', 'down');


SELECT * FROM service_status_59

WITH CTE AS
  (
	SELECT 
	  service_name,
	  updated_time,
	  status,
	  ROW_NUMBER() OVER (PARTITION BY service_name ORDER BY updated_time) AS row_num,
	  ROW_NUMBER() OVER (PARTITION BY service_name,status ORDER BY updated_time) AS status_row_num
	FROM service_status_59
)
  SELECT
     service_name,
	 MIN(updated_time) AS down_start_time,
	 MAX(updated_time) AS down_end_time,
	 COUNT(*) AS down_minutes
	 
 FROM CTE
 WHERE status = 'down'
 GROUP BY service_name , status_row_num - row_num
 HAVING COUNT(*) >= 5
	 
        
        
	
	