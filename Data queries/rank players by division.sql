	set seasonId =1;
    set serverId =1;
    
    -- create a view of players total points by division
	drop view if exists tallyPlayerPointsbyDiv;
	create view tallyPlayerPointsbyDiv as
		select Division_id, 
                Player_id, 
                sum(points) as totalPoints, 
                sum(noOfGamesWon) as gamesWon
		from player_leaguematch
        where Season_id = seasonId and League_id = serverId
		group by Division_id, Player_id
		order by Division_id, totalPoints desc, gamesWon desc;

	-- rank players by division
    set @row_number = 0;
    set @test = 0;
	select
		Division_id, 
		Player_id, 
		totalPoints, 
		gamesWon,
		rank() over (partition by Division_id
		order by totalPoints desc, gamesWon desc) playerRank,
        @row_number:=@row_number+1 as rowNum
	from
		tallyPlayerPointsbyDiv;
    
    
