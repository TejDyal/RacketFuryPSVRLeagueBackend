CREATE PROCEDURE `newSeasonLeagueSetup`(in serverId int,
											seasonId int, 
											maxPlayersInDiv int, 
											minPlayersInDiv int, 
											startDate date, 
											endDate date,
											seasonLength int)
BEGIN
	declare noOfDivs int;
    declare currentDivPlayerCount int;
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
                sum(noOfGamesWon) as gamesWon,            
				gamesCount(serverId, seasonId, Division_id, Player_Id) as gamesCount,
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
 
	select count(Player_id)
    into currentDivPlayerCount
    from playerSort;
            
	-- add in the new players in new season
	alter table playerSort
    add column selfRating int,
    add column rowNum int;
    insert into playersort (Division_id, Player_id, selfRating)
		select 0, Player_id, selfRating
		from player
		where Player_id not in (
			select Player_id
			from playerSort)
			and enterInNextSeason = 1
			and Server_id = serverId
		order by selfRating;
        
	select count(Player_id)
    into playerCount
    from playerSort;	
    
	set @rowNum = 0;
	update playerSort
		set rowNum = @rowNum:=@rowNum+1;
    
    /* calculate number of divisions needed */
    set noOfDivs = 0;
    select count(Player_id)
    into playerCount
    from playerSort;
    set noOfDivs = ceiling(playerCount/maxPlayersInDiv);
    
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
		end);
        
    -- TODO assign returning players who had a break to the divisions they were last promoted, remained or relegated to  (implement this when doing the third season simulation)
	
    -- fill in the player gaps in the divisions from top to bottom with 
END