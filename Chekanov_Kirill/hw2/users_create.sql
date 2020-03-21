CREATE TABLE users (
	user_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
	login varchar(256) NOT NULL,
	reg_dttm timestamp NOT NULL
);