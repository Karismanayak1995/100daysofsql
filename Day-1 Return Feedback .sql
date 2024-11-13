For instance, if a customer named ABC has placed 4 orders and returned 3 of them, they should be included in the output. On the other hand, if a customer named XYZ has placed 5 orders but only returned 2, they should not be included in the output. Write an SQL to find list of customers along with their return percent(Round to 2 decimal places).





CREATE TABLE Flipkart_tb 
(
    order_id	INT,
    order_date	DATE,
    customer_name	VARCHAR(230),
    sales 	BIGINT
);

INSERT INTO Flipkart_tb (order_id, order_date, customer_name, sales ) VALUES ('1', '2023-01-01', 'Alexa', '1239 ');
INSERT INTO Flipkart_tb (order_id, order_date, customer_name, sales ) VALUES ('2', '2023-01-02', 'Alexa', '1239 ');
INSERT INTO Flipkart_tb (order_id, order_date, customer_name, sales ) VALUES ('3', '2023-01-03', 'Alexa', '1239 ');
INSERT INTO Flipkart_tb (order_id, order_date, customer_name, sales ) VALUES ('4', '2023-01-03', 'Alexa', '1239 ');
INSERT INTO Flipkart_tb (order_id, order_date, customer_name, sales ) VALUES ('5', '2023-01-01', 'Ramesh', '1239 ');
INSERT INTO Flipkart_tb (order_id, order_date, customer_name, sales ) VALUES ('6', '2023-01-02', 'Ramesh', '1239 ');
INSERT INTO Flipkart_tb (order_id, order_date, customer_name, sales ) VALUES ('7', '2023-01-03', 'Ramesh', '1239 ');
INSERT INTO Flipkart_tb (order_id, order_date, customer_name, sales ) VALUES ('8', '2023-01-03', 'Neha', '1239');


CREATE TABLE Flipkart_Return 
(
    order_id	INT,
    return_date 	DATE
);

INSERT INTO Flipkart_Return (order_id, return_date ) VALUES ('1', '2023-01-02 ');
INSERT INTO Flipkart_Return (order_id, return_date ) VALUES ('2', '2023-01-04 ');
INSERT INTO Flipkart_Return (order_id, return_date ) VALUES ('3', '2023-01-05 ');
INSERT INTO Flipkart_Return (order_id, return_date ) VALUES ('7', '2023-01-06');


SELECT * FROM Flipkart_tb;
SELECT * FROM Flipkart_Return;

--Solution(Using CTE)----


WITH CTE_A AS
(
SELECT Flipkart_tb.customer_name,  COUNT(Flipkart_tb.order_id) as 'Total Order',COUNT(Flipkart_Return.order_id) as 'Return Count'
--CAST (COUNT(Flipkart_Return.order_id) AS float) / CAST ( NULLIF(COUNT(Flipkart_Return.order_id),0) AS float)

FROM Flipkart_tb
LEFT JOIN Flipkart_Return ON Flipkart_tb.order_id=Flipkart_Return.order_id
GROUP BY Flipkart_tb.customer_name
)

SELECT customer_name,  CAST  (([Return Count]*1.0/[Total Order] * 1.0)*100 AS DECIMAL(4,0))      AS 'return_percent' FROM CTE_A
WHERE CAST  (([Return Count]*1.0/[Total Order] * 1.0)*100 AS DECIMAL(4,0))>=75.00

--SOLUTION 2 (Using Group BY)--------


SELECT Flipkart_tb.customer_name,  (COUNT(Flipkart_tb.order_id)*1.00/COUNT(Flipkart_Return.order_id)*1.00) as 'Return Percent'

FROM Flipkart_tb
LEFT JOIN Flipkart_Return ON Flipkart_tb.order_id=Flipkart_Return.order_id
GROUP BY Flipkart_tb.customer_name

HAVING (COUNT(Flipkart_Return.order_id)*1.00/COUNT(Flipkart_Return.order_id)*1.00)>=75;