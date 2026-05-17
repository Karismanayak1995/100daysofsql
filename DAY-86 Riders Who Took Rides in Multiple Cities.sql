-- Riders Who Took Rides in Multiple Cities (Uber-type)

CREATE TABLE rides_14_05 (
    ride_id INT,
    user_id INT,
    city VARCHAR(50),
    ride_date DATE
);

INSERT INTO rides_14_05 VALUES
(1, 101, 'Delhi', '2024-01-01'),
(2, 101, 'Mumbai', '2024-01-02'),
(3, 101, 'Delhi', '2024-01-03'),
(4, 102, 'Bangalore', '2024-01-01'),
(5, 102, 'Bangalore', '2024-01-02'),
(6, 103, 'Delhi', '2024-01-01'),
(7, 103, 'Mumbai', '2024-01-05');

👉 Find users who have taken rides in at least 2 different cities

👉 Bonus:
👉 Also return count of cities

SELECT * FROM rides_14_05;

SELECT user_id,
COUNT(*) AS no_of_rides,
COUNT(DISTINCT city) AS no_of_cities,
STRING_AGG(DISTINCT city,',') AS cities_visited
FROM rides_14_05
GROUP BY user_id
HAVING COUNT(DISTINCT city) >=2