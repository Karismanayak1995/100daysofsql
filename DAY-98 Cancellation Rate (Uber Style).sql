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