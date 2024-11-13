SELECT * FROM lifts
SELECT * FROM lift_passengers


WITH total_weight AS (
SELECT l.id,l.capacity_kg,lp.passenger_name
,sum(lp.weight_kg) OVER(PARTITION BY lp.lift_id  ORDER BY lp.weight_kg 
						ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS weight_per_lift
FROM lift_passengers lp 
INNER JOIN lifts l
ON lp.lift_id = l.id
	) 
--SELECT * FROM total_weight	
SELECT id,STRING_AGG(passenger_name,',') AS passenger_list
FROM total_weight	
WHERE weight_per_lift < capacity_kg
GROUP BY id