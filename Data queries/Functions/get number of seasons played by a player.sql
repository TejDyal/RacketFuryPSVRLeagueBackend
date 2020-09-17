CREATE DEFINER=`root`@`localhost` FUNCTION `getSeasonsPlayed`(playerId int) RETURNS int
    READS SQL DATA
BEGIN
	declare seasonsPlayed int;
    select count(Season_id)
    into seasonsPlayed
    from division_player 
    where Player_id = playerId;
RETURN seasonsPlayed;
END