DROP PROCEDURE IF EXISTS generate_cars;

CREATE PROCEDURE generate_cars(IN count INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE max_chassis INT;
    DECLARE max_engine INT;
    DECLARE chassis INT;
    DECLARE engine INT;
    SET max_chassis = (SELECT count(distinct chassis_id) FROM Formula_1.Chassis);
    SET max_engine = (SELECT count(distinct engine_id) FROM Engines);
    WHILE i <= count
        DO
            SET chassis = FLOOR(1 + RAND() * (max_chassis - 0.5));
            SET engine = FLOOR(1 + RAND() * (max_engine - 0.5));
            INSERT INTO Cars
            VALUES (
                    i,
                    CONCAT('car_', CAST(i AS CHAR(10))),
                    chassis,
                    engine
                    );
            SET i = i + 1;
        END WHILE;
END;

CALL generate_cars(300);