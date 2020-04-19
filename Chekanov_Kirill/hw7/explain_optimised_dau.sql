CREATE INDEX session_begin_dttm ON sessions(begin_dttm);


EXPLAIN WITH RECURSIVE dates(date) AS (
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
1	PRIMARY	<derived2>		ALL					3	100	Using filesort
1	PRIMARY	sessions		ALL					3591	100	Using where
2	DERIVED										Select tables optimized away
3	UNION	dates		ALL					2	100	Recursive; Using where
5	SUBQUERY										Select tables optimized away

	2-ой и 5-й запрос происходят бкз обращения таблице, используя только индекс
 */