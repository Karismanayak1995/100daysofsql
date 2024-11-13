CREATE TABLE business_operations 
(
    business_date date,
    city_id	INT
);

INSERT INTO business_operations (business_date, city_id) VALUES ('2020-01-02', '3');
INSERT INTO business_operations (business_date, city_id) VALUES ('2020-07-01', '7');
INSERT INTO business_operations (business_date, city_id) VALUES ('2021-01-01', '3');
INSERT INTO business_operations (business_date, city_id) VALUES ('2021-02-03', '19');
INSERT INTO business_operations (business_date, city_id) VALUES ('2022-12-01', '3');
INSERT INTO business_operations (business_date, city_id) VALUES ('2022-12-15', '3');
INSERT INTO business_operations (business_date, city_id) VALUES ('2022-02-28', '12');

SELECT * FROM business_operations


WITH CTE_D AS(
SELECT city_id, MIN(DATE_PART('YEAR',business_date)) AS year
FROM  business_operations
GROUP BY city_id
	)
--SELECT * FROM CTE_D	
SELECT  year,COUNT (city_id) AS no_of_new_cities
FROM CTE_D
GROUP BY year
