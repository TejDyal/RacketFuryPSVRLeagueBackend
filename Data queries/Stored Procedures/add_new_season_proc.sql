CREATE DEFINER=`root`@`localhost` PROCEDURE `add_new_season`(in seasonId int)
BEGIN
	select max(Season_id) s from season;
    if seasonId > s then
		INSERT INTO season (`Season_id`) VALUES ('seasonId');
	end if;
END