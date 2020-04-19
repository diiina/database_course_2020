DROP PROCEDURE IF EXISTS generate_car_pilot;

CREATE PROCEDURE generate_car_pilot(IN count INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE max_car INT;
    DECLARE max_pilot INT;
    DECLARE pilot INT;
    DECLARE car INT;
    DECLARE begin DATE;
    DECLARE end DATE;
    DECLARE all_time INT;

    DECLARE CONTINUE HANDLER FOR 1062
        SET i = i - 1;

    SET max_car = (SELECT count(distinct car_id) FROM Cars);
    SET max_pilot = (SELECT count(distinct pilot_id) FROM Pilots);
    SET all_time = UNIX_TIMESTAMP('2020-04-01 00:00:00') - UNIX_TIMESTAMP('2000-01-01 00:00:00');

    WHILE i <= count
        DO
            SET pilot = FLOOR(1 + RAND() * (max_pilot - 0.5));
            SET car = FLOOR(1 + RAND() * (max_car - 0.5));
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
                                            RAND() * (
                                                UNIX_TIMESTAMP('2020-04-01 00:00:00') -
                                                UNIX_TIMESTAMP(begin)
                                            )
                                    )
                        )
                );

            INSERT INTO CarPilot (pilot_id, car_id, date_begin, date_end)
            VALUES (pilot,
                    car,
                    begin,
                    end);

            SET i = i + 1;
        END WHILE;
END;

CALL generate_car_pilot(500);
