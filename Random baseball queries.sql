-- Random Quesries to Explore the Lahman Database

use lahman2016;


-- Getting Rookie of the Year averages for all Hall of Famers 
SELECT m.debut as 'Debut', concat(m.nameFirst, ' ',m.nameLast) as Player,
	b.yearID as Year, b.H/b.AB as 'Rookie Batting Average', b.AB as 'At Bats', p.BA as 'Career Batting Average'
FROM master m

JOIN batting b
	ON m.playerID=b.playerID

JOIN 
	(SELECT * FROM halloffame where inducted='Y') h
ON m.playerID=h.playerID

JOIN 
	(SELECT playerID, sum(h)/sum(ab) as BA from batting group by playerID) p
	ON m.playerID=p.playerID

WHERE b.AB >=300;


-- Trying to Unerstand who is the best player ever to nt make it to the Hall of Fame
SELECT concat(m.nameFirst, ' ',m.nameLast) as Player, b.hits as Hits, b.average as 'Batting Average',
	h.yearID as Year, h.needed - h.votes AS 'Votes Missed By'
FROM master m

JOIN 
	(SELECT playerID, sum(h) as hits, sum(h)/sum(ab) as average FROM batting GROUP BY playerID having sum(ab) > 500) b
	ON m.playerID=b.playerID

JOIN 
	(SELECT * FROM halloffame where inducted='N' and votedby='BBWAA') h
	ON m.playerID=h.playerID 

GROUP BY m.playerID
ORDER BY b.average DESC;




-- Seeing how changes in salary affect changes in winning percentages
SELECT t.yearID as Year, t.franchID, t.w as wins, t.w/t.g AS PCT, attendance, s.salary, sh.salary as lag_salary,
	((s.salary-sh.salary)/sh.salary) *100 as salarychange, th.w as winslag, th.PCT as lagwinpct,
	((t.w-th.w)/(th.w)) *100 as winpctchange
FROM teams t

JOIN 
	(SELECT yearID, teamID, sum(salary) as salary FROM salaries WHERE yearID >= 1995 GROUP BY teamID, yearID) s
	ON t.yearID=s.yearID
	AND t.teamID=s.teamID

JOIN 
	(SELECT yearID, teamID, sum(salary) as salary FROM salaries WHERE yearID >= 1995 GROUP BY teamID, yearID) sh
	ON t.yearID -1 = sh.yearID
	AND t.teamID=sh.teamID 

JOIN 
	(SELECT yearID, teamID, w, w/g AS PCT from teams) th
	ON t.yearID -1 = th.yearID
	AND t.teamID=th.teamID
;



-- Number of ballplayers (non pitchers) born in each state
SELECT birthState, COUNT(*) as Players 
FROM master m

JOIN batting b
	On m.playerID=b.playerID

WHERE b.yearID=2016
AND birthCountry='USA'

GROUP BY birthState;

-- Number of pitchers born in each state
SELECT birthState, COUNT(*) AS Players 
FROM master m

JOIN pitching p
	ON m.playerID=p.playerID

WHERE p.yearID=2016
AND birthCountry='USA'
GROUP BY birthState;

-- Number of ballplayers (non pitchers) born in each country
SELECT birthCountry, count(*) AS Players 
FROM master m

JOIN batting b
	ON m.playerID=b.playerID
WHERE b.yearID=2016
GROUP BY birthCountry;


-- Looking for career stats for Phenomenal Smith
SELECT m.nameFirst, m.nameLast, m.birthYear, m.playerID, b.BA, b.HR, b.AB
FROM master  m

JOIN 
	(SELECT playerID, SUM(ab) AS AB, SUM(h)/SUM(ab) AS BA, SUM(hr) AS HR FROM batting
	group by playerID) b
	ON m.playerID=b.playerID

WHERE nameFirst like '%enom%'
;


-- Seeing how Rookie of the Year Winners Performed in their Second seasons
SELECT CONCAT(m.nameFirst, ' ',m.nameLast) AS Player, a.awardID, a.yearID, 
	r.h AS rookie_hits, r.hr AS rookie_hr, ROUND(r.ba, 3) AS rookie_avg,
	s.h AS sophomore_hits, ROUND(s.hr, 3) AS sophomore_hr, s.ba AS sophomore_avg,
	r.so AS rookie_so, s.so AS sophomore_so,
	ROUND(s.ba - r.ba, 3) AS avg_diff, s.hr - r.hr AS hr_diff,
	CASE WHEN (s.ba + 0.03) <= r.ba THEN 1
		ELSE 0
		END AS avg_drop,
	CASE WHEN s.hr + 7 <= r.hr THEN 1
		ELSE 0
		END AS hr_drop,
	CASE WHEN s.so - 20 >= r.so then 1
		ELSE 0
		END AS so_rise
FROM MASTER m

JOIN awardsplayers a
	ON m.playerID=a.playerID

JOIN
	(SELECT playerID, yearID, so, h, hr, h/ab as ba FROM batting where ab >=200) r
	ON a.yearID=r.yearID
	AND a.playerID=r.playerID
JOIN 
	(SELECT playerID, yearID, h, so, hr, h/ab as ba FROM batting where ab >=200) s
	ON a.yearID + 1=s.yearID
	AND a.playerID=s.playerID

WHERE awardID = 'Rookie of the Year' 
AND s.ba is not null
ORDER BY a.yearID
;