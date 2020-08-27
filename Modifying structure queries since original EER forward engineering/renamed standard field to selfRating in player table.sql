use rf_league_db;

alter table player
change `standard` `selfRating` varchar(45);
