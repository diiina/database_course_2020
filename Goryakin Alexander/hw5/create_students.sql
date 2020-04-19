CREATE TABLE students (
	id int NOT NULL AUTO_INCREMENT,
	stud_name varchar(45) NOT NULL,
	patronymic varchar(45) NOT NULL,
	surname varchar(45) NOT NULL,
	birthdate datetime NOT NULL,
	class_id int NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY(class_id) REFERENCES classes(id) ON UPDATE CASCADE ON DELETE RESTRICT
);