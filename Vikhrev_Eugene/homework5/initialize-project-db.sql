DROP DATABASE IF EXISTS HospitalDB;
CREATE DATABASE IF NOT EXISTS HospitalDB;
USE HospitalDB;

CREATE TABLE IF NOT EXISTS specialties (
    specialty VARCHAR(50) PRIMARY KEY NOT NULL,
    is_requires_referral BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS cabinets (
    room iNT PRIMARY KEY  NOT NULL
);

CREATE TABLE IF NOT EXISTS clients (
    full_name VARCHAR(50) PRIMARY KEY NOT NULL,
    is_insured BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS doctors (
    full_name VARCHAR(50) PRIMARY KEY NOT NULL,
    specialty VARCHAR(50) NOT NULL,
    FOREIGN KEY (specialty) REFERENCES specialties(specialty) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS shifts (
    shift_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    doctor VARCHAR(50) NOT NULL,
    FOREIGN KEY (doctor) REFERENCES doctors(full_name) ON DELETE CASCADE,
    cabinet INT NOT NULL,
    FOREIGN KEY (cabinet) REFERENCES cabinets(room) ON DELETE CASCADE,
    shift_begin DATETIME NOT NULL,
    CONSTRAINT valid_begin CHECK ( MINUTE(shift_begin) IN (0, 15, 30, 45) AND SECOND(shift_begin)=0 AND MICROSECOND(shift_begin)=0 ),
    shift_end DATETIME NOT NULL,
    CONSTRAINT valid_end CHECK ( MINUTE(shift_end) IN (0, 15, 30, 45) AND SECOND(shift_end)=0 AND MICROSECOND(shift_end)=0 )
);

CREATE TABLE IF NOT EXISTS appointments (
    appointment_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    doctor VARCHAR(50) NOT NULL,
    FOREIGN KEY (doctor) REFERENCES doctors(full_name) ON DELETE CASCADE,
    doctor_referred_from VARCHAR(50) DEFAULT NULL,
    FOREIGN KEY (doctor_referred_from) REFERENCES doctors(full_name) ON DELETE SET NULL,
    client VARCHAR(50) NOT NULL,
    FOREIGN KEY (client) REFERENCES clients(full_name) ON DELETE CASCADE,
    time DATETIME NOT NULL,
    CONSTRAINT valid_slot CHECK ( MINUTE(time) IN (0, 15, 30, 45) AND SECOND(time)=0 AND MICROSECOND(time)=0 )
);

CREATE TABLE IF NOT EXISTS bills (
    bill_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    cost INT NOT NULL,
    CONSTRAINT valid_cost CHECK ( cost>=0 ),
    due_date DATE NOT NULL,
    appointment_id INT NOT NULL,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id) ON DELETE CASCADE,
    client VARCHAR(50) NOT NULL,
    FOREIGN KEY (client) REFERENCES clients(full_name) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS diagnoses (
    diagnosis_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    information TEXT NOT NULL,
    appointment_id INT NOT NULL,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id) ON DELETE CASCADE
);