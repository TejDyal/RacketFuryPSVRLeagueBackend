CREATE DEFINER=`root`@`localhost` FUNCTION `gamesCount`(leagueId int, seasonId int, divisionId int, playerId int) RETURNS int
    READS SQL DATA
BEGIN
	declare gamesCount int;
	select count(Player_id)
    into gamesCount
	from player_leaguematch
	where League_id = leagueId and Season_id = seasonId and Division_id = divisionId and Player_id = playerId;
RETURN gamesCount;
END