DELIMITER &&
CREATE PROCEDURE insert_gamers(IN count INT)
BEGIN
	DECLARE i INT DEFAULT 1;
    WHILE i <= count DO
		INSERT INTO Gamers VALUES(
			i,
            CONCAT('first_name_', CAST(i AS CHAR(10))),
            CONCAT('last_name_', CAST(i AS CHAR(10))),
            RAND() * (30 - 14) + 14,
            RAND() * (1000),
            CONCAT('nickname_', CAST(i AS CHAR(10)))
		);
		SET i = i + 1;
	END WHILE;
END&&

CALL insert_gamers(500);