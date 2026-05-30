🔥 5. User Retention by Day


CREATE TABLE app_events_27_05 (
    user_id INT,
    event_date DATE
);

INSERT INTO app_events_27_05 VALUES
(1, '2024-01-01'),
(1, '2024-01-02'),
(1, '2024-01-05'),
(2, '2024-01-01'),
(2, '2024-01-03'),
(3, '2024-01-02'),
(3, '2024-01-03');


Problem

👉 Calculate Day-1 retention.

Formula:

Retention Rate=  Users active on Day 1 and Day 2 × 100 / Users active on Day 1 

SELECT * FROM app_events_27_05;

WITH firstday AS (
    SELECT 
        user_id,
        MIN(event_date) AS first_day
    FROM app_events_27_05
    GROUP BY user_id
),
retention AS (
    SELECT 
        f.user_id,
        f.first_day,
        a.event_date AS came_back_on
    FROM firstday f
    LEFT JOIN app_events_27_05 a
        ON  f.user_id    = a.user_id                         
        AND a.event_date = f.first_day + INTERVAL '1 day'   
)
SELECT 
    ROUND(
        COUNT(came_back_on) * 100.0 / COUNT(user_id), 2
    ) AS retention_rate
FROM retention;