-- first, a single employee in every position
INSERT INTO employees (first_name, last_name, birth_date, position_id, hired_date)
	WITH cte AS (SELECT position_id AS pid, ceil(rand()*10) AS r FROM positions)
	(SELECT 
		CONCAT("firstname",cte.pid), 
        CONCAT("lastname",cte.pid), 
        DATE(19800000 + cte.r*10101), -- dates would be 1981-01-01, 1982-02-02, ..., 1990-10-10
        cte.pid,
        DATE(20000000 + cte.r*10102) -- 2001-01-02, 2002-02-04, ..., 2010-10-20
	FROM cte)
;

-- a procedure to fill a given (by ud) position with a given number of employees
DELIMITER |
CREATE PROCEDURE fill_position(num INTEGER, position_id INTEGER)
BEGIN
	DECLARE i INTEGER;
    DECLARE cnt INTEGER;
    DECLARE r INTEGER;
    SET cnt = (SELECT count(*) FROM employees);
    SET i = cnt;
    loop1: REPEAT
		SET i = i + 1;
        SET r = ceil(rand()*12);
        INSERT INTO employees (first_name, last_name, birth_date, position_id, hired_date)
			VALUES (
				CONCAT("firstname",i),
                CONCAT("lastname",i),
                DATE(19800000 + r*10101),
                position_id,
                DATE(20000000 + r*10102)
            );
		UNTIL i >= (cnt + num)
        END REPEAT;
END;|

DELIMITER ;
    
CALL fill_position(4, (SELECT position_id FROM positions WHERE position_name="Security Officer"));
CALL fill_position(2, (SELECT position_id FROM positions WHERE position_name="Atmospheric Technician"));
CALL fill_position(4, (SELECT position_id FROM positions WHERE position_name="Station Engineer"));
CALL fill_position(5, (SELECT position_id FROM positions WHERE position_name="Scientist"));
CALL fill_position(4, (SELECT position_id FROM positions WHERE position_name="Geneticist"));
CALL fill_position(3, (SELECT position_id FROM positions WHERE position_name="Roboticist"));
CALL fill_position(3, (SELECT position_id FROM positions WHERE position_name="Medical Doctor"));
CALL fill_position(6, (SELECT position_id FROM positions WHERE position_name="Paramedic"));
CALL fill_position(2, (SELECT position_id FROM positions WHERE position_name="Chemist"));
CALL fill_position(1, (SELECT position_id FROM positions WHERE position_name="Virologist"));
CALL fill_position(2, (SELECT position_id FROM positions WHERE position_name="Janitor"));
CALL fill_position(3, (SELECT position_id FROM positions WHERE position_name="Clown"));
CALL fill_position(11, (SELECT position_id FROM positions WHERE position_name="Assistant"));
CALL fill_position(4, (SELECT position_id FROM positions WHERE position_name="Lawyer"));
CALL fill_position(3, (SELECT position_id FROM positions WHERE position_name="Psychologist"));
CALL fill_position(6, (SELECT position_id FROM positions WHERE position_name="Prisoner"));
CALL fill_position(4, (SELECT position_id FROM positions WHERE position_name="Drone"));

    
-- SELECT * FROM employees;