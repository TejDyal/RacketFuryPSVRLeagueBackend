use rf_league_db;

alter table league
add column 
(seasonLength int,
maxPlayersInDiv int,
gapBetweenSeasons int);
    