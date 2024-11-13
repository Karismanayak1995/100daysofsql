--Write an SQL query to identify dormant customers. A dormant customer is defined as a user 
--who registered more than 6 months ago from today but has not placed any orders in the last 3 months.
--Your query should return the list of dormant customers and order amount of last order placed by them. 
--If no order was placed by a customers then order amount should be 0. 


-- Create the users table
CREATE TABLE users_44 (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    registration_date DATE
);

-- Insert data into the users table
INSERT INTO users_44 (name, email, registration_date) VALUES
('John Doe', 'john@example.com', '2024-03-22'),
('Jane Smith', 'jane@example.com', '2023-10-08'),
('Alice Johnson', 'alice@example.com', '2023-08-29'),
('Bob Brown', 'bob@example.com', '2023-06-30'),
('Sania', 'sania@example.com', '2023-09-18');

-- Create the orders table
CREATE TABLE orders_44 (
    order_id SERIAL PRIMARY KEY,
    user_id INT,
    order_date DATE,
    order_amount DECIMAL(10, 2)
);

-- Insert data into the orders table
INSERT INTO orders_44 (user_id, order_date, order_amount) VALUES
(1, '2024-03-26', 150),
(2, '2024-04-05', 130),
(2, '2024-01-16', 145),
(3, '2024-01-11', 160),
(4, '2024-01-06', 125),
(4, '2024-01-04', 105);

SELECT * FROM users_44

SELECT * FROM orders_44

SELECT CURRENT_DATE - INTERVAL '3 months' AS three_months_before;

SELECT u.user_id,
COALESCE(MAX(o.order_amount), 0) AS last_order_amount
FROM users_44 u 
LEFT JOIN orders_44 o
ON u.user_id = o.user_id AND o.order_date <= CURRENT_DATE - INTERVAL '3 months' OR o.order_date IS NULL
WHERE u.registration_date <= CURRENT_DATE - INTERVAL '6 months'
GROUP BY u.user_id