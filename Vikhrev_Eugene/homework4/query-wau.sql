WITH RECURSIVE cte AS (
    SELECT MIN(CAST(begin_dttm AS DATE)) AS dt FROM sessions
    UNION ALL
    SELECT dt + INTERVAL 1 WEEK FROM cte
    WHERE dt + INTERVAL 1 WEEK <= (SELECT MAX(CAST(begin_dttm AS DATE)) FROM sessions)
) SELECT C.dt, count(DISTINCT S.user_id) as wau FROM cte C JOIN sessions S
    ON CAST(S.begin_dttm AS DATE) BETWEEN C.dt AND (C.dt + INTERVAL 6 DAY)
    GROUP BY C.dt
    ORDER BY C.dt;