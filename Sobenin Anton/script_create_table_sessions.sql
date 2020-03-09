CREATE TABLE IF NOT EXISTS tt.sessions
(
	session_id INT AUTO_INCREMENT,
    user_id INT,
    begin_dttm TIMESTAMP,
    end_dttm TIMESTAMP,
    PRIMARY KEY (session_id),
    FOREIGN KEY (user_id) REFERENCES tt.users (user_id)
);
