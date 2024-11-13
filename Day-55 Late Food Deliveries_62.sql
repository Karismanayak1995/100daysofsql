--You're analyzing the efficiency of food delivery on Zomato, focusing on the late deliveries.
--Total food delivery time for an order is a combination of food preparation time + time taken by rider to deliver the order. 
--Expected Food preparation minute is half of the expected delivery minute.
--Suppose that as per expected time of delivery there is equal time allocated to restaurant for food preparation and rider to deliver the order.  
--Write an SQL to find orders which got delayed just because of more than expected time taken by the rider. 
--------------------------------
-- Create the orders table
CREATE TABLE Orders_62 (
    order_id INT PRIMARY KEY,
    restaurant_id INT,
    order_time TIME,
    expected_delivery_time TIME,
    actual_delivery_time TIME,
    rider_delivery_mins INT
);

-- Insert data into the orders table
INSERT INTO Orders_62 (order_id, restaurant_id, order_time, expected_delivery_time, actual_delivery_time, rider_delivery_mins) VALUES
(1, 101, '12:00:00', '12:30:00', '12:25:00', 18),
(2, 102, '12:15:00', '12:40:00', '12:55:00', 30),
(3, 103, '12:30:00', '13:05:00', '13:10:00', 15),
(4, 101, '12:45:00', '13:12:00', '13:21:00', 5),
(5, 102, '13:00:00', '13:30:00', '13:36:00', 10),
(6, 103, '13:15:00', '13:45:00', '13:58:00', 29),
(7, 101, '13:30:00', '14:00:00', '14:12:00', 20),
(8, 102, '13:45:00', '14:20:00', '14:25:00', 10),
(9, 103, '14:00:00', '14:32:00', '14:32:00', 5),
(10, 101, '14:15:00', '14:50:00', '15:05:00', 18);

SELECT * FROM orders_62

WITH CTE AS (
	SELECT order_id,
           EXTRACT (MINUTE FROM (actual_delivery_time - order_time)) AS actual_delivery_mins,
           EXTRACT (MINUTE FROM (expected_delivery_time - order_time)) AS expected_delivery_mins ,
	       rider_delivery_mins,
	       EXTRACT (MINUTE FROM (actual_delivery_time - order_time)) - rider_delivery_mins AS food_prep_mins,
	       ROUND(EXTRACT (MINUTE FROM (expected_delivery_time - order_time))/2,1) AS expected_food_prep_mins
    FROM   orders_62 
	WHERE actual_delivery_time > expected_delivery_time
	)
SELECT	order_id,
        expected_delivery_mins,
		rider_delivery_mins,
		food_prep_mins
FROM CTE		
WHERE food_prep_mins <= expected_food_prep_mins 


