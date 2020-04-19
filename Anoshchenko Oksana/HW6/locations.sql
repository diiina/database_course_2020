DELIMITER &&
CREATE PROCEDURE insert_locations(IN count INT)
BEGIN
	DECLARE i INT DEFAULT 51;
    WHILE i <= count DO
		INSERT INTO Locations VALUES(
			i - 50,
            i,
            FLOOR(RAND() * (1000 - 100) + 100)
		);
		SET i = i + 1;
	END WHILE;
END&&

CALL insert_locations(100);