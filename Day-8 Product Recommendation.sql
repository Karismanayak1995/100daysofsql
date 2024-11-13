--Product recommendation. Just the basic type (“customers who bought this also bought…”).
--That, in its simplest form, is an outcome of basket analysis. 
--Write a SQL to find the product pairs along with the count of times they have been purchased together. 
--Based on the history ecommerce website can recommend products to new user.

CREATE TABLE orders_pr 
(
    order_id	VARCHAR(512),
    customer_id	VARCHAR(512),
    product_id	VARCHAR(512)
);

INSERT INTO orders_pr (order_id, customer_id, product_id) VALUES ('1', '1', 'p1');
INSERT INTO orders_pr (order_id, customer_id, product_id) VALUES ('1', '1', 'p2');
INSERT INTO orders_pr (order_id, customer_id, product_id) VALUES ('1', '1', 'p3');
INSERT INTO orders_pr (order_id, customer_id, product_id) VALUES ('2', '2', 'p1');
INSERT INTO orders_pr (order_id, customer_id, product_id) VALUES ('2', '2', 'p2');
INSERT INTO orders_pr (order_id, customer_id, product_id) VALUES ('2', '2', 'p4');
INSERT INTO orders_pr (order_id, customer_id, product_id) VALUES ('3', '1', 'p5');

Select * from orders_pr

SELECT o1.product_id AS product_1,o2.product_id AS product_2
, COUNT(*) AS purchase_frequency
FROM orders_pr o1
INNER JOIN orders_pr o2 ON o1.order_id=o2.order_id 
WHERE o1.product_id>o2.product_id
GROUP BY o1.product_id,o2.product_id





