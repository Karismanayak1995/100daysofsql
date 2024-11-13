--Amazon, the world's largest online retailer, offers various services to its customers, including Amazon Prime membership, Video streaming, Amazon Music, Amazon Pay, and more. 
--The company is interested in analyzing which of its services are most effective at converting regular customers into Amazon Prime members.

--You are given a table of events which consists services accessed by each users along with service access date. 
--This table also contains the event when customer bought the prime membership.

--Write an SQL to get date when each customer became prime member, last service used (just before becoming prime member), last service access date ( just before becoming prime member).
--If a customer never became prime member then populate last service used and last service access date by the customer.
----------------------------------------------------------
-- Create the table
CREATE TABLE users_57 (
    user_id INT,
    name VARCHAR(50)
);

-- Insert data into the table
INSERT INTO users_57 (user_id, name) VALUES
(1, 'Saurabh'),
(2, 'Amit'),
(3, 'Ankit');
-----------------------------------------------------------
-- Create the table
CREATE TABLE Events_57 (
    user_id INT,
    type VARCHAR(50),
    access_date DATE
);

-- Insert data into the table
INSERT INTO Events_57 (user_id, type, access_date) VALUES
(1, 'Amazon Music', '2024-01-05'),
(1, 'Amazon Video', '2024-01-07'),
(1, 'Prime', '2024-01-08'),
(1, 'Amazon Video', '2024-01-09'),
(2, 'Amazon Pay', '2024-01-08'),
(2, 'Prime', '2024-01-09'),
(3, 'Amazon Pay', '2024-01-07'),
(3, 'Amazon Music', '2024-01-09');

SELECT *  FROM Users_57
SELECT *  FROM Events_57

WITH CTE_X AS (
      SELECT *,
	LAG(type,1) OVER (PARTITION BY user_id ORDER BY access_date) AS prev_type,
	Lag(access_date,1) OVER (PARTITION BY user_id ORDER BY access_date) AS prev_access_date,
	ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY access_date DESC) AS rank
      FROM Events_57
      )
SELECT name AS user_name,c1.access_date AS prime_member_date, 
	   COALESCE(c1.prev_type,c2.type) AS last_access_service, COALESCE(c1.prev_access_date,c2.access_date) AS last_access_service_date 
--COALESCE(c1.prev_type, c2.type): If there is no previous type before the 'Prime' event, use the most recent event type.
--COALESCE(c1.prev_access_date, c2.access_date): If there is no previous access date before the 'Prime' event, use the most recent event date
FROM Users_57 u
LEFT JOIN CTE_X c1 ON u.user_id = c1.user_id AND c1.type = 'Prime'
LEFT JOIN CTE_X c2 ON u.user_id = c2.user_id AND c2.rank = 1 ;
	
	
	
	
	
	