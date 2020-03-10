CREATE TABLE payments (
	payment_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id int NOT NULL,
	payment_sum double NOT NULL,
	payment_dttm timestamp NOT NULL,
	FOREIGN KEY(user_id) REFERENCES users(user_id) ON UPDATE CASCADE
);