	-- number of players in each current division that play in next season
    -- change where League_id and Season_id = to appropriate values
    
	drop view if exists countPlayersPerDiv;
	create view countPlayersPerDiv as
		select Division_id, count(Player_id)
		from division_player dp
		join player p using (Player_id)
		where enterInNextSeason = 1 and League_id = 1 and Season_id = 1
		group by Division_id
		order by Division_id;