DELIMITER &&
CREATE PROCEDURE insert_line_up(IN count INT)
BEGIN
	DECLARE i INT DEFAULT 1;
    
    WHILE i <= count DO
		INSERT INTO Line_up VALUES(
			i,
            i,
            (i - 1) DIV 5 + 1
		);
		SET i = i + 1;
	END WHILE;
END&&

CALL insert_line_up(500);