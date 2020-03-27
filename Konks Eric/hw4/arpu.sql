-- ARPU
WITH RECURSIVE cte(dt) AS
(
	SELECT MIN(CAST(begin_dttm AS DATE)) AS dt FROM payments
    UNION ALL
    SELECT dt + INTERVAL 1 WEEK
    FROM cte
    WHERE dt + INTERVAL 1 WEEK <= (SELECT MAX(CAST(begin_dttm AS DATE)) from sessions)
),
wau AS 
(
	SELECT cte.dt AS dt, COUNT(DISTINCT sessions.user_id) AS user_count
	FROM cte LEFT JOIN sessions ON 
		cte.dt <= CAST(sessions.begin_dttm AS DATE)
		AND
		cte.dt + INTERVAL 1 WEEK > CAST(sessions.begin_dttm AS DATE)
	GROUP BY cte.dt
),
rev AS
(
	SELECT cte.dt AS dt, SUM(payments.payment_sum) as payment_sum
    FROM cte LEFT JOIN payments ON
		cte.dt <= CAST(payments.payment_dttm AS DATE)
        AND
        cte.dt + INTERVAL 1 WEEK > CAST(payments.payment_dttm AS DATE)
	GROUP BY cte.dt
)
SELECT cte.dt AS dt, COALESCE(rev.payment_sum, 0) / COALESCE(wau.user_count, 1) AS arpu
FROM cte 
LEFT JOIN rev ON cte.dt = rev.dt
LEFT JOIN wau ON cte.dt = wau.dt;

-- РЕЗУЛЬТАТ
/*
2018-08-02	150.33333333333334
2018-08-09	311.3636363636364
2018-08-16	228.11764705882354
2018-08-23	477.95454545454544
2018-08-30	196.48387096774192
2018-09-06	452.65714285714284
2018-09-13	427.7560975609756
2018-09-20	769.4
2018-09-27	808.2745098039215
*/
