CREATE DEFINER=`root`@`localhost` FUNCTION `getHighestDivWon`(playerId int) RETURNS int
    READS SQL DATA
BEGIN
	declare highestDivWon int;
	select max(Division_id)
    into highestDivWon
    from playerSort
    where Player_id = playerId and playerRank = 1;
RETURN highestDivWon;
END