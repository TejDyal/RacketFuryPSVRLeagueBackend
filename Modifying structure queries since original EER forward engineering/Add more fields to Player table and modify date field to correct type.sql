use rf_league_db;
alter table player
add column pwd varchar(255) not null,
modify column dateRegistered date;
