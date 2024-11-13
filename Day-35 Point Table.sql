--You are given table of cricket match played in a ICC cricket tounamant with the details of winner for each match.
--You need to derive a points table using below rules.

--1- For each win a team gets 2 points. 

--2- For a loss team gets 0 points.

--3- In case of a draw both the team gets 1 points each.

CREATE TABLE  icc_world_cup  
(
    team_1	VARCHAR(512),
    team_2	VARCHAR(512),
    winner	VARCHAR(512)
);

INSERT INTO  icc_world_cup  (team_1, team_2, winner) VALUES ('India', 'SL', 'India');
INSERT INTO  icc_world_cup  (team_1, team_2, winner) VALUES ('SL', 'Aus', 'Draw');
INSERT INTO  icc_world_cup  (team_1, team_2, winner) VALUES ('SA', 'Eng', 'Eng');
INSERT INTO  icc_world_cup  (team_1, team_2, winner) VALUES ('Eng', 'NZ', 'NZ');
INSERT INTO  icc_world_cup  (team_1, team_2, winner) VALUES ('Aus', 'India', 'India');
INSERT INTO  icc_world_cup  (team_1, team_2, winner) VALUES ('Eng', 'SA', 'Draw');

SELECT * FROM icc_world_cup 

WITH CTE_A AS (
SELECT team_1 AS team_name
,CASE WHEN team_1 = winner THEN 1 ELSE 0 END AS win_flag
,CASE WHEN winner = 'Draw' THEN 1 ELSE 0 END AS draw_flag
FROM icc_world_cup

UNION ALL

SELECT team_2 AS team_name
,CASE WHEN team_2 = winner THEN 1 ELSE 0 END AS win_flag
,CASE WHEN winner = 'Draw' THEN 1 ELSE 0 END AS draw_flag
FROM icc_world_cup	
)
SELECT team_name,COUNT(*) AS match_played
,SUM(win_flag) AS no_of_wins
,COUNT(*) - SUM(win_flag) - SUM(draw_flag) AS no_of_losses
,2*SUM(win_flag)+SUM(draw_flag) AS total_points
FROM CTE_A
GROUP BY team_name
