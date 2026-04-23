CREATE TABLE employees_13 (
    emp_id        INT PRIMARY KEY,
    full_name     VARCHAR(100),
    hire_date     DATE,
    birth_date    DATE,
    last_login    TIMESTAMP,
    contract_end  DATE         -- NULL if permanent
);

CREATE TABLE projects_13 (
    project_id    INT PRIMARY KEY,
    emp_id        INT,
    project_name  VARCHAR(100),
    start_date    DATE,
    end_date      DATE,
    status        VARCHAR(20)  -- 'completed', 'ongoing', 'delayed'
);

-- Employees
INSERT INTO employees_13 VALUES
(1,  'Arjun Sharma',  '2018-03-15', '1990-05-20', '2024-10-01 09:30:00', NULL),
(2,  'Priya Reddy',   '2019-07-22', '1992-11-15', '2024-09-15 14:45:00', '2024-12-31'),
(3,  'Kiran Mehta',   '2020-01-10', '1988-03-08', '2024-08-20 11:00:00', '2025-06-30'),
(4,  'Sneha Iyer',    '2017-11-05', '1995-07-25', '2024-11-01 16:20:00', '2024-10-31'),
(5,  'Ravi Kumar',    '2021-05-19', '1993-01-12', '2024-07-10 08:15:00', NULL),
(6,  'Divya Nair',    '2016-09-30', '1991-09-30', '2024-10-25 10:30:00', '2025-03-31'),
(7,  'Amit Joshi',    '2022-02-14', '1994-12-05', '2024-11-05 13:00:00', NULL),
(8,  'Neha Gupta',    '2023-06-25', '1996-04-18', '2024-06-01 09:45:00', '2025-12-31'),
(9,  'Suresh Babu',   '2015-08-11', '1987-08-11', '2024-10-30 17:30:00', NULL),
(10, 'Kavya Menon',   '2020-04-05', '1992-02-28', '2024-11-08 12:00:00', '2024-11-30'),
(11, 'Rohit Verma',   '2018-12-01', '1993-06-15', '2024-04-15 10:15:00', NULL),
(12, 'Lakshmi Rao',   '2019-03-18', '1990-10-22', '2024-11-02 15:45:00', '2025-09-30');

-- Projects
INSERT INTO projects_13 VALUES
(1,  1,  'Alpha Launch',      '2024-01-01', '2024-03-31', 'completed'),
(2,  2,  'Beta Rollout',      '2024-02-15', '2024-06-30', 'completed'),
(3,  3,  'Gamma Pipeline',    '2024-03-10', '2024-09-10', 'complete'),
(4,  4,  'Delta Migration',   '2024-04-01', '2024-07-31', 'completed'),
(5,  5,  'Epsilon Platform',  '2024-05-20', '2024-12-31', 'ongoing'),
(6,  6,  'Zeta Upgrade',      '2024-01-15', '2024-04-15', 'completed'),
(7,  7,  'Eta Dashboard',     '2024-06-01', '2024-11-30', 'ongoing'),
(8,  8,  'Theta API',         '2024-07-10', '2025-01-10', 'ongoing'),
(9,  9,  'Iota Security',     '2024-02-01', '2024-05-01', 'completed'),
(10, 10, 'Kappa Analytics',   '2024-08-01', '2024-10-31', 'delayed'),
(11, 11, 'Lambda ML Model',   '2024-03-15', '2024-08-15', 'completed'),
(12, 12, 'Mu Data Pipeline',  '2024-09-01', '2025-02-28', 'ongoing');


-- Part 1 — Employee tenure
-- Show each employee's tenure details:
-- emp_name      hire_date     years_of_service      months_of_service    day_of_week_hired
--  Arjun        2018-03-15        6                       72                 Thursday

-- Part 2 — Age & birthday
-- emp_name    birth_date      age        birth_month       days_until_next_birthday
--  Arjun       1990-05-20     34             May                 37

-- Part 3 — Contract expiry
-- For employees with a contract end date, show:
-- emp_name    contract_end     days_remaining      status
--  Priya        2024-12-31          45         'Expiring Soon' if ≤ 90 days, 'Active' if > 90, 'Expired' if past

-- Part 4 — Project duration analysis
-- project_name      start_date     end_date      duration_days  duration_months   which_quarter
--  Alpha             2024-01-01     2024-03-31       90                 3             Q1

-- Part 5 — Last login analysis
-- emp_name    last_login     login_date     login_time     days_since_login    active_status
-- Arjun       2024-11-01     2024-11-01       09:30:00          12             'Active' if ≤ 30 days, 'Inactive' if > 30
--              09:30:00
---------------------
SELECT * FROM employees_13;
SELECT * FROM projects_13;


-- Part 1 — Tenure
SELECT full_name AS emp_name,
       hire_date,
       EXTRACT(YEAR FROM AGE(CURRENT_DATE, hire_date))  AS years_of_service,
       EXTRACT(YEAR FROM AGE(CURRENT_DATE, hire_date)) * 12
       + EXTRACT(MONTH FROM AGE(CURRENT_DATE, hire_date)) AS months_of_service,
       TO_CHAR(hire_date, 'Day')                         AS day_of_week_hired
FROM employees_13;

-- Part 2 — Age & birthday
SELECT full_name AS emp_name,
       birth_date,
       EXTRACT(YEAR FROM AGE(CURRENT_DATE, birth_date))  AS age,
       TO_CHAR(birth_date, 'Month')                      AS birth_month,
       CASE
           WHEN MAKE_DATE(
                    EXTRACT(YEAR FROM CURRENT_DATE)::INT,
                    EXTRACT(MONTH FROM birth_date)::INT,
                    EXTRACT(DAY FROM birth_date)::INT
                ) >= CURRENT_DATE
           THEN MAKE_DATE(
                    EXTRACT(YEAR FROM CURRENT_DATE)::INT,
                    EXTRACT(MONTH FROM birth_date)::INT,
                    EXTRACT(DAY FROM birth_date)::INT
                ) - CURRENT_DATE
           ELSE MAKE_DATE(
                    EXTRACT(YEAR FROM CURRENT_DATE)::INT + 1,
                    EXTRACT(MONTH FROM birth_date)::INT,
                    EXTRACT(DAY FROM birth_date)::INT
                ) - CURRENT_DATE
       END                                               AS days_until_next_birthday
FROM employees_13;

-- Part 3 — Contract expiry
SELECT full_name AS emp_name,
       contract_end,
       contract_end - CURRENT_DATE                       AS days_remaining,
       CASE
           WHEN contract_end < CURRENT_DATE              THEN 'Expired'
           WHEN contract_end - CURRENT_DATE <= 90        THEN 'Expiring Soon'
           ELSE 'Active'
       END                                               AS status
FROM employees_13
WHERE contract_end IS NOT NULL;

-- Part 4 — Project duration
SELECT project_name,
       start_date,
       end_date,
       end_date - start_date                             AS duration_days,
       EXTRACT(YEAR FROM AGE(end_date, start_date)) * 12
       + EXTRACT(MONTH FROM AGE(end_date, start_date))   AS duration_months,
       'Q' || EXTRACT(QUARTER FROM start_date)           AS which_quarter
FROM projects_13;

-- Part 5 — Last login analysis
SELECT full_name AS emp_name,
       last_login,
       last_login::DATE                                  AS login_date,
       last_login::TIME                                  AS login_time,
       CURRENT_DATE - last_login::DATE                   AS days_since_login,
       CASE
           WHEN CURRENT_DATE - last_login::DATE <= 30   THEN 'Active'
           ELSE 'Inactive'
       END                                               AS active_status
FROM employees_13;