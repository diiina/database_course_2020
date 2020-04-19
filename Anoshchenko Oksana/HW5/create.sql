CREATE DATABASE project;

USE project;

CREATE TABLE Staff(
	staff_id INTEGER NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    PRIMARY KEY(staff_id)
);

CREATE TABLE Countries(
	country_id INTEGER NOT NULL AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    PRIMARY KEY(country_id)
);

CREATE TABLE Address(
	address_id INTEGER NOT NULL AUTO_INCREMENT,
    country_id INTEGER NOT NULL,
    address VARCHAR(30),
    PRIMARY KEY(address_id),
    FOREIGN KEY(country_id) 
	REFERENCES Countries(country_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Hostels(
	hostel_id INTEGER NOT NULL AUTO_INCREMENT,
    address_id INTEGER NOT NULL,
    PRIMARY KEY(hostel_id)
);

CREATE TABLE Locations(
	location_id INTEGER NOT NULL AUTO_INCREMENT,
    address_id INTEGER NOT NULL,
    capacity INTEGER,
    PRIMARY KEY(location_id),
    FOREIGN KEY(address_id) 
	REFERENCES Address(address_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Disciplines(
	discipline_id INTEGER NOT NULL AUTO_INCREMENT,
    name_disc VARCHAR(50) NOT NULL,
    PRIMARY KEY(discipline_id)
);

CREATE TABLE EventsForGamers(
	event_id INTEGER NOT NULL AUTO_INCREMENT,
	location_id INTEGER NOT NULL,
    event_name VARCHAR(30) NOT NULL,
    begin_dttm TIMESTAMP,
    end_dttm TIMESTAMP,
    PRIMARY KEY(event_id),
    FOREIGN KEY(location_id) 
	REFERENCES Locations(location_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Organizers(
	organizer_id INTEGER NOT NULL AUTO_INCREMENT,
	staff_id INTEGER NOT NULL,
    event_id INTEGER NOT NULL,
    PRIMARY KEY(organizer_id),
    FOREIGN KEY(staff_id) 
	REFERENCES Staff(staff_id)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY(event_id) 
    REFERENCES EventsForGamers(event_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Gamers(
	gamer_id INTEGER NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    age INTEGER NOT NULL,
    score INTEGER,
    nickname VARCHAR(30) NOT NULL,
    PRIMARY KEY(gamer_id)
);

CREATE TABLE Invited(
	invited_id INTEGER NOT NULL AUTO_INCREMENT,
    event_id INTEGER NOT NULL,
    gamer_id INTEGER NOT NULL,
    PRIMARY KEY(invited_id),
    FOREIGN KEY(event_id) 
    REFERENCES EventsForGamers(event_id)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY(gamer_id) 
    REFERENCES Gamers(gamer_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Teams(
	team_id INTEGER NOT NULL AUTO_INCREMENT,
    team_name VARCHAR(30) NOT NULL,
    captain_id INTEGER NOT NULL,
    country_id INTEGER NOT NULL,
    discipline_id INTEGER NOT NULL,
    hostel_id INTEGER NOT NULL,
    score INTEGER,
    team_group VARCHAR(6) NOT NULL,
    PRIMARY KEY(team_id),
    FOREIGN KEY(captain_id) 
    REFERENCES Gamers(gamer_id)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY(country_id) 
    REFERENCES Countries(country_id)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY(discipline_id) 
    REFERENCES Disciplines(discipline_id)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY(hostel_id) 
    REFERENCES Hostels(hostel_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Line_up(
	line_up_id INTEGER NOT NULL AUTO_INCREMENT,
    gamer_id INTEGER NOT NULL,
    team_id INTEGER NOT NULL,
    PRIMARY KEY(line_up_id),
    FOREIGN KEY(gamer_id) 
    REFERENCES Gamers(gamer_id)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY(team_id) 
    REFERENCES Teams(team_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Matches(
	match_id INTEGER NOT NULL AUTO_INCREMENT,
    team1_id INTEGER NOT NULL,
    team2_id INTEGER NOT NULL,
    winner_id INTEGER NOT NULL,
    score INTEGER,
    begin_dttm TIMESTAMP,
    end_dttm TIMESTAMP,
    PRIMARY KEY(match_id),
    FOREIGN KEY(team1_id) 
    REFERENCES Teams(team_id)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY(team2_id) 
    REFERENCES Teams(team_id)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY(winner_id) 
    REFERENCES Teams(team_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
);
