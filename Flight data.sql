USE flights;

CREATE TABLE flightinfo
(
YEAR                     int,
MONTH                    int,
DAY                      int,
DAY_OF_WEEK              int,
AIRLINE                  varchar(30),
FLIGHT_NUMBER            int,
TAIL_NUMBER              varchar(30),
ORIGIN_AIRPORT           varchar(30),
DESTINATION_AIRPORT_x    varchar(30),
SCHEDULED_DEPARTURE_x    int,
DEPARTURE_TIME_x         int,
DEPARTURE_DELAY_x        int,
TAXI_OUT_x               int,
WHEELS_OFF_x             int,
SCHEDULED_TIME_x         int,
ELAPSED_TIME_x           int,
AIR_TIME_x               int,
DISTANCE_x               int,
WHEELS_ON_x              int,
TAXI_IN_x                int,
SCHEDULED_ARRIVAL_x      int,
ARRIVAL_TIME_x           int,
ARRIVAL_DELAY_x          int,
DIVERTED_x               int,
CANCELLED_x              int,
CANCELLATION_REASON_x    varchar(30),
AIR_SYSTEM_DELAY_x       int,
SECURITY_DELAY_x         int,
AIRLINE_DELAY_x          int,
LATE_AIRCRAFT_DELAY_x    int,
WEATHER_DELAY_x          int,
IATA_CODE_x              varchar(30),
AIRPORT_x                varchar(30),
CITY_x                   varchar(30),
STATE_x                  varchar(30),
COUNTRY_x                varchar(30),
LATITUDE_x               int,
LONGITUDE_x              int,
DESTINATION_AIRPORT_y    varchar(30),
SCHEDULED_DEPARTURE_y    int,
DEPARTURE_TIME_y         int,
DEPARTURE_DELAY_y        int,
TAXI_OUT_y               int,
WHEELS_OFF_y             int,
SCHEDULED_TIME_y         int,
ELAPSED_TIME_y           int,
AIR_TIME_y               int,
DISTANCE_y               int,
WHEELS_ON_y              int,
TAXI_IN_y                int,
SCHEDULED_ARRIVAL_y      int,
ARRIVAL_TIME_y           int,
ARRIVAL_DELAY_y          int,
DIVERTED_y               int,
CANCELLED_y              int,
CANCELLATION_REASON_y    varchar(30),
AIR_SYSTEM_DELAY_y       int,
SECURITY_DELAY_y         int,
AIRLINE_DELAY_y          int,
LATE_AIRCRAFT_DELAY_y    int,
WEATHER_DELAY_y          int,
IATA_CODE_y              varchar(30),
AIRPORT_y                varchar(30),
CITY_y                   varchar(30),
STATE_y                  varchar(30),
COUNTRY_y                varchar(30),
LATITUDE_y               int,
LONGITUDE_y              int
)
;
LOAD DATA LOCAL INFILE 'C:/Users/rp/Desktop/Misc/python/new flights.csv' INTO TABLE flightinfo
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
;
select * from flightinfo limit 3;




drop table weather;
##########weather
create table weather
(
City varchar(30),
year int,
month int,
day int,
Wind_speed float,
Humidity float)
;

LOAD DATA LOCAL INFILE 'C:/Users/rp/Desktop/Misc/Python/weather.csv' INTO TABLE weather
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
;
/*#ALTER TABLE weather drop DATE;
ALTER TABLE weather ADD DATE varchar(12);
UPDATE weather SET DATE =  CONCAT(year,'-',month,'-',day) WHERE DATE IS NULL;
SHOW errors;*/
select weather.* from weather limit 30;
-- ALTER TABLE weather DROP INDEX days;
-- ALTER TABLE weather ADD INDEX days (month, day);


################################merge
select * from flightinfo limit 30;
-- ALTER TABLE flightinfo ADD INDEX fdays (MONTH, DAY);
-- show errors;

SELECT 
	flightinfo.MONTH as Month, flightinfo.DAY as Day, flightinfo.DAY_OF_WEEK, flightinfo.AIRLINE,
	flightinfo.FLIGHT_NUMBER, flightinfo.ORIGIN_AIRPORT, DESTINATION_AIRPORT_x as Destination_Aiport,
    flightinfo.DEPARTURE_DELAY_x as Departure_Delay, AIR_TIME_x as Air_time,
    flightinfo.DISTANCE_X  Distance, flightinfo.ARRIVAL_DELAY_x as Arrival_delay,
    flightinfo.DIVERTED_x as Diverted, CANCELLED_x as Cancelled,
    flightinfo.CITY_x as Departure_City, flightinfo.STATE_x as Departure_State,
    flightinfo.CITY_y as Arrival_City, flightinfo.STATE_y as Arrival_State,
    wd.Wind_Speed as departure_wind_speed, wd.Humidity as departure_humidity /*,
    wa.Wind_Speed as arrival_wind_speed, wa.Humidity as arrival_humidity */

FROM flightinfo 

JOIN weather wd /*Departures */
	ON flightinfo.CITY_x=wd.City 
	AND flightinfo.MONTH=wd.month
	AND flightinfo.DAY=wd.day

JOIN weather wa /*Arrivals */
	ON flightinfo.CITY_y=wa.City 
	AND flightinfo.MONTH=wa.month
	AND flightinfo.DAY=wa.day
;

SELECT COUNT(*) FROM flightinfo; 

DESCRIBE flightinfo;
SELECT * FROM flightinfo;

SELECT DISTINCT CITY_x FROM flightinfo;
SELECT DISTINCT City FROM weather;


DELETE FROM flightinfo
	WHERE CITY_x = 'San Juan' | CITY_y = 'San Juan'; 