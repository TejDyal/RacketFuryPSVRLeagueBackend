CREATE DEFINER=`root`@`localhost` PROCEDURE `newSeasonLeagueSetup`(in serverId int,
											seasonId int, 
                                            maxPlayersInDiv int, 
                                            minPlayersInDiv int, 
                                            startDate date, 
                                            seasonLength int)
BEGIN
	declare noOfDivs int;
    declare playerCount int;
    declare currentMaxDiv int;
    declare divCount int;
    declare divPlayersCount int;
    declare rowPointer int;
	declare s int;
    declare playersInLastDiv int;
    declare movePlayers bool;
	
    /* add new season to season table if it doesn't exist (remember different leagues might have different number of seasons) */
    select max(Season_id) from season
    into s;
    if seasonId > s then
		INSERT INTO season (`Season_id`) VALUES (seasonId);
	end if;
	
    -- create a view of players total points by division
	drop view if exists tallyPlayerPointsbyDiv;
	create view tallyPlayerPointsbyDiv as
		select Season_id, League_id, Division_id, Player_id, sum(points) as totalPoints, sum(noOfGamesWon) as gamesWon
		from player_leaguematch
		group by Season_id, League_id, Division_id, Player_id
		order by Season_id, League_id, Division_id, totalPoints desc, gamesWon desc;
	
    -- rank players by division
	select
		Season_id, 
		League_id, 
		Division_id, 
		Player_id, 
		totalPoints, 
		gamesWon,
		rank() over (partition by Season_id,
								League_id,
								Division_id
		order by totalPoints desc, gamesWon desc) playerRank
	from
		tallyPlayerPointsbyDiv;
    
    
    
END