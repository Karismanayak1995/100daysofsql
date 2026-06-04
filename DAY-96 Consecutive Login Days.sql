--🔥 8. Consecutive Login Days

--Table

CREATE TABLE user_logins_03_06 (
    user_id INT,
    login_date DATE
);

INSERT INTO user_logins_03_06 VALUES
(1, '2024-01-01'),
(1, '2024-01-02'),
(1, '2024-01-03'),
(1, '2024-01-04'),
(1, '2024-01-05'),
(2, '2024-01-01'),
(2, '2024-01-03');
 
--Find consecutive orders for 5 days.

SELECT * FROM user_logins_03_06;

WITH grouped AS (
	SELECT user_id,
    login_date,
    login_date - ROW_NUMBER() OVER(PARTITION BY user_id 
							   ORDER BY login_date  
							  ):: INT AS grp
    FROM user_logins_03_06
	)
SELECT user_id,
MIN(login_date) AS start_date,
MAX(login_date) AS end_date,
COUNT(*) AS no_of_consecutive_days
FROM grouped
GROUP BY user_id
HAVING COUNT(*) >= 5;


