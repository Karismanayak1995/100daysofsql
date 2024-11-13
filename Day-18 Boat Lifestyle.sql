--boAt Lifestyle is focusing on influencer marketing to build and scale their brand. 
--They want to partner with power creators for their upcoming campaigns. 
--The creators should satisy below conditions to qualify :

--1- They should have 100k+ followers on atleast 2 social media platforms and

--2- They should have atleast 50k+ views on their latest YouTube video.

--Write an SQL to get creator id and name satisfying above conditions.

CREATE TABLE creators_bl 
(
    id	INT,
    name	VARCHAR(512),
    platform	VARCHAR(512),
    followers	INT
);

INSERT INTO creators_bl (id, name, platform, followers) VALUES ('100', 'Ankit', 'YouTube', '90000');
INSERT INTO creators_bl (id, name, platform, followers) VALUES ('100', 'Ankit', 'LinkedIn', '150000');
INSERT INTO creators_bl (id, name, platform, followers) VALUES ('101', 'Warikoo', 'YouTube', '500000');
INSERT INTO creators_bl (id, name, platform, followers) VALUES ('101', 'Warikoo', 'LinkedIn', '600000');
INSERT INTO creators_bl (id, name, platform, followers) VALUES ('101', 'Warikoo', 'Instagram', '800000');
INSERT INTO creators_bl (id, name, platform, followers) VALUES ('102', 'Dhruv', 'LinkedIn', '60000');
INSERT INTO creators_bl (id, name, platform, followers) VALUES ('102', 'Dhruv', 'YouTube', '900000');
INSERT INTO creators_bl (id, name, platform, followers) VALUES ('102', 'Dhruv', 'Instagram', '800000');

DROP TABLE IF EXISTS youtube_videos
CREATE TABLE youtube_videos 
(
    id	INT,
    creator_id	INT,
    publish_date	DATE,
    views	INT
);

INSERT INTO youtube_videos (id, creator_id, publish_date, views) VALUES ('1', '100', '2024-01-01', '52000');
INSERT INTO youtube_videos (id, creator_id, publish_date, views) VALUES ('2', '100', '2024-01-06', '62000');
INSERT INTO youtube_videos (id, creator_id, publish_date, views) VALUES ('3', '101', '2024-01-05', '59000');
INSERT INTO youtube_videos (id, creator_id, publish_date, views) VALUES ('4', '101', '2024-01-07', '22000');
INSERT INTO youtube_videos (id, creator_id, publish_date, views) VALUES ('5', '102', '2024-01-05', '70000');
INSERT INTO youtube_videos (id, creator_id, publish_date, views) VALUES ('6', '102', '2024-01-09', '90000');

SELECT * FROM creators_bl
SELECT * FROM youtube_videos

WITH total_followers AS(
SELECT *
,ROW_NUMBER() OVER (PARTITION BY id ORDER BY followers ) AS rn
FROM creators_bl
WHERE followers > 100000
	) 
,total_views AS(
SELECT creator_id,views,publish_date
,DENSE_RANK() OVER(PARTITION BY creator_id ORDER BY publish_date DESC ) AS rn_1
FROM youtube_videos	
WHERE views >= 50000
	) 
SELECT id,name
FROM total_followers f
INNER JOIN total_views v
ON f.id = v.creator_id
WHERE f.rn >= 2 AND v.rn_1 = 1 AND f.platform = 'YouTube'
	

