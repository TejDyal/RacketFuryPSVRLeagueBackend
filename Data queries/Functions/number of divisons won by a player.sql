CREATE DEFINER=`root`@`localhost` FUNCTION `getDivisionsWon`(playerId int) RETURNS int
    READS SQL DATA
BEGIN
	declare divisionsWon int;
	select count(Player_id)
    into divisionsWon
    from playerSort
    where Player_id = playerId and playerRank = 1;
RETURN divisionsWon;
END