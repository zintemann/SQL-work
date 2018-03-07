## soccer data to see who played and who scored in which games using FIFA Data

CREATE DATABASE Soccer;

USE Soccer;

CREATE TABLE Matches (
i	INT(10)	,
id	INT(10)	,
country_id	INT(10)	NOT NULL,
league_id	INT(10)	NOT NULL,
season	VARCHAR(10)	,
stage	TINYINT(3)	,
match_date	DATE	,
match_api_id	INT(10)	,
home_team_api_id	INT(10)	NOT NULL,
away_team_api_id	INT(10)	NOT NULL,
home_team_goal	TINYINT(3)	,
away_team_goal	TINYINT(3)	,
home_player_X1	TINYINT(3)	,
home_player_X2	TINYINT(3)	,
home_player_X3	TINYINT(3)	,
home_player_X4	TINYINT(3)	,
home_player_X5	TINYINT(3)	,
home_player_X6	TINYINT(3)	,
home_player_X7	TINYINT(3)	,
home_player_X8	TINYINT(3)	,
home_player_X9	TINYINT(3)	,
home_player_X10	TINYINT(3)	,
home_player_X11	TINYINT(3)	,
away_player_X1	TINYINT(3)	,
away_player_X2	TINYINT(3)	,
away_player_X3	TINYINT(3)	,
away_player_X4	TINYINT(3)	,
away_player_X5	TINYINT(3)	,
away_player_X6	TINYINT(3)	,
away_player_X7	TINYINT(3)	,
away_player_X8	TINYINT(3)	,
away_player_X9	TINYINT(3)	,
away_player_X10	TINYINT(3)	,
away_player_X11	TINYINT(3)	,
home_player_Y1	INT(10)	,
home_player_Y2	INT(10)	,
home_player_Y3	INT(10)	,
home_player_Y4	INT(10)	,
home_player_Y5	INT(10)	,
home_player_Y6	INT(10)	,
home_player_Y7	INT(10)	,
home_player_Y8	INT(10)	,
home_player_Y9	INT(10)	,
home_player_Y10	INT(10)	,
home_player_Y11	INT(10)	,
away_player_Y1	INT(10)	,
away_player_Y2	INT(10)	,
away_player_Y3	INT(10)	,
away_player_Y4	INT(10)	,
away_player_Y5	INT(10)	,
away_player_Y6	INT(10)	,
away_player_Y7	INT(10)	,
away_player_Y8	INT(10)	,
away_player_Y9	INT(10)	,
away_player_Y10	INT(10)	,
away_player_Y11	INT(10)	,
home_player_1	INT(10)	,
home_player_2	INT(10)	,
home_player_3	INT(10)	,
home_player_4	INT(10)	,
home_player_5	INT(10)	,
home_player_6	INT(10)	,
home_player_7	INT(10)	,
home_player_8	INT(10)	,
home_player_9	INT(10)	,
home_player_10	INT(10)	,
home_player_11	INT(10)	,
away_player_1	INT(10)	,
away_player_2	INT(10)	,
away_player_3	INT(10)	,
away_player_4	INT(10)	,
away_player_5	INT(10)	,
away_player_6	INT(10)	,
away_player_7	INT(10)	,
away_player_8	INT(10)	,
away_player_9	INT(10)	,
away_player_10	INT(10)	,
away_player_11	INT(10)	,
goal	TEXT(65000)	,
shoton	TEXT(65000)	,
shotoff	TEXT(65000)	,
foulcommit	TEXT(65000)	,
card	TEXT(65000)	,
crosses	TEXT(65000)	,
corner	TEXT(65000)	,
possession	TEXT(65000)	,
B365H	INT(10)	,
B365D	INT(10)	,
B365A	INT(10)	,
BWH	INT(10)	,
BWD	INT(10)	,
BWA	INT(10)	,
IWH	INT(10)	,
IWD	INT(10)	,
IWA	INT(10)	,
LBH	INT(10)	,
LBD	INT(10)	,
LBA	INT(10)	,
PSH	INT(10)	,
PSD	INT(10)	,
PSA	INT(10)	,
WHH	INT(10)	,
WHD	INT(10)	,
WHA	INT(10)	,
SJH	INT(10)	,
SJD	INT(10)	,
SJA	INT(10)	,
VCH	INT(10)	,
VCD	INT(10)	,
VCA	INT(10)	,
GBH	INT(10)	,
GBD	INT(10)	,
GBA	INT(10)	,
BSH	INT(10)	,
BSD	INT(10)	,
BSA	INT(10)	,


PRIMARY KEY (
country_id	,
league_id	,
home_team_api_id	,
away_team_api_id	

)
);

LOAD DATA LOCAL INFILE 'C:/Users/rp/Documents/soccer matches.csv' INTO TABLE Matches
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
;
SELECT * FROM Matches LIMIT 20;

######FIND ZLATAN
SELECT season, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal
FROM Matches
WHERE goal LIKE '%35724%'
;

###MESSI
SELECT season, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal
FROM Matches
WHERE goal LIKE '%30981%'
;

-- Table for all matches
SELECT 
	i, id, country_id, league_id, season, stage, match_date, match_api_id, home_team_api_id,away_team_api_id,
	home_team_goal, away_team_goal, home_player_1, home_player_2,	home_player_3, home_player_4, home_player_5,
	home_player_6, home_player_7, home_player_8, home_player_9, home_player_10, home_player_11, away_player_1, away_player_2,
	away_player_3, away_player_4, away_player_5, away_player_6, away_player_7, away_player_8, away_player_9, away_player_10, away_player_11
FROM  Matches
;


