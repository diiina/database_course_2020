DELIMITER &&
CREATE PROCEDURE insert_organizers(IN count INT)
BEGIN
	DECLARE i INT DEFAULT 1;
    DECLARE num_staff INT;
    DECLARE staff_id INT;
    DECLARE num_events INT;
    DECLARE event_id INT;
    
    SET num_staff = 150; -- SELECT count(staff_id) FROM Staff
    
    SET num_events = 100; -- SELECT count(event_id) FROM EventsForGamers
    
    WHILE i <= count DO
		SET staff_id = RAND() * (num_staff - 1) + 1;
        SET event_id = RAND() * (num_events - 1) + 1;
		INSERT INTO Organizers VALUES(
			i,
            staff_id,
            event_id
		);
		SET i = i + 1;
	END WHILE;
END&&

CALL insert_organizers(500);