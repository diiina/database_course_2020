CREATE TABLE classes (
	id int NOT NULL AUTO_INCREMENT,
	class_name varchar(4) NOT NULL,
	teacher_id int,
	PRIMARY KEY (id),
	FOREIGN KEY(teacher_id) REFERENCES teachers(id) ON UPDATE CASCADE ON DELETE RESTRICT
);