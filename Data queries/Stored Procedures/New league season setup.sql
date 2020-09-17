CREATE DEFINER=`root`@`localhost` PROCEDURE `newSeasonLeagueSetup`(in serverId int,
											seasonId int, 
											maxPlayersInDiv int, 
											minPlayersInDiv int, 
											startDate date, 
											endDate date)
BEGIN

	/* This Stored Procedure sets up a new league season and automates player/div assignments 
		depending on last season results (if not first season) and new players self ratings.
        The result set is stored in a temporary table, playerSort, so that the admin can
        make changes if needed before committing.  But Admin has to execute "confirmNewLeagueSeasonSort"
        to append the result set to division_player table, effectively making the new league season live */
	
        
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
    declare playerReassign int;
    declare lastDiv int;
    
	/* add new season to season and season_league tables if they don't exist 
			(remember different leagues might have different number of seasons) */
    select max(Season_id) from season
    into s;
    
    
    if seasonId > s or s is null then
		INSERT INTO season (`Season_id`) VALUES (seasonId);
	end if;
	select max(Season_id) 
	from league_season
    where League_id = serverId
    into s;
    if seasonId > s or s is null then
		INSERT INTO league_season (`Season_id`, `League_id`, `startDate`, `endDate`) 
        VALUES (seasonId, serverId, statDate, endDate);
	end if;
    
    -- check if first season of league.  If it is then skip to assigning all new players to their divs
    if seasonId != 1 then
    
		call seasonResults(true, seasonId-1, serverId);
        
		-- remove players who are not playing next season
		delete from playerSort
		where enterInNextSeason = 0;
        
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
	else  --  this is the first season so just create a playerSort table for the new players
		drop table if exists playerSort;
		create table playerSort (
				League_id int,
                Season_id int,
				Division_id int, 
				Player_id int, 
				totalPoints int, 
				gamesWon int,
				gamesCount int,
				enterInNextSeason tinyint(1),
				playerRank int,
				playerRankReverse int,
				subRowNum int,
				subRowNumReverse int);
	end if;
    
    -- update seaosn column on playerSort to new season
    update playerSort
    set Season_id = seasonId
    where Season_id = seasonId-1;
    
    
    
	-- add in the new players in new season
	alter table playerSort
    add column selfRating int,
    add column rowNum int;
    insert into playersort (League_id, Season_id, Division_id, Player_id, selfRating, rowNum)
		select 
			serverId,
            seasonId,
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
        


	/* calculate number of divisions needed */
    set noOfDivs = ceiling(getPlayerCount()/maxPlayersInDiv);
    
    
	/* increment divisons in divison table if the 
		new number of divisions for the next league season is more than current maximum */
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
    set maxRow = getMaxRow();
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
    
    /* determines if there is sufficient players in the bottom division.  
			If there isn't then bump them up into next division up */
	set lastDiv = getMaxDiv();
    select count(Player_id)
    into playersInLastDiv
    from playerSort
    where Division_id = lastDiv;
    if playersInLastDiv < minPlayersInDiv then
			update playerSort
            set Division_id = Division_id-1
            where Division_id = lastDiv;
	end if;
    
    /* add and popagate columns with the league and Season id to finalise
		prep when admin executes confirm new season procedure 
	alter table playerSort
    add column League_id int,
    add column Season_id int;
    update playerSort set League_id = serverId, Season_id = seasonId;    */
END