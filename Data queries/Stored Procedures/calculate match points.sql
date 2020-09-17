CREATE DEFINER=`root`@`localhost` PROCEDURE `matchResultPoints`(filterBySeason bool, seasonId int, serverId int)
BEGIN

	-- This procedure calculates the points allocation to players in each match of a given league season

	drop table if exists matchresults;
	create table matchResults as
		select
			LeagueMatch_id,
			Player_id, 
			noOfGamesWon, 
			hasForfeited, 
			points,
            datePlayed,
			
			/* comparing the ranking of the games won in each match with
				its reverse, enables drawn matches to be identified
				where both rank columns are equal.
				
					1 2
					2 1
					1 2
					2 1
					1 1 --| Drawn game identified
					1 1 --| Drawn game identified
					1 2
					2 1  
				*/
			rank() over (partition by LeagueMatch_id
						order by noOfGamesWon desc) matchRank,
			rank() over (partition by LeagueMatch_id
						order by noOfGamesWon asc) matchRankReversed   
		from player_leaguematch
        join leaguematch using (LeagueMatch_id)
		where 
			case
				when filterBySeason = true then
					Season_id = seasonId and League_id = serverId
				else
					Season_id >= 1 -- All seasons					
			end
		order by LeagueMatch_id;
		
        
	-- Calculate points earned from matches

	update matchResults
	set points = 3
	where matchRank = 1;
	update matchResults
	set points = 1
	where matchRank = 2;
	update matchResults
	set points = 0
	where hasForfeited = 1;
	update matchResults
	set points = 2
	where matchRank = matchRankReversed;
    
    -- copy the calculated points field into player_leaguematch table for permanent storage
    update player_leaguematch pl
    set points = (select points
				from matchResults m
                where pl.LeagueMatch_id = m.LeagueMatch_Id
					and pl.Player_id = m.Player_id);
    
    
END