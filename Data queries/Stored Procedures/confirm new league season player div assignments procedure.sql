CREATE DEFINER=`root`@`localhost` PROCEDURE `confirmNewLeagueSeasonSort`()
BEGIN

/* This procedure allows admin to confirm the new season players division assignments 
	in the temporary playerSort table, effectively making the new league season live.
	If confirmed, the playerSort table will be appended to the division_player table */
        
        
/* append playersort table to division_player table */
insert into division_player (League_id, Season_id, Division_id, Player_id)
select League_id, Season_id, Division_id, Player_id
from playerSort;

END