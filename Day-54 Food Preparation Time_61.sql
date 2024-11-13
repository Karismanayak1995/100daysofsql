--You're analyzing the efficiency of food delivery on Zomato, focusing on the time taken by restaurants to prepare orders. 
--Total food delivery time for an order is a combination of food preparation time + time taken by rider to deliver the order. 

--Write an SQL to calculate average food preparation time(in minutes) for each restaurant . 
--Round the average to 2 decimal points and sort the output in increasing order of avg time. 
-------------------------------------------
CREATE TABLE Orders_61 (
    order_id INT PRIMARY KEY,
    restaurant_id INT,
    order_time TIME,
    expected_delivery_time TIME,
    actual_delivery_time TIME,
    rider_delivery_mins INT
);

INSERT INTO Orders_61 (order_id, restaurant_id, order_time, expected_delivery_time, actual_delivery_time, rider_delivery_mins) VALUES
(1, 101, '12:00:00', '12:30:00', '12:45:00', 15),
(2, 102, '12:15:00', '12:45:00', '12:55:00', 10),
(3, 103, '12:30:00', '13:00:00', '13:10:00', 15),
(4, 101, '12:45:00', '13:15:00', '13:21:00', 5),
(5, 102, '13:00:00', '13:30:00', '13:36:00', 10),
(6, 103, '13:15:00', '13:45:00', '13:58:00', 10),
(7, 101, '13:30:00', '14:00:00', '14:12:00', 20),
(8, 102, '13:45:00', '14:15:00', '14:25:00', 10),
(9, 103, '14:00:00', '14:30:00', '14:30:00', 5),
(10, 101, '14:15:00', '14:45:00', '15:05:00', 15);

SELECT * FROM Orders_61


WITH AvgMins AS (
	SELECT restaurant_id,
           EXTRACT(EPOCH FROM (actual_delivery_time - order_time ))/60 AS total_mins
    FROM Orders_61   
)
SELECT 	a.restaurant_id,
        ROUND(AVG(a.total_mins - o.rider_delivery_mins),2) AS avg_food_prep_mins
FROM AvgMins a INNER JOIN Orders_61 o
ON a.restaurant_id = o.restaurant_id
GROUP BY a.restaurant_id
ORDER BY avg_food_prep_mins ;
