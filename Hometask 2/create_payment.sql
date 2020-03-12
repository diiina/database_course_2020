CREATE TABLE Payments(
    payment_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    payment_sum DECIMAL NOT NULL ,
    payment_dttm TIMESTAMP NOT NULL,
    CONSTRAINT payments_users_fk
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

