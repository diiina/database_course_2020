CREATE TABLE IF NOT EXISTS `zemlyanoy_db`.`employees` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL COMMENT 'Technically might be possible to have an employee with no last name, but that can be ignored in this simple model.',
  `birth_date` DATE NOT NULL,
  `position_id` INT NOT NULL,
  `hired_date` DATE NOT NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `position_id_idx` (`position_id` ASC),
  CONSTRAINT `fk_position_id`
    FOREIGN KEY (`position_id`)
    REFERENCES `zemlyanoy_db`.`positions` (`position_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'Table of employee records.'
;