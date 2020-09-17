CREATE DEFINER=`root`@`localhost` FUNCTION `getMaxDiv`() RETURNS int
    READS SQL DATA
BEGIN
	declare maxDiv int;
	select max(Division_id)
    into maxDiv
    from playerSort;
RETURN maxDiv;
END