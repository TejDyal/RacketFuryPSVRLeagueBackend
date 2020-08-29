CREATE DEFINER=`root`@`localhost` PROCEDURE `firstSeasonLeagueSetup`(in serverId int, seasonId int, maxPlayersInDiv int, minPlayersInDiv int, startDate date, seasonLength int)
begin

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
	
    /* sort all players playing in next season by their self rating and add a row index */
	drop table if exists playerSort;
    create table playerSort
    (
    League_id int, Season_id int, Division_id int, Player_id int, selfRating int, row_num int
    );
    set @row_number = 0;
    insert into playerSort (Player_id, selfRating, row_num)
	select 
		player_id,
        selfRating,
        @row_number:=@row_number+1
	from player
	where Server_id = serverId and enterInNextLeague = 1
	order by selfRating;
    
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
    
	/* TODO determine if there is sufficient players in the bottom division.  If there isn't then spread players into immediate upper divisions. Make sure to test there is enough divisions above.*/
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
    

    
    
end