DELIMITER &&
CREATE PROCEDURE insert_events(IN count INT)
BEGIN
	DECLARE i INT DEFAULT 1;
    DECLARE num_locations INT;
    DECLARE location_id INT;
    DECLARE begin_dttm TIMESTAMP;
    DECLARE end_dttm TIMESTAMP;
    
    SET num_locations = 50; -- (SELECT count(location_id) FROM Locations)
    SET begin_dttm = 
    (SELECT
    FROM_UNIXTIME(
		FLOOR(
			RAND() * 
			(UNIX_TIMESTAMP('2020-06-20 00:00:00') - UNIX_TIMESTAMP('2020-02-20 00:00:00'))
			+ UNIX_TIMESTAMP('2020-02-20 00:00:00')
		)
	));
    
    SET end_dttm = 
    (SELECT
    FROM_UNIXTIME(
		FLOOR(
			RAND() * 
			(UNIX_TIMESTAMP('2020-08-20 00:00:00') - UNIX_TIMESTAMP(begin_dttm))
			+ UNIX_TIMESTAMP(begin_dttm)
		)
	));
    
    WHILE i <= count DO
		SET location_id = RAND() * (num_locations - 1) + 1;
		INSERT INTO EventsForGamers VALUES(
			i,
            location_id,
            CONCAT('event_name_', CAST(i AS CHAR(10))),
            begin_dttm,
            end_dttm
		);
		SET i = i + 1;
	END WHILE;
END&&

CALL insert_events(100);