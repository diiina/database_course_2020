DROP PROCEDURE IF EXISTS generate_teams;

CREATE PROCEDURE generate_teams(IN count INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE max_country INT;
    DECLARE country INT;

    SET max_country = (SELECT count(distinct country_id) FROM Countries);

    WHILE i <= count
        DO
            SET country = FLOOR(1 + RAND() * (max_country - 0.5));

            INSERT INTO Teams
            VALUES (i,
                    CONCAT('team_', CAST(i AS CHAR(10))),
                    country,
                    CONCAT('http://team', CAST(i AS CHAR(10)), '.com'));

            SET i = i + 1;
        END WHILE;
END;

CALL generate_teams(150);