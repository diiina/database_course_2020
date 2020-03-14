CREATE TABLE `sessions` (
	`session_id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NOT NULL,
    `begin_dttm` TIMESTAMP,
    `end_dttm` TIMESTAMP,
    
    PRIMARY KEY (`session_id`),
    FOREIGN KEY (`user_id`)
		REFERENCES `users` (`user_id`)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);