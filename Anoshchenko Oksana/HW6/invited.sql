DELIMITER &&
CREATE PROCEDURE insert_invited(IN count INT)
BEGIN
	DECLARE i INT DEFAULT 1;
    DECLARE num_gamers INT;
    DECLARE gamer_id INT;
    DECLARE num_events INT;
    DECLARE event_id INT;
    
    SET num_gamers = 500; -- SELECT count(gamer_id) FROM Gamers
    
    SET num_events = 100; -- SELECT count(event_id) FROM EventsForGamers
    
    WHILE i <= count DO
		SET gamer_id = RAND() * (num_gamers - 1) + 1;
        SET event_id = RAND() * (num_events - 1) + 1;
		INSERT INTO Invited VALUES(
			i,
            event_id,
            gamer_id
		);
		SET i = i + 1;
	END WHILE;
END&&

CALL insert_invited(500);