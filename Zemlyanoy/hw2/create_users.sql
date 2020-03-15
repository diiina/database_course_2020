CREATE TABLE `users` (
	`user_id` INTEGER NOT NULL AUTO_INCREMENT, 
	`login` VARCHAR(30) NOT NULL, 
	`reg_dttm` TIMESTAMP, 
	
    PRIMARY KEY(`user_id`)
);