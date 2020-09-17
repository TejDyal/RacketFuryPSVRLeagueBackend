CREATE DEFINER=`root`@`localhost` FUNCTION `getPlayerNumInDiv`(divisionId int) RETURNS int
    READS SQL DATA
BEGIN
	declare playerCount int;
	select count(Player_id)
    into playerCount
	from playerSort dp
	where Division_id = divisionId;
RETURN playerCount;
END