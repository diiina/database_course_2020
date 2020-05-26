-- WAU — Weekly Active Users
WITH RECURSIVE cte(dt) AS (
	SELECT MIN(cast(sessions.begin_dttm AS DATE)) AS dt
		FROM sessions
	UNION ALL
    SELECT dt + INTERVAL 1 WEEK
		FROM cte
        WHERE dt + INTERVAL 1 WEEK <= (SELECT MAX(cast(sessions.begin_dttm AS DATE)) FROM sessions)
)
SELECT cte.dt, COUNT(DISTINCT s.user_id) AS wau
	FROM sessions AS s
	RIGHT JOIN cte 
	ON cast(s.begin_dttm AS DATE) >= cte.dt AND cast(s.begin_dttm AS DATE) < cte.dt + INTERVAL 1 WEEK
	GROUP BY cte.dt
	ORDER BY cte.dt
;

-- Результат
-- см. wau.result.csv
