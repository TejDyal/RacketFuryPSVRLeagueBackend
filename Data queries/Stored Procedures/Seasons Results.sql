CREATE DEFINER=`root`@`localhost` PROCEDURE `seasonResults`(filterBySeason bool, seasonId int, serverId int)
BEGIN
	/*
    This procedure will calculate standings of players in each Division.  
    */
    
		call matchResultPoints(filterBySeason, seasonId, serverId); -- calculate the points per match
    
		-- create a table of players total points by division
		drop table if exists tallyPlayerPointsbyDiv;
		create table tallyPlayerPointsbyDiv as
			select League_id, 
					Season_id, 
					Division_id, 
					Player_id, 
					sum(points) as totalPoints, 
					sum(noOfGamesWon) as gamesWon,            
					gamesCount(serverId, seasonId, Division_id, Player_Id) as gamesCount,
					enterInNextSeason
			from player_leaguematch
			join player p using (Player_id)
			where
				case
					when filterBySeason = true then
					Season_id = seasonId and League_id = serverId
				else
					Season_id >= 1 and League_id = serverId -- All seasons
				end   
			group by League_id, Season_id, Division_id, Player_id
			order by League_id, Season_id, Division_id, totalPoints desc, gamesWon desc, gamesCount desc;
		
		-- rank players by division
		drop table if exists playerSort;
		create table playerSort as
			select
				*,
				rank() over (partition by League_id, Season_id, Division_id
				order by totalPoints desc, gamesWon desc, gamesCount desc) playerRank,
				rank() over (partition by League_id, Season_id, Division_id
				order by totalPoints asc, gamesWon asc, gamesCount asc) playerRankReverse,
				row_number() over (partition by League_id, Season_id, Division_id
				order by totalPoints desc, gamesWon desc, gamesCount desc) subRowNum,
				row_number() over (partition by League_id, Season_id, Division_id
				order by totalPoints asc, gamesWon asc, gamesCount asc) subRowNumReverse            
			from
				tallyPlayerPointsbyDiv
			order by League_id, Season_id, Division_id, totalPoints desc, gamesWon desc, gamesCount desc; 
END