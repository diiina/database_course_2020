DROP PROCEDURE IF EXISTS generate_team_pilot;

CREATE PROCEDURE generate_team_pilot(IN count INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE max_team INT;
    DECLARE max_pilot INT;
    DECLARE pilot INT;
    DECLARE team INT;
    DECLARE begin DATE;
    DECLARE end DATE;
    DECLARE all_time INT;

    DECLARE CONTINUE HANDLER FOR 1062
        SET i = i - 1;

    SET max_team = (SELECT count(distinct team_id) FROM Teams);
    SET max_pilot = (SELECT count(distinct pilot_id) FROM Pilots);
    SET all_time = UNIX_TIMESTAMP('2020-04-01 00:00:00') - UNIX_TIMESTAMP('2000-01-01 00:00:00');

    WHILE i <= count
        DO
            SET pilot = FLOOR(1 + RAND() * (max_pilot - 0.5));
            SET team = FLOOR(1 + RAND() * (max_team - 0.5));
            SET begin = DATE(
                    FROM_UNIXTIME(
                                UNIX_TIMESTAMP('2000-01-01 00:00:00') +
                                (i - 0.9) * all_time / count +
                                FLOOR(
                                        RAND() * 0.8 * all_time / count
                                    )
                        )
                );
            SET end = DATE(
                    FROM_UNIXTIME(
                                UNIX_TIMESTAMP(begin) +
                                FLOOR(
                                            RAND() *
                                            (
                                                    UNIX_TIMESTAMP('2020-04-01 00:00:00') -
                                                    UNIX_TIMESTAMP(begin)
                                                )
                                    )
                        )
                );

            INSERT INTO TeamPilot
            VALUES (pilot,
                    team,
                    begin,
                    end);

            SET i = i + 1;
        END WHILE;
END;

CALL generate_team_pilot(500);
