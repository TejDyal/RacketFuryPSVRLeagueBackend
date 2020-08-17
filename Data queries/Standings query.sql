-- Standings in a selected division --

USE rf_league_db;
SELECT PSN_id, SUM(points) AS Total_Points, SUM(noOfGamesWon) AS GamesWon
FROM player_leaguematch pl
JOIN player ON pl.Player_id = player.Player_id
WHERE League_id=1 AND Season_id=1 AND Division_id=1
-- in html/php dropdown boxes for league, season, and division will be presented --
GROUP BY player.Player_id
ORDER BY Total_Points desc;

