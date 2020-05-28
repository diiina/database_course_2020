USE rs;
-- Источники данных
CREATE TABLE IF NOT EXISTS rs.stype (
	stype_id INT NOT NULL AUTO_INCREMENT,
    type_name VARCHAR(32) NOT NULL DEFAULT ('unknown'),
    PRIMARY KEY (stype_id)
);
INSERT INTO rs.stype
	VALUE()
;
CREATE TABLE IF NOT EXISTS rs.datasource
(
	ds_id INT NOT NULL AUTO_INCREMENT,
    stype INT NOT NULL DEFAULT 1,
    launch_dttm TIMESTAMP NOT NULL DEFAULT ('2000-01-01 03:00:00'),
    PRIMARY KEY (ds_id),
    FOREIGN KEY (stype)
		REFERENCES rs.stype (stype_id)
		ON UPDATE CASCADE ON DELETE RESTRICT
);
INSERT INTO rs.datasource
	VALUE()
;

-- СЛужебная Информация
CREATE TABLE IF NOT EXISTS rs.sli (
	sli_id INT NOT NULL AUTO_INCREMENT,
    ds_id INT NOT NULL DEFAULT 1,
    get_dttm TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    coords POINT NOT NULL DEFAULT (point(0,0)),
    height DOUBLE NOT NULL DEFAULT 0,
    PRIMARY KEY (sli_id),
    FOREIGN KEY (ds_id) 
		REFERENCES rs.datasource (ds_id)
		ON UPDATE CASCADE ON DELETE RESTRICT
);
INSERT INTO rs.sli
	VALUE()
;

-- Территории
CREATE TABLE IF NOT EXISTS rs.territory (
	terra_id INT NOT NULL AUTO_INCREMENT,
    terra_name VARCHAR(256) DEFAULT ('anywhere'),
    coords POINT NOT NULL DEFAULT (point(0,0)),
    radius DOUBLE NOT NULL DEFAULT 0,
    PRIMARY KEY (terra_id)
);
INSERT INTO rs.territory
	VALUE()
;

-- Погода
CREATE TABLE IF NOT EXISTS rs.weather (
	weather_id INT NOT NULL AUTO_INCREMENT,
    terra_id INT NOT NULL DEFAULT 1,
    cloud ENUM('undefined', 'other', 'no cloud', 'cumulus', 'stratus', 'cirrus') DEFAULT ('undefined'),
    celsius FLOAT NOT NULL DEFAULT 24,
    wing ENUM('undefined', 'west', 'east', 'south', 'north') DEFAULT ('undefined'),
    precipitation ENUM('undefined', 'other', 'rain', 'snow', 'hail') DEFAULT ('undefined'),
    get_dttm TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    measure_dttm TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (weather_id),
    FOREIGN KEY (terra_id)
		REFERENCES rs.territory (terra_id)
		ON UPDATE CASCADE ON DELETE RESTRICT
);
INSERT INTO rs.weather
	VALUE()
;

-- Тепловые аномалии
CREATE TABLE IF NOT EXISTS rs.firetype (
	ftype_id INT NOT NULL AUTO_INCREMENT,
    type_name VARCHAR(32) NOT NULL DEFAULT ('unknown'),
    PRIMARY KEY (ftype_id)
);
INSERT INTO rs.firetype
	VALUE()
;

CREATE TABLE IF NOT EXISTS rs.datafire
(
	datafire_id INT NOT NULL AUTO_INCREMENT,
    ftype INT NOT NULL DEFAULT 1,
    ds_id INT NOT NULL DEFAULT 1,
    get_dttm TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (datafire_id),
    FOREIGN KEY (ds_id) 
		REFERENCES rs.datasource (ds_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (ftype)
		REFERENCES rs.firetype (ftype_id)
		ON UPDATE CASCADE ON DELETE RESTRICT
);
INSERT INTO rs.datafire
	VALUE()
;

-- необработанные сырые данные
CREATE TABLE IF NOT EXISTS rs.raw (
	raw_id INT NOT NULL AUTO_INCREMENT,
    coord_c POINT NOT NULL DEFAULT (point(0,0)),
    link VARCHAR(1024) DEFAULT ('example.com'),
    ds_id INT NOT NULL DEFAULT 1,
    PRIMARY KEY (raw_id),
    FOREIGN KEY (ds_id)
		REFERENCES rs.datasource (ds_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);
INSERT INTO rs.raw
	VALUE()
;
CREATE TABLE IF NOT EXISTS rs.raw_territory (
	raw_id INT NOT NULL DEFAULT 1,
    terra_id INT NOT NULL DEFAULT 1,
    PRIMARY KEY (raw_id, terra_id),
    FOREIGN KEY (raw_id) 
		REFERENCES rs.raw (raw_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (terra_id) 
		REFERENCES rs.territory (terra_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);
INSERT INTO rs.raw_territory
	VALUE()
;

-- первичная обработка
CREATE TABLE IF NOT EXISTS rs.primary_data (
    pd_id INT NOT NULL AUTO_INCREMENT,
    raw_id INT NOT NULL DEFAULT 1,
    link VARCHAR(1024) DEFAULT ('example.com'),
    PRIMARY KEY (pd_id),
    FOREIGN KEY (raw_id)
        REFERENCES rs.raw (raw_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);
INSERT INTO rs.primary_data
	VALUE()
;

