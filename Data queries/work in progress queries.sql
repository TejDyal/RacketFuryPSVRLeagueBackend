
	-- number of players in each current division that play in next season
	drop view if exists countPlayersPerDiv;
	create view countPlayersPerDiv as
		select Division_id, count(Player_id)
		from division_player dp
		join player p using (Player_id)
		where enterInNextSeason = 1 and League_id = 1 and Season_id = 1
		group by Division_id
		order by Division_id;


	-- create a view of players total points by division
	drop view if exists tallyPlayerPointsbyDiv;
	create view tallyPlayerPointsbyDiv as
		select Division_id, 
                Player_id, 
                sum(points) as totalPoints, 
                sum(noOfGamesWon) as gamesWon
		from player_leaguematch
        where Season_id = 1 and League_id = 1
		group by Division_id, Player_id
		order by Division_id, totalPoints desc, gamesWon desc;

	-- rank players by division
    drop table if exists playerSort;
    create table playerSort as
		select
			Division_id, 
			Player_id, 
			totalPoints, 
			gamesWon,
			rank() over (partition by Division_id
			order by totalPoints desc, gamesWon desc) playerRank
		from
			tallyPlayerPointsbyDiv;
            
	-- add in the new players in new season
    select Player_id
    from player
    where Player_id not in (
		select Player_id
        from playerSort)        
        and enterInNextSeason = 1
        and Server_id = 1
	order by Player_id;

-- number of players in new season
