-- ARPU — Average Revenue Per User
/**/
WITH RECURSIVE cte_weekly(dt) AS (
	SELECT MIN(cast(payments.payment_dttm AS DATE)) AS dt
		FROM payments
	UNION ALL
    SELECT dt + INTERVAL 1 WEEK
		FROM cte_weekly
        WHERE dt + INTERVAL 1 WEEK <= (SELECT MAX(cast(payments.payment_dttm AS DATE)) FROM payments)
),
revenue_weekly AS (
	SELECT cte_weekly.dt AS dt, SUM(payments.payment_sum) as pay_sum_per_week
    FROM payments
    RIGHT JOIN cte_weekly
    ON cast(payments.payment_dttm AS DATE) >= cte_weekly.dt AND cast(payments.payment_dttm AS DATE) < cte_weekly.dt + INTERVAL 1 WEEK
    GROUP BY cte_weekly.dt
),

wau AS (
	SELECT cte_weekly.dt, COUNT(DISTINCT sessions.user_id) AS cnt_users
    FROM sessions
    RIGHT JOIN cte_weekly 
    ON cast(sessions.begin_dttm AS DATE) >= cte_weekly.dt AND cast(sessions.begin_dttm AS DATE) < cte_weekly.dt + INTERVAL 1 WEEK
    GROUP BY cte_weekly.dt
    ORDER BY cte_weekly.dt
)
SELECT cte_weekly.dt, COALESCE(rev.pay_sum_per_week, 0) / COALESCE(wau.cnt_users, 1) AS arpu
	FROM cte_weekly 
	LEFT JOIN wau ON cte_weekly.dt = wau.dt
    LEFT JOIN revenue_weekly AS rev  ON cte_weekly.dt = rev.dt
;
/**/
/*
WITH RECURSIVE cte_daily(dt) AS (
	SELECT MIN(cast(payments.payment_dttm AS DATE)) AS dt
		FROM payments
	UNION ALL
    SELECT dt + INTERVAL 1 DAY
		FROM cte_daily
        WHERE dt + INTERVAL 1 DAY <= (SELECT MAX(cast(payments.payment_dttm AS DATE)) FROM payments)
),
revenue_daily AS (
	SELECT cast(payments.payment_dttm AS DATE) as dt, SUM(payments.payment_sum) as pay_sum_per_day
    FROM payments
    GROUP BY dt
),
dau AS (
	SELECT cast(sessions.begin_dttm AS DATE) AS dt, COUNT(DISTINCT sessions.user_id) AS cnt_users
    FROM sessions
    GROUP BY dt
)
SELECT cte_daily.dt, COALESCE(rev.pay_sum_per_day, 0) / COALESCE(dau.cnt_users, 1) AS arpu
	FROM cte_daily 
	LEFT JOIN dau ON cte_daily.dt = dau.dt
    LEFT JOIN revenue_daily AS rev  ON cte_daily.dt = rev.dt
;
*/

-- Результат
-- см. arpu.result.csv
