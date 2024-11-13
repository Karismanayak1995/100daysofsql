--You are working for a marketing agency that manages multiple Instagram influencer accounts. 
--Your task is to analyze the engagement performance of these influencers before and after they join your company.

--Write an SQL query to calculate average engagement growth rate percent for each influencer after they joined your company compare to before. 
--Round the growth rate to 2 decimal places and sort the output in descreasing order of growth rate.

--Engagement = # of likes + # of comments on each post
--------------------------------------------------------------
-- Create the table
CREATE TABLE influencers_54 (
    influencer_id INT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    join_date DATE NOT NULL
);

-- Insert the data
INSERT INTO influencers_54 (influencer_id, username, join_date) VALUES
(1, 'Ankit', '2023-02-01'),
(2, 'Rahul', '2023-03-05'),
(3, 'Suresh', '2023-05-20');
------------------------------------------------------
DROP TABLE IF EXISTS posts_54
-- Create the table
CREATE TABLE posts_54 (
    post_id INT,
    influencer_id INT,
    post_date DATE NOT NULL,
    likes INT NOT NULL,
    comments INT NOT NULL,
    PRIMARY KEY (post_id,influencer_id),
    FOREIGN KEY (influencer_id) REFERENCES influencers_54(influencer_id)
);

-- Insert the data
INSERT INTO posts_54 (post_id, influencer_id, post_date, likes, comments) VALUES
(1, 1, '2023-01-05', 100, 20),
(2, 1, '2023-01-10', 150, 30),
(3, 1, '2023-02-05', 200, 45),
(4, 1, '2023-02-10', 120, 25),
(1, 2, '2023-02-15', 150, 30),
(2, 2, '2023-02-20', 200, 25),
(3, 2, '2023-03-10', 250, 15),
(4, 2, '2023-03-15', 200, 35);

SELECT * FROM influencers_54 
SELECT * FROM posts_54

WITH CTE_X AS (
SELECT i.influencer_id,i.username,
       ROUND(AVG(CASE WHEN p.post_date < i.join_date THEN p.likes + p.comments END),2) AS before_engagement,
	   ROUND(AVG(CASE WHEN p.post_date > i.join_date THEN p.likes + p.comments END),2) AS after_engagement
FROM influencers_54 i INNER JOIN posts_54 p
ON i.influencer_id = p.influencer_id
GROUP BY i.influencer_id,i.username
ORDER BY i.influencer_id	
	)   
SELECT username,before_engagement,after_engagement,
	   ROUND((after_engagement - before_engagement)*100 / before_engagement,2) AS growth
FROM CTE_X 
	
	
	SUM()