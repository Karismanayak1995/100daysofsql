--Netflix wants to identify the top 2 binge-watched TV series in each country for users aged between 18 and 30 years old. 
--Binge-watching is defined as watching multiple episodes of a TV series consecutively within a short period.
--Your task is to write a SQL query to identify the top 2 binge-watched TV series in each country among users aged between 18 and 30 years old. 
--The query should return the country, TV series title, total duration viewed (in minutes), and the count of unique users who watched each series.
---------------------------------------------------
-- Create the users table
CREATE TABLE users_68 (
    user_id INT PRIMARY KEY,
    username VARCHAR(50),
    age INT,
    country VARCHAR(50)
);

-- Insert data into the users table
INSERT INTO users_68 (user_id, username, age, country) VALUES
(1, 'john_doe', 25, 'United States'),
(2, 'alice_smith', 22, 'United States'),
(3, 'bob_jones', 28, 'United States'),
(4, 'emma_brown', 20, 'Canada'),
(5, 'michael_clark', 29, 'Canada'),
(6, 'sarah_wilson', 26, 'Canada'),
(7, 'chris_evans', 30, 'United Kingdom'),
(8, 'lisa_taylor', 23, 'United Kingdom'),
(9, 'david_robinson', 21, 'United Kingdom');

---------------------------------------------------
-- Create the table
CREATE TABLE viewinghistory_68 (
    user_id INT,
    title VARCHAR(50),
    start_time TIMESTAMP,
    end_time TIMESTAMP
);

-- Insert data into the table
INSERT INTO viewinghistory_68 (user_id, title, start_time, end_time) VALUES
(1, 'Stranger Things', '2023-01-01 10:00:00', '2023-01-01 10:30:00'),
(1, 'Breaking Bad', '2023-01-02 09:00:00', '2023-01-02 09:45:00'),
(2, 'Stranger Things', '2023-01-01 11:00:00', '2023-01-01 12:30:00'),
(2, 'Breaking Bad', '2023-01-02 10:30:00', '2023-01-02 11:15:00'),
(3, 'Money Heist', '2023-01-01 09:00:00', '2023-01-01 11:00:00'),
(3, 'Stranger Things', '2023-01-02 08:00:00', '2023-01-02 10:00:00'),
(4, 'Stranger Things', '2023-01-01 10:00:00', '2023-01-01 10:45:00'),
(4, 'Breaking Bad', '2023-01-02 09:30:00', '2023-01-02 10:15:00'),
(5, 'Breaking Bad', '2023-01-01 08:00:00', '2023-01-01 09:30:00'),
(5, 'Money Heist', '2023-01-02 07:30:00', '2023-01-02 08:45:00'),
(6, 'Stranger Things', '2023-01-01 11:30:00', '2023-01-01 12:45:00'),
(6, 'Money Heist', '2023-01-02 09:00:00', '2023-01-02 10:30:00'),
(7, 'Breaking Bad', '2023-01-01 10:00:00', '2023-01-01 10:45:00'),
(7, 'Money Heist', '2023-01-02 08:30:00', '2023-01-02 09:15:00'),
(8, 'Stranger Things', '2023-01-01 09:00:00', '2023-01-01 10:30:00'),
(8, 'Breaking Bad', '2023-01-02 08:30:00', '2023-01-02 09:45:00'),
(9, 'Money Heist', '2023-01-01 10:00:00', '2023-01-01 11:15:00'),
(9, 'Stranger Things', '2023-01-02 09:30:00', '2023-01-02 11:00:00');
----------------------------------------------

SElECT * FROM users_68
SElECT * FROM viewinghistory_68
-------------------------------------------------
-- Query to find the top binge-watched TV series in each country among users aged between 18 and 30
WITH BingeWatchSummary AS (
	SELECT u.country,v.title,
          ROUND(SUM(EXTRACT(EPOCH FROM  (v.end_time - v.start_time))/60),0)  AS total_duration_minutes,
	      COUNT(DISTINCT v.user_id) AS unique_users
    FROM viewinghistory_68	v
    INNER JOIN users_68 u ON u.user_id = v.user_id
	WHERE u.age BETWEEN 18 AND 30
    GROUP BY u.country,v.title
	)
,RankedBingeWatchSummary AS (
    SELECT country,
           title,
           ROW_NUMBER() OVER (PARTITION BY country ORDER BY total_duration_minutes DESC) AS rank,
           total_duration_minutes,
           unique_users
    FROM BingeWatchSummary	
	)
--SELECT * FROM RankedBingeWatchSummary
SELECT rbs.country,
       rbs.title AS tv_series_title,
       rbs.total_duration_minutes AS total_duration_viewed_minutes,
       rbs.unique_users AS unique_users_count
FROM RankedBingeWatchSummary rbs
WHERE rbs.rank <= 2;

------------------------------------------------------
WITH filtered_users AS (
    SELECT 
        user_id,
        country
    FROM 
        users_68
    WHERE 
        age BETWEEN 18 AND 30
),
binge_sessions AS (
    SELECT 
        w.user_id,
        u.country,
        w.title,
        ROUND(SUM(EXTRACT(EPOCH FROM (w.end_time - w.start_time)) / 60),0) AS total_duration_viewed_minutes
    FROM 
        ViewingHistory_68 w
    JOIN 
        filtered_users u ON w.user_id = u.user_id
    GROUP BY 
        w.user_id, u.country, w.title
),
ranked_series AS (
    SELECT 
        country,
        title,
        SUM(total_duration_viewed_minutes) AS total_duration_viewed_minutes,
        COUNT(DISTINCT user_id) AS unique_users_count,
        ROW_NUMBER() OVER (PARTITION BY country ORDER BY SUM(total_duration_viewed_minutes) DESC) AS rank
    FROM 
        binge_sessions
    GROUP BY 
        country, title
)
--SELECT * FROM Ranked_series
SELECT 
    country,
    title AS tv_series_title,
    total_duration_viewed_minutes,
    unique_users_count
FROM 
    ranked_series
WHERE 
    rank <= 2
ORDER BY 
    country, rank;