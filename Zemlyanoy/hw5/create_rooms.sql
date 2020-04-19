CREATE TABLE IF NOT EXISTS `zemlyanoy_db`.`rooms` (
  `room_id` INT NOT NULL AUTO_INCREMENT,
  `room_number` INT NOT NULL,
  PRIMARY KEY (`room_id`),
  UNIQUE INDEX `room_number_UNIQUE` (`room_number` ASC))
ENGINE = InnoDB
COMMENT = 'Table of rooms in the supposed office / other building(s).'