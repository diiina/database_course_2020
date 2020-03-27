-- WAU
WITH recursive cte (dt) AS 
(
	SELECT MIN(CAST(begin_dttm AS DATE)) AS dt FROM sessions
    UNION ALL
    SELECT dt + INTERVAL 1 WEEK
	FROM cte
    WHERE dt + INTERVAL 1 WEEK <= (SELECT MAX(CAST(begin_dttm as DATE) from sessions)
)
SELECT cte.dt, COUNT(DISTINCT sessions.user_id)
FROM cte LEFT JOIN sessions ON 
    cte.dt <= CAST(sessions.begin_dttm AS DATE)
	AND
    cte.dt + INTERVAL 1 WEEK > CAST(sessions.begin_dttm AS DATE)
GROUP BY cte.dt
ORDER BY cte.dt;