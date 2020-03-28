CREATE TABLE marks (
	id int NOT NULL AUTO_INCREMENT,
	student_id int NOT NULL,
	subject_id int NOT NULL,
	mark int NOT NULL,
	mark_date date NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY(student_id) REFERENCES students(id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY(subject_id) REFERENCES subjects(id) ON UPDATE CASCADE ON DELETE RESTRICT
);