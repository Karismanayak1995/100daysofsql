CREATE TABLE customers_25 (
    customer_id   INT PRIMARY KEY,
    name          VARCHAR(50),
    city          VARCHAR(50),
    joined_date   DATE
);

CREATE TABLE accounts_25 (
    account_id    INT PRIMARY KEY,
    customer_id   INT,
    account_type  VARCHAR(20),  -- 'Savings', 'Current', 'Loan'
    opened_date   DATE
);

CREATE TABLE transactions_25 (
    txn_id        INT PRIMARY KEY,
    account_id    INT,
    txn_type      VARCHAR(10),  -- 'credit' or 'debit'
    amount        DECIMAL(10,2),
    txn_date      DATE
);

-- Customers
INSERT INTO customers_25 VALUES
(1,  'Arjun Sharma',   'Hyderabad', '2018-06-15'),
(2,  'Priya Reddy',    'Hyderabad', '2019-03-22'),
(3,  'Kiran Mehta',    'Mumbai',    '2020-01-10'),
(4,  'Sneha Iyer',     'Mumbai',    '2017-11-05'),
(5,  'Ravi Kumar',     'Bangalore', '2021-07-19'),
(6,  'Divya Nair',     'Bangalore', '2019-09-30'),
(7,  'Amit Joshi',     'Hyderabad', '2022-02-14'),  -- only 1 account, should be excluded
(8,  'Neha Gupta',     'Mumbai',    '2020-08-25');  -- no 2023 txns, should be excluded

-- Accounts
INSERT INTO accounts_25 VALUES
(101, 1, 'Savings',  '2018-06-20'),
(102, 1, 'Current',  '2019-01-15'),
(103, 2, 'Savings',  '2019-04-01'),
(104, 2, 'Loan',     '2020-06-10'),
(105, 3, 'Savings',  '2020-02-01'),
(106, 3, 'Current',  '2021-03-18'),
(107, 4, 'Savings',  '2017-12-01'),
(108, 4, 'Current',  '2018-05-22'),
(109, 4, 'Loan',     '2019-08-14'),
(110, 5, 'Savings',  '2021-08-01'),
(111, 5, 'Current',  '2022-01-10'),
(112, 6, 'Savings',  '2019-10-05'),
(113, 6, 'Loan',     '2020-03-22'),
(114, 7, 'Savings',  '2022-03-01'),  -- only 1 account
(115, 8, 'Savings',  '2020-09-01'),
(116, 8, 'Current',  '2021-04-15');

-- Transactions
INSERT INTO transactions_25 VALUES
-- Arjun (customer 1) — accounts 101, 102
(1001, 101, 'credit', 50000.00, '2024-01-15'),
(1002, 101, 'debit',  15000.00, '2024-03-10'),
(1003, 102, 'credit', 30000.00, '2024-06-22'),
(1004, 102, 'debit',  10000.00, '2024-09-05'),
(1005, 101, 'credit', 40000.00, '2023-04-18'),
(1006, 102, 'debit',  12000.00, '2023-08-30'),

-- Priya (customer 2) — accounts 103, 104
(1007, 103, 'credit', 70000.00, '2024-02-20'),
(1008, 103, 'debit',  25000.00, '2024-05-14'),
(1009, 104, 'credit', 20000.00, '2024-11-01'),
(1010, 104, 'debit',  5000.00,  '2024-12-10'),
(1011, 103, 'credit', 55000.00, '2023-03-05'),
(1012, 104, 'debit',  18000.00, '2023-07-19'),

-- Kiran (customer 3) — accounts 105, 106
(1013, 105, 'credit', 45000.00, '2024-03-08'),
(1014, 105, 'debit',  20000.00, '2024-07-25'),
(1015, 106, 'credit', 15000.00, '2024-10-13'),
(1016, 106, 'debit',  8000.00,  '2024-11-30'),
(1017, 105, 'credit', 38000.00, '2023-05-22'),
(1018, 106, 'debit',  10000.00, '2023-09-14'),

-- Sneha (customer 4) — accounts 107, 108, 109
(1019, 107, 'credit', 90000.00, '2024-01-30'),
(1020, 108, 'debit',  30000.00, '2024-04-17'),
(1021, 109, 'credit', 25000.00, '2024-08-09'),
(1022, 107, 'debit',  12000.00, '2024-10-21'),
(1023, 108, 'credit', 60000.00, '2023-02-11'),
(1024, 109, 'debit',  22000.00, '2023-06-28'),

-- Ravi (customer 5) — accounts 110, 111
(1025, 110, 'credit', 35000.00, '2024-02-05'),
(1026, 110, 'debit',  18000.00, '2024-06-19'),
(1027, 111, 'credit', 22000.00, '2024-09-27'),
(1028, 111, 'debit',  9000.00,  '2024-12-03'),
(1029, 110, 'credit', 28000.00, '2023-04-30'),
(1030, 111, 'debit',  11000.00, '2023-10-15'),

-- Divya (customer 6) — accounts 112, 113
(1031, 112, 'credit', 55000.00, '2024-03-22'),
(1032, 112, 'debit',  20000.00, '2024-07-08'),
(1033, 113, 'credit', 18000.00, '2024-11-14'),
(1034, 113, 'debit',  7000.00,  '2024-12-20'),
(1035, 112, 'credit', 42000.00, '2023-01-17'),
(1036, 113, 'debit',  15000.00, '2023-08-06'),

-- Amit (customer 7) — 1 account, should be excluded
(1037, 114, 'credit', 20000.00, '2024-05-10'),
(1038, 114, 'debit',  8000.00,  '2023-09-25'),

-- Neha (customer 8) — 2 accounts but NO 2023 txns, should be excluded
(1039, 115, 'credit', 30000.00, '2024-04-14'),
(1040, 116, 'debit',  12000.00, '2024-08-30');

SELECT * FROM customers_25;
SELECT * FROM accounts_25;
SELECT * FROM transactions_25;

--Write a query that returns customers who have made transactions in both 2023 and 2024, along with:
--Column                           Description  
--customer_name              Customer's name
--city                       Customer's city
--total_credited_2024        Total credited amount in 2024
--total_debited_2024         Total debited amount in 2024
--net_amount_2024            total_credited_2024 - total_debited_2024
--txn_rank                   Rank of customer by net_amount_2024 within their city (1 = highest)
--prev_year_total            Their total transaction amount (credit + debit) in 2023
--yoy_growth_pct             Year-over-year growth: ((net_amount_2024 - prev_year_total) / prev_year_total) * 100
--Only include customers whose net_amount_2024 is positive, and who have at least 2 accounts.

WITH tran_2024 AS (
SELECT c.customer_id,c.name,
c.city,t.txn_type,
t.amount as amount_2024 
FROM customers_25 c
JOIN accounts_25 a 
ON c.customer_id = a.customer_id
JOIN transactions_25 t
ON a.account_id = t.account_id
WHERE EXTRACT(YEAR FROM t.txn_date) =2024
	),credit_2024 AS(
		SELECT customer_id, name,city,
	SUM(amount_2024) AS total_credited_2024
	FROM tran_2024
	WHERE txn_type = 'credit'
	GROUP BY customer_id,name,city
	)
--SELECT * FROM credit_2024
,debited_2024 AS (
	SELECT customer_id,name,city,
	SUM(amount_2024) AS total_debited_2024
	FROM tran_2024
	WHERE txn_type = 'debit'
	GROUP BY customer_id,name,city
	),
--SELECT * FROM debited_2024;
tran_2023 AS (
    SELECT c.customer_id,
           SUM(t.amount) AS prev_year_total
    FROM customers c
    JOIN accounts_25 a ON c.customer_id = a.customer_id
    JOIN transactions_25 t ON a.account_id = t.account_id
    WHERE EXTRACT(YEAR FROM t.txn_date) = 2023
    GROUP BY c.customer_id
),
-- customers with at least 2 accounts
multi_account AS (
    SELECT customer_id
    FROM accounts_25
    GROUP BY customer_id
    HAVING COUNT(account_id) >= 2
),net_amount AS  (
    SELECT d.customer_id,d.name,d.city,
	c.total_credited_2024,
	d.total_debited_2024,
	(c.total_credited_2024 - d.total_debited_2024) AS net_amount_2024,
	p.prev_year_total,
	ROUND(
		((c.total_credited_2024 - d.total_debited_2024)
		 - p.prev_year_total) / p.prev_year_total *100 ,2) AS yoy_growth_pct,
	DENSE_RANK() OVER (PARTITION BY d.city 
					   ORDER BY (c.total_credited_2024 - d.total_debited_2024) DESC
					  ) AS txn_rank 
	FROM debited_2024 d JOIN credit_2024 c ON d.name = c.name
    JOIN tran_2023 p  ON c.customer_id = p.customer_id   -- ✅ ensures both years
    JOIN multi_account m  ON c.customer_id = m.customer_id   -- ✅ at least 2 accounts
)

SELECT name, city, total_credited_2024, total_debited_2024,
       net_amount_2024, txn_rank, prev_year_total, yoy_growth_pct
FROM net_amount
WHERE net_amount_2024 > 0
ORDER BY city, txn_rank;
