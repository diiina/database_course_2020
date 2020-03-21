-- WAU
-- for every day, starting with the first having a record,
-- a week is considered starting at that day;
-- for this week, a total number of unique user_id's is counted;
-- last six days recorded are not processed, as for each of those
-- the week would be incomplete
WITH RECURSIVE cte AS (
	SELECT MIN(CAST(begin_dttm AS DATE)) AS dt
		FROM sessions
	UNION ALL
    SELECT (dt + INTERVAL 1 DAY)
		FROM cte
        WHERE (dt + INTERVAL 7 DAY) <= (SELECT MAX(CAST(begin_dttm AS DATE)) FROM sessions)
        -- so that the last six days present in sessions are not returned
        -- to process them, change 7 to 1
)
SELECT cte.dt, COUNT(DISTINCT ses.user_id)
	FROM
		cte
	LEFT JOIN
		(SELECT user_id, CAST(begin_dttm AS DATE) AS bdt FROM sessions) AS ses
	ON cte.dt <= ses.bdt AND ses.bdt < cte.dt + INTERVAL 7 DAY
    -- thus, for each day returned by the CTE, a week is counted as starting from this day
    GROUP BY cte.dt
    ORDER BY cte.dt
;