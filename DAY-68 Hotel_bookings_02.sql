CREATE TABLE hotels_02 (
    hotel_id     INT PRIMARY KEY,
    hotel_name   VARCHAR(50),
    city         VARCHAR(50),
    category     VARCHAR(20)  -- 'Luxury', 'Business', 'Budget'
);

CREATE TABLE customers_02 (
    customer_id  INT PRIMARY KEY,
    name         VARCHAR(50),
    membership   VARCHAR(20),  -- 'Gold', 'Silver', 'Standard'
    joined_date  DATE
);

CREATE TABLE bookings_02 (
    booking_id   INT PRIMARY KEY,
    customer_id  INT,
    hotel_id     INT,
    check_in     DATE,
    check_out    DATE,
    status       VARCHAR(20),  -- 'completed', 'cancelled', 'no_show'
    room_price   DECIMAL(10,2) -- price per night
);


INSERT INTO hotels_02 VALUES
(1, 'Taj Deccan',      'Hyderabad', 'Luxury'),
(2, 'Novotel',         'Hyderabad', 'Business'),
(3, 'Ibis Budget',     'Hyderabad', 'Budget'),
(4, 'Taj Mahal Palace','Mumbai',    'Luxury'),
(5, 'Trident',         'Mumbai',    'Business'),
(6, 'Ginger Hotel',    'Mumbai',    'Budget'),
(7, 'The Leela',       'Bangalore', 'Luxury'),
(8, 'Marriott',        'Bangalore', 'Business'),
(9, 'Ibis Styles',     'Bangalore', 'Budget'); -- only 3 completed, excluded

-- Customers
INSERT INTO customers_02 VALUES
(1,  'Arjun Sharma',  'Gold',     '2020-03-15'),
(2,  'Priya Reddy',   'Gold',     '2019-07-22'),
(3,  'Kiran Mehta',   'Silver',   '2021-01-10'),
(4,  'Sneha Iyer',    'Silver',   '2020-11-05'),
(5,  'Ravi Kumar',    'Standard', '2022-05-19'),
(6,  'Divya Nair',    'Gold',     '2021-09-30'),
(7,  'Amit Joshi',    'Silver',   '2020-02-14'),
(8,  'Neha Gupta',    'Standard', '2021-06-25'),
(9,  'Suresh Babu',   'Gold',     '2019-08-11'),
(10, 'Kavya Menon',   'Standard', '2022-04-05'),
(11, 'Rohit Verma',   'Silver',   '2021-03-18'),
(12, 'Lakshmi Rao',   'Gold',     '2020-07-09');

INSERT INTO bookings_02 VALUES
-- Taj Deccan (1) - Luxury, Hyderabad
(1001, 1,  1, '2024-01-05', '2024-01-08', 'completed',  8000.00),
(1002, 2,  1, '2024-01-12', '2024-01-15', 'completed',  8000.00),
(1003, 6,  1, '2024-01-20', '2024-01-23', 'completed',  8500.00),
(1004, 9,  1, '2024-02-01', '2024-02-05', 'completed',  8000.00),
(1005, 12, 1, '2024-02-10', '2024-02-13', 'completed',  8200.00),
(1006, 3,  1, '2024-02-18', '2024-02-20', 'cancelled',  8000.00),
(1007, 5,  1, '2024-03-01', '2024-03-03', 'no_show',    8000.00),
(1008, 1,  1, '2024-03-10', '2024-03-13', 'completed',  8500.00),

-- Novotel (2) - Business, Hyderabad
(1009, 3,  2, '2024-01-06', '2024-01-09', 'completed',  4500.00),
(1010, 4,  2, '2024-01-14', '2024-01-17', 'completed',  4500.00),
(1011, 7,  2, '2024-01-22', '2024-01-25', 'completed',  4800.00),
(1012, 11, 2, '2024-02-03', '2024-02-06', 'completed',  4500.00),
(1013, 5,  2, '2024-02-12', '2024-02-14', 'completed',  4500.00),
(1014, 8,  2, '2024-02-20', '2024-02-22', 'cancelled',  4500.00),
(1015, 10, 2, '2024-03-05', '2024-03-07', 'no_show',    4500.00),

-- Ibis Budget (3) - Budget, Hyderabad
(1016, 5,  3, '2024-01-08', '2024-01-10', 'completed',  1800.00),
(1017, 8,  3, '2024-01-15', '2024-01-17', 'completed',  1800.00),
(1018, 10, 3, '2024-01-24', '2024-01-26', 'completed',  2000.00),
(1019, 5,  3, '2024-02-05', '2024-02-07', 'completed',  1800.00),
(1020, 8,  3, '2024-02-14', '2024-02-16', 'completed',  1800.00),
(1021, 10, 3, '2024-02-22', '2024-02-24', 'cancelled',  1800.00),
(1022, 5,  3, '2024-03-08', '2024-03-10', 'no_show',    1800.00),

-- Taj Mahal Palace (4) - Luxury, Mumbai
(1023, 1,  4, '2024-01-07', '2024-01-11', 'completed',  15000.00),
(1024, 2,  4, '2024-01-15', '2024-01-18', 'completed',  15000.00),
(1025, 6,  4, '2024-01-25', '2024-01-28', 'completed',  15500.00),
(1026, 9,  4, '2024-02-05', '2024-02-09', 'completed',  15000.00),
(1027, 12, 4, '2024-02-14', '2024-02-17', 'completed',  15200.00),
(1028, 3,  4, '2024-02-22', '2024-02-24', 'cancelled',  15000.00),
(1029, 7,  4, '2024-03-05', '2024-03-08', 'completed',  15000.00),
(1030, 4,  4, '2024-03-12', '2024-03-14', 'no_show',    15000.00),

-- Trident (5) - Business, Mumbai
(1031, 4,  5, '2024-01-08', '2024-01-11', 'completed',  6000.00),
(1032, 7,  5, '2024-01-16', '2024-01-19', 'completed',  6000.00),
(1033, 11, 5, '2024-01-24', '2024-01-27', 'completed',  6200.00),
(1034, 3,  5, '2024-02-06', '2024-02-09', 'completed',  6000.00),
(1035, 8,  5, '2024-02-15', '2024-02-17', 'completed',  6000.00),
(1036, 10, 5, '2024-02-23', '2024-02-25', 'cancelled',  6000.00),
(1037, 5,  5, '2024-03-07', '2024-03-09', 'no_show',    6000.00),

-- Ginger Hotel (6) - Budget, Mumbai
(1038, 5,  6, '2024-01-09', '2024-01-11', 'completed',  2200.00),
(1039, 8,  6, '2024-01-17', '2024-01-19', 'completed',  2200.00),
(1040, 10, 6, '2024-01-26', '2024-01-28', 'completed',  2400.00),
(1041, 5,  6, '2024-02-07', '2024-02-09', 'completed',  2200.00),
(1042, 8,  6, '2024-02-16', '2024-02-18', 'completed',  2200.00),
(1043, 10, 6, '2024-02-24', '2024-02-26', 'cancelled',  2200.00),
(1044, 5,  6, '2024-03-08', '2024-03-10', 'no_show',    2200.00),

-- The Leela (7) - Luxury, Bangalore
(1045, 1,  7, '2024-01-10', '2024-01-14', 'completed',  12000.00),
(1046, 2,  7, '2024-01-18', '2024-01-22', 'completed',  12000.00),
(1047, 6,  7, '2024-01-27', '2024-01-30', 'completed',  12500.00),
(1048, 9,  7, '2024-02-08', '2024-02-12', 'completed',  12000.00),
(1049, 12, 7, '2024-02-17', '2024-02-20', 'completed',  12200.00),
(1050, 3,  7, '2024-02-25', '2024-02-27', 'cancelled',  12000.00),
(1051, 7,  7, '2024-03-08', '2024-03-11', 'no_show',    12000.00),

-- Marriott (8) - Business, Bangalore
(1052, 4,  8, '2024-01-11', '2024-01-14', 'completed',  7500.00),
(1053, 7,  8, '2024-01-19', '2024-01-22', 'completed',  7500.00),
(1054, 11, 8, '2024-01-28', '2024-01-31', 'completed',  7800.00),
(1055, 3,  8, '2024-02-09', '2024-02-12', 'completed',  7500.00),
(1056, 8,  8, '2024-02-18', '2024-02-20', 'completed',  7500.00),
(1057, 10, 8, '2024-02-26', '2024-02-28', 'cancelled',  7500.00),
(1058, 5,  8, '2024-03-09', '2024-03-11', 'no_show',    7500.00),

-- Ibis Styles (9) - Budget, Bangalore - only 3 completed, excluded
(1059, 5,  9, '2024-01-12', '2024-01-14', 'completed',  1500.00),
(1060, 8,  9, '2024-01-20', '2024-01-22', 'completed',  1500.00),
(1061, 10, 9, '2024-02-10', '2024-02-12', 'completed',  1500.00),
(1062, 5,  9, '2024-02-20', '2024-02-22', 'cancelled',  1500.00),
(1063, 8,  9, '2024-03-05', '2024-03-07', 'no_show',    1500.00);

--Write a query that returns for each hotel:
--Column                         Description
--hotel_name                     Hotel name
--city                           City
--category                       Hotel category
--total_bookings                 Count of all bookings
--completed_bookings             Count of completed bookings only
--cancellation_rate              cancelled / total bookings * 100
--total_revenue                  Sum of room_price * nights_stayed for completed bookings
--avg_revenue_per_booking        total_revenue / completed_bookings
--top_membership                Membership tier that brought the most completed bookings
--city_rank                      Rank by total_revenue within city
--revenue_vs_city_avg            Their total_revenue minus city average total_revenue

--Where nights_stayed = check_out - check_in.
--Only include hotels with at least 5 completed bookings.


SELECT * FROM hotels_02;
SELECT * FROM customers_02;
SELECT * FROM bookings_02;

WITH booking_stats AS (
    SELECT
        h.hotel_id,
        h.hotel_name,
        h.city,
        h.category,
        COUNT(b.booking_id)  AS total_bookings,
        ROUND(
            COUNT(CASE WHEN b.status = 'cancelled' THEN 1 END)
            / COUNT(b.booking_id) * 100, 2
        )                    AS cancellation_rate
    FROM hotels_02 h
    JOIN bookings_02 b ON h.hotel_id = b.hotel_id
    GROUP BY h.hotel_id, h.hotel_name, h.city, h.category
),
revenue_stats AS (
    SELECT
        h.hotel_id,
        COUNT(b.booking_id)  AS completed_bookings,
        ROUND(
            SUM(b.room_price * (b.check_out - b.check_in)), 2
        )                    AS total_revenue,
        ROUND(
            SUM(b.room_price * (b.check_out - b.check_in))
            / COUNT(b.booking_id), 2
        )                    AS avg_revenue_per_booking
    FROM hotels_02 h
    JOIN bookings_02 b ON h.hotel_id = b.hotel_id
    WHERE b.status = 'completed'
    GROUP BY h.hotel_id
    HAVING COUNT(b.booking_id) >= 5        
),
top_membership AS (
    SELECT hotel_id, membership
    FROM (
        SELECT
            b.hotel_id,
            c.membership,
            RANK() OVER (
                PARTITION BY b.hotel_id
                ORDER BY COUNT(*) DESC     
            ) AS rnk
        FROM bookings_02 b
        JOIN customers_02 c ON b.customer_id = c.customer_id
        WHERE b.status = 'completed'
        GROUP BY b.hotel_id, c.membership  
    ) ranked
    WHERE rnk = 1
)
SELECT
    bs.hotel_name,
    bs.city,
    bs.category,
    bs.total_bookings,
    bs.cancellation_rate,
    rs.completed_bookings,
    rs.total_revenue,
    rs.avg_revenue_per_booking,
    tm.membership           AS top_membership, 
    DENSE_RANK() OVER (
        PARTITION BY bs.city
        ORDER BY rs.total_revenue DESC
    )                       AS city_rank,
    ROUND(
        rs.total_revenue - AVG(rs.total_revenue) OVER (
            PARTITION BY bs.city         
        ), 2
    )                       AS revenue_vs_city_avg
FROM booking_stats bs
JOIN revenue_stats rs  ON bs.hotel_id = rs.hotel_id   
JOIN top_membership tm ON bs.hotel_id = tm.hotel_id
ORDER BY bs.city, city_rank;