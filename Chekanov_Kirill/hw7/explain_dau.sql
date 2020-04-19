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
2	DERIVED	sessions		ALL					3591	100	
3	UNION	dates		ALL					2	100	Recursive; Using where
5	SUBQUERY	sessions		ALL					3591	100

	1. LEFT JOIN с таблицей dates, проситано 3 строчки, исопльзована сортировка.
	1. Запрос к sessions с импользрванием where прочитано 3591 строчки отфильтровано 100 строк.
	2. Запрос внутри JOIN-a
	3. Запрос UNION внутри рекурсивного WITH, на каждом шаге читается 2 строчки
	5. Внутренний SELECT в рекурсивном WITH, прочитано 3591 строк.
 */