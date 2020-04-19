-- DAU
-- before optimization
EXPLAIN
WITH RECURSIVE cte AS ( -- returns all days from the first one having sessions to the last one
	SELECT MAX(CAST(begin_dttm AS DATE)) AS dt
		FROM sessions
	UNION ALL
    SELECT (dt + INTERVAL 1 DAY)
		FROM cte
        WHERE (dt + INTERVAL 1 DAY) <= (SELECT MAX(CAST(begin_dttm AS DATE)) FROM sessions)
)
SELECT cte.dt, COUNT(DISTINCT ses.user_id)
	FROM
		cte
	LEFT JOIN
		(SELECT user_id, CAST(begin_dttm AS DATE) AS bdt FROM sessions) AS ses
        -- as an alternative, just use sessions as the right side of the JOIN;
        -- no real change, as only those two columns would be queried anyway
	ON cte.dt = ses.bdt -- session is defined to belong to the day it started
    GROUP BY cte.dt
    ORDER BY cte.dt
;