DELIMITER &&
CREATE PROCEDURE insert_hostels(IN count INT)
BEGIN
	DECLARE i INT DEFAULT 1;
    WHILE i <= count DO
		INSERT INTO Hostels VALUES(
			i,
            i
		);
		SET i = i + 1;
	END WHILE;
END&&

CALL insert_hostels(50);