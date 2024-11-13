--Income tax returns are supposed to file every year before due date announce by govt every year . 
--Goverment wants to find out people who have filed late returns or people who have completely skipped filing returns. 
--Write an SQL to list all the users along with the year for which they have done late filing or missed filing the returns.
--Create a comment column as well specifying if its a 'late return' or  'missed'.


CREATE TABLE income_tax_dates 
(
    financial_year	VARCHAR(512),
    file_start_date	DATE,
    file_due_date	DATE
);

INSERT INTO income_tax_dates (financial_year, file_start_date, file_due_date) VALUES ('FY20', '2020-05-01', '2020-08-31');
INSERT INTO income_tax_dates (financial_year, file_start_date, file_due_date) VALUES ('FY21', '2021-06-01', '2021-09-30');
INSERT INTO income_tax_dates (financial_year, file_start_date, file_due_date) VALUES ('FY22', '2022-05-05', '2022-08-29');
INSERT INTO income_tax_dates (financial_year, file_start_date, file_due_date) VALUES ('FY23', '2023-05-05', '2023-08-31');

CREATE TABLE users_it 
(
    user_id	INT,
    financial_year	VARCHAR(512),
    return_file_date	DATE
);

INSERT INTO users_it (user_id, financial_year, return_file_date) VALUES ('1', 'FY20', '2020-05-10');
INSERT INTO users_it (user_id, financial_year, return_file_date) VALUES ('1', 'FY21', '2021-10-10');
INSERT INTO users_it (user_id, financial_year, return_file_date) VALUES ('1', 'FY23', '2023-08-20');
INSERT INTO users_it (user_id, financial_year, return_file_date) VALUES ('2', 'FY20', '2020-05-15');
INSERT INTO users_it (user_id, financial_year, return_file_date) VALUES ('2', 'FY21', '2021-09-10');
INSERT INTO users_it (user_id, financial_year, return_file_date) VALUES ('2', 'FY22', '2022-08-20');
INSERT INTO users_it (user_id, financial_year, return_file_date) VALUES ('2', 'FY23', '2023-10-10');

SELECT * FROM  income_tax_dates
SELECT * FROM users_it


WITH CTE_I AS(
SELECT u.user_id,i.financial_year, i.file_due_date
FROM users_it u 
CROSS JOIN 	income_tax_dates i
GROUP BY u.user_id,i.financial_year, i.file_due_date
	) 
SELECT c.user_id,c.financial_year
,CASE WHEN  u.return_file_date > c.file_due_date THEN 'Late Return'
      ELSE 'Missed' END AS comments
FROM CTE_I c
LEFT OUTER JOIN users_it u
ON u.financial_year = c.financial_year AND u.user_id = c.user_id
WHERE  u.return_file_date > c.file_due_date OR u.return_file_date IS NULL