WITH RECURSIVE cte AS (
    SELECT MIN(CAST(begin_dttm AS DATE)) AS dt FROM sessions
    UNION ALL
    SELECT dt + INTERVAL 1 DAY FROM cte
    WHERE dt + INTERVAL 1 DAY <= (SELECT MAX(CAST(begin_dttm AS DATE)) FROM sessions)
) SELECT C.dt, FORMAT(SP.total_daily_payments / SP.paying_users, 2) AS arppu FROM
    cte C
    JOIN
    (SELECT P.dt, P.paying_users, S.total_daily_payments FROM
    (SELECT CAST(payment_dttm AS DATE) AS dt, COUNT(DISTINCT user_id) AS paying_users FROM payments
    GROUP BY CAST(payment_dttm AS DATE)) P
    JOIN
    (SELECT CAST(payment_dttm AS DATE) AS dt, SUM(payment_sum) AS total_daily_payments FROM payments
    GROUP BY CAST(payment_dttm AS DATE)) S
    ON P.dt = S.dt) SP
    ON SP.dt = C.dt
    ORDER BY C.dt;