--Ankur Warikoo, an influential figure in Indian social media, shares a guideline in one of his videos called the 20-6-20 rule for determining whether one can afford to buy a phone.
--The rule entails three conditions:
--1.Having enough savings to cover a 20 percent down payment.
--2.Utilizing a maximum 6-month EMI plan (no-cost) for the remaining cost.
--3.Ensuring that the monthly EMI does not exceed 20 percent of one's monthly salary.
--write an SQL to generate a list of phones (comma-separated) that each user can afford based on these criteria.


CREATE TABLE users_warikoo 
(
    user_name	VARCHAR(512),
    monthly_salary	INT,
    savings	INT
);

INSERT INTO users_warikoo (user_name, monthly_salary, savings) VALUES ('Rahul', '40000', '15000');
INSERT INTO users_warikoo (user_name, monthly_salary, savings) VALUES ('Vivek', '70000', '10000');


CREATE TABLE phones_warikoo 
(
    phone_name	VARCHAR(512),
    cost	INT
);

INSERT INTO phones_warikoo (phone_name, cost) VALUES ('iphone-12', '60000');
INSERT INTO phones_warikoo (phone_name, cost) VALUES ('oneplus-12', '50000');
INSERT INTO phones_warikoo (phone_name, cost) VALUES ('iphone-14', '70000');

SELECT * FROM users_warikoo
SELECT * FROM phones_warikoo

WITH CTE_warikoo AS(
SELECT *
,ROUND((cost*0.2),0) AS down_pay_amount
,ROUND((cost*0.8)/6 ,0) AS monthly_emi
FROM phones_warikoo
	)

SELECT u.user_name, STRING_AGG(c.phone_name,',') AS affordable_phones
FROM users_warikoo u
CROSS JOIN CTE_warikoo c
WHERE u.savings >= down_pay_amount AND 	u.monthly_salary * 0.2 >= monthly_emi
GROUP BY u.user_name

---------------------------------------------------------------------
SELECT u.user_name, STRING_AGG(p.phone_name,',') AS affordable_phones
FROM users_warikoo u
CROSS JOIN phones_warikoo p
WHERE u.savings >= (p.cost*0.2) AND u.monthly_salary * 0.2 >= (p.cost*0.8)/6 
GROUP BY u.user_name