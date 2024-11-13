--In the realm of user authentication and account verification, email confirmation plays a pivotal role in ensuring the security and validity of user accounts.
--Analyzing the efficiency of email confirmation processes provides insights into user engagement and the effectiveness of onboarding strategies.

--You are tasked with analyzing the email confirmation process of a web application to determine the percentage of users
--who confirm their email addresses on the same day of registration, the next day, beyond next day and never confirmed.

--Round the result to 2 decimal places and sort by confirmation percent in descending order.
--------------------------------------------
-- Create the users table
CREATE TABLE user_registration (
    user_id INT,
    registration_date DATE
);

-- Insert data into the users table
INSERT INTO user_registration(user_id, registration_date) VALUES
(1, '2024-03-13'),
(2, '2024-03-13'),
(3, '2024-03-13'),
(4, '2024-03-14'),
(5, '2024-03-14'),
(6, '2024-03-15'),
(7, '2024-03-16'),
(8, '2024-03-16'),
(9, '2024-03-16'),
(10, '2024-03-16'),
(11, '2024-03-17');
---------------------------------------
-- Create the confirmations table
CREATE TABLE email_confirmation (
    user_id INT,
    confirmation_date DATE
);

-- Insert data into the confirmations table
INSERT INTO email_confirmation (user_id, confirmation_date) VALUES
(1, '2024-03-13'),
(2, '2024-03-14'),
(3, '2024-03-16'),
(4, '2024-03-14'),
(5, '2024-03-16'),
(6, '2024-03-15'),
(8, '2024-03-17'),
(9, '2024-03-16'),
(11, '2024-03-20');



SELECT * FROM user_registration
SELECT * FROM email_confirmation

WITH CTE AS (
  SELECT COUNT(r.user_id) AS total_users,
	     COUNT(CASE WHEN r.registration_date = c.confirmation_date THEN 1 ELSE NULL END) AS same_day_confirm,
	     COUNT(CASE WHEN c.confirmation_date = r.registration_date + INTERVAL '1 DAY' THEN 1 ELSE NULL END) AS next_day_confirm,
	     COUNT(CASE WHEN c.confirmation_date > r.registration_date + INTERVAL '1 DAY' THEN 1 ELSE NULL END) AS beyond_next_day_confirm,
	     COUNT(CASE WHEN c.confirmation_date IS NULL THEN 1 ELSE NULL END ) AS not_confirmed 
  FROM user_registration r 
  LEFT JOIN email_confirmation c ON r.user_id = c.user_id
	)
SELECT 
    'same day confirm' AS confirm_category,
    ROUND(same_day_confirm::numeric / total_users * 100 , 2) AS percent_of_total
FROM CTE
UNION ALL
SELECT 
    'next day confirm' AS confirm_category,
    ROUND(next_day_confirm:: numeric / total_users * 100, 2) AS percent_of_total
FROM CTE
UNION ALL
SELECT 
    'beyond next day confirm' AS confirm_category,
    ROUND(beyond_next_day_confirm:: numeric / total_users * 100, 2) AS percent_of_total
FROM CTE
UNION ALL
SELECT 
    'not confirmed' AS confirm_category,
    ROUND(not_confirmed:: numeric / total_users * 100 , 2) AS percent_of_total
FROM CTE
ORDER BY percent_of_total DESC

-------------------------------------------------------------------------
with cte as (
select u.user_id ,c.Confirmation_Date - u.Registration_Date as days_to_confirm
,count(*) over() as total_users
 from user_registration u 
left join email_confirmation c on u.user_id=c.user_id
)
,cte2 as (
select *, case when days_to_confirm=0 then 'same day confirm' 
when days_to_confirm=1 then 'next day confirm'
when days_to_confirm is null then 'not confirmed'
else 'beyond next day confirm' end as confirm_category
 from cte

)
select confirm_category,round(count(*)*100.0/total_users,2) as percent_of_total
from cte2 
group by confirm_category,total_users
order by percent_of_total desc;