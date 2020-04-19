CREATE TABLE payments (
	payment_id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    payment_sum DOUBLE NOT NULL,
    payment_dttm TIMESTAMP NOT NULL,
    PRIMARY KEY(payment_id),
    FOREIGN KEY(user_id)
	  REFERENCES users(user_id)
      ON UPDATE CASCADE ON DELETE RESTRICT
);
 