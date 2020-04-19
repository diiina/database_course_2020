DELIMITER //
CREATE PROCEDURE populate_teachers(IN rows_num INT)
	BEGIN 
		DECLARE i INT;
		SET i = 1;
        START TRANSACTION;
		WHILE i <= rows_num DO 
			INSERT INTO teachers(teach_name, patronymic, surname, leadership, birthdate, salary)
            VALUES (CONCAT('t_name', i), CONCAT('t_patr', i), CONCAT('t_surname', i), true, DATE(FROM_UNIXTIME(UNIX_TIMESTAMP('1970-01-01 00:00:00') + FLOOR(0 + (RAND() * 473040000)))), 30000);
            SET i = i + 1;
		END WHILE;
        COMMIT;
	END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE populate_students(IN rows_num INT)
	BEGIN 
		DECLARE i INT;
        DECLARE dt DATE;
        DECLARE cid INT;
		SET i = 1;
        START TRANSACTION;
		WHILE i <= rows_num DO
            IF (i >= 1 AND i <= 30) THEN 
				SET cid = 1;
                SET dt = FROM_UNIXTIME(UNIX_TIMESTAMP('2013-01-01 00:00:00') + FLOOR(0 + (RAND() * 31536000)), '%Y-%m-%d');
            ELSEIF (i >= 31 AND i <= 60) THEN 
				SET cid = 2;
				SET dt = FROM_UNIXTIME(UNIX_TIMESTAMP('2012-01-01 00:00:00') + FLOOR(0 + (RAND() * 31536000)), '%Y-%m-%d');
            ELSEIF (i >= 61 AND i <= 90) THEN 
				SET cid = 3;
                SET dt = FROM_UNIXTIME(UNIX_TIMESTAMP('2011-01-01 00:00:00') + FLOOR(0 + (RAND() * 31536000)), '%Y-%m-%d');
            ELSEIF (i >= 91 AND i <= 120) THEN 
				SET cid = 4;
                SET dt = FROM_UNIXTIME(UNIX_TIMESTAMP('2010-01-01 00:00:00') + FLOOR(0 + (RAND() * 31536000)), '%Y-%m-%d');
            ELSEIF (i >= 121 AND i <= 150) THEN 
				SET cid = 5;
                SET dt = FROM_UNIXTIME(UNIX_TIMESTAMP('2009-01-01 00:00:00') + FLOOR(0 + (RAND() * 31536000)),'%Y-%m-%d');
            ELSEIF (i >= 151 AND i <= 180) THEN 
				SET cid = 6;
				SET dt = FROM_UNIXTIME(UNIX_TIMESTAMP('2008-01-01 00:00:00') + FLOOR(0 + (RAND() * 31536000)), '%Y-%m-%d');
            ELSEIF (i >= 181 AND i <= 210) THEN 
				SET cid = 7;
                SET dt = FROM_UNIXTIME(UNIX_TIMESTAMP('2007-01-01 00:00:00') + FLOOR(0 + (RAND() * 31536000)), '%Y-%m-%d');
            ELSEIF (i >= 211 AND i <= 240) THEN 
				SET cid = 8;
                SET dt = FROM_UNIXTIME(UNIX_TIMESTAMP('2006-01-01 00:00:00') + FLOOR(0 + (RAND() * 31536000)), '%Y-%m-%d');
            ELSEIF (i >= 241 AND i <= 270) THEN 
				SET cid = 9;
                SET dt = FROM_UNIXTIME(UNIX_TIMESTAMP('2005-01-01 00:00:00') + FLOOR(0 + (RAND() * 31536000)), '%Y-%m-%d');
            ELSEIF (i >= 271 AND i <= 300) THEN 
				SET cid = 10;
                SET dt = FROM_UNIXTIME(UNIX_TIMESTAMP('2004-01-01 00:00:00') + FLOOR(0 + (RAND() * 31536000)), '%Y-%m-%d');
            ELSE 
				SET cid = 11;
                SET dt = FROM_UNIXTIME(UNIX_TIMESTAMP('2003-01-01 00:00:00') + FLOOR(0 + (RAND() * 31536000)), '%Y-%m-%d');
            END IF;
			INSERT INTO students(stud_name, patronymic, surname, birthdate, class_id)
            VALUES (CONCAT('s_name', i), CONCAT('s_patr', i), CONCAT('s_surname', i), dt, cid);
            SET i = i + 1;
		END WHILE;
        COMMIT;
	END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE populate_classes(IN rows_num INT, IN teachers_num INT)
	BEGIN 
		DECLARE i INT;
        DECLARE tid INT;
		SET i = 1;
        START TRANSACTION;
		WHILE i <= rows_num DO
			IF i >= 1 AND i <= 4 THEN
				SET tid = i;
            ELSE 
				SET tid = FLOOR(RAND()*(teachers_num - 4 )+ 4);
            END IF;
            
			INSERT INTO classes(class_name, teacher_id)
            VALUES (CONCAT(i, 'кл'), tid);
            SET i = i + 1;
		END WHILE;
        COMMIT;
	END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE populate_marks(IN rows_num INT, IN subjects_num INT, IN students_num INT)
	BEGIN 
		DECLARE i INT;
        DECLARE sid INT;
        DECLARE sbid INT;
        DECLARE m INT;
        DECLARE dt DATE;
		SET i = 1;
        START TRANSACTION;
		WHILE i <= rows_num DO
			SET sid = FLOOR(RAND()*students_num + 1);
            IF (sid >= 1 AND sid <= 120) THEN
				SET sbid = FLOOR(RAND()*4 + 1);
			ELSE
				SET sbid = FLOOR(RAND()*12 + 1);
			END IF;
            
            SET m = RAND()*5;
            SET dt = FROM_UNIXTIME(UNIX_TIMESTAMP('2019-09-01 00:00:00') + FLOOR(0 + (RAND() * 31536000)), '%Y-%m-%d');
			INSERT INTO marks(student_id, subject_id, mark, mark_date)
            VALUES (sid, sbid, m, dt);
            SET i = i + 1;
		END WHILE;
        COMMIT;
	END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE populate_subjects()
	BEGIN 
        START TRANSACTION;
			INSERT INTO subjects(subj_name) VALUES('Русский язык');
			INSERT INTO subjects(subj_name) VALUES('Математика');
			INSERT INTO subjects(subj_name) VALUES('Литература');
			INSERT INTO subjects(subj_name) VALUES('Физкультура');
			INSERT INTO subjects(subj_name) VALUES('История');
			INSERT INTO subjects(subj_name) VALUES('Естествознание');
			INSERT INTO subjects(subj_name) VALUES('География');
			INSERT INTO subjects(subj_name) VALUES('Химия');
			INSERT INTO subjects(subj_name) VALUES('Физика');
			INSERT INTO subjects(subj_name) VALUES('ОБЖ');
			INSERT INTO subjects(subj_name) VALUES('Биология');
            INSERT INTO subjects(subj_name) VALUES('Информатика');
			INSERT INTO subjects(subj_name) VALUES('Иностранный язык');
        COMMIT;
	END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE populate_teacher_subject_class()
	BEGIN 
        START TRANSACTION;
        
        -- Учителя начальной школы
			INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (1, 1, 1);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (1, 2, 1);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (1, 3, 1);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (1, 5, 1);
            
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (2, 1, 2);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (2, 2, 2);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (2, 3, 2);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (2, 5, 2);
            
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (3, 1, 3);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (3, 2, 3);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (3, 3, 3);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (3, 5, 3);
            
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (4, 1, 4);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (4, 2, 4);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (4, 3, 4);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (4, 5, 4);
		
        -- Учитель физкультуры
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (5, 4, 1);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (5, 4, 2);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (5, 4, 3);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (5, 4, 4);
            
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (5, 4, 5);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (5, 4, 6);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (5, 4, 7);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (5, 4, 8);
            
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (5, 4, 9);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (5, 4, 10);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (5, 4, 11);
            
		-- Учитель Русского языка
			
			INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (6, 1, 5);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (6, 1, 6);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (6, 1, 7);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (6, 1, 8);
            
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (6, 1, 9);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (6, 1, 10);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (6, 1, 11);
            
		-- Учитель Литературы
        
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (7, 3, 5);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (7, 3, 6);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (7, 3, 7);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (7, 3, 8);
            
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (7, 3, 9);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (7, 3, 10);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (7, 3, 11);
            
		-- Учитель естествознания
			INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (8, 6, 5);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (8, 6, 6);
            
		-- Учитель географии
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (9, 7, 7);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (9, 7, 8);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (9, 7, 9);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (9, 7, 10);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (9, 7, 11);
            
		-- Учитель химии
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (10, 8, 7);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (10, 8, 8);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (10, 8, 9);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (10, 8, 10);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (10, 8, 11);
            
		-- Учитель физики
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (11, 9, 7);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (11, 9, 8);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (11, 9, 9);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (11, 9, 10);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (11, 9, 11);
            
		-- Учитель ОБЖ
			INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (12, 10, 5);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (12, 10, 6);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (12, 10, 7);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (12, 10, 8);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (12, 10, 9);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (12, 10, 10);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (12, 10, 11);
            
		-- Учитель биологии
			INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (13, 11, 6);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (13, 11, 7);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (13, 11, 8);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (13, 11, 9);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (13, 11, 10);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (13, 11, 11);
            
		-- Учитель информатики
			INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (14, 12, 5);
			INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (14, 12, 6);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (14, 12, 7);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (14, 12, 8);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (14, 12, 9);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (14, 12, 10);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (14, 12, 11);
            
		-- Учитель иностранного языка
			INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (15, 13, 2);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (15, 13, 3);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (15, 13, 4);
			INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (15, 13, 5);
			INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (15, 13, 6);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (15, 13, 7);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (15, 13, 8);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (15, 13, 9);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (15, 13, 10);
            INSERT INTO teacher_subject_class(teacher_id, subject_id, class_id) VALUES (15, 13, 11);
            
        COMMIT;
	END;
//
DELIMITER ;

CALL populate_subjects();
CALL populate_teachers(15);
CALL populate_classes(11, 15);
CALL populate_teacher_subject_class();
CALL populate_students(330);
CALL populate_marks(28545, 11, 330);