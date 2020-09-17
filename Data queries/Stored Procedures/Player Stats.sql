CREATE DEFINER=`root`@`localhost` PROCEDURE `playerStats`(playerid int)
BEGIN

	/* This procedure will show:  
			PSN ID
            Date Joined
            Number of Seasons played
            Divisions won  (count number of first rankings)
            Highest Division won
            Highest Division reached
            
            
			Matches History
            
    */
    
        
    declare psnId int;
    declare dateJoined date;
    declare seasonsPlayed int;
    declare divisionsWon int;
    declare highestDivWon int;
    declare highestDivReached int;
    
	declare serverId int;
    set serverId = (select ServerId from player where Player_id = playerId);
	
    /* caluculate all seasons results for the league this player belongs to
		to work out the player's invididual stats */
    call seasonResults (false, seasonId, serverId);
	
    
    set psnId = getPSNid(playerId);
    
    set dateJoined = getDateJoined(playerId);
    
    set seasonsPlayed = getSeasonsPlayed (playerId);
    
    set divisionsWon = getDivisionsWon(playerId);
    
    set highestDivWon = getHighestDivWon(playerId);
    
    -- TODO Matches hisotry
	
    
END