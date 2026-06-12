🔥 10. Cancellation Rate (Uber Style)

Tables

CREATE TABLE trips_04_06 (
    trip_id INT,
    rider_id INT,
    driver_id INT,
    status VARCHAR(20),
    trip_date DATE
);

INSERT INTO trips_04_06 VALUES
(1, 101, 201, 'completed', '2024-01-01'),
(2, 102, 202, 'cancelled', '2024-01-01'),
(3, 103, 203, 'completed', '2024-01-01'),
(4, 104, 204, 'cancelled', '2024-01-02'),
(5, 105, 205, 'completed', '2024-01-02');

Problem

👉 Calculate cancellation percentage per day.

Formula:

Cancellation Rate= Total Trips * 100 / Cancelled Trips

SELECT * FROM trips_04_06;

WITH trips AS (
	SELECT trip_date,
	COUNT(*) AS Total_Trips
	FROM trips_04_06
	GROUP BY trip_date
	),cancel_trips AS (
		SELECT trip_date,
		COUNT(*) Cancelled_Trips
		FROM trips_04_06
		WHERE status = 'cancelled'
		GROUP BY trip_date
	)
SELECT t.trip_date,
ROUND(
	COALESCE(c.Cancelled_Trips,0) * 100.0 / t.Total_Trips
	,2
) AS Cancellation_Rate
FROM trips t
LEFT JOIN cancel_trips c
ON t.trip_date = c.trip_date
ORDER BY trip_date;