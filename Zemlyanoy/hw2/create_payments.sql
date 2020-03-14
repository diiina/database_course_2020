CREATE TABLE `payments` (
	`payment_id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NOT NULL,
    `payment_sum` DOUBLE,
    `payment_dttm` TIMESTAMP,
    
    PRIMARY KEY (`payment_id`),
    FOREIGN KEY (`user_id`)	
		REFERENCES `users` (`user_id`)
		ON UPDATE CASCADE
        ON DELETE NO ACTION
);
