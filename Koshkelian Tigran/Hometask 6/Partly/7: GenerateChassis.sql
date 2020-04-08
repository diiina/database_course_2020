DROP PROCEDURE IF EXISTS generate_chassis;

CREATE PROCEDURE generate_chassis(IN count INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE max_manufacturer INT;
    DECLARE manufacturer INT;
    DECLARE year INT;

    SET max_manufacturer = (SELECT count(distinct manufacturer_id) FROM Manufacturers);

    WHILE i <= count
        DO
            SET manufacturer = FLOOR(1 + RAND() * (max_manufacturer - 0.5));
            SET year = FLOOR(2000 + RAND() * (21 - 0.5));

            INSERT INTO Chassis
            VALUES (i,
                    manufacturer,
                    CONCAT('chassis_', CAST(i AS CHAR(10))),
                    year);

            SET i = i + 1;
        END WHILE;
END;

CALL generate_chassis(100);