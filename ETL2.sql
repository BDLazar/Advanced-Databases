exec etl2;

CREATE OR REPLACE PROCEDURE ETL2
IS
BEGIN

    --Player Staging
    insert into player_stage (player_sk, player_name, player_surname) 
    (select Player_ID, Pl_name, Pl_surname from Player
    where Player_ID not in (select player_sk from player_stage));

    insert into dimplayer 
    (select player_sk, player_name, player_surname from player_stage
    where player_sk not in (select player_sk from dimplayer));

    --Fact Staging
    execute immediate 'truncate table fact_stage';

    insert into fact_stage (date_sk, player_sk, team_sk,opponent_sk,stadium_sk,min_played,goals,shot_on,shot_off,penalty, pass_ok, pass_ko)
    select M_date, Player_ID, Team_A_ID, Team_B_ID, s.stadium_sk, MinPlayed, Goals, Shot_on, Shot_off, Penalty, Pass_OK, Pass_KO from Players_stats, stadium_stage s
    where Team_A_ID = s.TEAM_ID;

    execute immediate 'truncate table fact_stats';
    insert into fact_stats (date_sk, player_sk, team_sk, opponent_sk, stadium_sk, min_played, goals, shot_on, shot_off, penalty, pass_ok, pass_ko)
    select date_sk, player_sk, team_sk, opponent_sk, stadium_sk, min_played, goals, shot_on, shot_off, penalty, pass_ok, pass_ko from fact_stage;

    commit;

END;
/

