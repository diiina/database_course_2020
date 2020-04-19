CREATE TABLE users (
    user_id INT NOT NULL AUTO_INCREMENT,
    user_login VARCHAR(16) NOT NULL,
    user_balance BIGINT NOT NULL,
    PRIMARY KEY (user_id)
) ENGINE=INNODB;

CREATE TABLE payments (
    payment_id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    payment_sum DOUBLE NOT NULL,
    payment_dttm TIMESTAMP NOT NULL,
    PRIMARY KEY (payment_id),
    FOREIGN KEY (user_id)
        REFERENCES users (user_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=INNODB;

CREATE TABLE sessions (
    session_id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    begin_dttm TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    end_dttm TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    PRIMARY KEY (session_id),
    FOREIGN KEY (user_id)
        REFERENCES users (user_id)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=INNODB;

CREATE TABLE withdrawals (
	withdrawal_id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    withdrawal_sum DOUBLE NOT NULL,
    withdrawal_dttm TIMESTAMP NOT NULL,
    PRIMARY KEY (withdrawal_id),
    FOREIGN KEY (user_id)
        REFERENCES users (user_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=INNODB;

CREATE TABLE teams (
	team_id INT NOT NULL AUTO_INCREMENT,
	team_name VARCHAR(36) NOT NULL,
    PRIMARY KEY (team_id)
) ENGINE=INNODB;

CREATE TABLE games (
	game_id INT NOT NULL AUTO_INCREMENT,
    team1_id INT NOT NULL,
    team2_id INT NOT NULL,
    winner_id INT,
    game_dttm TIMESTAMP,
	ratio FLOAT NOT NULL,
    PRIMARY KEY (game_id),
    FOREIGN KEY (team1_id)
		REFERENCES teams (team_id)
		ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (team2_id)
		REFERENCES teams (team_id)
		ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (winner_id)
		REFERENCES teams (team_id)
		ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=INNODB;

CREATE TABLE bets (
	bet_id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    game_id INT NOT NULL,
    winner_id INT NOT NULL,
    bet_sum DOUBLE NOT NULL,
    bet_dttm TIMESTAMP NOT NULL,
    PRIMARY KEY (bet_id),
    FOREIGN KEY (user_id)
		REFERENCES users (user_id)
		ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (game_id)
		REFERENCES games (game_id)
		ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (winner_id)
		REFERENCES teams (team_id)
		ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=INNODB;
