# Вывести средний доход с пользователя, для каждого дня
WITH RECURSIVE dates(date) AS (
	SELECT MIN(CAST(begin_dttm AS DATE)) date
	FROM Sessions
	UNION ALL
	SELECT date + INTERVAL 1 DAY FROM dates
	WHERE date + INTERVAL 1 DAY <= (
	          SELECT MAX(CAST(begin_dttm AS DATE))
	          FROM Sessions
	          )
),
total_daily_payment AS (
	SELECT CAST(payments.payment_dttm AS DATE) date,
	       SUM(payment_sum) total_payment
    FROM payments
    GROUP BY date
),
daily_active_users AS (
	SELECT CAST(sessions.begin_dttm AS DATE) AS date,
	       COUNT(DISTINCT sessions.user_id) AS user_count
    FROM sessions
    GROUP BY date
)
SELECT dates.date Day, COALESCE(total_daily_payment.total_payment, 0)
                       /COALESCE(daily_active_users.user_count, 1) ARPU
FROM dates
LEFT JOIN total_daily_payment ON dates.date = total_daily_payment.date
LEFT JOIN daily_active_users ON dates.date = daily_active_users.date
ORDER BY Day DESC

# 2018-09-30	326.9268
# 2018-09-29	261.6667
# 2018-09-28	321.6765
# 2018-09-27	163.6389
# 2018-09-26	342.7568
# 2018-09-25	145.4737
# 2018-09-24	211.7429
# 2018-09-23	114.5938
# 2018-09-22	35.0667
# 2018-09-21	124.4118
# 2018-09-20	111.4286
# 2018-09-19	102.2813
# 2018-09-18	23.3333
# 2018-09-17	64.3462
# 2018-09-16	172.2258
# 2018-09-15	121.3448
# 2018-09-14	59.9167
# 2018-09-13	61.3846
# 2018-09-12	87.7600
# 2018-09-11	133.7391
# 2018-09-10	96.8846
# 2018-09-09	58.9231
# 2018-09-08	112.1250
# 2018-09-07	48.6667
# 2018-09-06	115.7826
# 2018-09-05	50.0000
# 2018-09-04	68.6250
# 2018-09-03	0.0000
# 2018-09-02	15.4500
# 2018-09-01	61.8889
# 2018-08-31	50.7647
# 2018-08-30	100.3684
# 2018-08-29	38.3571
# 2018-08-28	158.4375
# 2018-08-27	272.8333
# 2018-08-26	0.0000
# 2018-08-25	81.3077
# 2018-08-24	158.9286
# 2018-08-23	59.1333
# 2018-08-22	0.0000
# 2018-08-21	25.1818
# 2018-08-20	63.5000
# 2018-08-19	54.5000
# 2018-08-18	64.5385
# 2018-08-17	209.0000
# 2018-08-16	2.5455
# 2018-08-15	248.0000
# 2018-08-14	113.3333
# 2018-08-13	0.0000
# 2018-08-12	55.0000
# 2018-08-11	54.0000
# 2018-08-10	63.4000
# 2018-08-09	0.0000
# 2018-08-08	0.0000
# 2018-08-07	451.0000
# 2018-08-06	0.0000
# 2018-08-05	0.0000
# 2018-08-04	0.0000
# 2018-08-03	0.0000
# 2018-08-02	0.0000