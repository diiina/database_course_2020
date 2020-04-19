-- CREATE INDEX ind_dttm ON sessions(user_id, begin_dttm);

EXPLAIN WITH RECURSIVE cte(dt) AS (
	SELECT MIN(CAST(begin_dttm AS DATE)) AS dt FROM sessions
    UNION ALL
    SELECT dt + INTERVAL 1 DAY FROM cte
    WHERE dt + INTERVAL 1 DAY <= (SELECT MAX(CAST(begin_dttm AS DATE)) from sessions)
)
SELECT cte.dt, count(DISTINCT user_id)
FROM cte
LEFT JOIN
sessions ON cte.dt = CAST(sessions.begin_dttm AS DATE)
AND
cte.dt + INTERVAL 7 DAY > CAST(sessions.begin_dttm AS DATE)
GROUP BY cte.dt
ORDER BY cte.dt;

-- Результат:
-- '1', 'PRIMARY', '<derived2>', NULL, 'ALL', NULL, NULL, NULL, NULL, '3', '100.00', 'Using filesort'
-- '1', 'PRIMARY', 'sessions', NULL, 'index', NULL, 'ind_dttm', '8', NULL, '3591', '100.00', 'Using where; Using index'
-- '2', 'DERIVED', 'sessions', NULL, 'index', NULL, 'ind_dttm', '8', NULL, '3591', '100.00', 'Using index'
-- '3', 'UNION', 'cte', NULL, 'ALL', NULL, NULL, NULL, NULL, '2', '100.00', 'Recursive; Using where'
-- '5', 'SUBQUERY', 'sessions', NULL, 'index', NULL, 'ind_dttm', '8', NULL, '3591', '100.00', 'Using index'
