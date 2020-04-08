DROP PROCEDURE IF EXISTS generate_teams_results;

CREATE PROCEDURE generate_teams_results()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT;
    DECLARE num_championships INT;
    DECLARE max_team INT;
    DECLARE team INT;
    DECLARE CONTINUE HANDLER FOR 1062
        SET j = j - 1;

    SET num_championships = (SELECT count(distinct championship_id) FROM Championships);
    SET max_team = (SELECT count(distinct team_id) FROM Teams);

    WHILE i <= num_championships
        DO
            SET j = 1;
            WHILE j <= 10
                DO
                    SET team = FLOOR(1 + RAND() * (max_team - 0.5));

                    INSERT INTO ResultsTeams
                    VALUES (i,
                            team,
                            j);

                    SET j = j + 1;
                END WHILE;
            SET i = i + 1;
        END WHILE;
END;

CALL generate_teams_results();