--You are given a history of credit card transaction data for the people of India across cities as below.
--Your task is to find out highest spend card type and lowest spent card type for each city.

-- Create the transactions table
CREATE TABLE transactions_40 (
    transaction_id INT,
    city VARCHAR(50),
    transaction_date DATE,
    card_type VARCHAR(20),
    gender CHAR(1),
    amount DECIMAL(10, 2)
);

-- Insert data into the transactions table
INSERT INTO transactions_40 (transaction_id, city, transaction_date, card_type, gender, amount) VALUES
(1, 'Delhi', '2024-01-13', 'Gold', 'F', 500),
(2, 'Bengaluru', '2024-01-13', 'Silver', 'M', 1000),
(3, 'Mumbai', '2024-01-14', 'Silver', 'F', 1200),
(4, 'Bengaluru', '2024-01-14', 'Gold', 'M', 900),
(5, 'Bengaluru', '2024-01-14', 'Gold', 'F', 300),
(6, 'Delhi', '2024-01-15', 'Silver', 'M', 200),
(7, 'Mumbai', '2024-01-15', 'Gold', 'F', 900),
(8, 'Delhi', '2024-01-15', 'Gold', 'F', 800),
(9, 'Mumbai', '2024-01-15', 'Silver', 'F', 150),
(10, 'Mumbai', '2024-01-16', 'Platinum', 'F', 1900),
(11, 'Bengaluru', '2024-01-16', 'Platinum', 'M', 1250),
(12, 'Delhi', '2024-01-16', 'Platinum', 'F', 130);

SELECT * FROM transactions_40

WITH total_transactions AS (
SELECT city,card_type,
SUM(amount) AS total_amount
,RANK() OVER (PARTITION BY city ORDER BY SUM(amount) DESC) AS rank_high,
RANK() OVER (PARTITION BY city ORDER BY SUM(amount) ASC) AS rank_low
FROM transactions_40
GROUP BY  city,card_type
ORDER BY city
	)
SELECT city
,MAX(CASE WHEN rank_high = 1 THEN card_type END) AS highest_expense_type
,MIN(CASE WHEN rank_low = 1 THEN card_type END) AS lowest_expense_type
FROM total_transactions
GROUP BY city

