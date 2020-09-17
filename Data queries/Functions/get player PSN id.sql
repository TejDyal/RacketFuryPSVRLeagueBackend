CREATE DEFINER=`root`@`localhost` FUNCTION `getPSNid`(playerId int) RETURNS int
    READS SQL DATA
BEGIN
	declare psnId int;
	select PSN_id 
    into psnId
    from player 
    where Player_id = playerId;
RETURN psnId;
END