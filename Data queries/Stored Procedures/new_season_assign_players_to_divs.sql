CREATE DEFINER=`root`@`localhost` PROCEDURE `newSeasonLeagueSetup`(in serverId int,
											seasonId int, 
											maxPlayersInDiv int, 
											minPlayersInDiv int, 
											startDate date, 
											endDate date)
BEGIN

	/* This Stored Procedure sets up a new league season and automates player/div assignments 
		depending on last season results and new players self ratings.
        The result set is stored in a temporary table, playerSort, so that the admin can
        make changes if needed before committing.  But Admin has to execute "confirmNewLeagueSeasonSort"
        to append the result set to division_player table, effectively making the new league season live */
        
	/* TODO revise this procedure so that it can also be used to set up first season leagues 
			and eliminate the "firstSeasonLeagueSetup" procedure */
        
	declare noOfDivs int;
    declare currentDivPlayerCount int;
    declare playerCount int;
    declare currentMaxDiv int;
    declare divLoop int;
    declare divPlayersCount int;
    declare rowPointer int;
	declare s int;
    declare playersInLastDiv int;
    declare movePlayers bool;
    declare maxRow int;
    
	/* add new season to season and season_league tables if they don't exist 
			(remember different leagues might have different number of seasons) */
    select max(Season_id) from season
    into s;
    if seasonId > s then
		INSERT INTO season (`Season_id`) VALUES (seasonId);
	end if;
	select max(Season_id) 
	from league_season
    where League_id = serverId
    into s;
    if seasonId > s then
		INSERT INTO league_season (`Season_id`, `League_id`, `startDate`, `endDate`) 
        VALUES (seasonId, serverId, statDate, endDate);
	end if;
    
	-- create a table of players total points by division
	drop table if exists tallyPlayerPointsbyDiv;
	create table tallyPlayerPointsbyDiv as
		select Division_id, 
                Player_id, 
                sum(points) as totalPoints, 
                sum(noOfGamesWon) as gamesWon,            
				gamesCount(serverId, seasonId-1, Division_id, Player_Id) as gamesCount,
                enterInNextSeason
		from player_leaguematch
        join player p using (Player_id)
        where Season_id = seasonId-1 and League_id = serverId
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
        
	-- remove players who are not playing next season
    delete from playerSort
    where enterInNextSeason = 0;
    
	-- add in the new players in new season
	alter table playerSort
    add column selfRating int,
    add column rowNum int;
    insert into playersort (Division_id, Player_id, selfRating, rowNum)
		select 
			0, 
            Player_id, 
            selfRating, 
            row_number() over (order by selfRating)
		from player
		where Player_id not in (
			select Player_id
			from playerSort)
			and enterInNextSeason = 1
			and Server_id = serverId
		order by selfRating;
        
	/* promote and relegate players from last season into their new divisions 
			(bottom 2 players relegate to lower div, top 2 players promote to higher div) */
	update playerSort
	set Division_id = (
		case
			-- relegate
			when Division_id != getMaxDiv()
				and subRowNumReverse in (1,2)
				then Division_id+1
			-- promote
			when Division_id != 1
				and subRowNum in (1,2) 
                then Division_id-1
			else Division_id
		end);

	/* calculate number of divisions needed */
    set noOfDivs = ceiling(getPlayerCount()/maxPlayersInDiv);
    
	/* increment divisons in divison table if the 
		new number of divisions for the next league is more than current maximum */
    select max(Division_id)
    into currentMaxDiv
    from division;
    while noOfDivs > currentMaxDiv do
		insert into division
        values (currentMaxDiv+1);
        set currentMaxDiv = currentMaxDiv + 1;
	end while;    
    
	/* TODO assign returning players who had a break to the divisions they were 
		last promoted, remained or relegated to  (implement this when doing the third season simulation) */
	
    /* Assign new players to divisions including filling the player gaps in the divisions from top to bottom
			(TODO this needs to be revised to factor in players who are returning after a break) */            
	set rowPointer = 1;
    set divLoop = 1;
    set maxRow = (select max(rowNum) from playerSort);
    while rowPointer <= maxRow do
			if getPlayerNumInDiv(divLoop) < maxPlayersInDiv then
				update playerSort
                set Division_id = divLoop
                where rowNum = rowPointer;
                set rowPointer:=rowPointer+1;
			else 
				set divLoop:= divLoop + 1;
			end if;
    end while;
    
    /* TODO  determines if there is sufficient players in the bottom division.  
			If there isn't then spread players into immediate upper divisions. 
					Also tests there is enough divisions above.*/
    select count(Player_id)
    into playersInLastDiv
    from playerSort
    where Division_id = noOfDivs;
    if playersInLastDiv < minPlayersInDiv then
		set rowPointer = playerCount;
		while (playersInLastDiv > 0) and (divCount-playersInLastDiv > 0) do
			update playerSort 
			set Division_id = divCount-playersInLastDiv
			where row_num = rowPointer;
            set playersInLastDiv = playersInLastDiv-1;
            set rowPointer = rowPointer - 1;
		end while;
        if playersInLastDiv = 0 then
			set noOfDivs = noOfDivs-1;
		end if;
	end if;
    
    
END