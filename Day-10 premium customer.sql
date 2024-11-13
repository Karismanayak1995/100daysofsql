--Write an SQL to find the list of premium customers along with the number of orders 
--placed by each of them.
SELECT * FROM orders
CREATE TABLE orders (
    order_id INT,
    order_date DATE ,
    customer_name VARCHAR(50),
    sales INT
);

-- Insert the data
INSERT INTO orders (order_id, order_date, customer_name, sales) VALUES
(1, '2023-01-01', 'Alexa', 1239),
(2, '2023-01-02', 'Alexa', 1239),
(3, '2023-01-03', 'Alexa', 1239),
(4, '2023-01-03', 'Alexa', 1239),
(5, '2023-01-01', 'Ramesh', 1239),
(6, '2023-01-02', 'Ramesh', 1239),
(7, '2023-01-03', 'Ramesh', 1239),
(8, '2023-01-03', 'Neha', 1200),
(9, '2023-01-03', 'Subhash', 100),
(10, '2023-01-03', 'Subhash', 230);


WITH CTE_orders AS(
SELECT 
(COUNT(order_id)*1.00/COUNT(DISTINCT(customer_name))*1.00) AS avg_order_count
FROM orders
)
SELECT customer_name,COUNT(order_id) AS no_of_orders FROM orders
GROUP BY customer_name
HAVING COUNT(order_id)> (SELECT avg_order_count FROM CTE_orders)


	