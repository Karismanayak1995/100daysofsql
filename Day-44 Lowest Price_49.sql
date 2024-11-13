--You own a small online store, and want to analyze customer ratings for the products that you're selling. 
--After doing a data pull, you have a list of products and a log of purchases. 
--Within the purchase log, each record includes the number of stars (from 1 to 5) as a customer rating for the product.
--Specifically, you now have a database containing 2 tables - purchases and products.
--For each category, find the lowest price among all products that received at least one 4-star or above rating from customers.
--If a product category did not have any products that received at least one 4-star or above rating, the lowest price is considered to be 0.
--The final output should be sorted by product category in alphabetical order.

 
CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    category VARCHAR(50),
    price INT
);

INSERT INTO products (id, name, category, price) VALUES
(1, 'Cripps Pink', 'apple', 10),
(2, 'Navel Orange', 'orange', 12),
(3, 'Golden Delicious', 'apple', 6),
(4, 'Clementine', 'orange', 14),
(5, 'Pinot Noir', 'grape', 20),
(6, 'Bing Cherries', 'cherry', 36);
-----------------------------------------------
CREATE TABLE purchases (
    id INT PRIMARY KEY,
    product_id INT,
    stars INT,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO purchases (id, product_id, stars) VALUES
(1, 1, 2),
(2, 3, 3),
(3, 2, 2),
(4, 4, 4),
(5, 6, 5),
(6, 6, 4);
-----------------------------------------------
SELECT * FROM  products
SELECT * FROM  purchases
-----------------------------------------------
--Using CTE

WITH CTE AS (
SELECT p.id,p.name,p.category,p.price,pu.stars
FROM products P LEFT JOIN purchases pu 
ON p.id = pu.product_id
	)
SELECT category,
MAX(CASE WHEN stars > 4 or stars = 4 THEN price ELSE 0 END )AS price
FROM CTE
GROUP BY category
ORDER BY category 

-----------------------------------------------

SELECT category,COALESCE(MIN(CASE WHEN pur.product_id IS NOT NULL THEN price END),0) AS price
FROM products p
LEFT JOIN purchases pur ON p.id=pur.product_id AND pur.stars IN (4,5)
GROUP BY category
ORDER BY category;








