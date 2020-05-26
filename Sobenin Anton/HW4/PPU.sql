-- PPU – Percentage of Paying Users
WITH RECURSIVE cte(dt) AS (
	SELECT MIN(cast(payments.payment_dttm AS DATE)) AS dt
		FROM payments
	UNION ALL
    SELECT dt + INTERVAL 1 DAY
		FROM cte
        WHERE dt + INTERVAL 1 DAY <= (SELECT MAX(cast(payments.payment_dttm AS DATE)) FROM payments)
),
pu AS (
	SELECT cast(payments.payment_dttm AS DATE) as dt, COUNT(DISTINCT payments.user_id) as cnt_pay_users
    FROM payments
    GROUP BY dt
),
dau AS (
	SELECT cast(sessions.begin_dttm AS DATE) AS dt, COUNT(DISTINCT sessions.user_id) AS cnt_users
    FROM sessions
    GROUP BY dt
)
SELECT cte.dt, COALESCE(pu.cnt_pay_users, 0) / COALESCE(dau.cnt_users, 1) AS ppu
	FROM cte 
	LEFT JOIN dau ON cte.dt = dau.dt
    LEFT JOIN pu  ON cte.dt = pu.dt
;

-- Результат
-- см. ppu.result.csv
