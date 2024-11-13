--Sachin Tendulkar - Also known as little master. You are given runs scored by Sachin in his first 10 matches.
--You need to write an SQL to get match number when he completed 500 runs and his batting average at the end of 10 matches.
--Batting Average = (Total runs scored) / (no of times batsman got out)

--Round the result to 2 decimal places.
DROP TABLE IF EXISTS sachin
CREATE TABLE sachin 
(
    match_no	INT,
    runs_scored	INT,
    status	VARCHAR(512)
);

INSERT INTO sachin (match_no, runs_scored, status) VALUES ('1', '53', 'out');
INSERT INTO sachin (match_no, runs_scored, status) VALUES ('2', '59', 'not-out');
INSERT INTO sachin (match_no, runs_scored, status) VALUES ('3', '113', 'out');
INSERT INTO sachin (match_no, runs_scored, status) VALUES ('4', '29', 'out');
INSERT INTO sachin (match_no, runs_scored, status) VALUES ('5', '0', 'out');
INSERT INTO sachin (match_no, runs_scored, status) VALUES ('6', '39', 'out');
INSERT INTO sachin (match_no, runs_scored, status) VALUES ('7', '73', 'out');
INSERT INTO sachin (match_no, runs_scored, status) VALUES ('8', '149', 'out');
INSERT INTO sachin (match_no, runs_scored, status) VALUES ('9', '93', 'out');
INSERT INTO sachin (match_no, runs_scored, status) VALUES ('10', '25', 'out');

SELECT * FROM sachin

WITH total_runs AS (
SELECT match_no,SUM(runs_scored) OVER ( ORDER BY match_no
						ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS runs_per_match
FROM sachin
),match_no AS 
(
--SELECT * FROM total_runs
SELECT match_no FROM total_runs
WHERE runs_per_match > 500 AND runs_per_match < 600
  )
  SELECT * FROM match_no
  CROSS JOIN 
  (
SELECT ROUND(SUM(runs_scored*1.00)/(SELECT COUNT(status) AS no_of_times_batsman_gotout FROM sachin 
										 WHERE status = 'out'),2) AS batting_average
FROM sachin)A