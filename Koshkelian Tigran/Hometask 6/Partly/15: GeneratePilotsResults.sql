DROP PROCEDURE IF EXISTS generate_pilots_results;

CREATE PROCEDURE generate_pilots_results()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT;
    DECLARE num_championships INT;
    DECLARE max_pilot INT;
    DECLARE pilot INT;
    DECLARE CONTINUE HANDLER FOR 1062
        SET j = j - 1;

    SET num_championships = (SELECT count(distinct championship_id) FROM Championships);
    SET max_pilot = (SELECT count(distinct pilot_id) FROM Pilots);

    WHILE i <= num_championships
        DO
            SET j = 1;
            WHILE j <= 10
                DO
                    SET pilot = FLOOR(1 + RAND() * (max_pilot - 0.5));

                    INSERT INTO ResultsPilots
                    VALUES (i,
                            pilot,
                            j);

                    SET j = j + 1;
                END WHILE;
            SET i = i + 1;
        END WHILE;
END;

CALL generate_pilots_results();