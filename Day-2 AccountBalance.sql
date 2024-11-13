--You are given a list of users and their opening account balance along with the trasaction done by them. 
--Write a SQL to calculate their account balance at the end of all the transactions.
--Please note that users can do transactions among themselves as well. 


CREATE TABLE users 
(
    user_id	INT,
    username	VARCHAR(512),
    opening_balance	INT
);

INSERT INTO users (user_id, username, opening_balance) VALUES ('100', 'Ankit', '1000');
INSERT INTO users (user_id, username, opening_balance) VALUES ('101', 'Rahul', '9000');
INSERT INTO users (user_id, username, opening_balance) VALUES ('102', 'Amit', '5000');
INSERT INTO users (user_id, username, opening_balance) VALUES ('103', 'Agam', '7500');

drop table if exists transactions
CREATE TABLE transactions
(
    id	INT,
    from_userid	INT,
    to_userid	INT,
    amount	INT
);

INSERT INTO transactions (id, from_userid, to_userid, amount) VALUES ('1', '100', '102', '500');
INSERT INTO transactions (id, from_userid, to_userid, amount) VALUES ('2', '102', '101', '700');
INSERT INTO transactions (id, from_userid, to_userid, amount) VALUES ('3', '101', '102', '600');
INSERT INTO transactions (id, from_userid, to_userid, amount) VALUES ('4', '102', '100', '1500');
INSERT INTO transactions (id, from_userid, to_userid, amount) VALUES ('5', '102', '101', '800');
INSERT INTO transactions (id, from_userid, to_userid, amount) VALUES ('6', '102', '101', '300');


SELECT * FROM transactions
SELECT * FROM users u


WITH all_trans AS(
SELECT from_userid AS user_id ,-1*amount AS amount
FROM transactions
UNION ALL
SELECT to_userid ,amount AS amount
FROM transactions
	)
,total_trans AS(
SELECT user_id, SUM(amount) AS trans_amount
FROM all_trans
GROUP BY user_id
    )
-------------------------------------------------------------------------------------------
--SELECT * FROM total_trans
--As there in no trans_ampont for user_id 103 , the final balance of the user_id 103 is NULL.
--SELECT u.user_id, u.opening_balance + COALESCE(t.trans_amount,0) AS final_balance
--FROM users u
--LEFT OUTER JOIN  total_trans t
--ON u.user_id = t.user_id)
----------------------------------------------------------------------------------------------
--COALESCE() function that returns the first non-null argument.
--(Now the final balance of the user_id 103 is 7500 because the query uses zero instead of NULL 
--when calculating the final balance).

SELECT u.user_id, u.opening_balance + COALESCE(t.trans_amount,0) AS final_balance
FROM users u
LEFT OUTER JOIN  total_trans t
ON u.user_id = t.user_id


