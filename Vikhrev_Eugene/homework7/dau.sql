USE HospitalDB;

EXPLAIN WITH RECURSIVE cte AS (
    SELECT MIN(CAST(time AS DATE)) AS dt FROM appointments
    UNION ALL
    SELECT dt + INTERVAL 1 DAY FROM cte
    WHERE dt + INTERVAL 1 DAY <= (SELECT MAX(CAST(time AS DATE)) FROM appointments)
) SELECT C.dt, count(DISTINCT AP.appointment_id) as dau FROM cte C JOIN appointments AP
    ON CAST(AP.time AS DATE) = C.dt
    GROUP BY C.dt
    ORDER BY C.dt;

CREATE INDEX appointment_time ON appointments (time);

EXPLAIN WITH RECURSIVE cte AS (
    SELECT MIN(CAST(time AS DATE)) AS dt FROM appointments
    UNION ALL
    SELECT dt + INTERVAL 1 DAY FROM cte
    WHERE dt + INTERVAL 1 DAY <= (SELECT MAX(CAST(time AS DATE)) FROM appointments)
) SELECT C.dt, count(*) as dau FROM cte C JOIN appointments AP
    ON CAST(AP.time AS DATE) = C.dt
    GROUP BY C.dt
    ORDER BY C.dt;