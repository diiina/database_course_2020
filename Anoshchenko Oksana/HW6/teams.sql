DELIMITER &&
CREATE PROCEDURE insert_teams(IN count INT)
BEGIN
	DECLARE i INT DEFAULT 1;
    DECLARE num_countries INT;
    DECLARE country_id INT;
    DECLARE num_disc INT;
    DECLARE disc_id INT;
    DECLARE num_hostels INT;
    DECLARE hostel_id INT;
    DECLARE team_group VARCHAR(30) DEFAULT 'A';
    
    SET num_countries = 207; -- SELECT count(country_id) FROM Countries
    SET num_disc = 20; -- SELECT count(discipline_id) FROM Disciplines
    SET num_hostels = 50; -- SELECT count(hostel_id) FROM Hostels
    
    WHILE i <= count DO
		SET country_id = FLOOR(RAND() * (num_countries - 1) + 1.5);
        SET disc_id = FLOOR(RAND() * (num_disc - 1) + 1.5);
        SET hostel_id = FLOOR(RAND() * (num_hostels - 1) + 1.5);
        IF (i > 50) THEN
			SET team_group='B';
		END IF;
		INSERT INTO Teams VALUES(
			i,
            CONCAT('team_name_', CAST(i AS CHAR(10))),
            i * 5 - 4,
            country_id,
            disc_id,
            hostel_id,
            RAND() * (1000),
            team_group
		);
		SET i = i + 1;
	END WHILE;
END&&

CALL insert_teams(100);