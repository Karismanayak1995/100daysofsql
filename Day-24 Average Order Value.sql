--Write an SQL query to determine the order date with the lowest average order value (AOV) among all dates recorded in the transaction table. 
--Display the order date, its corresponding AOV, and the difference between the AOV for that date and the highest AOV for any day in the dataset.
--Round the result to 2 decimal places.

CREATE TABLE transactions_ns2 
(
    order_id	INT,
    user_id	INT,
    transaction_amount	INT,
    transaction_date	DATE
);

INSERT INTO transactions_ns2 (order_id, user_id, transaction_amount, transaction_date) VALUES ('1', '101', '50', '2024-02-24');
INSERT INTO transactions_ns2 (order_id, user_id, transaction_amount, transaction_date) VALUES ('2', '102', '75', '2024-02-24');
INSERT INTO transactions_ns2 (order_id, user_id, transaction_amount, transaction_date) VALUES ('3', '103', '100', '2024-02-25');
INSERT INTO transactions_ns2 (order_id, user_id, transaction_amount, transaction_date) VALUES ('4', '104', '30', '2024-02-26');
INSERT INTO transactions_ns2 (order_id, user_id, transaction_amount, transaction_date) VALUES ('5', '105', '200', '2024-02-27');
INSERT INTO transactions_ns2 (order_id, user_id, transaction_amount, transaction_date) VALUES ('6', '106', '50', '2024-02-27');
INSERT INTO transactions_ns2 (order_id, user_id, transaction_amount, transaction_date) VALUES ('7', '107', '150', '2024-02-27');
INSERT INTO transactions_ns2 (order_id, user_id, transaction_amount, transaction_date) VALUES ('8', '108', '80', '2024-02-29');

SELECT * FROM transactions_ns2

WITH cte_avg as(
SELECT transaction_date
,(ROUND(AVG(transaction_amount),2)) AS aov 
FROM transactions_ns2
GROUP BY transaction_date
),cte_highest_aov AS (
SELECT *
,ROW_NUMBER() OVER (ORDER BY aov) AS rn	
,LAST_VALUE(aov) OVER (ORDER BY aov ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS highest_aov
FROM cte_avg
	)
--SELECT * FROM cte_highest_aov	
SELECT transaction_date ,ROUND(aov,0) AS aov
,ROUND(highest_aov - aov,2) AS diff_from_highest_aov
from cte_highest_aov
WHERE rn = 1









