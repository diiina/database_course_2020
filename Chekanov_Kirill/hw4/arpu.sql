DELIMITER //
/* profit since start_time to end_time */
DROP FUNCTION IF EXISTS PROFIT //
CREATE FUNCTION PROFIT(
	start_time DATETIME,
	end_time DATETIME 
) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE profit INT;
   	SET profit = (
	   	SELECT SUM(payment_sum) FROM payments
		WHERE payment_dttm > start_time and payment_dttm < end_time
   	);
	RETURN (profit);
END;//
DELIMITER ;

DELIMITER //
/* profit since start_time to end_time */
DROP FUNCTION IF EXISTS ARPU //
CREATE FUNCTION ARPU(
	start_time DATETIME,
	end_time DATETIME 
) 
RETURNS FLOAT
DETERMINISTIC
BEGIN
    DECLARE arpu FLOAT;
   	DECLARE user_amount INT;
   	SET user_amount = (
   	SELECT COUNT(t.user_id) from 
	   	(SELECT users.user_id FROM users
		   	LEFT JOIN sessions ON users.user_id = sessions.user_id 
			WHERE sessions.begin_dttm > start_time 
				and sessions.end_dttm < end_time
				and TIMESTAMPDIFF(MINUTE, sessions.begin_dttm , sessions.end_dttm ) > 10 /* check that users were logged at least 10 minutes*/
				GROUP BY users.user_id
		) as t
   	);
   	SET arpu = (SELECT IF(user_amount != 0,PROFIT(start_time, end_time) / user_amount, 0));
	RETURN (arpu);
END;//
DELIMITER ;


SELECT ARPU('2018-09-07 23:59:59.0', '2018-09-09 23:59:59.0');

/* results
 * ARPU('2018-09-07 23:59:59.0', '2018-09-09 23:59:59.0');  ->  140.767
 * ARPU('2018-09-07 23:59:59.0', '2018-09-08 23:59:59.0');  -> 122.318
 * ARPU('2018-09-10 23:59:59.0', '2018-09-15 23:59:59.0');  -> 319.541
 * ARPU('2018-09-10 10:59:59.0', '2018-09-10 23:59:59.0');  -> 98.3
 * ARPU('2018-09-10 22:59:59.0', '2018-09-10 23:59:59.0');  -> 0
 */


