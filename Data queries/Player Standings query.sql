-- Player Standings History __WORK IN PROGRESS --
USE rf_league_db;
select pl.player_id, Season_id AS Season
from player AS p
JOIN  player_leaguematch AS pl ON p.Player_id = pl.Player_id
where pl.Player_id=6;

