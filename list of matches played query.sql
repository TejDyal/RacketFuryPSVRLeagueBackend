USE rf_league_db;
SELECT  League_id, Season_id, Division_id, 
	LeagueMatch_id, PSN_id, noOfGamesWon, points, hasForfeited AS Forfeited
FROM player_leaguematch pl
JOIN player on pl.player_id = player.player_id
order by LeagueMatch_id