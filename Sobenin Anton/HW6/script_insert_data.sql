USE rs;

DELIMITER //
CREATE PROCEDURE main_stypes()
	BEGIN
    START TRANSACTION;
		INSERT INTO stype(type_name) VALUE ('КА');
        INSERT INTO stype(type_name) VALUE ('Самолет');
        INSERT INTO stype(type_name) VALUE ('Радар');
        INSERT INTO stype(type_name) VALUE ('Лидар');
        INSERT INTO stype(type_name) VALUE ('Сейсмограф');
        INSERT INTO stype(type_name) VALUE ('Сонар');
        INSERT INTO stype(type_name) VALUE ('Человек');
    COMMIT;
    END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE terra_cells()
	BEGIN
    DECLARE lon DOUBLE;
    DECLARE lat DOUBLE;
    DECLARE step DOUBLE;
    DECLARE counter INT;
    SET lon = 1.5;
	SET lat = 1.5;
    SET step = 3;
    SET counter = 0;
    START TRANSACTION;
		WHILE lat < 90 AND lat > 0 DO
			WHILE lon < 360 DO
				INSERT INTO territory (terra_name, coords, radius)
				VALUE (concat('terra_', counter), point(lon, lat), step);
				SET counter = counter + 1;
                SET lon = lon + step;
			END WHILE;
            SET lat = lat + step;
            SET lon = 1.5;
		END WHILE;
        IF lat > 90 THEN
			SET lat = -88.5;
            SET lon = 1.5;
		END IF;
		WHILE lat > -90 AND lat < 0 DO
			WHILE lon < 360 DO
				INSERT INTO territory (terra_name, coords, radius)
				VALUE (concat('terra_', counter), point(lon, lat), step);
				SET counter = counter + 1;
                SET lon = lon + step;
			END WHILE;
            SET lat = lat + step;
		END WHIlE;
    COMMIT;
    END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE main_ftypes()
	BEGIN
    START TRANSACTION;
		INSERT INTO firetype(type_name) VALUE ('wildfire');
        INSERT INTO firetype(type_name) VALUE ('volcano');
        INSERT INTO firetype(type_name) VALUE ('oil-producing towers');
        INSERT INTO firetype(type_name) VALUE ('technogenic');
     
    COMMIT;
    END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE all_datasources()
	BEGIN
    START TRANSACTION;
		INSERT INTO datasource(stype, launch_dttm) VALUE (2, from_unixtime(unix_timestamp('2000-01-01 03:00:00')) );
        INSERT INTO datasource(stype, launch_dttm) VALUE (2, from_unixtime(unix_timestamp('2001-05-21 13:27:17')) );
        INSERT INTO datasource(stype, launch_dttm) VALUE (2, from_unixtime(unix_timestamp('2004-12-15 06:55:12')) );
        INSERT INTO datasource(stype, launch_dttm) VALUE (2, from_unixtime(unix_timestamp('2010-08-04 17:43:21')) );
        INSERT INTO datasource(stype, launch_dttm) VALUE (3, from_unixtime(unix_timestamp('2010-09-10 12:10:00')));
        INSERT INTO datasource(stype, launch_dttm) VALUE (4, from_unixtime(unix_timestamp('2000-03-01 09:00:00')));
        INSERT INTO datasource(stype, launch_dttm) VALUE (5, from_unixtime(unix_timestamp('2005-05-05 15:15:00')));
 
    COMMIT;
    END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE random_fires(IN max_ftype INT, IN max_ds_id INT)
	BEGIN
    DECLARE dt_from TIMESTAMP DEFAULT ('2005-09-01 03:00:00');
    DECLARE dt_to TIMESTAMP DEFAULT ('2005-10-01 03:00:00');
    DECLARE dt_cur TIMESTAMP DEFAULT ('2005-09-01 03:00:00');
    DECLARE fire_dttm TIMESTAMP DEFAULT ('2005-09-01 04:00:00');
    DECLARE fnumb INT;
    DECLARE cur_numb INT;
    SET dt_from = from_unixtime(unix_timestamp('2005-09-01 03:00:00'));
    SET dt_to = from_unixtime(unix_timestamp('2005-10-01 03:00:00'));
    SET dt_cur = dt_from;
    SET cur_numb = 0;
    START TRANSACTION;
		WHILE dt_cur < dt_to DO
			SET fnumb = FLOOR(0 + RAND()*(100));
            WHILE cur_numb < fnumb DO
                SET fire_dttm = from_unixtime(unix_timestamp(dt_cur) + FLOOR(0 + RAND()*86400));
                INSERT INTO datafire(ftype, ds_id, get_dttm)
					VALUES (FLOOR(1 + RAND()*(max_ftype-1)), FLOOR(1 + RAND()*(max_ds_id-1)), fire_dttm );
				SET cur_numb = cur_numb + 1;
            END WHILE;
            SET cur_numb = 0;
        END WHILE;
    COMMIT;
    END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE random_sli(IN entries_per_day INT, IN max_ds_id INT)
	BEGIN
    DECLARE dt_from TIMESTAMP DEFAULT ('2005-09-01 03:00:00');
    DECLARE dt_to TIMESTAMP DEFAULT ('2005-10-01 03:00:00');
    DECLARE dt_cur TIMESTAMP DEFAULT ('2005-09-01 03:00:00');
    DECLARE sli_dttm TIMESTAMP DEFAULT ('2005-09-01 04:00:00') ;
    DECLARE sec_between_entries FLOAT DEFAULT 8640;
    DECLARE cur_numb INT;
    DECLARE coord_x DOUBLE DEFAULT 0;
    DECLARE coord_y DOUBLE DEFAULT 0;
    SET dt_from = from_unixtime(unix_timestamp('2005-09-01 03:00:00'));
    SET dt_to = from_unixtime(unix_timestamp('2005-10-01 03:00:00'));
    SET dt_cur = dt_from;
    SET cur_numb = 0;
    START TRANSACTION;
		WHILE dt_cur < dt_to DO
			SET sec_between_entries = 86400/entries_per_day;
            WHILE cur_numb < entries_per_day DO
                SET sli_dttm = from_unixtime(unix_timestamp(dt_cur) + FLOOR(cur_numb*sec_between_entries));
                SET coord_x = 0 + RAND()*360;
                SET coord_y = -90 + RAND()*180;
                INSERT INTO datafire(ds_id, get_dttm)
					VALUES (FLOOR(1 + RAND()*(max_ds_id-1)), sli_dttm, point(0,0), FLOOR(0 + RAND()*40000) );
				SET cur_numb = cur_numb + 1;
            END WHILE;
            SET cur_numb = 0;
        END WHILE;
    COMMIT;
    END;
//
DELIMITER ;

CALL main_stypes();
CALL terra_cells();
CALL main_ftypes();
CALL all_datasources();
CALL random_fires(5, 8);
CALL random_sli(10, 8);