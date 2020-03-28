CREATE TABLE IF NOT EXISTS `zemlyanoy_db`.`position_changes` (
  `change_id` INT NOT NULL AUTO_INCREMENT,
  `employee_id` INT NOT NULL,
  `old_position` INT NOT NULL,
  `new_position` INT NOT NULL,
  `change_date` DATE NOT NULL,
  PRIMARY KEY (`change_id`),
  INDEX `fk_position_changes_employee_id_idx` (`employee_id` ASC) VISIBLE,
  INDEX `fk_position_changes_old_position_idx` (`old_position` ASC) VISIBLE,
  INDEX `fk_position_changes_new_position_idx` (`new_position` ASC) VISIBLE,
  CONSTRAINT `fk_position_changes_employee_id`
    FOREIGN KEY (`employee_id`)
    REFERENCES `zemlyanoy_db`.`employees` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_position_changes_old_position`
    FOREIGN KEY (`old_position`)
    REFERENCES `zemlyanoy_db`.`positions` (`position_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_position_changes_new_position`
    FOREIGN KEY (`new_position`)
    REFERENCES `zemlyanoy_db`.`positions` (`position_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'History of all changes in position of existing employees.'
;