--In some poorly designed UI applications, there's often a lack of data input restrictions. 
--For instance, in a free text field for the country, users might input variations such as 'USA,' 'United States of America,' or 'US.'
--Suppose we have survey data from individuals in the USA about their job satisfaction, rated on a scale of 1 to 5.
--Write a SQL query to count the number of respondents for each rating on the scale. 
--Additionally, include the country name in the format that occurs most frequently in that scale.


CREATE TABLE survey 
(
    name	VARCHAR(512),
    job_satisfaction	INT,
    country	VARCHAR(512)
);

INSERT INTO survey (name, job_satisfaction, country) VALUES ('Alex', '4', 'USA');
INSERT INTO survey (name, job_satisfaction, country) VALUES ('Saurabh', '5', 'US');
INSERT INTO survey (name, job_satisfaction, country) VALUES ('Mark', '4', 'United States');
INSERT INTO survey (name, job_satisfaction, country) VALUES ('Shane', '4', 'USA');
INSERT INTO survey (name, job_satisfaction, country) VALUES ('Kim', '5', 'United States');
INSERT INTO survey (name, job_satisfaction, country) VALUES ('Joe', '5', 'USA');
INSERT INTO survey (name, job_satisfaction, country) VALUES ('Mira', '5', 'United States');

SELECT * FROM survey

SELECT job_satisfaction
,CASE WHEN job_satisfaction = 4 THEN 'USA' ELSE 'United States' END AS country 
,COUNT(job_satisfaction) AS number_of_respondents
FROM survey
GROUP BY job_satisfaction
