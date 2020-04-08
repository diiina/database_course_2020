DROP PROCEDURE IF EXISTS generate_grand_prix;

CREATE PROCEDURE generate_grand_prix(IN count INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE max_championship INT;
    DECLARE max_circuit INT;
    DECLARE championship INT;
    DECLARE circuit INT;
    DECLARE championship_begin INT;
    DECLARE championship_end INT;
    DECLARE begin DATE;
    DECLARE all_time INT;

    DECLARE CONTINUE HANDLER FOR 1062
        SET i = i - 1;

    SET max_championship = (SELECT count(distinct championship_id) FROM Championships);
    SET max_circuit = (SELECT count(distinct circuit_id) FROM Circuits);

    WHILE i <= count
        DO
            SET circuit = FLOOR(1 + RAND() * (max_circuit - 0.5));
            SET championship = FLOOR(1 + RAND() * (max_championship - 0.5));
            SET championship_begin = (SELECT UNIX_TIMESTAMP(date_begin)
                                      FROM Championships
                                      WHERE championship_id = championship);
            SET championship_end = (SELECT UNIX_TIMESTAMP(date_begin)
                                    FROM Championships
                                    WHERE championship_id = championship);
            SET all_time = championship_begin - championship_end;
            SET begin = DATE(
                    FROM_UNIXTIME(
                                championship_begin +
                                FLOOR(
                                        RAND() * all_time
                                    )
                        )
                );

            INSERT INTO Grand_prix
            VALUES (i,
                    CONCAT('grandprix_', CAST(i AS CHAR(10))),
                    championship,
                    circuit,
                    begin);

            SET i = i + 1;
        END WHILE;
END;

CALL generate_grand_prix(500);