--You're working for a financial analytics company that specializes in analyzing credit card expenditures. 
--You have a dataset containing information about users' credit card expenditures across different card companies.
--Write an SQL query to find the total expenditure from other cards (excluding Mastercard) for users who hold Mastercard credit cards. 
--Display only the users for which expense from other cards together is more than mastercard expense.


DROP TABLE IF EXISTS expenditures
CREATE TABLE expenditures (
    user_name VARCHAR(50),
    card_company VARCHAR(50),
    expenditure DECIMAL(10, 2)
);

INSERT INTO expenditures (user_name, card_company, expenditure) VALUES
('user1', 'Mastercard', 1000),
('user1', 'Visa', 500),
('user1', 'RuPay', 2000),
('user2', 'Visa', 2000),
('user3', 'Mastercard', 5000),
('user3', 'Visa', 2000),
('user3', 'Slice', 500),
('user3', 'Amex', 1000),
('user4', 'Mastercard', 2000);

SELECT * FROM expenditures

WITH expense AS(
     SELECT user_name,
            SUM(CASE WHEN card_company = 'Mastercard' THEN expenditure  END ) AS mastercard_expense,
            SUM(CASE WHEN card_company != 'Mastercard' THEN expenditure ELSE 0 END ) AS othercard_epense
     FROM expenditures
     GROUP BY user_name
      )
SELECT user_name,mastercard_expense,othercard_epense
FROM expense
WHERE mastercard_expense < othercard_epense
