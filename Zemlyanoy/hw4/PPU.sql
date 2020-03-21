-- PPU, computed per each day
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
	cte.dt, 
    COUNT(DISTINCT ses.suid) AS dau, 
    COUNT(DISTINCT ses.puid) AS dapu, -- number of (unique) active user_id's among paying ones in a given day
	IF(COUNT(DISTINCT ses.suid), COUNT(DISTINCT ses.puid)/COUNT(DISTINCT ses.suid), NULL) AS ppu
    -- PPU will be returned as NULL on days with DAU=0;
    -- behavior is the same if just dapu/dau used, 
    -- but better to set it explicitly
	FROM 
		cte 
	LEFT JOIN 
		(
        -- return all session records, along with payment records where those exist
        SELECT sessions.user_id AS suid, payments.user_id AS puid, sessions.begin_dttm 
			FROM 
				sessions 
			LEFT JOIN -- thus, a paying user id is counted only when it is also an active user id;
					  -- yet an active user id is counted no matter what
				payments
			ON sessions.user_id = payments.user_id
		) AS ses
	ON cte.dt = CAST(ses.begin_dttm AS DATE)
    GROUP BY cte.dt
	ORDER BY cte.dt
;