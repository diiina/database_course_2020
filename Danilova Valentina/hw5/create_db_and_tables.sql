CREATE DATABASE fencing_school_db;

USE fencing_school_db;

CREATE TABLE members (
	member_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(32) NOT NULL,
    last_name VARCHAR(32) NOT NULL,
    start_experience YEAR NOT NULL,
    PRIMARY KEY(member_id)
);

CREATE TABLE rooms (
	room_id INT NOT NULL AUTO_INCREMENT,
    room_area INT NOT NULL,
    floor VARCHAR(32) NOT NULL,
    ceiling_height INT NOT NULL,
    rent_per_hour INT NOT NULL,
    PRIMARY kEY(room_id)
);

CREATE TABLE timeslots (
	timeslot_id INT NOT NULL AUTO_INCREMENT,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    weekday VARCHAR(32) NOT NULL,
    PRIMARY KEY(timeslot_id)   
);

CREATE TABLE fencing_events (
	event_id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(32) NOT NULL,
    start_dttm DATETIME NOT NULL,
    end_dttm DATETIME NOT NULL,
    adress VARCHAR(32) NOT NULL,
    PRIMARY KEY(event_id)
);

CREATE TABLE trainers (
	trainer_id INT NOT NULL AUTO_INCREMENT,
    member_id INT NOT NULL,
    wage_per_hour INT NOT NULL,
    PRIMARY KEY(trainer_id),
    FOREIGN KEY(member_id)
	  REFERENCES members(member_id)
      ON UPDATE CASCADE ON DELETE RESTRICT
);
 
CREATE TABLE disciplines (
	discipline_id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(32) NOT NULL,
    trainer_id INT NOT NULL,
    PRIMARY KEY(discipline_id),
    FOREIGN KEY(trainer_id)
		REFERENCES trainers(trainer_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE students (
	student_id INT NOT NULL AUTO_INCREMENT,
    member_id INT NOT NULL,
    discipline_id INT NOT NULL,
    PRIMARY KEY(student_id),
    FOREIGN KEY(member_id)
	  REFERENCES members(member_id)
      ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY(discipline_id)
	  REFERENCES disciplines(discipline_id)
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE personal_equipment (
	personal_equipment_id INT NOT NULL AUTO_INCREMENT,
    member_id INT NOT NULL,
    room_id INT NOT NULL,
    eq_type VARCHAR(32) NOT NULL,
    PRIMARY KEY(personal_equipment_id),
    FOREIGN KEY(member_id)
		REFERENCES members(member_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY(room_id)
		REFERENCES rooms(room_id)
		ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE club_equipment (
	club_equipment_id INT NOT NULL AUTO_INCREMENT,
    room_id INT NOT NULL,
    eq_type VARCHAR(32) NOT NULL,
    eq_condition VARCHAR(32) NOT NULL,
    purchase_date DATE NOT NULL,
    price INT NOT NULL,
    PRIMARY KEY(club_equipment_id),
	FOREIGN KEY(room_id)
		REFERENCES rooms(room_id)
		ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE taken_time (
	taken_time_id INT NOT NULL AUTO_INCREMENT,
    timeslot_id INT NOT NULL,
    room_id INT NOT NULL,
    discipline_id INT NOT NULL,
    PRIMARY KEY(taken_time_id),
    FOREIGN KEY(room_id)
		REFERENCES rooms(room_id)
		ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY(discipline_id)
	    REFERENCES disciplines(discipline_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY(timeslot_id)
	    REFERENCES timeslots(timeslot_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);