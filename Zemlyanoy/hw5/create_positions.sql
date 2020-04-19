CREATE TABLE IF NOT EXISTS `zemlyanoy_db`.`positions` (
  `position_id` INT NOT NULL AUTO_INCREMENT,
  `position_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`position_id`))
ENGINE = InnoDB
COMMENT = 'Table of positions in the supposed company that can be held.'
;