CREATE TABLE IF NOT EXISTS `zemlyanoy_db`.`accesses` (
  `access_id` INT NOT NULL AUTO_INCREMENT,
  `employee_id` INT NOT NULL COMMENT 'All permissions are per employee. It is logical that in many cases permissions are tied to position, \nbut it is easily possible that a permission is granted to a specific person for some kind of task, \nor a permission is rewoked for a specific individual from a group.',
  `room_id` INT NOT NULL,
  `start_time` DATETIME NOT NULL COMMENT 'To represent permission being granted since a specific moment, because it could be granted only for a specific time period.',
  `end_time` DATETIME NULL COMMENT 'A permission can be without a definite end time, but it can have one either.',
  PRIMARY KEY (`access_id`),
  INDEX `employee_id_idx` (`employee_id` ASC),
  INDEX `room_id_idx` (`room_id` ASC),
  CONSTRAINT `fk_accesses_employee_id`
    FOREIGN KEY (`employee_id`)
    REFERENCES `zemlyanoy_db`.`employees` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_accesses_room_id`
    FOREIGN KEY (`room_id`)
    REFERENCES `zemlyanoy_db`.`rooms` (`room_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'Table of permissions to access rooms for individual employees.'
;