CREATE DEFINER=`root`@`localhost` FUNCTION `getMaxRow`() RETURNS int
    READS SQL DATA
BEGIN
	declare maxRow int;
	select max(rowNum)
    into maxRow
    from playerSort;
RETURN maxRow;
END