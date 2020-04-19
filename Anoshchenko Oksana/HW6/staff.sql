DELIMITER &&
CREATE PROCEDURE insert_staff(IN count INT)
BEGIN
	DECLARE i INT DEFAULT 1;
    WHILE i <= count DO
		INSERT INTO Staff VALUES(
			i,
            CONCAT('firstn_staff_', CAST(i AS CHAR(10))),
            CONCAT('lastn_staff_', CAST(i AS CHAR(10)))            
		);
		SET i = i + 1;
	END WHILE;
END&&

CALL insert_staff(150);