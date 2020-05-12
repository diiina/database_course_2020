USE HospitalDB;
DROP PROCEDURE IF EXISTS  populate_specialties;
DROP PROCEDURE IF EXISTS populate_doctors;
DROP PROCEDURE IF EXISTS populate_clients;
DROP PROCEDURE IF EXISTS populate_cabinets;
DROP PROCEDURE IF EXISTS populate_shifts;
DROP PROCEDURE IF EXISTS populate_appointments;
DROP PROCEDURE IF EXISTS populate_diagnoses;
DROP PROCEDURE IF EXISTS populate_bills;


DELIMITER |
CREATE PROCEDURE populate_specialties()
BEGIN
    INSERT INTO specialties (specialty, is_requires_referral)
    VALUES ('Dermatologist', FALSE),
           ('Endocrinologist', FALSE),
           ('Family Physician', FALSE),
           ('Cardiologist', TRUE),
           ('Psychiatrist', FALSE),
           ('Urologist', FALSE),
           ('Oncologist', TRUE),
           ('Emergency Medicine Specialist', FALSE);
END;|
DELIMITER ;


DELIMITER |
CREATE PROCEDURE populate_doctors()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i < 100 DO
        INSERT INTO doctors (full_name, specialty)
        SELECT  N.full_name, S.specialty FROM
        (SELECT CONCAT(FN.first_name, ' ', LN.last_name) AS full_name FROM
            (SELECT 'Liam' AS first_name
                UNION SELECT 'Noah' UNION SELECT 'William' UNION SELECT 'James'
                UNION SELECT 'Logan' UNION SELECT 'Benjamin' UNION SELECT 'Mason'
                UNION SELECT 'Elijah' UNION SELECT 'Oliver' UNION SELECT 'Jacob'
                UNION SELECT 'Emma' UNION SELECT 'Olivia' UNION SELECT 'Isabella'
                UNION SELECT 'Sophia' UNION SELECT 'Abigail' UNION SELECT 'Emily'
                UNION SELECT 'Barbara' UNION SELECT 'Mary' UNION SELECT 'Susan'
                UNION SELECT 'Jeff' UNION SELECT 'Andrew' UNION SELECT 'Zoe'
            ) FN
            CROSS JOIN
            (SELECT 'Smith' AS last_name
                UNION SELECT 'Johnson' UNION SELECT 'Williams' UNION SELECT 'Brown'
                UNION SELECT 'Jones' UNION SELECT 'Miller' UNION SELECT 'Davis'
                UNION SELECT 'Garcia' UNION SELECT 'Rodriguez' UNION SELECT 'Wilson'
                UNION SELECT 'Moore' UNION SELECT 'Thompson' UNION SELECT 'Anderson'
                UNION SELECT 'Adams' UNION SELECT 'Edwards' UNION SELECT 'Nguyen'
            ) LN
        ORDER BY RAND(1)
        LIMIT 1 OFFSET i) AS N
        CROSS JOIN
        (SELECT specialty FROM specialties
        ORDER BY RAND(i)
        LIMIT 1 OFFSET 0) AS S;
        SET i = i + 1;
        END WHILE;
END;|
DELIMITER ;


DELIMITER |
CREATE PROCEDURE populate_clients()
BEGIN
    DECLARE i INT DEFAULT 100;

    WHILE i < 350 DO

        INSERT INTO clients (full_name, is_insured)
        SELECT  N.full_name, MOD(i, 2) FROM
        (SELECT CONCAT(FN.first_name, ' ', LN.last_name) AS full_name FROM
            (SELECT 'Liam' AS first_name
                UNION SELECT 'Noah' UNION SELECT 'William' UNION SELECT 'James'
                UNION SELECT 'Logan' UNION SELECT 'Benjamin' UNION SELECT 'Mason'
                UNION SELECT 'Elijah' UNION SELECT 'Oliver' UNION SELECT 'Jacob'
                UNION SELECT 'Emma' UNION SELECT 'Olivia' UNION SELECT 'Isabella'
                UNION SELECT 'Sophia' UNION SELECT 'Abigail' UNION SELECT 'Emily'
                UNION SELECT 'Barbara' UNION SELECT 'Mary' UNION SELECT 'Susan'
                UNION SELECT 'Jeff' UNION SELECT 'Andrew' UNION SELECT 'Zoe'
            ) FN
            CROSS JOIN
            (SELECT 'Smith' AS last_name
                UNION SELECT 'Johnson' UNION SELECT 'Williams' UNION SELECT 'Brown'
                UNION SELECT 'Jones' UNION SELECT 'Miller' UNION SELECT 'Davis'
                UNION SELECT 'Garcia' UNION SELECT 'Rodriguez' UNION SELECT 'Wilson'
                UNION SELECT 'Moore' UNION SELECT 'Thompson' UNION SELECT 'Anderson'
                UNION SELECT 'Adams' UNION SELECT 'Edwards' UNION SELECT 'Nguyen'
            ) LN
        ORDER BY RAND(1)
        LIMIT 1 OFFSET i) AS N;

        SET i = i + 1;
        END WHILE;
END;|
DELIMITER ;


DELIMITER |
CREATE PROCEDURE populate_cabinets()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i < 30 DO
        INSERT INTO cabinets (room)
        VALUES (i + 100),
               (i + 200),
               (i + 300);
        SET i = i + 1;
    END WHILE;
END;|
DELIMITER ;


DELIMITER |
CREATE PROCEDURE populate_shifts()
BEGIN
    DECLARE i INT DEFAULT 13;
    DECLARE j INT DEFAULT 1;
    WHILE i < 18 DO
        SET j = 1;

        WHILE j < 90 DO
            INSERT INTO shifts (doctor, cabinet, shift_begin, shift_end)
            SELECT D.full_name, C.room, DTTM.start, DTTM.end FROM
                (SELECT full_name FROM doctors
                ORDER BY RAND(1)
                LIMIT 1 OFFSET j) AS D
            CROSS JOIN
                (SELECT room FROM cabinets
                ORDER BY RAND(1)
                LIMIT 1 OFFSET j) AS C
            CROSS JOIN
                (SELECT
                        STR_TO_DATE(CONCAT('2020-04-', i,' 09:00:00'),'%Y-%m-%e %T') AS start,
                        STR_TO_DATE(CONCAT('2020-04-', i,' 15:00:00'),'%Y-%m-%e %T') AS end
                UNION ALL
                SELECT
                       STR_TO_DATE(CONCAT('2020-04-', i,' 15:00:00'),'%Y-%m-%e %T') AS start,
                       STR_TO_DATE(CONCAT('2020-04-', i,' 21:00:00'),'%Y-%m-%e %T') AS end
                ORDER BY RAND(j)
                LIMIT 1 OFFSET 0) AS DTTM;

            SET j = j + 1;
        END WHILE;

        SET i = i + 1;
    END WHILE;
END;|
DELIMITER ;


DELIMITER |
CREATE PROCEDURE populate_appointments()
BEGIN
    DECLARE i INT DEFAULT 13;
    DECLARE j INT DEFAULT 1;

    DECLARE d VARCHAR(50);
    DECLARE sb DATETIME;
    DECLARE sp VARCHAR(50);
    DECLARE c VARCHAR(50);
    DECLARE ref VARCHAR(50) DEFAULT NULL;

    WHILE i < 18 DO
        SET j = 1;

        WHILE j < 60 DO
            INSERT INTO appointments (doctor, doctor_referred_from, client, time)
            SELECT DRS.fn, DRS.ref, C.client, DRS.sb + INTERVAL MOD(RAND(J), 6)HOUR FROM
                (SELECT full_name AS fn, NULL AS ref, shift_begin AS sb FROM doctors JOIN shifts
                ON doctors.full_name = shifts.doctor
                WHERE DATE(shift_begin) = STR_TO_DATE(CONCAT('2020-04-', i), '%Y-%m-%e')
                ORDER BY RAND(1)
                LIMIT 1 OFFSET j) DRS
            CROSS JOIN
                (SELECT full_name as client FROM clients
                ORDER BY RAND(1)
                LIMIT 1 OFFSET j) C;

            SET j = j + 1;
        END WHILE;

        SET i = i + 1;
    END WHILE;
END;|
DELIMITER ;


DELIMITER |
CREATE PROCEDURE populate_diagnoses()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i < 200 DO
        INSERT INTO diagnoses (information, appointment_id)
        SELECT INF.information, AP.appointment_id FROM
            (SELECT 'Dies from cringe...' AS information
                UNION SELECT 'Viral pneumonia.' UNION SELECT 'Chronic laziness.' UNION SELECT 'NF6.'
            ORDER BY RAND(i)
            LIMIT 1 OFFSET 0) INF
        CROSS JOIN
            (SELECT appointment_id FROM appointments
            LIMIT 1 OFFSET i) AP;

        SET i = i + 1;
    END WHILE;
END;|
DELIMITER ;


DELIMITER |
CREATE PROCEDURE populate_bills()
BEGIN
    INSERT INTO bills (cost, due_date, appointment_id, client)
    SELECT (MOD(FLOOR(RAND() * 100), 35) + 2) * 1000, DATE(time) + INTERVAL 3 DAY, appointment_id, client
    FROM appointments
    LIMIT 200;
END;|
DELIMITER ;


CALL populate_specialties();
CALL populate_cabinets();
CALL populate_doctors();
CALL populate_clients();
CALL populate_shifts();
CALL populate_appointments();
CALL populate_diagnoses();
CALL populate_bills();