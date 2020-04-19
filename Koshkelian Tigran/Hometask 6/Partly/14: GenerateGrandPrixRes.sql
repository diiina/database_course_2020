DROP PROCEDURE IF EXISTS generate_grand_prix_res;

CREATE PROCEDURE generate_grand_prix_res()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT;
    DECLARE num_grand_prix INT;
    DECLARE max_pilot INT;
    DECLARE pilot INT;
    DECLARE res INT;
    DECLARE CONTINUE HANDLER FOR 1062
        SET j = j - 1;

    SET num_grand_prix = (SELECT count(distinct grandprix_id) FROM Grand_prix);
    SET max_pilot = (SELECT count(distinct pilot_id) FROM Pilots);

    WHILE i <= num_grand_prix
        DO
            SET j = 1;
            WHILE j <= 10
                DO
                    SET pilot = FLOOR(1 + RAND() * (max_pilot - 0.5));
                    # These rules change from time to time,
                    # so we need to keep both the place and the result
                    SET res = CASE j
                                  WHEN 1 THEN 25
                                  WHEN 2 THEN 18
                                  WHEN 3 THEN 15
                                  WHEN 4 THEN 12
                                  WHEN 5 THEN 10
                                  WHEN 6 THEN 8
                                  WHEN 7 THEN 6
                                  WHEN 8 THEN 4
                                  WHEN 9 THEN 2
                                  WHEN 10 THEN 1
                        END;

                    INSERT INTO GrandPrixRes
                    VALUES (i,
                            pilot,
                            res,
                            j);
                    SET j = j + 1;
                END WHILE;
            SET i = i + 1;
        END WHILE;
END;

CALL generate_grand_prix_res();