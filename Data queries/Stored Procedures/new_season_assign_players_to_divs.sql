CREATE DEFINER=`root`@`localhost` PROCEDURE `newSeasonLeagueSetup`(in serverId int,
											seasonId int, 
                                            maxPlayersInDiv int, 
                                            minPlayersInDiv int, 
                                            startDate date,
                                            endDate date,
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
	
    /* add new season to season and season_league tables if they don't exist (remember different leagues might have different number of seasons) */
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
	
	-- create a view of players total points by division
	drop view if exists tallyPlayerPointsbyDiv;
	create view tallyPlayerPointsbyDiv as
		select Division_id, 
                Player_id, 
                sum(points) as totalPoints, 
                sum(noOfGamesWon) as gamesWon
		from player_leaguematch
        where Season_id = seasonId-1 and League_id = serverId
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
        and Server_id = serverId
	order by Player_id;
		
	-- number of players in each current division that play in next season
	drop view if exists countPlayersPerDiv;
	create view countPlayersPerDiv as
		select Division_id, count(Player_id)
		from division_player dp
		join player p using (Player_id)
		where enterInNextSeason = 1 and League_id = serverId and Season_id = seasonId-1
		group by Division_id
		order by Division_id;
        
	
    
    /* popagate columns with the league and Season ids */
    update playerSort set League_id = serverId, Season_id = seasonId;
    
    /* calculate number of divisions needed */
    set noOfDivs = 0;
    select count(Player_id)
    into playerCount
    from playerSort;
    set noOfDivs = ceiling(playerCount/maxPlayersInDiv);
    
    /* increment divisons in divison table if the new number of divisions for the next league is more than current maximum */
    select max(Division_id)
    into currentMaxDiv
    from division;
    while noOfDivs > currentMaxDiv do
		insert into division
        values (currentMaxDiv+1);
        set currentMaxDiv = currentMaxDiv + 1;
	end while;    
    
    /* assign players to their division */
    set divCount = 1;
    set divPlayersCount = 0;
    set rowPointer = 1;
    while rowPointer <= playerCount do
		update playerSort 
        set Division_id = divCount
        where row_num = rowPointer;
        set rowPointer = rowPointer+1;
        set divPlayersCount = divPlayersCount + 1;
        if divPlayersCount = maxPlayersInDiv then
			set divPlayersCount = 0;
            set divCount = divCount+1;
		end if;
    end while;
    
	/* determines if there is sufficient players in the bottom division.  
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
    
    /* update league_season table with new season and dates*/
    insert into league_season (League_id, Season_id, startDate, endDate)
        values (serverId, seasonId, startDate, startDate+seasonLength);
    
    /* update league_season_division table with new season rows */
    set divCount = 1;
    set rowPointer = 1;
    while divCount <= noOfDivs do
		insert into league_season_division (League_id, Season_id, Division_id)
        values (serverId, seasonId, divCount);
        set divCount = divCount + 1;
	end while;
    
    /* append playersort table to division_player table - (this completes the first league season setup) */
    insert into division_player (League_id, Season_id, Division_id, Player_id)
    select League_id, Season_id, Division_id, Player_id
    from playerSort;
END