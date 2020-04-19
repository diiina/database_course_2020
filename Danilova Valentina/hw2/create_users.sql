CREATE TABLE users (
	user_id INT NOT NULL AUTO_INCREMENT,
    login VARCHAR(32) NOT NULL,
    reg_dttm TIMESTAMP NOT NULL,
    PRIMARY KEY(user_id)
);
