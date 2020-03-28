CREATE TABLE teachers (
	id int NOT NULL AUTO_INCREMENT,
	name varchar(45) NOT NULL,
	patronymic varchar(45) NOT NULL,
	surname varchar(45) NOT NULL,
	leadership boolean NOT NULL,
	birthdate datetime NOT NULL,
	salary double NOT NULL,
	PRIMARY KEY (id)
);