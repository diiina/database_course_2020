-- ARPU, Average Revenue Per User

USE database_course;

WITH RECURSIVE cte(dt) AS (
	SELECT MIN(CAST(payments.payment_dttm AS DATE)) AS dt
    FROM payments
    UNION ALL
    SELECT dt + INTERVAL 1 WEEK
    FROM cte
    WHERE dt + INTERVAL 1 WEEK <= (SELECT MAX(CAST(payments.payment_dttm AS DATE)) FROM payments)
),
wau AS (
	SELECT cte.dt, COUNT(DISTINCT sessions.user_id) AS user_count
	FROM sessions RIGHT JOIN cte ON CAST(sessions.begin_dttm AS DATE) >= cte.dt 
		AND CAST(sessions.begin_dttm AS DATE) < cte.dt + INTERVAL 1 WEEK
	GROUP BY cte.dt
	ORDER BY cte.dt
),
revenue AS (
	SELECT cte.dt AS dt, SUM(payments.payment_sum) as payment_sum
    FROM cte LEFT JOIN payments ON cte.dt <= CAST(payments.payment_dttm AS DATE)
        AND cte.dt + INTERVAL 1 WEEK > CAST(payments.payment_dttm AS DATE)
	GROUP BY cte.dt
)
SELECT cte.dt AS dt, COALESCE(revenue.payment_sum, 0) / COALESCE(wau.user_count, 1) AS arpu
FROM cte 
	LEFT JOIN revenue ON cte.dt = revenue.dt
	LEFT JOIN wau ON cte.dt = wau.dt;
    
-- Результат
-- # dt, arpu
-- '2018-08-07', '181.9'
-- '2018-08-14', '359.3529411764706'
-- '2018-08-21', '406.3157894736842'
-- '2018-08-28', '250.51724137931035'
-- '2018-09-04', '366.79411764705884'
-- '2018-09-11', '482.94871794871796'
-- '2018-09-18', '494.55102040816325'
-- '2018-09-25', '1142.923076923077'
