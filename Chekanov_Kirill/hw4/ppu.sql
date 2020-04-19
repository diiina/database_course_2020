/* users that were logged during last 24 hours */

DELIMITER //

SET @day_in_minutes = 24 * 60 //

DROP FUNCTION IF EXISTS DAU //
CREATE FUNCTION DAU(
	wau_time DATETIME 
) 
RETURNS FLOAT
DETERMINISTIC
BEGIN
    DECLARE wau FLOAT;
   	SET wau = (
   	SELECT count(user_id) FROM 
   	(
	   	SELECT users.user_id from users 
		LEFT JOIN sessions ON sessions.user_id = users.user_id
		WHERE TIMESTAMPDIFF(MINUTE, sessions.begin_dttm, wau_time) < @day_in_minutes AND 
			TIMESTAMPDIFF(MINUTE, sessions.begin_dttm, sessions.end_dttm) > 0 AND
			TIMESTAMPDIFF(MINUTE, sessions.begin_dttm, wau_time) > 0 /* minutes that user at least was logged */
		GROUP BY users.user_id
   	)
   	AS logged_users
   	);
	-- return the customer level
	RETURN (wau);
END;//

/* users that were logged during last 24 hours and have payments */

DROP FUNCTION IF EXISTS DAU_PAYED //
CREATE FUNCTION DAU_PAYED(
	wau_time DATETIME 
) 
RETURNS FLOAT
DETERMINISTIC
BEGIN
    DECLARE wau FLOAT;
   	SET wau = (
   	SELECT count(user_id) FROM 
   	(
	   	SELECT users.user_id from users 
		LEFT JOIN sessions ON sessions.user_id = users.user_id
		RIGHT JOIN payments ON users.user_id  = payments.user_id
		WHERE TIMESTAMPDIFF(MINUTE, sessions.begin_dttm, wau_time) < @day_in_minutes AND 
			TIMESTAMPDIFF(MINUTE, sessions.begin_dttm, sessions.end_dttm) > 0 AND
			TIMESTAMPDIFF(MINUTE, sessions.begin_dttm, wau_time) > 0
		GROUP BY users.user_id
   	)
   	AS logged_users
   	);
	-- return the customer level
	RETURN (wau);
END;//

DROP FUNCTION IF EXISTS PPU //
CREATE FUNCTION PPU(
	dau_time DATETIME 
) 
RETURNS FLOAT
DETERMINISTIC
BEGIN
    DECLARE ppu FLOAT;
   	SET ppu = (
   		SELECT IF(DAU(dau_time) != 0, DAU_PAYED(dau_time) / DAU(dau_time), 0)
   	);
	-- return the customer level
	RETURN (ppu);
END;//


DELIMITER ;


SELECT PPU('2018-09-30 23:59:59.0');

/* results
 * 2018-08-9 23:59:59.0  ->  0.166667
 * 2018-08-10 23:59:59.0 ->  0.4
 * 2018-08-12 23:59:59.0  ->  0.333333
 * 2018-08-16 23:59:59.0 -> 0.363636
 * 2018-09-30 23:59:59.0 -> 0.512195
 */


