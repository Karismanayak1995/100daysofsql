CREATE TABLE warehouses_31 (
    warehouse_id   INT PRIMARY KEY,
    city           VARCHAR(50),
    region         VARCHAR(30)  -- 'North', 'South', 'East', 'West'
);

CREATE TABLE orders_31 (
    order_id       INT PRIMARY KEY,
    customer_id    INT,
    warehouse_id   INT,
    order_date     DATE,
    delivery_date  DATE,
    status         VARCHAR(20),  -- 'delivered', 'returned', 'failed'
    order_value    DECIMAL(10,2)
);

CREATE TABLE delivery_agents_31 (
    agent_id       INT PRIMARY KEY,
    name           VARCHAR(50),
    warehouse_id   INT
);

CREATE TABLE deliveries_31 (
    delivery_id    INT PRIMARY KEY,
    order_id       INT,
    agent_id       INT,
    dispatch_date  DATE,
    delivery_date  DATE,
    status         VARCHAR(20)  -- 'on_time', 'late', 'failed'
);

-- Warehouses
INSERT INTO warehouses_31 VALUES
(1, 'Hyderabad', 'South'),
(2, 'Mumbai',    'West'),
(3, 'Delhi',     'North'),
(4, 'Kolkata',   'East');

-- Delivery Agents
INSERT INTO delivery_agents_31 VALUES
(1,  'Arjun Reddy',   1),
(2,  'Priya Nair',    1),
(3,  'Kiran Shah',    2),
(4,  'Sneha Kulkarni',2),
(5,  'Ravi Sharma',   3),
(6,  'Divya Singh',   3),
(7,  'Amit Das',      4),
(8,  'Neha Bose',     4),
(9,  'Suresh Pillai', 1),  -- only 3 deliveries, excluded
(10, 'Rohit Verma',   2);

-- Orders
INSERT INTO orders_31 VALUES
(101, 1001, 1, '2024-01-05', '2024-01-08', 'delivered', 2500.00),
(102, 1002, 1, '2024-01-08', '2024-01-11', 'delivered', 3200.00),
(103, 1003, 1, '2024-01-12', '2024-01-15', 'delivered', 1800.00),
(104, 1004, 1, '2024-01-15', '2024-01-19', 'delivered', 4100.00),
(105, 1005, 1, '2024-01-20', '2024-01-24', 'returned',  2200.00),
(106, 1006, 1, '2024-01-25', '2024-01-28', 'delivered', 3500.00),
(107, 1007, 1, '2024-02-01', '2024-02-04', 'delivered', 2900.00),
(108, 1008, 1, '2024-02-05', '2024-02-09', 'delivered', 1600.00),
(109, 1009, 1, '2024-02-10', '2024-02-14', 'delivered', 5200.00),
(110, 1010, 1, '2024-02-15', '2024-02-18', 'returned',  2800.00),
(111, 1011, 2, '2024-01-06', '2024-01-09', 'delivered', 3100.00),
(112, 1012, 2, '2024-01-10', '2024-01-13', 'delivered', 2700.00),
(113, 1013, 2, '2024-01-14', '2024-01-18', 'delivered', 4500.00),
(114, 1014, 2, '2024-01-19', '2024-01-22', 'delivered', 1900.00),
(115, 1015, 2, '2024-01-24', '2024-01-27', 'failed',    2300.00),
(116, 1016, 2, '2024-01-28', '2024-02-01', 'delivered', 3800.00),
(117, 1017, 2, '2024-02-03', '2024-02-06', 'delivered', 2100.00),
(118, 1018, 2, '2024-02-08', '2024-02-11', 'delivered', 4200.00),
(119, 1019, 3, '2024-01-07', '2024-01-10', 'delivered', 2800.00),
(120, 1020, 3, '2024-01-11', '2024-01-15', 'delivered', 3600.00),
(121, 1021, 3, '2024-01-16', '2024-01-20', 'delivered', 1700.00),
(122, 1022, 3, '2024-01-21', '2024-01-25', 'returned',  2900.00),
(123, 1023, 3, '2024-01-26', '2024-01-30', 'delivered', 4800.00),
(124, 1024, 3, '2024-02-02', '2024-02-06', 'delivered', 2200.00),
(125, 1025, 3, '2024-02-07', '2024-02-11', 'delivered', 3300.00),
(126, 1026, 4, '2024-01-08', '2024-01-11', 'delivered', 1500.00),
(127, 1027, 4, '2024-01-12', '2024-01-16', 'delivered', 2600.00),
(128, 1028, 4, '2024-01-17', '2024-01-21', 'delivered', 3900.00),
(129, 1029, 4, '2024-01-22', '2024-01-26', 'failed',    2100.00),
(130, 1030, 4, '2024-01-27', '2024-01-31', 'delivered', 4700.00),
(131, 1031, 4, '2024-02-01', '2024-02-05', 'delivered', 2800.00),
(132, 1032, 4, '2024-02-06', '2024-02-10', 'delivered', 3200.00);

-- Deliveries
INSERT INTO deliveries_31 VALUES
-- Arjun (agent 1) - 7 deliveries
(1001, 101, 1, '2024-01-05', '2024-01-08', 'on_time'),
(1002, 102, 1, '2024-01-08', '2024-01-11', 'on_time'),
(1003, 103, 1, '2024-01-12', '2024-01-16', 'late'),
(1004, 104, 1, '2024-01-15', '2024-01-19', 'on_time'),
(1005, 106, 1, '2024-01-25', '2024-01-28', 'on_time'),
(1006, 107, 1, '2024-02-01', '2024-02-04', 'on_time'),
(1007, 108, 1, '2024-02-05', '2024-02-10', 'late'),

-- Priya (agent 2) - 6 deliveries
(1008, 105, 2, '2024-01-20', '2024-01-25', 'late'),
(1009, 109, 2, '2024-02-10', '2024-02-14', 'on_time'),
(1010, 110, 2, '2024-02-15', '2024-02-19', 'on_time'),
(1011, 101, 2, '2024-01-05', '2024-01-08', 'on_time'),
(1012, 102, 2, '2024-01-08', '2024-01-11', 'on_time'),
(1013, 103, 2, '2024-01-12', '2024-01-15', 'on_time'),

-- Kiran (agent 3) - 6 deliveries
(1014, 111, 3, '2024-01-06', '2024-01-09', 'on_time'),
(1015, 112, 3, '2024-01-10', '2024-01-14', 'late'),
(1016, 113, 3, '2024-01-14', '2024-01-18', 'on_time'),
(1017, 114, 3, '2024-01-19', '2024-01-22', 'on_time'),
(1018, 116, 3, '2024-01-28', '2024-02-01', 'on_time'),
(1019, 117, 3, '2024-02-03', '2024-02-07', 'late'),

-- Sneha (agent 4) - 5 deliveries
(1020, 115, 4, '2024-01-24', '2024-01-28', 'late'),
(1021, 118, 4, '2024-02-08', '2024-02-11', 'on_time'),
(1022, 111, 4, '2024-01-06', '2024-01-09', 'on_time'),
(1023, 112, 4, '2024-01-10', '2024-01-13', 'on_time'),
(1024, 113, 4, '2024-01-14', '2024-01-17', 'on_time'),

-- Ravi (agent 5) - 6 deliveries
(1025, 119, 5, '2024-01-07', '2024-01-10', 'on_time'),
(1026, 120, 5, '2024-01-11', '2024-01-15', 'on_time'),
(1027, 121, 5, '2024-01-16', '2024-01-21', 'late'),
(1028, 123, 5, '2024-01-26', '2024-01-30', 'on_time'),
(1029, 124, 5, '2024-02-02', '2024-02-06', 'on_time'),
(1030, 125, 5, '2024-02-07', '2024-02-11', 'on_time'),

-- Divya (agent 6) - 5 deliveries
(1031, 122, 6, '2024-01-21', '2024-01-26', 'late'),
(1032, 119, 6, '2024-01-07', '2024-01-10', 'on_time'),
(1033, 120, 6, '2024-01-11', '2024-01-14', 'on_time'),
(1034, 121, 6, '2024-01-16', '2024-01-19', 'on_time'),
(1035, 123, 6, '2024-01-26', '2024-01-29', 'on_time'),

-- Amit (agent 7) - 6 deliveries
(1036, 126, 7, '2024-01-08', '2024-01-11', 'on_time'),
(1037, 127, 7, '2024-01-12', '2024-01-16', 'late'),
(1038, 128, 7, '2024-01-17', '2024-01-21', 'on_time'),
(1039, 130, 7, '2024-01-27', '2024-01-31', 'on_time'),
(1040, 131, 7, '2024-02-01', '2024-02-05', 'on_time'),
(1041, 132, 7, '2024-02-06', '2024-02-10', 'on_time'),

-- Neha (agent 8) - 5 deliveries
(1042, 129, 8, '2024-01-22', '2024-01-27', 'late'),
(1043, 126, 8, '2024-01-08', '2024-01-11', 'on_time'),
(1044, 127, 8, '2024-01-12', '2024-01-15', 'on_time'),
(1045, 128, 8, '2024-01-17', '2024-01-20', 'on_time'),
(1046, 130, 8, '2024-01-27', '2024-01-30', 'on_time'),

-- Suresh (agent 9) - only 3 deliveries, excluded
(1047, 101, 9, '2024-01-05', '2024-01-08', 'on_time'),
(1048, 102, 9, '2024-01-08', '2024-01-12', 'late'),
(1049, 103, 9, '2024-01-12', '2024-01-16', 'on_time'),

-- Rohit (agent 10) - 5 deliveries
(1050, 111, 10, '2024-01-06', '2024-01-09', 'on_time'),
(1051, 112, 10, '2024-01-10', '2024-01-13', 'on_time'),
(1052, 116, 10, '2024-01-28', '2024-02-02', 'late'),
(1053, 117, 10, '2024-02-03', '2024-02-06', 'on_time'),
(1054, 118, 10, '2024-02-08', '2024-02-11', 'on_time');

--Write a query that returns for each delivery agent:
--Column                           Description
--agent_name                       Agent's name
--warehouse_city                   City of their warehouse
--region                           Warehouse region
--total_deliveries                 Count of all deliveries
--on_time_rate                     on_time / total deliveries * 100
--avg_order_value                  Avg order value of their delivered orders
--total_revenue                    Sum of order values for delivered orders
--region_rank                      Rank by total_revenue within region
--avg_days_to_deliver              Avg days between dispatch_date and delivery_date
--revenue_vs_region_avg            Their total_revenue minus region average total_revenue

--Only include agents with at least 5 deliveries.

SELECT * FROM warehouses_31;
SELECT * FROM orders_31;
SELECT * FROM delivery_agents_31;
SELECT * FROM deliveries_31;


-- CTE 1: ALL delivery stats per agent (no order status filter)
WITH delivery_stats AS (
    SELECT
        da.agent_id,
        da.name          AS agent_name,
        w.city           AS warehouse_city,
        w.region,
        COUNT(d.delivery_id) AS total_deliveries,
        ROUND(
            COUNT(CASE WHEN d.status = 'on_time' THEN 1 END)
            / COUNT(*) * 100, 2
        )                AS on_time_rate,
        ROUND(
            AVG(d.delivery_date - d.dispatch_date), 2
        )                AS avg_days_to_deliver
    FROM deliveries_31 d
    JOIN delivery_agents_31 da ON d.agent_id = da.agent_id
    JOIN warehouses_31 w       ON da.warehouse_id = w.warehouse_id
    GROUP BY da.agent_id, da.name, w.city, w.region
    HAVING COUNT(d.delivery_id) >= 5        -- ✅ all deliveries counted
),
-- CTE 2: Revenue stats — only from delivered orders
revenue_stats AS (
    SELECT
        da.agent_id,
        SUM(o.order_value)        AS total_revenue,
        ROUND(AVG(o.order_value), 2) AS avg_order_value
    FROM deliveries_31 d
    JOIN orders_31 o           ON d.order_id = o.order_id
    JOIN delivery_agents_31 da ON d.agent_id = da.agent_id
    WHERE o.status = 'delivered'            -- ✅ revenue only from delivered
    GROUP BY da.agent_id
)
SELECT
    ds.agent_name,
    ds.warehouse_city,
    ds.region,
    ds.total_deliveries,
    ds.on_time_rate,
    ds.avg_days_to_deliver,
    rs.total_revenue,
    rs.avg_order_value,
    DENSE_RANK() OVER (
        PARTITION BY ds.region
        ORDER BY rs.total_revenue DESC
    )  AS region_rank,
    ROUND(
        rs.total_revenue - AVG(rs.total_revenue) OVER (
            PARTITION BY ds.region
        ), 2
    ) AS revenue_vs_region_avg
FROM delivery_stats ds
JOIN revenue_stats rs 
ON ds.agent_id = rs.agent_id
ORDER BY ds.region, region_rank;