CREATE TABLE inventory (
    location_id INT,
    product_id INT,
    inventory_level INT,
    inventory_target INT
);
INSERT INTO inventory (location_id, product_id, inventory_level, inventory_target) VALUES
(1, 101, 90, 80),
(1, 102, 100, 85),
(2, 102, 90, 80),
(2, 103, 70, 95),
(2, 104, 50, 60),
(3, 103, 120, 100),
(4, 104, 90, 102);

-- Create the product_costs table
CREATE TABLE product_costs (
    product_id INT PRIMARY KEY,
    unit_cost DECIMAL(10,2)
);

-- Insert data into the product_costs table
INSERT INTO product_costs (product_id, unit_cost) VALUES
(101, 51.5),
(102, 55.5),
(103, 59),
(104, 50);


SELECT * FROM inventory
SELECT * FROM product_costs

WITH CTE AS (
SELECT  i.location_id
,SUM(i.inventory_level - i.inventory_target) AS excess_insufficient_qty
,SUM((i.inventory_level - i.inventory_target)* p.unit_cost) AS excess_insufficient_value
FROM inventory i
INNER JOIN product_costs p
ON i.product_id = p.product_id
GROUP BY i.location_id
ORDER BY i.location_id
	)
SELECT * FROM CTE

UNION ALL

SELECT 'Overall'::text AS location_id 
,SUM(excess_insufficient_qty) AS excess_insufficient_qty
,SUM(excess_insufficient_value) AS excess_insufficient_value
FROM CTE
