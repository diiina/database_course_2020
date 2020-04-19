CREATE TABLE payments (
	payment_id int(11) NOT NULL AUTO_INCREMENT,
    user_id int(11) NOT NULL,
    payment_sum double NOT NULL,
    payment_dttm timestamp NOT NULL,
    PRIMARY KEY (payment_id),
    FOREIGN KEY(user_id) 
	  REFERENCES users(user_id)
      ON UPDATE CASCADE ON DELETE RESTRICT
);
