🔥 4. Duplicate Transactions Detection

CREATE TABLE transactions_20_05 (
    txn_id INT,
    user_id INT,
    amount INT,
    txn_time TIMESTAMP
);

INSERT INTO transactions_20_05 VALUES
(1, 101, 500, '2024-01-01 10:00:00'),
(2, 101, 500, '2024-01-01 10:03:00'),
(3, 101, 700, '2024-01-01 10:10:00'),
(4, 102, 300, '2024-01-01 11:00:00'),
(5, 102, 300, '2024-01-01 11:20:00');

Problem

👉 Detect duplicate transactions:

same user
same amount
within 5 minutes

SELECT 
    t1.txn_id           AS txn1_id,
    t2.txn_id           AS txn2_id,
    t1.user_id,
    t1.amount,
    t1.txn_time         AS time1,
    t2.txn_time         AS time2,
    EXTRACT(EPOCH FROM (t2.txn_time - t1.txn_time)) / 60 AS diff_minutes
FROM transactions_20_05 t1
JOIN transactions_20_05 t2
    ON  t1.user_id = t2.user_id        -- same user
    AND t1.amount  = t2.amount         -- same amount
    AND t1.txn_id  < t2.txn_id        -- avoid self & reverse compare
WHERE EXTRACT(EPOCH FROM (t2.txn_time - t1.txn_time)) / 60 <= 5;