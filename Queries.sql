
--Query 1
--For all the shots that team took, what percentage of the shots were on target
select sum(shot_on + shot_off) as Total_Shots_Made, round( sum(shot_on) / sum(shot_on + shot_off)* 100 ) ||'%' as Shots_on_Target
from fact_stats
where team_sk = 1
and date_sk >= to_date('01/10/2011', 'DD-MM-YYYY') 
and date_sk <= to_date('31/12/2011', 'DD-MM-YYYY');


--Query 2
--List all goals for a certain team 
select t.team_name, sum(f.goals) from fact_stats s
join dimteam t on f.team_sk = t.team_sk
where f.team_sk = 1
group by team_name;