CREATE TABLE IF NOT EXISTS tt.users
(
	user_id INT AUTO_INCREMENT,
    login VARCHAR(32),
    reg_dttm TIMESTAMP,
    PRIMARY KEY (user_id)
);
