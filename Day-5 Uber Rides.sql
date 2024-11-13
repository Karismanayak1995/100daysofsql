--A profit ride for a Uber driver is considered when the start location and start time of a ride 
--exactly match with the previous ride's end location and end time. 

--Write an SQL to calculate total number of rides and total profit rides by each driver.


CREATE TABLE drivers 
(
    id	VARCHAR(512),
    start_time	TIME,
    end_time	TIME,
    start_loc	VARCHAR(512),
    end_loc	VARCHAR(512)
);

INSERT INTO drivers (id, start_time, end_time, start_loc, end_loc) VALUES ('dri_1', '09:00', '09:30', 'a', 'b');
INSERT INTO drivers (id, start_time, end_time, start_loc, end_loc) VALUES ('dri_1', '09:30', '10:30', 'b', 'c');
INSERT INTO drivers (id, start_time, end_time, start_loc, end_loc) VALUES ('dri_1', '11:00', '11:30', 'd', 'e');
INSERT INTO drivers (id, start_time, end_time, start_loc, end_loc) VALUES ('dri_1', '12:00', '12:30', 'f', 'g');
INSERT INTO drivers (id, start_time, end_time, start_loc, end_loc) VALUES ('dri_1', '13:30', '14:30', 'c', 'h');
INSERT INTO drivers (id, start_time, end_time, start_loc, end_loc) VALUES ('dri_2', '12:15', '12:30', 'f', 'g');
INSERT INTO drivers (id, start_time, end_time, start_loc, end_loc) VALUES ('dri_2', '13:30', '14:30', 'c', 'h');

SELECT * FROM drivers

WITH end_time_location AS(
SELECT *,
LAG(end_time,1) OVER (PARTITION BY id ORDER BY start_time) AS prev_end_time
,LAG(end_loc,1) OVER (PARTITION BY id ORDER BY start_loc) AS prev_end_location
FROM drivers	
)
--SELECT * FROM end_time_location
SELECT id
,COUNT(*) AS total_rides
,SUM(CASE WHEN start_loc = prev_end_location AND start_time = prev_end_time THEN 1 ELSE 0 END )AS profit_rides
FROM  end_time_location
GROUP BY id