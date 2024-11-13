--You are given a table of list of lifts , their maximum capacity and people along with their weight and gender who wants to enter into it.
--You need to make sure maximum people enter into the lift without lift getting overloaded but you need to give preference to female passengers first.
--For each lift find the comma separated list of people who can be accomodated. 
--The comma separated list should have female first and then people in the order of their weight in increasing order.

SELECT * FROM lifts
SELECT * FROM lift_passengerswithgender

WITH total_weight AS (
SELECT l.id,l.capacity_kg,lpg.passenger_name,lpg.gender
,sum(lpg.weight_kg) OVER(PARTITION BY lpg.lift_id  ORDER BY CASE WHEN lpg.gender = 'F' THEN 0 ELSE 1 END ,lpg.weight_kg 
						ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS weight_per_lift
FROM lift_passengerswithgender lpg 
INNER JOIN lifts l
ON lpg.lift_id = l.id
)
--SELECT * FROM total_weight
SELECT id,STRING_AGG(passenger_name,',') AS passenger_list
FROM total_weight	
WHERE weight_per_lift < capacity_kg 
GROUP BY id
