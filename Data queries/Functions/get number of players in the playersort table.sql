CREATE DEFINER=`root`@`localhost` FUNCTION `getPlayerCount`() RETURNS int
    READS SQL DATA
BEGIN
	declare playerCount int;
	select count(Player_id)
    into playerCount
    from playerSort;	
RETURN playerCount;
END