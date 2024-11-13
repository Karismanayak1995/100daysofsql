--Suppose you are a data analyst working for a retail company, and your team is interested in analyzing customer 
--feedback to identify trends and patterns in product reviews.
--write an SQL query to find all product reviews containing the word "excellent" or "amazing" in the review text.
--However, you want to exclude reviews that contain the word "not" immediately before "excellent" or "amazing". 
--Please note that the words can be in upper or lower case or combination of both. 
--Your query should return the review_id,product_id, and review_text for each review meeting the criteria.


CREATE TABLE product_reviews 
(
    review_id	INT,
    product_id	INT,
    review_text	VARCHAR(512)
);

INSERT INTO product_reviews (review_id, product_id, review_text) VALUES ('1', '101', 'The product is excellent!');
INSERT INTO product_reviews (review_id, product_id, review_text) VALUES ('2', '102', 'This product is Amazing.');
INSERT INTO product_reviews (review_id, product_id, review_text) VALUES ('3', '103', 'Not an excellent product.');
INSERT INTO product_reviews (review_id, product_id, review_text) VALUES ('4', '104', 'The quality is Excellent.');
INSERT INTO product_reviews (review_id, product_id, review_text) VALUES ('5', '105', 'An amazing product!');
INSERT INTO product_reviews (review_id, product_id, review_text) VALUES ('6', '106', 'This is not an amazing product.');
INSERT INTO product_reviews (review_id, product_id, review_text) VALUES ('7', '107', 'This product is not Excellent.');
INSERT INTO product_reviews (review_id, product_id, review_text) VALUES ('8', '108', 'This is a not excellent product.');
INSERT INTO product_reviews (review_id, product_id, review_text) VALUES ('9', '109', 'The product is not amazing.');
INSERT INTO product_reviews (review_id, product_id, review_text) VALUES ('10', '110', 'An excellent product, not amazing.');


SELECT * FROM product_reviews


SELECT review_id ,review_text 
FROM product_reviews
WHERE (LOWER(review_text) LIKE '%amazing%' OR  LOWER(review_text) LIKE'%excellent%' )
AND LOWER(review_text) NOT LIKE '%not amazing%' 
AND LOWER(review_text) NOT LIKE'%not excellent%';


