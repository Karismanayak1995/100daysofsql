--Suppose you are a data analyst working for Spotify (a music streaming service company) . 
--Your company is interested in analyzing user engagement with playlists and wants to identify the most popular tracks from those playlist.

--Your task is to write an SQL query to find the top 2 most popular tracks based on number of playlists they are part of. 

CREATE TABLE playlists 
(
    playlist_id	INT,
    playlist_name	VARCHAR(512)
);

INSERT INTO playlists (playlist_id, playlist_name) VALUES ('1', 'Chill Vibes');
INSERT INTO playlists (playlist_id, playlist_name) VALUES ('2', 'Morning Jams');
INSERT INTO playlists (playlist_id, playlist_name) VALUES ('3', 'Workout Beats');
INSERT INTO playlists (playlist_id, playlist_name) VALUES ('4', 'Party Mix');
INSERT INTO playlists (playlist_id, playlist_name) VALUES ('5', 'Study Playlist');
---------------------------------------------------------------------------------------

CREATE TABLE playlist_tracks 
(
    playlist_id	INT,
    track_id	INT
);

INSERT INTO playlist_tracks (playlist_id, track_id) VALUES ('1', '101');
INSERT INTO playlist_tracks (playlist_id, track_id) VALUES ('1', '102');
INSERT INTO playlist_tracks (playlist_id, track_id) VALUES ('1', '103');
INSERT INTO playlist_tracks (playlist_id, track_id) VALUES ('2', '104');
INSERT INTO playlist_tracks (playlist_id, track_id) VALUES ('2', '102');
INSERT INTO playlist_tracks (playlist_id, track_id) VALUES ('3', '104');
INSERT INTO playlist_tracks (playlist_id, track_id) VALUES ('3', '107');
INSERT INTO playlist_tracks (playlist_id, track_id) VALUES ('4', '101');
INSERT INTO playlist_tracks (playlist_id, track_id) VALUES ('4', '104');
INSERT INTO playlist_tracks (playlist_id, track_id) VALUES ('4', '110');
INSERT INTO playlist_tracks (playlist_id, track_id) VALUES ('5', '104');
INSERT INTO playlist_tracks (playlist_id, track_id) VALUES ('5', '109');
INSERT INTO playlist_tracks (playlist_id, track_id) VALUES ('5', '101');
----------------------------------------------------------------------------
DROP TABLE playlist_plays
CREATE TABLE playlist_plays 
(
    playlist_id	INT,
    user_id	VARCHAR(512)
);

INSERT INTO playlist_plays (playlist_id, user_id) VALUES ('1', 'u1');
INSERT INTO playlist_plays (playlist_id, user_id) VALUES ('1', 'u2');
INSERT INTO playlist_plays (playlist_id, user_id) VALUES ('2', 'u3');
INSERT INTO playlist_plays (playlist_id, user_id) VALUES ('3', 'u3');
INSERT INTO playlist_plays (playlist_id, user_id) VALUES ('3', 'u1');
INSERT INTO playlist_plays (playlist_id, user_id) VALUES ('1', 'u4');
INSERT INTO playlist_plays (playlist_id, user_id) VALUES ('4', 'u1');
INSERT INTO playlist_plays (playlist_id, user_id) VALUES ('4', 'u2');
INSERT INTO playlist_plays (playlist_id, user_id) VALUES ('5', 'u3');
INSERT INTO playlist_plays (playlist_id, user_id) VALUES ('5', 'u1');
-------------------------------------------------------------------------
SELECT * FROM playlists
SELECT * FROM playlist_tracks
SELECT * FROM playlist_plays

SELECT pt.track_id
,COUNT( DISTINCT pt.playlist_id) AS no_of_playlist
FROM  playlist_tracks pt
INNER JOIN playlists p ON pt.playlist_id = p.playlist_id
INNER JOIN (SELECT playlist_id FROM playlist_plays 
			GROUP BY playlist_id 
			HAVING COUNT(DISTINCT user_id) >1
		       )t ON t.playlist_id = pt.playlist_id
GROUP BY pt.track_id
ORDER BY no_of_playlist DESC
LIMIT 2 OFFSET 0





