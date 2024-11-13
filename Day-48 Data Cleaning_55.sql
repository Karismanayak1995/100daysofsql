--You are a data analyst working for a transportation company that manages routes between various cities. 
--The company stores information about distances between cities in a table named city_distances. 
--Each record in the table represents the distance between a source city and a destination city.
--However, due to data entry errors or inconsistencies, there are duplicate records in the table where the source and destination cities are interchanged.
--These duplicates need to be removed to ensure data integrity and accuracy. 
--In case the distance value in the duplicate records is not same then take average of the 2 distances.
--Sort the ouput in descending order by distance.
--------------------------------------------------------------
-- Create the table
CREATE TABLE  city_distances_55 (
    source VARCHAR(255) NOT NULL,
    destination VARCHAR(255) NOT NULL,
    distance INT NOT NULL
    
);

-- Insert the data
INSERT INTO city_distances_55(source, destination, distance) VALUES
('Bangalore', 'Hyderbad', 350),
('Hyderbad', 'Bangalore', 350),
('Mumbai', 'Delhi', 400),
('Delhi', 'Mumbai', 450),
('Chennai', 'Pune', 500);
------------------------------------------
SELECT * FROM  city_distances_55

WITH cte AS (
    SELECT 
        CASE 
            WHEN source < destination THEN source 
            ELSE destination 
        END AS source,
        CASE 
            WHEN source < destination THEN destination 
            ELSE source 
        END AS destination,
        distance
    FROM city_distances_55
)
SELECT 
    source,
    destination,
    ROUND(AVG(distance),1) AS avg_distance
FROM cte
GROUP BY source, destination
ORDER BY avg_distance DESC;

