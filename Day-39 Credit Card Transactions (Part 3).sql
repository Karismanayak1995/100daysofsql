--You are given a history of credit card transaction data for the people of India across cities as below.
--Write an SQL to find how many days each city took to reach cumulative spend of 1500 from its first day of transactions.
SELECT * FROM transactions_40


WITH CTE AS (
SELECT city,transaction_date
,SUM(amount) OVER (PARTITION BY city ORDER BY transaction_date) AS cumulative_amount
FROM transactions_40
)
SELECT city,
MIN(transaction_date ) AS first_transaction_date,
MIN(CASE WHEN cumulative_amount >= 1500 THEN transaction_date END) AS tran_date_1500,
DATE_PART('day', MIN(CASE WHEN cumulative_amount >= 1500 THEN transaction_date::date END)) -  DATE_PART('day',MIN(transaction_date::date)) AS no_of_days
FROM CTE 
GROUP BY city
-----------------------------------------------------------------
WITH CTE AS (
SELECT city,transaction_date
,SUM(amount) OVER (PARTITION BY city ORDER BY transaction_date) AS cumulative_amount
FROM transactions_40
)
SELECT city,
MIN(transaction_date ) AS first_transaction_date,
MIN(CASE WHEN cumulative_amount >= 1500 THEN transaction_date END) AS tran_date_1500,
    CASE WHEN MIN(CASE WHEN cumulative_amount >= 1500 THEN transaction_date END) IS NOT NULL
         THEN DATE_PART('day', MIN(CASE WHEN cumulative_amount >= 1500 THEN transaction_date::date END)) -  DATE_PART('day',MIN(transaction_date::date))
         ELSE NULL
    END AS no_of_days
FROM CTE 
GROUP BY city
-----------------------------------------------------------------------