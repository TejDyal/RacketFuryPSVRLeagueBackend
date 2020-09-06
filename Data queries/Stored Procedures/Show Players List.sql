CREATE DEFINER=`root`@`localhost` PROCEDURE `showAllPlayers`(sortBy varchar(25), loggedIn bool, psnAscending bool, divAscending bool, inLeaguesAscending bool)
BEGIN
	
    /* create copy of players table with additional playingInLeagues coloumn*/
    drop table if exists playersList;
    create table playersList
    (
    Player_id int, PSN_id varchar(45), availability varchar(100), enterInNextLeague int, playingInLeagues varchar(3)
    );
    insert into playersList (Player_id, PSN_id, availability, enterInNextLeague)
	select 
		Player_id,
		PSN_id,
        availability,
        enterInNextLeague
	from player;
    
    /* fill in playingInLeagues column */
    UPDATE playersList
	SET playingInleagues = CASE
    WHEN enterInNextLeague=1 THEN "Yes"
    ELSE "No"
	END;    
	 
    
    /* create a temp table to obtain player divisions */
	drop table if exists playerDivisions;
	create table playerDivisions as
		select dp.League_id, dp.Season_id, dp.Division_id, dp.Player_id
        from division_player dp
        left join league_season ls
			on ls.League_id = dp.League_id
            and ls.Season_id = dp.Season_id
		where endDate > now();
        
	/* join the above two temp tables to show a complete players list with associated divisions */
	select pl.PSN_id as "PSN",
		pl.availability as "Availability",
        (case when loggedIn = true then pd.Division_id
        else pl.playingInLeagues
        end)
    from playersList pl
    left join playerDivisions pd
		on pl.Player_id = pd.Player_id
    order by     
		case when sortBy = "Division_id" and divAscending = true then Division_id end asc,
        case when sortBy = "Division_id" and divAscending = false then Division_id end desc,
		case when sortby = "playingInLeagues" and inLeaguesAscending = true then playingInLeagues end asc,
        case when sortby = "playingInLeagues" and inLeaguesAscending = false then playingInLeagues end desc,
        case when psnAscending = false then PSN_id end desc,
		case when psnAscending = true then PSN_id end asc;

END