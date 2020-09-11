	
    
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
                sum(noOfGamesWon) as gamesWon,            
				gamesCount(1, 1, Division_id, Player_Id) as gamesCount,
                enterInNextSeason
		from player_leaguematch
        join player p using (Player_id)
        where Season_id = 1 and League_id = 1
		group by Division_id, Player_id
		order by Division_id, totalPoints desc, gamesWon desc, gamesCount desc;

	-- rank players by division
    drop table if exists playerSort;
    create table playerSort as
		select
			Division_id, 
			Player_id, 
			totalPoints, 
			gamesWon,
            gamesCount,
            enterInNextSeason,
			rank() over (partition by Division_id
			order by totalPoints desc, gamesWon desc, gamesCount desc) playerRank,
            rank() over (partition by Division_id
			order by totalPoints asc, gamesWon asc, gamesCount asc) playerRankReverse,
            row_number() over (partition by Division_id
			order by totalPoints desc, gamesWon desc, gamesCount desc) subRowNum,
            row_number() over (partition by Division_id
			order by totalPoints asc, gamesWon asc, gamesCount asc) subRowNumReverse
		from
			tallyPlayerPointsbyDiv
		order by Division_id, totalPoints desc, gamesWon desc, gamesCount desc;
        
	delete from playerSort
    where enterInNextSeason = 0;
    
            
	alter table playerSort
    add column selfRating int,
    add column rowNum int,
    add column newRowNum int;
            
	-- add in the new players in new season
    insert into playerSort (Division_id, Player_id, selfRating)
		select '0', Player_id, selfRating
		from player
		where Player_id not in (
			select Player_id
			from playerSort)
			and enterInNextSeason = 1
			and Server_id = 1
		order by selfRating;

	set @rowNum = 0;
	update playerSort
		set rowNum = @rowNum:=@rowNum+1;




select count(Player_id)
from player_leaguematch
where League_id = 1 and Season_id = 1 and Division_id = 1 and Player_id = 3;


update playerSort
        set Division_id = (
			case
				-- relegate
				when Division_id != getMaxDiv() and subRowNumReverse in (1) then Division_id+1
                -- promote
                when Division_id != 1 and subRowNum in (1) then Division_id-1
                else Division_id
			end)
