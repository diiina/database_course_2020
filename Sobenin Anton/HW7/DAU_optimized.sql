-- DAU without any optimizations
EXPLAIN
WITH RECURSIVE cte_daily(dt) AS (
	SELECT MIN(cast(sessions.begin_dttm AS DATE)) AS dt
		FROM sessions
	UNION ALL
    SELECT dt + INTERVAL 1 DAY
		FROM cte_daily
        WHERE dt + INTERVAL 1 DAY <= (SELECT MAX(cast(sessions.begin_dttm AS DATE)) FROM sessions)
)
SELECT cte_daily.dt, COUNT(DISTINCT sessions.user_id) AS cnt_users
    FROM sessions
    RIGHT JOIN cte_daily
    ON cast(sessions.begin_dttm AS DATE) >= cte_daily.dt AND cast(sessions.begin_dttm AS DATE) < cte_daily.dt + INTERVAL 1 DAY
    GROUP BY cte_daily.dt
    ORDER BY cte_daily.dt
;

