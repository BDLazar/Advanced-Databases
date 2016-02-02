exec etl1;

CREATE OR REPLACE PROCEDURE ETL1
IS
BEGIN

    --Player Staging
    insert into player_stage (player_sk, player_name, player_surname) 
    select Player_ID, Pl_name, Pl_surname from Player;

    insert into dimplayer select player_sk, player_name, player_surname from player_stage;

    --Teams Staging
    insert into team_stage (team_sk, team_name, year_founded) 
    select Team_ID, Team_name, YearofFound from Teams;

    insert into dimteam select team_sk, team_name, year_founded from team_stage;

    --Stadium Staging
    insert into stadium_stage (stadium_sk, stadium_name, stadium_city, capacity, team_id) 
    select Stadium_ID, St_name, City, Capacity, Team_ID from Stadium;

    insert into dimstadium select stadium_sk, stadium_name, stadium_city, capacity from stadium_stage;

    --Time Staging
    insert into time_stage (date_sk, year, month, day) 
    select unique M_date, extract (year from M_date), extract (month from M_date), extract (day from M_date) from Matches;

    insert into dimtime select date_sk, year, month, day from time_stage;

    --Fact Staging
    insert into fact_stage (date_sk, player_sk, team_sk,opponent_sk,stadium_sk,min_played,goals,shot_on,shot_off,penalty, pass_ok, pass_ko)
    select M_date, Player_ID, Team_A_ID, Team_B_ID, s.stadium_sk, MinPlayed, Goals, Shot_on, Shot_off, Penalty, Pass_OK, Pass_KO from Players_stats, stadium_stage s
    where Team_A_ID = s.TEAM_ID;

    insert into fact_stats (date_sk, player_sk, team_sk, opponent_sk, stadium_sk, min_played, goals, shot_on, shot_off, penalty, pass_ok, pass_ko)
    select date_sk, player_sk, team_sk, opponent_sk, stadium_sk, min_played, goals, shot_on, shot_off, penalty, pass_ok, pass_ko from fact_stage;

    commit;
	
END;
/