WITH RECURSIVE dates(date) AS (
	SELECT CAST(MIN(begin_dttm) AS DATE) date
	FROM sessions
	UNION ALL
	SELECT date + INTERVAL 1 DAY FROM dates
	WHERE date + INTERVAL 1 DAY <= 
	(
		SELECT CAST(MAX(begin_dttm) AS DATE)
	    FROM sessions
	)
)
SELECT dates.date 'Date',
       COUNT(DISTINCT sessions.user_id) DAU
FROM dates Left JOIN sessions
    ON CAST(sessions.begin_dttm AS DATE) >= dates.date
        AND CAST(sessions.begin_dttm AS DATE) < dates.date + INTERVAL 1 WEEK
        AND TIMESTAMPDIFF(MINUTE, sessions.begin_dttm, sessions.end_dttm ) > 10
GROUP BY dates.date
ORDER BY dates.date DESC;

/*  results:
 	2018-09-30	41
	2018-09-29	49
	2018-09-28	50
	2018-09-27	51
	2018-09-26	52
	2018-09-25	52
	2018-09-24	52
	2018-09-23	52
	...
 */