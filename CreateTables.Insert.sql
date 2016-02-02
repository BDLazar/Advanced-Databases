--Drop the tables: 
--Drop the ones with FKs first
--Then the ones with PKs
drop table Stadium;
drop table Players_stats;
drop table Matches;
drop table Player;
drop table Teams;


--Create tables
--Table Player
create table Player
(
  Player_ID int primary key,
  Pl_name varchar2(30),
  Pl_surname varchar2(30),
  Team_ID int references Teams(Team_ID)
);

--Table Stadium
create table Stadium
(
  Stadium_ID int primary key,
  St_name varchar2(30),
  City varchar2(30),
  Capacity int,
  Team_ID int references Teams(Team_ID)
);

--Table Teams
create table Teams
(
  Team_ID int primary key,
  Team_name varchar2(30),
  YearOfFound number(4) 
);

--Table Matches
create table Matches
(
  Team_A int,
  Team_B int,
  M_date date,
  primary key (Team_A, Team_B, M_date)
);

--Table Players_stats
create table Players_stats
(
  Team_A_ID int,
  Team_B_ID int,
  M_date date,
  Player_ID int references Player(Player_ID),
  MinPlayed number,
  Goals number,
  Shot_on number,
  Shot_off number,
  Penalty number,
  Pass_OK number,
  Pass_KO number,
  foreign key (Team_A_ID, Team_B_ID, M_date) references Matches(Team_A_ID, Team_B_ID, M_date)
);


--Insert teams
--team_id,team_name,year_of_foundation
insert into Teams values (11,'Everton',1912);
insert into Teams values (1,'Manchester United',1902);
insert into Teams values (110,'Stoke City',1908);
insert into Teams values (56,'Sunderland',1895);
insert into Teams values (54,'Fulham',1887);
insert into Teams values (8,'Chelsea',1872);
insert into Teams values (111,'Wigan Athletic',1904);
insert into Teams values (3,'Arsenal',1888);
insert into Teams values (6,'Tottenham Hotspur',1901);
insert into Teams values (4,'Newcastle United',1899);
insert into Teams values (52,'Queens Park Rangers',1901);
insert into Teams values (30,'Bolton Wanderers',1887);
insert into Teams values (80,'Swansea City',1900);
insert into Teams values (14,'Liverpool',1907);
insert into Teams values (35,'West Bromwich Albion',1897);
insert into Teams values (39,'Wolverhampton Wanderers',1867);
insert into Teams values (45,'Norwich City',1914);
insert into Teams values (5,'Blackburn Rovers',	1870	);
insert into Teams values (7,'Aston Villa',	1899	);
insert into Teams values (43,'Manchester City',	1891	);


--Insert Stadiums
--stadiumID,stadium name, city, capacity, team_id (FK)
insert into Stadium values(1,'Old Trafford','Manchester',76100,1);
insert into Stadium values(2,'Emirates Stadium','London',60432,3);
insert into Stadium values(3,'St James'' Park','Newcastle-upon-Tyne',52401,4);
insert into Stadium values(4,'Stadium of Light','Sunderland',49000,56);
insert into Stadium values(5,'Etihad Stadium','Manchester',48000,43);
insert into Stadium values(6,'Anfield','Liverpool',45362,14);
insert into Stadium values(7,'Villa Park','Birmingham',42785,7);
insert into Stadium values(8,'Stamford Bridge','London',41623,8);
insert into Stadium values(9,'Goodison Park','Liverpool',40569,11);
insert into Stadium values(12,'White Hart Lane','London',36274,6);
insert into Stadium values(13,'Craven Cottage','London',25678,54);
insert into Stadium values(14,'DW Stadium','Wigan',25023,111);
insert into Stadium values(15,'Loftus Road','London',18360,52);
insert into Stadium values(16,'Macron Stadium','Horwich',28723,30);
insert into Stadium values(17,'Britannia Stadium','Stoke-on-Trent',28323,110);
insert into Stadium values(18,'Liberty Stadium','Swansea',20700,80);
insert into Stadium values(19,'Carrow Road','Norwich',27220,45);
insert into Stadium values(20,'The Hawthorns','West Bromwich',26500,35);
insert into Stadium values(21,'Molineux','Wolverhampton',31700,39);
insert into Stadium values(22,'Ewood Park','Blackburn',31367,5);
