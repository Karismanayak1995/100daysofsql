1. Monthly Active Users (MAU)

CREATE TABLE user_activity_19_05 (
    user_id INT,
    activity_date DATE
);

INSERT INTO user_activity_19_05 VALUES
(1, '2024-01-01'),
(1, '2024-01-15'),
(1, '2024-02-10'),
(2, '2024-01-05'),
(2, '2024-02-12'),
(3, '2024-02-20'),
(4, '2024-01-25');

Problem

👉 Find Monthly Active Users for each month.

Output:

month
active_users

SELECT * FROM user_activity_19_05;

SELECT
DATE_TRUNC('month', activity_date)AS mnth,
--TO_CHAR( activity_date,'MM-YYYY')AS mnth,
COUNT(DISTINCT user_id) AS active_users
FROM user_activity_19_05
GROUP BY DATE_TRUNC('month', activity_date)
--GROUP BY TO_CHAR( activity_date,'MM-YYYY')
ORDER BY mnth