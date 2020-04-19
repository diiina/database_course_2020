USE database_course;

EXPLAIN WITH RECURSIVE cte(dt) AS (
	SELECT MIN(CAST(sessions.begin_dttm AS DATE)) AS dt FROM sessions
	UNION ALL
	SELECT dt + INTERVAL 1 DAY
    FROM cte 
	WHERE dt + INTERVAL 1 DAY <= (SELECT MAX(CAST(sessions.begin_dttm AS DATE)) from sessions)
)
SELECT cte.dt, COUNT(DISTINCT sessions.user_id) AS dau
FROM sessions RIGHT JOIN cte ON CAST(sessions.begin_dttm AS DATE) >= cte.dt 
AND CAST(sessions.begin_dttm AS DATE) < cte.dt + INTERVAL 1 WEEK
GROUP BY cte.dt
ORDER BY cte.dt;

-- Результат
-- # id, select_type, table,        partitions, type,  possible_keys, key,  key_len, ref,  rows,   filtered, Extra
-- '1', 'PRIMARY',    '<derived2>', NULL,       'ALL', NULL,          NULL, NULL,    NULL, '3',    '100.00', 'Using filesort'
-- '1', 'PRIMARY',    'sessions',   NULL,       'ALL', NULL,          NULL, NULL,    NULL, '3591', '100.00', 'Using where'
-- '2', 'DERIVED',    'sessions',   NULL,       'ALL', NULL,          NULL, NULL,    NULL, '3591', '100.00',  NULL
-- '3', 'UNION',      'cte',        NULL,       'ALL', NULL,          NULL, NULL,    NULL, '2',    '100.00', 'Recursive; Using where'
-- '5', 'SUBQUERY',   'sessions',   NULL,       'ALL', NULL,          NULL, NULL,    NULL, '3591', '100.00',  NULL
