USE fencing_school_db;

DELIMITER //
CREATE PROCEDURE populate_members(IN rows_num INT)
BEGIN
	DECLARE i INT unsigned DEFAULT 1;
	WHILE i <= rows_num DO
		INSERT INTO members(first_name, last_name, start_experience)
		VALUES (CONCAT('Firstname_', i), CONCAT('Lastname_', i), YEAR(FROM_UNIXTIME(
					UNIX_TIMESTAMP('2000-1-1') + FLOOR(RAND() * (UNIX_TIMESTAMP('2010-12-31') - UNIX_TIMESTAMP('2000-1-1') + 1)))
                ));
		SET i = i + 1;
	END WHILE;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE populate_rooms(IN rows_num INT)
BEGIN
	DECLARE i INT unsigned DEFAULT 1;
	WHILE i <= rows_num DO
		INSERT INTO rooms(room_area, floor, ceiling_height, rent_per_hour)
        VALUES (FLOOR(RAND()*100 + 10), CONCAT('Covering ', i), FLOOR(RAND()*3 + 2), FLOOR(RAND()*500 + 500));
		SET i = i + 1;
    END WHILE;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE populate_timeslots()
BEGIN
	DECLARE i INT unsigned DEFAULT 1;
    DECLARE begin_slot TIME DEFAULT '09:00:00';
    DECLARE end_day TIME DEFAULT '23:00:00';
    DECLARE end_slot TIME DEFAULT begin_slot;
	WHILE i <= 7 DO
		WHILE begin_slot <= end_day DO
			SET end_slot = DATE_ADD(begin_slot, INTERVAL 2 HOUR);
			INSERT INTO timeslots(start_time, end_time, weekday)
            VALUES (begin_slot, end_slot, i);
			SET begin_slot = end_slot;
		END WHILE;
    SET i = i + 1;
    END WHILE;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE populate_fencing_events(IN rows_num INT)
BEGIN
	DECLARE i INT unsigned DEFAULT 1;
    DECLARE event_start DATETIME;
	WHILE i <= rows_num DO
		SET event_start = FROM_UNIXTIME(
			UNIX_TIMESTAMP('2019-08-02 00:00:00') + FLOOR(0 + (RAND() * 63072000))
		);
		INSERT INTO fencing_events(title, start_dttm, end_dttm, adress)
        VALUES (CONCAT('Event ', i), event_start, DATE_ADD(event_start, INTERVAL 5 HOUR), CONCAT('Adress ', i));
    SET i = i + 1;
    END WHILE;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE populate_trainers(IN rows_num INT, IN members_num INT)
BEGIN
	DECLARE i INT unsigned DEFAULT 1;
	WHILE i <= rows_num DO
		INSERT INTO trainers(member_id, wage_per_hour)
        VALUES (FLOOR(RAND()*members_num), FLOOR(RAND()*1000 + 1000));
    END WHILE;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE populate_disciplines(IN rows_num INT, IN trainers_num INT)
BEGIN
	DECLARE i INT unsigned DEFAULT 1;
	WHILE i <= rows_num DO
		INSERT INTO disciplines(title, trainer_id)
        VALUES (CONCAT('Discipline ', i), FLOOR(RAND()*trainers_num));
    END WHILE;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE populate_students(IN rows_num INT, IN members_num INT, IN disciplines_num INT)
BEGIN
	DECLARE i INT unsigned DEFAULT 1;
	WHILE i <= rows_num DO
		INSERT INTO students(member_id, discipline_id)
        VALUES (FLOOR(RAND()*members_num), FLOOR(RAND()*disciplines_num));
    END WHILE;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE populate_events_attendance(IN rows_num INT, IN events_num INT, IN members_num INT)
BEGIN
	DECLARE i INT unsigned DEFAULT 1;
	WHILE i <= rows_num DO
		INSERT INTO events_attendance(event_id, member_id)
        VALUES (FLOOR(RAND()*events_num), FLOOR(RAND()*members_num));
    END WHILE;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE populate_club_equipment(IN rows_num INT, IN rooms_num INT)
BEGIN
	DECLARE i INT unsigned DEFAULT 1;
	WHILE i <= rows_num DO
		INSERT INTO club_equipment(room_id, eq_type, eq_condition, purchase_date, price)
        VALUES (FLOOR(RAND()*rooms_num), CONCAT('Type ', i), CONCAT('Condition ', i), FROM_UNIXTIME(
			UNIX_TIMESTAMP('2019-08-02 00:00:00') + FLOOR(0 + (RAND() * 63072000))
		), FLOOR(RAND()*20000 + 3000));
    END WHILE;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE populate_personal_equipment(IN rows_num INT, IN rooms_num INT, IN members_num INT)
BEGIN
	DECLARE i INT unsigned DEFAULT 1;
	WHILE i <= rows_num DO
		INSERT INTO personal_equipment(member_id, room_id, eq_type)
        VALUES (FLOOR(RAND()*members_num), FLOOR(RAND()*rooms_num), CONCAT('Type ', i));
    END WHILE;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE populate_taken_time(IN rows_num INT, IN rooms_num INT, IN disciplines_num INT, IN timeslots_num INT)
BEGIN
	DECLARE i INT unsigned DEFAULT 1;
	WHILE i <= rows_num DO
		INSERT INTO taken_time(timeslot_id, room_id, discipline_id)
        VALUES (FLOOR(RAND()*timeslots_num), FLOOR(RAND()*rooms_num), FLOOR(RAND()*disciplines_num));
    END WHILE;
END;
//
DELIMITER ;

CALL populate_members(200);
CALL populate_rooms(10);
CALL populate_timeslots();
CALL populate_fencing_events(100);
CALL populate_trainers(20, 200);
CALL populate_disciplines(30, 20);
CALL populate_students(190, 200, 30);
CALL populate_events_attendance(300, 100, 200);
CALL populate_club_equipment(100, 10);
CALL populate_personal_equipment(100, 10, 200);
CALL populate_taken_time(100, 10, 30, 42);

SELECT * FROM members;