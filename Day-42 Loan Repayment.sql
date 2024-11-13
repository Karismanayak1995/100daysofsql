--You're working for a large financial institution that provides various types of loans to customers. 
--Your task is to analyze loan repayment data to assess credit risk and improve risk management strategies.
--Write an SQL to create 2 flags for each loan as per below rules:

--fully_paid_flag: 1 if the loan was fully repaid irrespective of payment date else it should be 0.

--on_time_flag : 1 if the loan was fully repaid on or before due date else 0.

-- Create the loans table
CREATE TABLE loans (
    loan_id INT PRIMARY KEY,
    customer_id INT,
    loan_amount DECIMAL(10, 2),
    due_date DATE
);

-- Insert data into the loans table
INSERT INTO loans (loan_id, customer_id, loan_amount, due_date) VALUES
    (1, 1, 5000, '2023-01-15'),
    (2, 2, 8000, '2023-02-20'),
    (3, 3, 10000, '2023-03-10'),
    (4, 4, 6000, '2023-04-05'),
    (5, 5, 7000, '2023-05-01');

-- Create the payments table
CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    loan_id INT,
    payment_date DATE,
    amount_paid DECIMAL(10, 2)
);

-- Insert data into the payments table
INSERT INTO payments (payment_id, loan_id, payment_date, amount_paid) VALUES
    (1, 1, '2023-01-10', 2000),
    (2, 1, '2023-02-10', 1500),
    (3, 2, '2023-02-20', 8000),
    (4, 3, '2023-04-20', 5000),
    (5, 4, '2023-03-15', 2000),
    (6, 4, '2023-04-02', 4000),
    (7, 5, '2023-04-02', 4000),
    (8, 5, '2023-05-02', 3000);

SELECT * FROM loans
SELECT * FROM payments

WITH CTE AS(
SELECT loan_id
,SUM(amount_paid) AS total_paid_amount
,MAX(payment_date) AS max_payment_date
FROM payments 
GROUP BY loan_id	
)
SELECT l.loan_id,l.loan_amount,l.due_date
,CASE WHEN l.loan_amount = CTE.total_paid_amount THEN 1 ELSE 0 END AS fully_paid_flag
,CASE WHEN l.loan_amount = CTE.total_paid_amount AND l.due_date >= CTE.max_payment_date THEN 1 ELSE 0 END AS on_time_flag
FROM loans l
INNER JOIN CTE ON l.loan_id = CTE.loan_id


