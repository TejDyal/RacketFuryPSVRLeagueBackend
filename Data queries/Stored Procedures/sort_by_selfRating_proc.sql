CREATE DEFINER=`root`@`localhost` PROCEDURE `sortBySelfRating`(in serverId int)
begin
select Player_id from player 
	where Server_id = serverId and enterInNextLeague = 1
    order by selfRating;
end