WITH RECURSIVE cte AS (
    SELECT MIN(CAST(begin_dttm AS DATE)) AS dt FROM sessions
    UNION ALL
    SELECT dt + INTERVAL 1 DAY FROM cte
    WHERE dt + INTERVAL 1 DAY <= (SELECT MAX(CAST(begin_dttm AS DATE)) FROM sessions)
) SELECT C.dt, SP.paying_users / SP.active_users AS ppu FROM
    cte C
    JOIN
    (SELECT P.dt, P.paying_users, S.active_users FROM
    (SELECT CAST(payment_dttm AS DATE) AS dt, count(DISTINCT user_id) AS paying_users FROM payments
    GROUP BY CAST(payment_dttm AS DATE)) P
    JOIN
    (SELECT CAST(begin_dttm AS DATE) AS dt,  count(DISTINCT user_id) AS active_users FROM sessions
    GROUP BY CAST(begin_dttm AS DATE)) S
    ON P.dt = S.dt) SP
    ON SP.dt = C.dt
    ORDER BY C.dt;