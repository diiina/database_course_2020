DROP PROCEDURE IF EXISTS generate_championships;

CREATE PROCEDURE generate_championships(IN count INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE begin DATE;
    DECLARE end DATE;
    DECLARE all_time INT;
    SET all_time = UNIX_TIMESTAMP('2020-04-01 00:00:00') - UNIX_TIMESTAMP('2000-01-01 00:00:00');
    WHILE i <= count
        DO
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
                                FLOOR(RAND() *
                                      FLOOR(
                                              all_time / count
                                          )
                                    )
                        )
                );
            INSERT INTO Championships
            VALUES (i,
                    CONCAT('championship_', CAST(i AS CHAR(10))),
                    begin,
                    end);
            SET i = i + 1;
        END WHILE;
END;

CALL generate_championships(100);