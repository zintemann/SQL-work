######I want to see if hosting an SNL episode prior to film release leads to higher revenues for a movie 
######problem is that SNL data has the exact data of airing, while the movies only have the year of release not indicating how close 
##the dates of the movie release and snl episode hosted by an actor are.

######data from IMDB and from SNL databases from Kaggle.com 
CREATE DATABASE IF NOT EXISTS SNL;

USE SNL;

DROP TABLE Episodes;
DROP TABLE Movies;

CREATE TABLE Episodes (
	sid tinyint(2),
    eid tinyint(2),
    year tinyint(4),
    aired date,
    host varchar(33),
    primary key (sid, eid, host)
    );
    
LOAD DATA LOCAL INFILE 'C:/Users/rp/Documents/snl_episode.csv' INTO TABLE Episodes
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
;

SELECT * FROM Episodes;




#########Movie Data
CREATE TABLE Movies (
    yearID INT(11),
	color VARCHAR(5),
    director VARCHAR(30),
    num_critic_riviews tinyint(4),
    duration tinyint(3),
    actor_2 VARCHAR(30),
    gross int(10),
    genre VARCHAR(30),
    actor_1 VARCHAR(30),
    title VARCHAR(30),
    actor_3 VARCHAR(30),
    language VARCHAR(30),
    country VARCHAR(10),
    content VARCHAR(5),
    budget INT(10),
    imdb_score INT(11),
    facebook_likes int(11),
    PRIMARY KEY (actor_1, actor_2, actor_3) )
    ;
    
LOAD DATA LOCAL INFILE 'C:/Users/rp/Documents/movie_metadata1.csv' INTO TABLE Movies
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
;


SELECT * FROM Movies;

describe Movies;


-- Find all movies with stars who recently hosted Saturday Night Live 
SELECT e.eid, e.sid, e.aired, DATE_FORMAT(e.aired, '%Y'), e.host, m.title, m.yearID, m.actor_1, m.actor_2, m.actor_3, m.gross, m.imdb_score, m.budget
	
    FROM Episodes e

RIGHT JOIN Movies m

ON (YEAR(e.aired)=m.yearID) AND (e.host=m.actor_1 OR e.host=m.actor_2 OR e.host=m.actor_3) 
;