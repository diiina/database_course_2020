DELIMITER &&
CREATE PROCEDURE insert_address(IN count INT)
BEGIN
	DECLARE i INT DEFAULT 1;
    DECLARE num_countries INT;
    DECLARE country_id INT;
    SET num_countries = 207; -- (SELECT count(country_id) FROM Countries)
    WHILE i <= count DO
		SET country_id = FLOOR(RAND() * (num_countries - 1) + 1.5);
		INSERT INTO Address VALUES(
			i,
            country_id,
            CONCAT('address_', CAST(i AS CHAR(10)))
		);
		SET i = i + 1;
	END WHILE;
END&&

CALL insert_address(100);