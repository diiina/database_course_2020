CREATE TABLE Sessions(
    session_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    begin_dttm TIMESTAMP NOT NULL ,
    end_dttm TIMESTAMP NOT NULL,
    CONSTRAINT sessions_users_fk
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
