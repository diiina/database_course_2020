CREATE TABLE users (
	user_id int(11) NOT NULL AUTO_INCREMENT,
	login varchar(256) NOT NULL,
	reg_dttm timestamp NOT NULL,
	PRIMARY KEY(user_id)
);