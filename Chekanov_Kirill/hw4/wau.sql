/* users that were logged during last 24 hours */

DELIMITER //

SET @week_in_minutes = 7 * 24 * 60 //

DROP FUNCTION IF EXISTS WAU //
CREATE FUNCTION WAU(
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
		WHERE TIMESTAMPDIFF(MINUTE, sessions.begin_dttm, wau_time) < @week_in_minutes AND 
			TIMESTAMPDIFF(MINUTE, sessions.begin_dttm, sessions.end_dttm) > 0 AND
			TIMESTAMPDIFF(MINUTE, sessions.begin_dttm, wau_time) > 0
		GROUP BY users.user_id
   	)
   	AS logged_users
   	);
	-- return the customer level
	RETURN (wau);
END;//
DELIMITER ;

SELECT WAU('2018-09-07 23:59:59.0');

/* results
 * 2018-09-27 23:59:59.0  ->  59
 * 2018-08-03 23:59:59.0' ->  3
 * 2018-09-07 23:59:59.0  ->  32
 */




   	
   
   