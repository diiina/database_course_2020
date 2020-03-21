-- ARPU, computed per each day
WITH RECURSIVE cte AS (
-- return all days between the first and the last having a session record
	SELECT MIN(CAST(begin_dttm AS DATE)) AS dt
		FROM sessions
	UNION ALL
    SELECT (dt + INTERVAL 1 DAY)
		FROM cte
        WHERE (dt + INTERVAL 1 DAY) <= (SELECT MAX(CAST(begin_dttm AS DATE)) FROM sessions)
)
SELECT
	pjoin.dt, 
    pjoin.dpay AS dpay, -- total revenue per given day
    sjoin.dau AS dau,
    IF(sjoin.dau, pjoin.dpay/sjoin.dau, NULL) AS arpu
    -- will return NULL when DAU for the day is 0;
    -- otherwise, returns a number, which may be 0
	FROM 
		(
        SELECT cte.dt, IF(SUM(payments.payment_sum), SUM(payments.payment_sum), 0) AS dpay
        -- will return 0 for days where no payments were found
			FROM cte LEFT JOIN payments
				ON cte.dt = CAST(payments.payment_dttm AS DATE)
		GROUP BY cte.dt
        ) AS pjoin -- returns table listing revenue for each day
	INNER JOIN -- still easier than making a outer join substitute
		(
        SELECT cte.dt, COUNT(DISTINCT sessions.user_id) AS dau
			FROM cte LEFT JOIN sessions
				ON cte.dt = CAST(sessions.begin_dttm AS DATE)
		GROUP BY cte.dt
        ) AS sjoin -- returns table listing DAU for each day
	ON pjoin.dt = sjoin.dt
	ORDER BY pjoin.dt
;