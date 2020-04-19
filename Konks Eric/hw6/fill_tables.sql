DELIMITER //
CREATE PROCEDURE generate_users(IN count INT)
BEGIN
	DECLARE iter INT DEFAULT 1;
    WHILE iter <= count DO
		INSERT INTO users VALUES (
			iter, 
			CONCAT("login_", CAST(iter AS CHAR(10))),
			FLOOR(0 + RAND() * 100000)
		);
		SET iter = iter + 1;
    END WHILE;
END//

DELIMITER //
CREATE PROCEDURE generate_payments(IN count INT)
BEGIN
	DECLARE iter INT DEFAULT 1;
    DECLARE users_count INT;
    SET users_count = (SELECT COUNT(DISTINCT user_id) FROM users);
    WHILE iter <= count DO
		INSERT INTO payments VALUES (
			iter,
            FLOOR(1 + RAND() * (users_count - 1)),
            FLOOR(0 + RAND() * 100000),
            FROM_UNIXTIME(UNIX_TIMESTAMP('2018-01-01 00:00:00') + FLOOR(0 + (RAND() * 63072000)))
        );
        SET iter = iter + 1;
    END WHILE;
END//

DELIMITER //
CREATE PROCEDURE generate_sessions(IN count INT)
BEGIN
	DECLARE iter INT DEFAULT 1;
    DECLARE users_count INT;
    DECLARE reg_dttm TIMESTAMP;
    SET users_count = (SELECT COUNT(DISTINCT user_id) FROM users);
    WHILE iter <= count DO
		SET reg_dttm = FROM_UNIXTIME(UNIX_TIMESTAMP('2018-01-01 00:00:00') + FLOOR(0 + (RAND() * 63072000)));
		INSERT INTO sessions VALUES (
			iter,
            FLOOR(1 + RAND() * (users_count - 1)),
            reg_dttm,
            FROM_UNIXTIME(UNIX_TIMESTAMP(reg_dttm) + FLOOR(0 + (RAND() * 86400)))
        );
        SET iter = iter + 1;
    END WHILE;
END//

DELIMITER //
CREATE PROCEDURE generate_withdrawals(IN count INT)
BEGIN
	DECLARE iter INT DEFAULT 1;
    DECLARE users_count INT;
    SET users_count = (SELECT COUNT(DISTINCT user_id) FROM users);
    WHILE iter <= count DO
		INSERT INTO withdrawals VALUES (
			iter,
            FLOOR(1 + RAND() * (users_count - 1)),
            FLOOR(0 + RAND() * 100000),
            FROM_UNIXTIME(UNIX_TIMESTAMP('2018-01-01 00:00:00') + FLOOR(0 + (RAND() * 63072000)))
        );
        SET iter = iter + 1;
    END WHILE;
END//

DELIMITER //
CREATE PROCEDURE generate_teams(IN count INT)
BEGIN
	DECLARE iter INT DEFAULT 1;
    WHILE iter <= count DO
		INSERT INTO teams VALUES (
			iter, 
			CONCAT("team_", CAST(iter AS CHAR(10)))
		);
		SET iter = iter + 1;
    END WHILE;
END//

DELIMITER //
CREATE PROCEDURE generate_games(IN count INT)
BEGIN
	DECLARE iter INT DEFAULT 1;
    DECLARE teams_count INT;
    DECLARE team1 INT;
    DECLARE team2 INT;
    DECLARE winner INT;
    SET teams_count = (SELECT COUNT(DISTINCT team_id) FROM teams);
    WHILE iter <= count DO
		SET team1 = FLOOR(1 + RAND() * (teams_count - 1));
        SET team2 = FLOOR(1 + RAND() * (teams_count - 1));
        WHILE team2 = team1 DO
			SET team2 = FLOOR(1 + RAND() * (teams_count - 1));
		END WHILE;
        SET winner = IF(RAND() < 0.5, team1, team2);
		INSERT INTO games VALUES (
			iter,
            team1,
            team2,
            winner,
			FROM_UNIXTIME(UNIX_TIMESTAMP('2018-01-01 00:00:00') + FLOOR(0 + (RAND() * 63072000))),
            RAND()
		);
		SET iter = iter + 1;
    END WHILE;
END//

DELIMITER //
CREATE PROCEDURE generate_bets(IN count INT)
BEGIN
	DECLARE iter INT DEFAULT 1;
    DECLARE users_count INT;
    DECLARE teams_count INT;
    DECLARE games_count INT;
    DECLARE game INT;
    DECLARE winner INT;
    SET users_count = (SELECT COUNT(DISTINCT user_id) FROM users);
    SET teams_count = (SELECT COUNT(DISTINCT team_id) FROM teams);
    SET games_count = (SELECT COUNT(DISTINCT game_id) FROM games);
    WHILE iter <= count DO
		SET game = FLOOR(1 + RAND() * (games_count - 1));
		SET winner = IF(
			RAND() < 0.5,
			(SELECT team1_id FROM games WHERE game_id = game),
			(SELECT team2_id FROM games WHERE game_id = game)
        ); 
		INSERT INTO bets VALUES (
			iter,
            FLOOR(1 + RAND() * (users_count - 1)),
            FLOOR(1 + RAND() * (games_count - 1)),
            winner,
            FLOOR(1 + RAND() * 1000),
			FROM_UNIXTIME(UNIX_TIMESTAMP('2018-01-01 00:00:00') + FLOOR(0 + (RAND() * 63072000)))
		);
		SET iter = iter + 1;
    END WHILE;
END//

CALL generate_users(300);
CALL generate_payments(300);
CALL generate_sessions(300);
CALL generate_withdrawals(300);
CALL generate_teams(300);
CALL generate_games(300);
CALL generate_bets(300);
