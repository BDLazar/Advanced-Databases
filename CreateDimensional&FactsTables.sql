--Drop tables
drop table fact_stats;
drop table dimplayer;
drop table dimteam;
drop table dimtime;
drop table dimstadium;

--Create dimensional and fact tables
create table DimPlayer
(
		player_sk int primary key,
		player_name varchar2(30),
		player_surname varchar2(30)
);

create table DimTeam
(
		team_sk int primary key,
		team_name varchar2(30),
		year_founded int
);

create table DimTime
    (
        date_sk date primary key,
        year number(4),
        month number(2),
        day number(2)
    );

create table DimStadium
    (
        stadium_sk int primary key,
        stadium_name varchar2(30),
        stadium_city varchar2(30),
        capacity int
    );

create table Fact_Stats
    (
        date_sk date references DimTime(date_sk),
        player_sk int references DimPlayer(player_sk),
        team_sk int references DimTeam(team_sk),
        opponent_sk int references DimTeam(team_sk),
        stadium_sk int references DimStadium(stadium_sk),
        min_played number,
        goals number,
        shot_on number,
        shot_off number,
        penalty number,
        pass_ok number,
        pass_ko number
    );

	
--Staging tables
drop table fact_stage;
drop table player_stage;
drop table team_stage;
drop table stadium_stage;
drop table time_stage;

create table player_stage (
    player_sk integer primary key,
    player_name varchar2(30),
    player_surname varchar2(30)
);

create table team_stage
(
    team_sk int,
    team_name varchar2(30),
    year_founded number(4)
);

create table stadium_stage
(
    stadium_sk int,
    stadium_name varchar2(30),
    stadium_city varchar2(30),
    capacity int,
    team_id int
);

create table time_stage
(
    date_sk date,
    year number(4),
    month number(2),
    day number(2)
);

create table fact_stage
(
    date_sk date,
    player_sk int,
    team_sk int,
    opponent_sk int,
    stadium_sk int,
    min_played number,
    goals number,
    shot_on number,
    shot_off number,
    penalty number,
    pass_ok number,
    pass_ko number
);

commit;