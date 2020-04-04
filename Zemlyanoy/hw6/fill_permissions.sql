-- Captain and Head of Personnel get access to all rooms
DELIMITER |
CREATE PROCEDURE fill_chiefs_all()
BEGIN
	DECLARE cap INTEGER; -- id of Captain
    DECLARE hop INTEGER; -- id of Head of Personnel
	DECLARE hop_pid INTEGER; -- this way is easier
    DECLARE cap_start DATE;
    DECLARE hop_start DATE;
    SET cap = ( -- but can be done this way too
		SELECT e.employee_id 
		FROM 
			employees AS e
        INNER JOIN 
			positions AS p
		ON 
			(e.position_id=p.position_id) 
		WHERE 
			p.position_name = "Captain");
    SET hop_pid  = (SELECT position_id FROM positions WHERE position_name="Head of Personnel");
    SET hop = (SELECT employee_id FROM employees WHERE position_id = hop_pid);
    SET cap_start = (SELECT hired_date FROM employees WHERE employee_id = cap);
    SET hop_start = (SELECT hired_date FROM employees WHERE employee_id = hop);
    
    INSERT INTO accesses (employee_id, room_id, start_time)
    WITH cte AS (SELECT room_id FROM rooms)
    (SELECT cap, room_id, cap_start FROM cte);
    INSERT INTO accesses (employee_id, room_id, start_time)
    WITH cte AS (SELECT room_id FROM rooms)
    (SELECT hop, room_id, hop_start FROM cte);
END;|
DELIMITER ;

DELIMITER |
CREATE PROCEDURE fill_room_to_position(pid INTEGER, rid INTEGER)
-- grant access to all position holders to a room, by ids, with no expiration date, starting at hired date
BEGIN
	INSERT INTO accesses (employee_id, room_id, start_time)
		(SELECT employee_id, rid, hired_date FROM employees WHERE position_id = pid)
	;
END;|
DELIMITER ;

CALL fill_chiefs_all();
-- give HoS the entire first floor
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Head of Security"), 
    (SELECT room_id FROM rooms WHERE room_number=101)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Head of Security"), 
    (SELECT room_id FROM rooms WHERE room_number=102)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Head of Security"), 
    (SELECT room_id FROM rooms WHERE room_number=103)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Head of Security"), 
    (SELECT room_id FROM rooms WHERE room_number=104)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Head of Security"), 
    (SELECT room_id FROM rooms WHERE room_number=105)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Head of Security"), 
    (SELECT room_id FROM rooms WHERE room_number=106)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Head of Security"), 
    (SELECT room_id FROM rooms WHERE room_number=107)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Head of Security"), 
    (SELECT room_id FROM rooms WHERE room_number=108)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Head of Security"), 
    (SELECT room_id FROM rooms WHERE room_number=109)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Head of Security"), 
    (SELECT room_id FROM rooms WHERE room_number=110)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Head of Security"), 
    (SELECT room_id FROM rooms WHERE room_number=111)
);
-- give security most of the floor too
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Security Officer"), 
    (SELECT room_id FROM rooms WHERE room_number=102)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Security Officer"), 
    (SELECT room_id FROM rooms WHERE room_number=103)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Security Officer"), 
    (SELECT room_id FROM rooms WHERE room_number=104)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Security Officer"), 
    (SELECT room_id FROM rooms WHERE room_number=105)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Warden"), 
    (SELECT room_id FROM rooms WHERE room_number=105)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Warden"), 
    (SELECT room_id FROM rooms WHERE room_number=106)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Warden"), 
    (SELECT room_id FROM rooms WHERE room_number=107)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Warden"), 
    (SELECT room_id FROM rooms WHERE room_number=108)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Detective"), 
    (SELECT room_id FROM rooms WHERE room_number=105)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Detective"), 
    (SELECT room_id FROM rooms WHERE room_number=106)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Detective"), 
    (SELECT room_id FROM rooms WHERE room_number=107)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Detective"), 
    (SELECT room_id FROM rooms WHERE room_number=109)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Chief Engineer"), 
    (SELECT room_id FROM rooms WHERE room_number=110)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Chief Engineer"), 
    (SELECT room_id FROM rooms WHERE room_number=111)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Chief Engineer"), 
    (SELECT room_id FROM rooms WHERE room_number=101)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Station Engineer"), 
    (SELECT room_id FROM rooms WHERE room_number=110)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Atmospheric Technician"), 
    (SELECT room_id FROM rooms WHERE room_number=110)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Atmospheric Technician"), 
    (SELECT room_id FROM rooms WHERE room_number=101)
);
-- define 201 as Research Director's office, 
-- 202 as general scientist room, 
-- 203-204 as specific science rooms,
-- 205 as science/medicine room,
-- 206-207 as medicals
-- 208 as Chief Medical's office
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Research Director"), 
    (SELECT room_id FROM rooms WHERE room_number=201)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Research Director"), 
    (SELECT room_id FROM rooms WHERE room_number=202)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Research Director"), 
    (SELECT room_id FROM rooms WHERE room_number=203)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Research Director"), 
    (SELECT room_id FROM rooms WHERE room_number=204)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Research Director"), 
    (SELECT room_id FROM rooms WHERE room_number=205)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Scientist"), 
    (SELECT room_id FROM rooms WHERE room_number=202)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Roboticist"), 
    (SELECT room_id FROM rooms WHERE room_number=202)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Roboticist"), 
    (SELECT room_id FROM rooms WHERE room_number=203)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Geneticist"), 
    (SELECT room_id FROM rooms WHERE room_number=202)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Geneticist"), 
    (SELECT room_id FROM rooms WHERE room_number=204)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Geneticist"), 
    (SELECT room_id FROM rooms WHERE room_number=205)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Chief Medical Officer"), 
    (SELECT room_id FROM rooms WHERE room_number=205)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Chief Medical Officer"), 
    (SELECT room_id FROM rooms WHERE room_number=206)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Chief Medical Officer"), 
    (SELECT room_id FROM rooms WHERE room_number=207)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Chief Medical Officer"), 
    (SELECT room_id FROM rooms WHERE room_number=208)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Medical Doctor"), 
    (SELECT room_id FROM rooms WHERE room_number=206)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Medical Doctor"), 
    (SELECT room_id FROM rooms WHERE room_number=207)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Paramedic"), 
    (SELECT room_id FROM rooms WHERE room_number=207)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Chemist"), 
    (SELECT room_id FROM rooms WHERE room_number=205)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Virologist"), 
    (SELECT room_id FROM rooms WHERE room_number=205)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Virologist"), 
    (SELECT room_id FROM rooms WHERE room_number=206)
);
-- now, specialized areas for unique professions
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Bartender"), 
    (SELECT room_id FROM rooms WHERE room_number=301)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Janitor"), 
    (SELECT room_id FROM rooms WHERE room_number=306)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Clown"), 
    (SELECT room_id FROM rooms WHERE room_number=302)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Mime"), 
    (SELECT room_id FROM rooms WHERE room_number=302)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Chaplain"), 
    (SELECT room_id FROM rooms WHERE room_number=304)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Quartermaster"), 
    (SELECT room_id FROM rooms WHERE room_number=303)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Cook"), 
    (SELECT room_id FROM rooms WHERE room_number=301)
);
-- others
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Lawyer"), 
    (SELECT room_id FROM rooms WHERE room_number=403)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Psychologist"), 
    (SELECT room_id FROM rooms WHERE room_number=405)
);
CALL fill_room_to_position(
	(SELECT position_id FROM positions WHERE position_name="Curator"), 
    (SELECT room_id FROM rooms WHERE room_number=406)
);

-- SELECT * FROM accesses;
-- DROP PROCEDURE `zemlyanoy_db`.`fill_chiefs_all`;
-- DROP PROCEDURE `zemlyanoy_db`.`fill_room_to_position`;