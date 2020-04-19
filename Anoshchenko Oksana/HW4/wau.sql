USE HW3;

WITH RECURSIVE cte(dt) AS (
	SELECT MIN(CAST(begin_dttm AS DATE)) AS dt FROM sessions
    UNION ALL
    SELECT dt + INTERVAL 7 DAY FROM cte
    WHERE dt + INTERVAL 7 DAY <= (SELECT MAX(CAST(begin_dttm AS DATE)) from sessions)
)
SELECT cte.dt, count(DISTINCT user_id)
FROM cte
LEFT JOIN
sessions ON cte.dt <= CAST(sessions.begin_dttm AS DATE)
AND
cte.dt + INTERVAL 7 DAY > CAST(sessions.begin_dttm AS DATE)
GROUP BY cte.dt
ORDER BY cte.dt;

-- Результат:
-- '2018-08-02', '6'
-- '2018-08-09', '11'
-- '2018-08-16', '17'
-- '2018-08-23', '22'
-- '2018-08-30', '31'
-- '2018-09-06', '35'
-- '2018-09-13', '41'
-- '2018-09-20', '50'
-- '2018-09-27', '51'
