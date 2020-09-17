CREATE DEFINER=`root`@`localhost` FUNCTION `getdDateJoined`(dateJoined date) RETURNS int
    READS SQL DATA
BEGIN
	declare dateJoined date;
    select dateRegistered 
    into dateJoined
    from player 
    where Player_id = playerId;
RETURN dateJoined;
END