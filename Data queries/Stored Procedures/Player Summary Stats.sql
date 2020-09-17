CREATE DEFINER=`root`@`localhost` PROCEDURE `playerSummaryStats`(playerId int)
BEGIN

	/* This procedure will show:  
			PSN ID
            Date Joined
            Number of Seasons played
            Divisions won  (count number of first rankings)
            Highest Division won
            Highest Division reached
    */
    
	declare serverId int;
    set serverId = (select Server_Id from player where Player_id = playerId);
	
    /* caluculate all seasons results for the league this player belongs to
		to work out the player's invididual stats */
    call seasonResults (false, 0, serverId);
	
    drop table if exists playerStats;
    create table playerStats (
		Player_id int,
		psnId varchar(45),
        dateJoined date,
        seasonsPlayed int,
        divisionsWon int,
        highestDivWon int,
        highestDivReached int);        
	insert into playerStats (
		`Player_id`,
		`psnId`,
        `dateJoined`,
        `seasonsPlayed`,
        `divisionsWon`,
        `highestDivWon`)
    values (
		playerId,
		getPSNid(playerId),
        getDateJoined(playerId),
        getSeasonsPlayed(playerId),
        getDivisionsWon(playerId),
        getHighestDivWon(playerId)
        );
END