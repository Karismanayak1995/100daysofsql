--You are given a history of credit card transaction data for the people of India across cities as below.
--Write an SQL to find percentage contribution of spends by females in each city.  Round the percentage to 2 decimal places.
SELECT * FROM transactions_40

WITH total_transactions AS(
SELECT city
,SUM(amount) AS total_spend
FROM transactions_40
GROUP BY city
),female_transactions AS(
SELECT city,gender
,SUM(amount) AS female_spend
FROM transactions_40
WHERE gender = 'F'
GROUP BY city,gender
	)
SELECT t.city,t.total_spend,f.female_spend
,ROUND((female_spend * 100 / total_spend),2) AS female_contribution
FROM total_transactions t
INNER JOIN female_transactions f
ON t.city = f.city
