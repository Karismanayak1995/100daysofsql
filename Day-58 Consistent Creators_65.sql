--You are working as a data analyst at LinkedIn. Your task is to find the consistent creators.
-- A consistent creator is a user who has posted atleast 2 times every month for the last 3 months. 
--Please note that last 3 months doesn't include current month. 
--So for example if you are running the SQL in March 24 then you should look for data from 2023-12-01 to 2024-02-29.
--Write an SQL to find consistent creator along with total likes they got in those 3 months. 

--Please note that the output may change based on which date you are running the query. 
--This is the output on 2024-03-15. But evaluation will happen as per today's date.
--------------------------------------
CREATE TABLE posts_65 (
    user_id INT,
    post_date DATE,
    count_likes INT,
    PRIMARY KEY (user_id, post_date)
);
INSERT INTO posts_65 (user_id, post_date, count_likes) VALUES
(1, '2024-05-22', 10),
(1, '2024-06-18', 15),
(1, '2024-05-01', 20),
(1, '2024-05-16', 10),
(1, '2024-04-11', 12),
(1, '2024-04-01', 15),
(1, '2024-03-12', 20),
(2, '2024-06-02', 8),
(2, '2024-05-31', 12),
(2, '2024-05-17', 20),
(2, '2024-05-06', 8),
(2, '2024-04-01', 25),
(2, '2024-03-24', 18),
(2, '2024-03-02', 8),
(2, '2024-02-26', 25),
(2, '2024-03-07', 18),
(3, '2024-05-21', 5),
(3, '2024-05-06', 10),
(3, '2024-04-21', 15);

SELECT * FROM posts_65

SELECT user_id, SUM(count_likes) AS total_likes
FROM posts_65
WHERE post_date BETWEEN '2024-03-01' AND '2024-05-31'
GROUP BY user_id
HAVING COUNT(EXTRACT(MONTH FROM post_date))>2
----------------------------------------
SELECT user_id, SUM(count_likes) AS total_likes
FROM posts_65
WHERE post_date >= date_trunc('month', current_date) - INTERVAL '3 months'
AND post_date <= date_trunc('month', current_date) - INTERVAL '1 day'
GROUP BY user_id
HAVING COUNT(EXTRACT(MONTH FROM post_date))>2
