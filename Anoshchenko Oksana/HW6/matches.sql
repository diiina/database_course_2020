DELIMITER &&
CREATE PROCEDURE insert_matches(IN count INT)
BEGIN
	DECLARE i INT DEFAULT 1;
    DECLARE num_teams INT;
    DECLARE team1_id INT;
    DECLARE team2_id INT;
    DECLARE winner INT;
    DECLARE begin_dttm TIMESTAMP;
    DECLARE end_dttm TIMESTAMP;
    
    SET num_teams = 100; -- SELECT count(team_id) FROM Teams
    
    SET begin_dttm = 
    (SELECT
    FROM_UNIXTIME(
		FLOOR(
			RAND() * 
			(UNIX_TIMESTAMP('2020-06-20 00:00:00') - UNIX_TIMESTAMP('2020-02-20 00:00:00'))
			+ UNIX_TIMESTAMP('2020-02-20 00:00:00')
		)
	));
    
    SET end_dttm = 
    (SELECT
    FROM_UNIXTIME(
		FLOOR(
			RAND() * 
			(UNIX_TIMESTAMP('2020-08-20 00:00:00') - UNIX_TIMESTAMP(begin_dttm))
			+ UNIX_TIMESTAMP(begin_dttm)
		)
	));
    
    WHILE i <= count DO
        SET team1_id = FLOOR(RAND() * (num_teams - 1) + 1.5);
        SET team2_id = FLOOR(RAND() * (num_teams - 1) + 1.5);
        
        IF (team1_id = team2_id) THEN
			IF (team1_id = 100) THEN
				SET team2_id = 1;
			ELSE
				SET team2_id = team2_id + 1;
			END IF;
		END IF;
        
        SET winner = RAND() * 2;
        
        IF (winner < 1) THEN
			SET winner = team1_id;
		ELSE
			SET winner = team2_id;
		END IF;
        
		INSERT INTO Matches VALUES(
			i,
            team1_id,
            team2_id,
            winner,
            RAND() * 10,
            begin_dttm,
            end_dttm
		);
		SET i = i + 1;
	END WHILE;
END&&

CALL insert_matches(500);