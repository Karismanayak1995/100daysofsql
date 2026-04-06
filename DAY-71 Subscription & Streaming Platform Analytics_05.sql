CREATE TABLE users_05 (
    user_id       INT PRIMARY KEY,
    name          VARCHAR(50),
    city          VARCHAR(50),
    joined_date   DATE
);

CREATE TABLE plans_05(
    plan_id       INT PRIMARY KEY,
    plan_name     VARCHAR(30),  -- 'Basic', 'Standard', 'Premium'
    price         DECIMAL(10,2),
    duration_days INT           -- 30, 90, 365
);

CREATE TABLE subscriptions_05 (
    sub_id        INT PRIMARY KEY,
    user_id       INT,
    plan_id       INT,
    start_date    DATE,
    end_date      DATE,
    status        VARCHAR(20)   -- 'active', 'expired', 'cancelled'
);

CREATE TABLE watch_history_05 (
    watch_id      INT PRIMARY KEY,
    user_id       INT,
    content_id    INT,
    genre         VARCHAR(30),  -- 'Action', 'Drama', 'Comedy', 'Thriller', 'Horror'
    watched_date  DATE,
    watch_minutes INT
);

-- Users
INSERT INTO users_05 VALUES
(1,  'Arjun Sharma',  'Hyderabad', '2020-03-15'),
(2,  'Priya Reddy',   'Hyderabad', '2021-07-22'),
(3,  'Kiran Mehta',   'Mumbai',    '2020-01-10'),
(4,  'Sneha Iyer',    'Mumbai',    '2019-11-05'),
(5,  'Ravi Kumar',    'Bangalore', '2021-05-19'),
(6,  'Divya Nair',    'Bangalore', '2020-09-30'),
(7,  'Amit Joshi',    'Hyderabad', '2021-02-14'),
(8,  'Neha Gupta',    'Mumbai',    '2022-06-25'),  -- joined 2022, but < 2 non-cancelled, excluded
(9,  'Suresh Babu',   'Bangalore', '2020-08-11'),
(10, 'Kavya Menon',   'Hyderabad', '2023-02-05'),  -- joined 2023, excluded
(11, 'Rohit Verma',   'Mumbai',    '2021-04-18'),
(12, 'Lakshmi Rao',   'Bangalore', '2020-07-09');

-- Plans
INSERT INTO plans_05 VALUES
(1, 'Basic',    199.00,  30),
(2, 'Standard', 499.00,  90),
(3, 'Premium',  999.00, 365);

-- Subscriptions
INSERT INTO subscriptions_05 VALUES
-- Arjun (1) - Hyderabad
(101, 1, 1, '2021-01-01', '2021-01-31', 'expired'),
(102, 1, 2, '2021-02-01', '2021-04-30', 'expired'),
(103, 1, 3, '2021-05-01', '2022-04-30', 'expired'),
(104, 1, 3, '2022-05-01', '2023-04-30', 'active'),
(105, 1, 1, '2020-06-01', '2020-06-30', 'cancelled'),

-- Priya (2) - Hyderabad
(106, 2, 2, '2021-08-01', '2021-10-31', 'expired'),
(107, 2, 2, '2021-11-01', '2022-01-31', 'expired'),
(108, 2, 3, '2022-02-01', '2023-01-31', 'active'),
(109, 2, 1, '2021-07-01', '2021-07-31', 'cancelled'),

-- Kiran (3) - Mumbai
(110, 3, 1, '2020-02-01', '2020-02-29', 'expired'),
(111, 3, 2, '2020-03-01', '2020-05-31', 'expired'),
(112, 3, 3, '2020-06-01', '2021-05-31', 'expired'),
(113, 3, 3, '2021-06-01', '2022-05-31', 'active'),
(114, 3, 1, '2020-01-01', '2020-01-31', 'cancelled'),

-- Sneha (4) - Mumbai
(115, 4, 3, '2020-01-01', '2020-12-31', 'expired'),
(116, 4, 3, '2021-01-01', '2021-12-31', 'expired'),
(117, 4, 3, '2022-01-01', '2022-12-31', 'active'),
(118, 4, 2, '2019-12-01', '2020-02-29', 'cancelled'),

-- Ravi (5) - Bangalore
(119, 5, 2, '2021-06-01', '2021-08-31', 'expired'),
(120, 5, 2, '2021-09-01', '2021-11-30', 'expired'),
(121, 5, 3, '2022-01-01', '2022-12-31', 'active'),
(122, 5, 1, '2021-05-01', '2021-05-31', 'cancelled'),

-- Divya (6) - Bangalore
(123, 6, 1, '2020-10-01', '2020-10-31', 'expired'),
(124, 6, 2, '2020-11-01', '2021-01-31', 'expired'),
(125, 6, 3, '2021-02-01', '2022-01-31', 'expired'),
(126, 6, 3, '2022-02-01', '2023-01-31', 'active'),
(127, 6, 1, '2020-09-01', '2020-09-30', 'cancelled'),

-- Amit (7) - Hyderabad
(128, 7, 1, '2021-03-01', '2021-03-31', 'expired'),
(129, 7, 2, '2021-04-01', '2021-06-30', 'expired'),
(130, 7, 3, '2021-07-01', '2022-06-30', 'active'),
(131, 7, 1, '2021-02-01', '2021-02-28', 'cancelled'),

-- Neha (8) - Mumbai - all cancelled, excluded
(132, 8, 1, '2022-07-01', '2022-07-31', 'cancelled'),
(133, 8, 2, '2022-08-01', '2022-10-31', 'cancelled'),

-- Suresh (9) - Bangalore
(134, 9, 2, '2020-09-01', '2020-11-30', 'expired'),
(135, 9, 3, '2020-12-01', '2021-11-30', 'expired'),
(136, 9, 3, '2021-12-01', '2022-11-30', 'active'),
(137, 9, 1, '2020-08-01', '2020-08-31', 'cancelled'),

-- Kavya (10) - joined 2023, excluded
(138, 10, 2, '2023-03-01', '2023-05-31', 'active'),
(139, 10, 3, '2023-06-01', '2024-05-31', 'active'),

-- Rohit (11) - Mumbai
(140, 11, 1, '2021-05-01', '2021-05-31', 'expired'),
(141, 11, 2, '2021-06-01', '2021-08-31', 'expired'),
(142, 11, 3, '2021-09-01', '2022-08-31', 'active'),
(143, 11, 1, '2021-04-01', '2021-04-30', 'cancelled'),

-- Lakshmi (12) - Bangalore
(144, 12, 2, '2020-08-01', '2020-10-31', 'expired'),
(145, 12, 3, '2020-11-01', '2021-10-31', 'expired'),
(146, 12, 3, '2021-11-01', '2022-10-31', 'active'),
(147, 12, 1, '2020-07-01', '2020-07-31', 'cancelled');

-- Watch History
INSERT INTO watch_history_05 VALUES
-- Arjun (1)
(1001, 1, 201, 'Action',   '2021-06-10', 120),
(1002, 1, 202, 'Action',   '2021-07-15', 90),
(1003, 1, 203, 'Drama',    '2021-08-20', 60),
(1004, 1, 204, 'Action',   '2022-01-05', 110),
(1005, 1, 205, 'Comedy',   '2022-03-18', 45),

-- Priya (2)
(1006, 2, 206, 'Drama',    '2021-09-12', 80),
(1007, 2, 207, 'Drama',    '2021-11-25', 95),
(1008, 2, 208, 'Thriller', '2022-02-14', 70),
(1009, 2, 209, 'Drama',    '2022-05-30', 85),

-- Kiran (3)
(1010, 3, 210, 'Comedy',   '2020-07-08', 55),
(1011, 3, 211, 'Comedy',   '2020-09-22', 65),
(1012, 3, 212, 'Action',   '2021-01-14', 100),
(1013, 3, 213, 'Comedy',   '2021-08-30', 75),

-- Sneha (4)
(1014, 4, 214, 'Thriller', '2020-03-10', 90),
(1015, 4, 215, 'Thriller', '2020-07-25', 110),
(1016, 4, 216, 'Horror',   '2021-02-18', 80),
(1017, 4, 217, 'Thriller', '2022-04-05', 95),

-- Ravi (5)
(1018, 5, 218, 'Action',   '2021-07-12', 130),
(1019, 5, 219, 'Action',   '2021-10-28', 115),
(1020, 5, 220, 'Drama',    '2022-03-15', 70),
(1021, 5, 221, 'Action',   '2022-07-20', 125),

-- Divya (6)
(1022, 6, 222, 'Horror',   '2020-11-05', 85),
(1023, 6, 223, 'Horror',   '2021-04-18', 95),
(1024, 6, 224, 'Comedy',   '2021-09-30', 60),
(1025, 6, 225, 'Horror',   '2022-05-14', 90),

-- Amit (7)
(1026, 7, 226, 'Drama',    '2021-04-08', 75),
(1027, 7, 227, 'Action',   '2021-06-22', 100),
(1028, 7, 228, 'Drama',    '2022-01-10', 80),
(1029, 7, 229, 'Drama',    '2022-04-25', 90),

-- Suresh (9)
(1030, 9, 230, 'Thriller', '2020-10-15', 95),
(1031, 9, 231, 'Thriller', '2021-03-28', 105),
(1032, 9, 232, 'Action',   '2021-08-14', 85),
(1033, 9, 233, 'Thriller', '2022-02-20', 110),

-- Rohit (11)
(1034, 11, 234, 'Comedy',  '2021-06-10', 65),
(1035, 11, 235, 'Comedy',  '2021-09-25', 70),
(1036, 11, 236, 'Drama',   '2022-01-18', 55),
(1037, 11, 237, 'Comedy',  '2022-06-30', 75),

-- Lakshmi (12)
(1038, 12, 238, 'Drama',   '2020-09-12', 80),
(1039, 12, 239, 'Drama',   '2021-02-25', 90),
(1040, 12, 240, 'Horror',  '2021-07-18', 70),
(1041, 12, 241, 'Drama',   '2022-03-05', 85);


--Write a query that returns for each user:
--Column               Description
--user_name            User name
--city                 City
--total_subscriptions  Count of all subscriptions
--total_spent          Sum of plan prices for all non-cancelled subscriptions
--avg_watch_minutes    Average watch minutes per session
--total_watch_minutes  Total minutes watched
--favourite_genre      Genre they watched the most minutes in
--cancellation_rate    cancelled / total subscriptions * 100
--city_rank            Rank by total_spent within city
--spent_vs_city_avg    Their total_spent minus city average total_spent

--Only include users who have at least 2 non-cancelled subscriptions and joined before 2023.

SELECT * FROM users_05;
SELECT * FROM plans_05;
SELECT * FROM subscriptions_05;
SELECT * FROM watch_history_05;

WITH sub_stats AS (
    SELECT u.user_id, u.name, u.city,
           COUNT(s.sub_id) AS total_subscriptions,
           ROUND(
               COUNT(CASE WHEN s.status = 'cancelled' THEN 1 END)
               / COUNT(s.sub_id) * 100, 2
           ) AS cancellation_rate
    FROM users_05 u
    JOIN subscriptions_05 s ON u.user_id = s.user_id
    WHERE u.joined_date < '2023-01-01'          -- ✅ correct date format
    GROUP BY u.user_id, u.name, u.city
),
non_cancel_stats AS (
    SELECT s.user_id,
           SUM(p.price) AS total_spent
    FROM subscriptions_05 s
    JOIN plans_05 p ON s.plan_id = p.plan_id
    WHERE s.status != 'cancelled'
    GROUP BY s.user_id                           -- ✅ group by user only
    HAVING COUNT(s.sub_id) >= 2                  -- ✅ count sub_id not user_id
),
watch_stats AS (
    SELECT user_id,
           SUM(watch_minutes)        AS total_watch_minutes,
           ROUND(AVG(watch_minutes), 2) AS avg_watch_minutes
    FROM watch_history_05
    GROUP BY user_id
),
favourite_genre AS (
    SELECT user_id, genre
    FROM (
        SELECT user_id, genre,
               RANK() OVER (
                   PARTITION BY user_id          -- ✅ partition by user not genre
                   ORDER BY SUM(watch_minutes) DESC
               ) AS rnk
        FROM watch_history_05
        GROUP BY user_id, genre
    ) ranked
    WHERE rnk = 1
)
SELECT
    s.user_id,
    s.name              AS user_name,
    s.city,
    s.total_subscriptions,
    s.cancellation_rate,
    n.total_spent,
    w.total_watch_minutes,
    w.avg_watch_minutes,
    f.genre             AS favourite_genre,
    DENSE_RANK() OVER (
        PARTITION BY s.city
        ORDER BY n.total_spent DESC
    )                   AS city_rank,
    ROUND(
        n.total_spent - AVG(n.total_spent) OVER (
            PARTITION BY s.city
        ), 2
    )                   AS spent_vs_city_avg
FROM sub_stats s
JOIN non_cancel_stats n  ON s.user_id = n.user_id
JOIN watch_stats w       ON s.user_id = w.user_id
JOIN favourite_genre f   ON s.user_id = f.user_id
ORDER BY s.city, city_rank;