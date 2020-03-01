CREATE TABLE sessions (
	session_id int(11) NOT NULL AUTO_INCREMENT,
	user_id int(11) NOT NULL,
	begin_dttm timestamp NOT NULL,
	end_dttm timestamp NOT NULL,
	PRIMARY KEY(session_id),
	FOREIGN KEY(user_id) REFERENCES users(user_id) ON UPDATE CASCADE ON DELETE RESTRICT
);