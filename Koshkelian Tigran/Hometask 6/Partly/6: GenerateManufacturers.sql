DROP PROCEDURE IF EXISTS generate_manufacturers;

CREATE PROCEDURE generate_manufacturers(IN count INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE max_country INT;
    DECLARE country INT;

    SET max_country = (SELECT count(distinct country_id) FROM Countries);

    WHILE i <= count
        DO
            SET country = FLOOR(1 + RAND() * (max_country - 0.5));

            INSERT INTO Manufacturers
            VALUES (i,
                    CONCAT('manufacturer_', CAST(i AS CHAR(10))),
                    CONCAT('http://manufacturer', CAST(i AS CHAR(10)), '.com'),
                    country);

            SET i = i + 1;
        END WHILE;
END;

CALL generate_manufacturers(100);