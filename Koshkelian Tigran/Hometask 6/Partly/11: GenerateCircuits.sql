DROP PROCEDURE IF EXISTS generate_circuits;

CREATE PROCEDURE generate_circuits(IN count INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE max_location INT;
    DECLARE location INT;
    DECLARE length DECIMAL(4, 2);

    SET max_location = (SELECT count(distinct location_id) FROM Locations);

    WHILE i <= count
        DO
            SET location = FLOOR(1 + RAND() * (max_location - 0.5));
            SET length = 4 + RAND() * 2;

            INSERT INTO Circuits
            VALUES (i,
                    CONCAT('circuit_', CAST(i AS CHAR(10))),
                    location,
                    length);

            SET i = i + 1;
        END WHILE;
END;

CALL generate_circuits(200);