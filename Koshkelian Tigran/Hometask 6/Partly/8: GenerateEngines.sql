DROP PROCEDURE IF EXISTS generate_engines;

CREATE PROCEDURE generate_engines(IN count INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE max_manufacturer INT;
    DECLARE manufacturer INT;
    DECLARE year INT;
    DECLARE volume DECIMAL(2, 1);
    DECLARE power INT;
    DECLARE frequency INT;

    SET max_manufacturer = (SELECT count(distinct manufacturer_id) FROM Manufacturers);

    WHILE i <= count
        DO
            SET manufacturer = FLOOR(1 + RAND() * (max_manufacturer - 0.5));
            SET year = FLOOR(2000 + RAND() * (21 - 0.5));
            SET volume = 3 + RAND() * 2;
            SET power = FLOOR(300 + RAND() * 200);
            SET frequency = FLOOR(3000 + RAND() * 2000);

            INSERT INTO Engines
            VALUES (i,
                    manufacturer,
                    CONCAT('engine_', CAST(i AS CHAR(10))),
                    year,
                    volume,
                    power,
                    frequency);

            SET i = i + 1;
        END WHILE;
END;

CALL generate_engines(100);