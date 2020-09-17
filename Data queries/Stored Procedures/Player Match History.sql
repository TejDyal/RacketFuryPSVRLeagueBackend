CREATE DEFINER=`root`@`localhost` PROCEDURE `playerMatchHistory`(playerId int)
BEGIN
	/* shows following info of all mathces played by a player:
    datePlayed Season Division oppoPlayer gamesWonByPlayer gamesWonByOppoPlayer Result 
    */
    drop table if exists playerMatchHistory;
    create table playerMatchHistory as
    select 
		p.LeagueMatch_id,
		datePlayed,
        p.Season_id,
        p.Division_id,
        p.oppo_id,
        PSN_id,
        p.noOfGamesWon as GamesWon,
        oppo.noOfGamesWon as GamesWonByOppo,        
        (select
			case
				when p.noOfGamesWon > (select GamesWonByOppo) then "Won"
                when p.noOfGamesWon < (select GamesWonByOppo) then "Lost"
                when p.noOfGamesWon = (select GamesWonByOppo) then "Draw"
			else
				"No Result"
			end) as Result        
	from player_leaguematch p
    join leaguematch using (LeagueMatch_id)
    join player pl on p.oppo_id = pl.Player_id
    join player_Leaguematch oppo on p.LeagueMatch_id = oppo.LeagueMatch_id and p.oppo_id = oppo.Player_id
    where p.Player_id = playerId;
END