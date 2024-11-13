--LinkedIn is a professional social networking app.
--They want to give top voice badge to their best creators to encourage them to create more quality content.
--A creator qualifies for the badge if he/she satisfies following criteria. 
--1- Creator should have more then 50k followers.
--2- Creator should have more than 100k impressions on the posts that they published in the month of Dec-2023.
--3- Creator should have published atleast 3 posts in Dec-2023.
--Write a SQL to get the list of top voice creators name along with no of posts and impressions by them in the month of Dec-2023.
SELECT * FROM creators
SELECT * FROM posts

SELECT c.creator_name,COUNT(p.post_id) AS no_of_posts, SUM(p.impressions) AS total_impressions
--,CONCAT(DATE_PART('MONTH',publish_date),'-',DATE_PART('YEAR',publish_date)) AS month_year
FROM creators c LEFT OUTER JOIN posts p
ON c.creator_id = p.creator_id
WHERE CONCAT(DATE_PART('MONTH',publish_date),'-',DATE_PART('YEAR',publish_date))='12-2023'
GROUP BY c.creator_name
HAVING COUNT(p.post_id)>=3 AND SUM(p.impressions)>= 100000 AND MAX(followers)>=50000;

