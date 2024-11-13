--Suppose you are a data analyst working for a travel company that offers vacation rentals similar to Airbnb. 
--Your company wants to identify the top hosts with the highest average ratings for their listings in each neighborhood. 
--This information will be used to recognize exceptional hosts and potentially offer them incentives to continue providing outstanding service.
--Your task is to write an SQL query to find the top 2 hosts with the highest average ratings for their listings. 
--However, you should only consider hosts who have at least 2 listings, as hosts with fewer listings may not be representative.
--Display output in descending order of average ratings and round the average ratings to 2 decimal places.

CREATE TABLE listings 
(
    listing_id	INT,
    host_id	INT,
    neighborhood	VARCHAR(512),
    room_type	VARCHAR(512),
    price	INT,
    minimum_nights	VARCHAR(512)
);

INSERT INTO listings (listing_id, host_id, neighborhood, room_type, price, minimum_nights) VALUES ('1', '101', 'Downtown', 'Entire home/apt', '150', '2');
INSERT INTO listings (listing_id, host_id, neighborhood, room_type, price, minimum_nights) VALUES ('2', '101', 'Downtown', 'Private room', '80', '1');
INSERT INTO listings (listing_id, host_id, neighborhood, room_type, price, minimum_nights) VALUES ('3', '101', 'Downtown', 'Entire home/apt', '200', '3');
INSERT INTO listings (listing_id, host_id, neighborhood, room_type, price, minimum_nights) VALUES ('4', '102', 'Downtown', 'Entire home/apt', '120', '2');
INSERT INTO listings (listing_id, host_id, neighborhood, room_type, price, minimum_nights) VALUES ('5', '102', 'Downtown', 'Private room', '100', '1');
INSERT INTO listings (listing_id, host_id, neighborhood, room_type, price, minimum_nights) VALUES ('6', '102', 'Midtown', 'Entire home/apt', '250', '2');
INSERT INTO listings (listing_id, host_id, neighborhood, room_type, price, minimum_nights) VALUES ('7', '103', 'Midtown', 'Private room', '70', '1');
INSERT INTO listings (listing_id, host_id, neighborhood, room_type, price, minimum_nights) VALUES ('8', '103', 'Queens', 'Private room', '90', '1');
INSERT INTO listings (listing_id, host_id, neighborhood, room_type, price, minimum_nights) VALUES ('9', '104', 'Midtown', 'Private room', '170', '1');


CREATE TABLE reviews 
(
    review_id	INT,
    listing_id	INT,
    review_date	DATE,
    rating	INT
);

INSERT INTO reviews (review_id, listing_id, review_date, rating) VALUES ('1', '1', '2023-01-05', '4');
INSERT INTO reviews (review_id, listing_id, review_date, rating) VALUES ('2', '1', '2023-01-10', '5');
INSERT INTO reviews (review_id, listing_id, review_date, rating) VALUES ('3', '2', '2023-01-15', '4');
INSERT INTO reviews (review_id, listing_id, review_date, rating) VALUES ('4', '3', '2023-01-20', '5');
INSERT INTO reviews (review_id, listing_id, review_date, rating) VALUES ('5', '3', '2023-01-25', '3');
INSERT INTO reviews (review_id, listing_id, review_date, rating) VALUES ('6', '3', '2023-01-30', '4');
INSERT INTO reviews (review_id, listing_id, review_date, rating) VALUES ('7', '4', '2023-02-05', '5');
INSERT INTO reviews (review_id, listing_id, review_date, rating) VALUES ('8', '5', '2023-02-10', '4');
INSERT INTO reviews (review_id, listing_id, review_date, rating) VALUES ('9', '6', '2023-02-15', '5');
INSERT INTO reviews (review_id, listing_id, review_date, rating) VALUES ('10', '6', '2023-02-20', '4');
INSERT INTO reviews (review_id, listing_id, review_date, rating) VALUES ('11', '7', '2023-02-25', '5');
INSERT INTO reviews (review_id, listing_id, review_date, rating) VALUES ('12', '8', '2023-03-05', '5');
INSERT INTO reviews (review_id, listing_id, review_date, rating) VALUES ('13', '9', '2023-03-05', '5');

SELECT * FROM listings
SELECT * FROM reviews


WITH CTE_Y AS (
SELECT listing_id
,AVG(rating) AS rating
from reviews
GROUP BY listing_id
	)
SELECT l.host_id
,COUNT(l.listing_id) AS no_of_listings
,ROUND(AVG(r.rating),1) avg_ratings
FROM listings l
INNER JOIN CTE_Y r 
ON l.listing_id = r.listing_id
GROUP BY l.host_id
HAVING COUNT(l.listing_id) > 1
ORDER BY ROUND(AVG(r.rating),1) DESC
LIMIT 2 OFFSET 0



