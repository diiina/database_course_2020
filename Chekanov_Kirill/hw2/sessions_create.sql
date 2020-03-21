CREATE TABLE sessions (
	session_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id int NOT NULL,
	begin_dttm timestamp NOT NULL,
	end_dttm timestamp NOT NULL,
	FOREIGN KEY(user_id) REFERENCES users(user_id) ON UPDATE CASCADE
);