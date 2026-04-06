--Write a query that returns for each customer:
--Column                   Description
--customer_name            Customer name
--segment                  Customer segment
--total_orders             Count of delivered orders
--total_spent              Sum of quantity * unit_price on delivered orders
--first_order_date         Date of their first delivered order
--last_order_date          Date of their most recent delivered order
--days_between             Days between first and last delivered order
--return_rate              returned / total orders * 100
--favourite_category       Category they spent the most on (delivered only)
--segment_rank             Rank by total_spent within their segment
--spend_vs_segment_avg     Their spend minus the segment average spend
--Only include customers who have at least 3 delivered orders and joined before 2024.

CREATE TABLE customers_28 (
    customer_id   INT PRIMARY KEY,
    name          VARCHAR(50),
    segment       VARCHAR(20),  -- 'Premium', 'Regular', 'New'
    joined_date   DATE
);

CREATE TABLE orders_28 (
    order_id      INT PRIMARY KEY,
    customer_id   INT,
    order_date    DATE,
    status        VARCHAR(20)   -- 'delivered', 'returned', 'cancelled'
);

CREATE TABLE order_items_28 (
    item_id       INT PRIMARY KEY,
    order_id      INT,
    category      VARCHAR(30),
    quantity      INT,
    unit_price    DECIMAL(10,2)
);

-- Customers
INSERT INTO customers_28 VALUES
(1,  'Arjun Sharma',   'Premium', '2021-03-15'),
(2,  'Priya Reddy',    'Premium', '2020-07-22'),
(3,  'Kiran Mehta',    'Regular', '2022-01-10'),
(4,  'Sneha Iyer',     'Regular', '2021-11-05'),
(5,  'Ravi Kumar',     'Regular', '2022-05-19'),
(6,  'Divya Nair',     'New',     '2023-08-30'),
(7,  'Amit Joshi',     'Premium', '2021-02-14'),
(8,  'Neha Gupta',     'New',     '2023-06-25'),
(9,  'Suresh Babu',    'Regular', '2022-09-11'),
(10, 'Kavya Menon',    'Premium', '2024-01-05'), -- joined 2024, excluded
(11, 'Rohit Verma',    'Regular', '2022-04-18'),
(12, 'Lakshmi Rao',    'New',     '2023-07-09');

-- Orders
INSERT INTO orders_28 VALUES
-- Arjun (1) - Premium
(101, 1,  '2023-01-10', 'delivered'),
(102, 1,  '2023-03-22', 'delivered'),
(103, 1,  '2023-06-15', 'delivered'),
(104, 1,  '2023-09-08', 'delivered'),
(105, 1,  '2023-11-20', 'returned'),
(106, 1,  '2024-01-05', 'cancelled'),

-- Priya (2) - Premium
(107, 2,  '2022-05-14', 'delivered'),
(108, 2,  '2022-08-30', 'delivered'),
(109, 2,  '2023-01-18', 'delivered'),
(110, 2,  '2023-05-25', 'delivered'),
(111, 2,  '2023-10-12', 'returned'),
(112, 2,  '2024-02-08', 'delivered'),

-- Kiran (3) - Regular
(113, 3,  '2022-06-20', 'delivered'),
(114, 3,  '2022-09-15', 'delivered'),
(115, 3,  '2023-02-10', 'delivered'),
(116, 3,  '2023-07-28', 'returned'),
(117, 3,  '2023-11-05', 'cancelled'),

-- Sneha (4) - Regular
(118, 4,  '2022-03-12', 'delivered'),
(119, 4,  '2022-07-19', 'delivered'),
(120, 4,  '2022-12-25', 'delivered'),
(121, 4,  '2023-04-14', 'delivered'),
(122, 4,  '2023-08-30', 'returned'),
(123, 4,  '2024-01-22', 'delivered'),

-- Ravi (5) - Regular
(124, 5,  '2022-08-05', 'delivered'),
(125, 5,  '2023-01-14', 'delivered'),
(126, 5,  '2023-06-22', 'delivered'),
(127, 5,  '2023-10-18', 'cancelled'),

-- Divya (6) - New
(128, 6,  '2023-09-10', 'delivered'),
(129, 6,  '2023-11-25', 'delivered'),
(130, 6,  '2024-01-15', 'delivered'),
(131, 6,  '2024-03-08', 'returned'),

-- Amit (7) - Premium
(132, 7,  '2022-04-18', 'delivered'),
(133, 7,  '2022-09-05', 'delivered'),
(134, 7,  '2023-02-14', 'delivered'),
(135, 7,  '2023-07-30', 'delivered'),
(136, 7,  '2023-12-10', 'returned'),
(137, 7,  '2024-02-20', 'cancelled'),

-- Neha (8) - New - only 2 delivered, excluded
(138, 8,  '2023-08-15', 'delivered'),
(139, 8,  '2023-12-20', 'delivered'),
(140, 8,  '2024-02-10', 'returned'),

-- Suresh (9) - Regular
(141, 9,  '2022-10-05', 'delivered'),
(142, 9,  '2023-03-18', 'delivered'),
(143, 9,  '2023-08-25', 'delivered'),
(144, 9,  '2023-12-15', 'returned'),

-- Rohit (11) - Regular
(145, 11, '2022-05-22', 'delivered'),
(146, 11, '2022-10-14', 'delivered'),
(147, 11, '2023-03-30', 'delivered'),
(148, 11, '2023-09-12', 'delivered'),
(149, 11, '2024-01-28', 'cancelled'),

-- Lakshmi (12) - New
(150, 12, '2023-08-20', 'delivered'),
(151, 12, '2023-11-10', 'delivered'),
(152, 12, '2024-02-05', 'delivered'),
(153, 12, '2024-03-18', 'returned');

-- Order Items
INSERT INTO order_items_28 VALUES
-- Arjun's delivered orders (101-104)
(1001, 101, 'Electronics',  2, 5000.00),
(1002, 101, 'Clothing',     1,  800.00),
(1003, 102, 'Electronics',  1, 8000.00),
(1004, 103, 'Electronics',  1, 6000.00),
(1005, 103, 'Books',        3,  300.00),
(1006, 104, 'Electronics',  2, 4500.00),

-- Priya's delivered orders (107-110, 112)
(1007, 107, 'Clothing',     3, 1500.00),
(1008, 108, 'Clothing',     2, 2000.00),
(1009, 108, 'Beauty',       2,  800.00),
(1010, 109, 'Clothing',     4, 1200.00),
(1011, 110, 'Beauty',       3,  900.00),
(1012, 112, 'Clothing',     2, 1800.00),

-- Kiran's delivered orders (113-115)
(1013, 113, 'Books',        5,  400.00),
(1014, 114, 'Books',        3,  350.00),
(1015, 114, 'Sports',       1, 1200.00),
(1016, 115, 'Books',        4,  450.00),

-- Sneha's delivered orders (118-121, 123)
(1017, 118, 'Sports',       2, 2000.00),
(1018, 119, 'Sports',       1, 3500.00),
(1019, 120, 'Clothing',     3, 1000.00),
(1020, 121, 'Sports',       2, 2500.00),
(1021, 123, 'Sports',       1, 1800.00),

-- Ravi's delivered orders (124-126)
(1022, 124, 'Electronics',  1, 3000.00),
(1023, 125, 'Books',        4,  500.00),
(1024, 126, 'Electronics',  1, 4500.00),

-- Divya's delivered orders (128-130)
(1025, 128, 'Beauty',       3,  700.00),
(1026, 129, 'Beauty',       2,  900.00),
(1027, 130, 'Clothing',     1, 1200.00),

-- Amit's delivered orders (132-135)
(1028, 132, 'Electronics',  1, 9000.00),
(1029, 133, 'Electronics',  2, 7000.00),
(1030, 134, 'Electronics',  1, 8500.00),
(1031, 135, 'Sports',       2, 3000.00),

-- Neha's delivered orders (138-139) - excluded
(1032, 138, 'Beauty',       2,  600.00),
(1033, 139, 'Clothing',     1,  900.00),

-- Suresh's delivered orders (141-143)
(1034, 141, 'Books',        6,  300.00),
(1035, 142, 'Sports',       1, 2200.00),
(1036, 143, 'Books',        5,  400.00),

-- Rohit's delivered orders (145-148)
(1037, 145, 'Clothing',     2, 1500.00),
(1038, 146, 'Electronics',  1, 2500.00),
(1039, 147, 'Clothing',     3, 1200.00),
(1040, 148, 'Electronics',  1, 3500.00),

-- Lakshmi's delivered orders (150-152)
(1041, 150, 'Beauty',       4,  600.00),
(1042, 151, 'Beauty',       3,  800.00),
(1043, 152, 'Beauty',       2,  700.00);


SELECT * FROM customers_28;
SELECT * FROM orders_28;
SELECT * FROM order_items_28;


WITH customer_details AS (
	SELECT c.customer_id,c.name,c.segment,
    COUNT(o.order_id) AS total_orders,
    MIN(o.order_date) AS first_order_date,
    MAX(o.order_date) AS last_order_date,
    MAX(o.order_date)-MIN(o.order_date) AS days_between,
    SUM(t.quantity * t.unit_price) AS total_spent
    FROM customers_28 c
    JOIN orders_28 o
    ON c.customer_id = o.customer_id
    JOIN order_items_28 t
    ON o.order_id = t.order_id 
    WHERE o.status = 'delivered'
	AND c.joined_date < '2024-01-01'  
    GROUP BY c.customer_id,c.name,c.segment
	HAVING COUNT(DISTINCT o.order_id) >= 3 
),return_order_rate AS (
	SELECT customer_id,
	ROUND(
		COUNT(CASE WHEN status = 'returned' THEN 1 END) /
		COUNT(*) * 100 ,2
	)AS return_rate
	FROM orders_28 
	GROUP BY customer_id
),fav_category AS (
	SELECT customer_id,category 
	FROM (
		SELECT  o.customer_id ,
	    t.category,
        RANK( ) OVER (
			PARTITION BY o.customer_id 
		    ORDER BY SUM(t.quantity * t.unit_price) DESC ) AS rnk
	    FROM orders_28 o
        JOIN order_items_28 t
	    ON o.order_id =t.order_id
	    WHERE o.status = 'delivered'
	    GROUP BY  o.customer_id ,
	    t.category
	) ranked
WHERE rnk = 1
)
SELECT c.name,
c.segment,
c.total_orders,
c.total_spent,
c.first_order_date,
c.last_order_date,
c.days_between,
r.return_rate,
ROUND(
	c.total_spent - AVG(c.total_spent) OVER (PARTITION BY c.segment), 2
) AS spend_vs_segment_avg ,
DENSE_RANK() OVER (
	PARTITION BY c.segment
    ORDER BY c.total_spent DESC ) AS segment_rank
FROM customer_details c
JOIN return_order_rate r
ON c.customer_id = r.customer_id
JOIN fav_category f
ON r.customer_id = f.customer_id
ORDER BY c.segment,segment_rank




	