--In the realm of global indicators and country-level assessments, it's imperative to identify the years in which certain indicators hit their lowest values for each country. 
--Leveraging a dataset provided by government, which contains indicators across multiple years for various countries.
--your task is to formulate an SQL query to find the following information:
--For each country and indicator combination, determine the year in which the indicator value was lowest, along with the corresponding indicator value.
--Sort the output by country name and indicator name.
--------------------------------------------------------------------------

CREATE TABLE country_data_63(
    country_name VARCHAR(50),
    indicator_name VARCHAR(50),
    year_2010 DECIMAL(3,2),
    year_2011 DECIMAL(3,2),
    year_2012 DECIMAL(3,2),
    year_2013 DECIMAL(3,2),
    year_2014 DECIMAL(3,2)
);

INSERT INTO country_data_63 (country_name, indicator_name, year_2010, year_2011, year_2012, year_2013, year_2014) VALUES
('United States', 'Control of Corruption', 1.26, 1.51, 1.52, 1.5, 1.46),
('United States', 'Government Effectiveness', 1.27, 1.45, 1.28, 1.25, 1.27),
('United States', 'Regulatory Quality', 1.28, 1.63, 1.63, 1.54, 1.62),
('United States', 'Rule of Law', 1.32, 1.61, 1.6, 1.54, 1.62),
('United States', 'Voice and Accountability', 1.3, 1.11, 1.13, 1.08, 1.05),
('Canada', 'Control of Corruption', 1.46, 1.61, 1.71, 1.5, 1.56),
('Canada', 'Government Effectiveness', 1.47, 1.55, 1.38, 1.35, 1.47),
('Canada', 'Regulatory Quality', 1.38, 1.73, 1.63, 1.59, 1.68),
('Canada', 'Rule of Law', 1.42, 1.71, 1.8, 1.64, 1.72),
('Canada', 'Voice and Accountability', 1.4, 1.19, 1.21, 1.16, 1.09);

SELECT * FROM country_data_63
WITH Unpivoted AS ( 
 SELECT 
        country_name,
        indicator_name,
        '2010' AS year, year_2010 AS indicator_value
    FROM country_data_63
 UNION ALL
 SELECT 
        country_name,
        indicator_name,
        '2011' AS year, year_2011 AS indicator_value
    FROM country_data_63
 UNION ALL
 SELECT 
        country_name,
        indicator_name,
        '2012' AS year, year_2012 AS indicator_value
    FROM country_data_63
UNION ALL
 SELECT 
        country_name,
        indicator_name,
        '2013' AS year, year_2013 AS indicator_value
    FROM country_data_63
	UNION ALL
 SELECT 
        country_name,
        indicator_name,
        '2014' AS year, year_2014 AS indicator_value
    FROM country_data_63
	)
,Ranking AS (
	SELECT country_name,
           indicator_name,
	       year,
	       indicator_value,
	       RANK() OVER (PARTITION BY country_name,indicator_name ORDER BY indicator_value) AS rn
	FROM Unpivoted
	)
--SELECT * FROM Minvalue	
SELECT country_name,
       indicator_name,
	   indicator_value,
		   year
FROM Ranking 
WHERE rn =1
ORDER BY country_name,
	     indicator_name;
	