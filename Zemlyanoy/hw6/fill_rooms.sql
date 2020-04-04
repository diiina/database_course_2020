DELIMITER |
CREATE PROCEDURE fillfloor (floornum INTEGER, roomcount INTEGER)
-- insert a given number of rooms on a given floor
-- the database does not care for floors at all, 
-- but this helps to generate room numbers
BEGIN
	DECLARE i INTEGER;
    SET i = 0;
    loop1: REPEAT
		SET i = i+1;
        INSERT INTO rooms (room_number) VALUES(floornum*100 + i);
    UNTIL i >= roomcount
    END REPEAT;
END;
|

DELIMITER ;
CALL fillfloor(1,11);
CALL fillfloor(2,12);
CALL fillfloor(3,11);
CALL fillfloor(4,10);
CALL fillfloor(5,9);


-- DELETE FROM rooms;
-- SELECT * FROM rooms;