--Suppose you are a data analyst working for a company that operates a ride-sharing platform similar to Uber. 
--Your company is interested in analyzing the performance of drivers based on their ratings and wants to
--categorize them into different performance tiers.
--write an SQL query to categorize drivers equally into three performance tiers (top, middle, and bottom) based on their average ratings.
--Drivers with the highest average ratings should be placed in the top tier,
--drivers with ratings below the top tier but above the bottom tier should be placed in the middle tier, 
--and drivers with the lowest average ratings should be placed in the bottom tier.
CREATE TABLE driver_ratings 
(
    driver_id	INT,
    avg_rating	DECIMAL(3,2)
);

INSERT INTO driver_ratings (driver_id, avg_rating) VALUES ('1', '4.8');
INSERT INTO driver_ratings (driver_id, avg_rating) VALUES ('2', '4.5');
INSERT INTO driver_ratings (driver_id, avg_rating) VALUES ('3', '3.9');
INSERT INTO driver_ratings (driver_id, avg_rating) VALUES ('4', '4.2');
INSERT INTO driver_ratings (driver_id, avg_rating) VALUES ('5', '4.7');
INSERT INTO driver_ratings (driver_id, avg_rating) VALUES ('6', '3.6');
INSERT INTO driver_ratings (driver_id, avg_rating) VALUES ('7', '4.9');
INSERT INTO driver_ratings (driver_id, avg_rating) VALUES ('8', '3.8');
INSERT INTO driver_ratings (driver_id, avg_rating) VALUES ('9', '4.4');
INSERT INTO driver_ratings (driver_id, avg_rating) VALUES ('10', '3.5');
INSERT INTO driver_ratings (driver_id, avg_rating) VALUES ('11', '4.1');
INSERT INTO driver_ratings (driver_id, avg_rating) VALUES ('12', '4.6');


SELECT * FROM driver_ratings

SELECT driver_id,avg_rating
,CASE 
     WHEN avg_rating < 5 AND avg_rating > 4.50 THEN 'Top'
     WHEN avg_rating < 4.60 AND avg_rating > 4 THEN 'Middle' 
ELSE 
    'Bottom'
END AS performance_tier
FROM driver_ratings
ORDER BY avg_rating DESC
----------------------------------------------------------
--Using NTILE() window function
SELECT driver_id,avg_rating
,CASE 
     WHEN tier = 1 THEN 'Top'
     WHEN tier = 2 THEN 'Middle' 
ELSE 
    'Bottom'
END AS performance_tier
FROM
(SELECT driver_id,avg_rating
,NTILE(3) OVER ( ORDER BY avg_rating DESC) AS tier
FROM driver_ratings
) AS ranked_driver 





