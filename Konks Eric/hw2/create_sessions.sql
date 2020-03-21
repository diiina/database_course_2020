CREATE TABLE sessions (
    session_id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    begin_dttm TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    end_dttm TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    PRIMARY KEY (session_id),
    FOREIGN KEY (user_id)
        REFERENCES users (user_id)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB;