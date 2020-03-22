CREATE TABLE Countries (
	country_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL
);

CREATE TABLE Locations (
	location_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
	country_id INTEGER NOT NULL
);

CREATE TABLE Circuits (
	circuit_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
	location_id INTEGER NOT NULL,
	lap_length DECIMAL(4, 2) NOT NULL
);

CREATE TABLE Championships (
	championship_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
	date_begin DATE NOT NULL,
	date_end DATE NOT NULL
);

CREATE TABLE Grand_prix(
	grandprix_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
	name VARCHAR(100),
	championship_id INTEGER NOT NULL,
	circuit_id INTEGER NOT NULL,
	date DATE
);

CREATE TABLE GrandPrixRes(
	grandprix_id INTEGER NOT NULL,
	pilot_id INTEGER NOT NULL,
	result INTEGER NOT NULL,
	place INTEGER NOT NULL,
    CONSTRAINT PK_GRANDPRIXRES PRIMARY KEY(grandprix_id, pilot_id)
);

CREATE TABLE Pilots (
	pilot_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
	first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100) NOT NULL,
	birthdate DATE NOT NULL,
	location_id INTEGER NOT NULL
);

CREATE TABLE Teams (
	team_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
	country_id INTEGER NOT NULL,
	web VARCHAR(100) NOT NULL
);

CREATE TABLE TeamPilot (
	pilot_id INTEGER NOT NULL,
	team_id INTEGER NOT NULL,
	date_begin DATE NOT NULL,
	date_end DATE,
    CONSTRAINT PK_TEAMPILOT PRIMARY KEY(pilot_id, team_id)
);

CREATE TABLE Manufacturers (
	manufacturer_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
	web VARCHAR(100) NOT NULL,
	country_id INTEGER NOT NULL
);

CREATE TABLE Engines (
	engine_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
	manufacturer_id INTEGER NOT NULL,
	name VARCHAR(100) NOT NULL,
	year INTEGER NOT NULL,
	volume DECIMAL(2, 1) NOT NULL,
	power INTEGER NOT NULL,
	frequency INTEGER NOT NULL
);

CREATE TABLE Chassis (
	chassis_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
	manufacturer_id INTEGER NOT NULL,
	name VARCHAR(100) NOT NULL,
	year INTEGER NOT NULL
);

CREATE TABLE Cars (
	car_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
	model VARCHAR(100) NOT NULL,
	chassis_id INTEGER NOT NULL,
	engine_id INTEGER NOT NULL
);

CREATE TABLE CarPilot (
	pilot_id INTEGER NOT NULL,
	car_id INTEGER NOT NULL,
	date_begin DATE NOT NULL,
	date_end DATE,
    CONSTRAINT PK_CARPILOT PRIMARY KEY(pilot_id, date_begin)
);

CREATE TABLE ResultsPilots(
	championship_id INTEGER NOT NULL,
	pilot_id INTEGER NOT NULL,
	place INTEGER,
    CONSTRAINT PK_RESULTSPILOTS PRIMARY KEY(pilot_id, championship_id)
);

CREATE TABLE ResultsTeams(
	championship_id INTEGER NOT NULL,
	team_id INTEGER NOT NULL,
	place INTEGER,
    CONSTRAINT PK_RESULTSTEAMS PRIMARY KEY(team_id, championship_id)
);




ALTER TABLE Locations ADD 
	FOREIGN KEY (country_id) 
	REFERENCES Countries (country_id);

ALTER TABLE Pilots ADD 
	FOREIGN KEY (location_id) 
	REFERENCES Locations (location_id);

ALTER TABLE Circuits ADD 
	FOREIGN KEY (location_id) 
	REFERENCES Locations (location_id);

ALTER TABLE Teams ADD 
	FOREIGN KEY (country_id) 
	REFERENCES Countries (country_id);

ALTER TABLE Manufacturers ADD 
	FOREIGN KEY (country_id) 
	REFERENCES Countries (country_id);

ALTER TABLE TeamPilot ADD 
	FOREIGN KEY (pilot_id) 
	REFERENCES Pilots (Pilot_id);

ALTER TABLE TeamPilot ADD 
	FOREIGN KEY (team_id) 
	REFERENCES Teams (team_id);

ALTER TABLE Chassis ADD 
	FOREIGN KEY (manufacturer_id) 
	REFERENCES Manufacturers (Manufacturer_id);

ALTER TABLE Engines ADD 
	FOREIGN KEY (manufacturer_id) 
	REFERENCES Manufacturers (Manufacturer_id);

ALTER TABLE Cars ADD 
	FOREIGN KEY (chassis_id) 
	REFERENCES Chassis (chassis_id);

ALTER TABLE Cars ADD 
	FOREIGN KEY (engine_id) 
	REFERENCES Engines (engine_id);

ALTER TABLE Chassis ADD 
	FOREIGN KEY (manufacturer_id) 
	REFERENCES Manufacturers (Manufacturer_id);

ALTER TABLE Grand_prix ADD 
	FOREIGN KEY (circuit_id) 
	REFERENCES Circuits (circuit_id);

ALTER TABLE Grand_prix ADD 
	FOREIGN KEY (championship_id) 
	REFERENCES Championships (championship_id);

ALTER TABLE GrandPrixRes ADD 
	FOREIGN KEY (grandprix_id) 
	REFERENCES Grand_prix (grandprix_id);

ALTER TABLE GrandPrixRes ADD 
	FOREIGN KEY (pilot_id) 
	REFERENCES Pilots (pilot_id);

ALTER TABLE CarPilot ADD 
	FOREIGN KEY (pilot_id) 
	REFERENCES Pilots (Pilot_id);

ALTER TABLE CarPilot ADD 
	FOREIGN KEY (car_id) 
	REFERENCES Cars (car_id);

ALTER TABLE ResultsPilots ADD 
	FOREIGN KEY (championship_id) 
	REFERENCES Championships (championship_id);

ALTER TABLE ResultsPilots ADD 
	FOREIGN KEY (pilot_id) 
	REFERENCES Pilots (pilot_id);

ALTER TABLE ResultsTeams ADD 
	FOREIGN KEY (championship_id) 
	REFERENCES Championships (championship_id);

ALTER TABLE ResultsTeams ADD 
	FOREIGN KEY (team_id) 
	REFERENCES Teams (team_id);