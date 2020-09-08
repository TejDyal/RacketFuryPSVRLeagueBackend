-- create a view of players total points by division
drop view if exists tallyPlayerPointsbyDiv;
create view tallyPlayerPointsbyDiv as
	select Season_id, League_id, Division_id, Player_id, sum(points) as totalPoints, sum(noOfGamesWon) as gamesWon
	from player_leaguematch
	group by Season_id, League_id, Division_id, Player_id
	order by Season_id, League_id, Division_id, totalPoints desc, gamesWon desc;

-- rank players by division
select
	Season_id, 
	League_id, 
	Division_id, 
	Player_id, 
	totalPoints, 
	gamesWon,
	rank() over (partition by Season_id,
							League_id,
							Division_id
	order by totalPoints desc, gamesWon desc) playerRank
from
	tallyPlayerPointsbyDiv;
    
    
