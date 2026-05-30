2. Retained Users (Cohort Style)
Table:-

CREATE TABLE logins_19_05 (
    user_id INT,
    login_date DATE
);

INSERT INTO logins_19_05 VALUES
(1, '2024-01-01'),
(1, '2024-01-03'),
(1, '2024-01-10'),
(2, '2024-01-01'),
(2, '2024-01-20'),
(3, '2024-01-05'),
(3, '2024-01-08');

Problem

👉 Find users who logged in again within 7 days of first login.

Approach_1:-

WITH first_login AS (
	SELECT user_id,
	MIN(login_date) AS first_login_date
    FROM logins_19_05
	GROUP BY user_id
	)
SELECT f.user_id,
       f.first_login_date
FROM first_login f	
WHERE EXISTS (
    SELECT 1
    FROM logins_19_05 l
    WHERE f.user_id = l.user_id
    AND l.login_date > f.first_login_date 
	AND  l.login_date <= (f.first_login_date + INTERVAL'7Days')
	)
    ORDER BY f.user_id 

Approach_2:-

WITH first_login AS ( 
	SELECT user_id, 
	MIN(login_date) AS first_login_date 
	FROM logins_19_05 GROUP BY user_id 
) 
SELECT DISTINCT f.user_id ,
    f.first_login_date 
FROM first_login f 
JOIN logins_19_05 l 
ON f.user_id = l.user_id 
WHERE l.login_date > f.first_login_date 
AND l.login_date < (f.first_login_date + INTERVAL'+7Days') 
ORDER BY f.user_id