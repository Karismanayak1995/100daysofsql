--As an analyst at Amazon, you are responsible for ensuring the integrity of product ratings on the platform. 
--Fake ratings can distort the perception of product quality and mislead customers. To maintain trust and reliability,
--you need to identify potential fake ratings that deviate significantly from the average ratings for each product.

--Write an SQL query to identify the single rating that is farthest (in absolute value) from the average rating value for each product.
-------------------------------
CREATE TABLE product_ratings_60 (
    rating_id INT PRIMARY KEY,
    product_id INT,
    user_id INT,
    rating DECIMAL(2, 1)
);

INSERT INTO product_ratings_60 (rating_id, product_id, user_id, rating) VALUES
(1, 101, 1001, 4.5),
(2, 101, 1002, 4.8),
(3, 101, 1003, 4.9),
(4, 101, 1004, 5.0),
(5, 101, 1005, 3.2),
(6, 102, 1006, 4.7),
(7, 102, 1007, 4.0),
(8, 102, 1008, 4.1),
(9, 102, 1009, 3.8),
(10, 102, 1010, 3.9);


SELECT * FROM product_ratings_60

WITH AvgRating AS 
 (
	 SELECT product_id, AVG(rating) AS avg_rating
	 FROM product_ratings_60
	 GROUP BY product_id
 ),
  RatingDifferences AS 
  (
	 SELECT  p.rating_id,p.product_id , p.user_id, p.rating, a.avg_rating,
	         ABS(a.avg_rating - p.rating) AS rating_diff
	 FROM product_ratings_60 p INNER JOIN AvgRating a
	 ON p.product_id = a.product_id
 )
--SELECT * FROM  RatingDifferences 
  ,farthestRating AS 
  (
	  SELECT product_id ,
	  MAX(rating_diff) AS max_rating_diff
	  FROM RatingDifferences
	  GROUP BY product_id
	  )
--SELECT * FROM farthestRating	  
SELECT rd.rating_id, rd.product_id, rd.user_id, rd.rating	  
FROM RatingDifferences rd INNER JOIN farthestRating fr
ON rd.product_id = fr.product_id AND rd.rating_diff = fr.max_rating_diff
ORDER BY 
    rd.product_id;

	  
 

	 
	       

