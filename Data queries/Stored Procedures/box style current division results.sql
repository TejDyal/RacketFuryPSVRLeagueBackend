CREATE DEFINER=`root`@`localhost` PROCEDURE `divisionProgress`(playerId int)
BEGIN

	/* This Procedure calculates the "box gid style" current results for the logged in player's division in the current season
    */

	declare serverId int;
    declare seasonId int;
    declare divisionId int;
    declare player1index int;
    declare player2index int;
    declare playersInDiv int;
    
    set serverId = (select Server_Id 
					from player 
                    where Player_id = playerId
                    );    
    set seasonId = (select Season_id 
					from league_season 
					where League_id = serverId 
						and ((curdate()>=startDate and curdate()<=endDate)
							or (curdate()>=startDate and curdate()>endDate))
					);
	set divisionId = (select Division_id 
						from division_player 
                        where League_id = serverId 
							and Season_id= seasonId 
                            and Player_id = playerId
					);
    
    -- temp table acts as an array of players in the Div with a rownumber index
    drop table if exists playersInDiv;
    create table playersInDiv as
    select Player_id, row_number() over (order by Player_id) as rowNum
    from division_player
    where League_id = serverId 
		and Season_id = seasonId 
        and Division_id = divisionId;
    
    -- create a table listing all match player pairings 
	drop table if exists divMatches;
    create table divMatches (player1_id int, player2_id int);    
    set player1index = 1;
    set player2index = 2;
    set playersInDiv = (select max(rowNum) from playersInDiv);
    while player1index <= playersInDiv do
		while player2index <= playersInDiv do
			if player1index != player2index then
				insert into divMatches (player1_id, player2_id)
				select Player_id,
					(select Player_id
					from playersInDiv
					where rowNum=player2index)
				from playersInDiv
				where rowNum=player1index;
			end if;
            set player2index:=player2index+1;
		end while;
        set player2index = 1;
        set player1index:=player1index+1;
	end while;
    
    -- TODO add PSN, points and game difference columns
    
    select 
		player1_id,
        player2_id,
        (select noOfGamesWon 
			from player_leaguematch 
			where Season_id = seasonId
				and League_id = serverId
                and Division_id = divisionId
                and Player_id = player1_id
                and oppo_id = player2_id) as p1_score,
		(select noOfGamesWon 
			from player_leaguematch 
			where Season_id = seasonId
				and League_id = serverId
                and Division_id = divisionId
                and Player_id = player2_id
                and oppo_id = player1_id) as p2_score
	from divMatches;
        
END