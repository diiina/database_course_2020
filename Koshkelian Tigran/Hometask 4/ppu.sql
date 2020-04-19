# Вывести процент платящей аудитории от дневной аудитории, для каждого дня
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
paying_users AS (
	SELECT CAST(payments.payment_dttm AS DATE) date,
	       COUNT(DISTINCT payments.user_id) count
    FROM payments
    GROUP BY date
), 
daily_active_users AS (
	SELECT CAST(sessions.begin_dttm AS DATE) date,
	       COUNT(DISTINCT sessions.user_id) count
    FROM sessions
    GROUP BY date
)
SELECT dates.date Day, COALESCE(paying_users.count, 0)
                           /COALESCE(daily_active_users.count, 1) * 100 PPU
FROM dates
LEFT JOIN paying_users ON dates.date = paying_users.date
LEFT JOIN daily_active_users ON dates.date = daily_active_users.date
ORDER BY Day DESC

# 2018-09-30	29.2683
# 2018-09-29	30.9524
# 2018-09-28	32.3529
# 2018-09-27	38.8889
# 2018-09-26	32.4324
# 2018-09-25	23.6842
# 2018-09-24	28.5714
# 2018-09-23	15.6250
# 2018-09-22	13.3333
# 2018-09-21	20.5882
# 2018-09-20	17.1429
# 2018-09-19	25.0000
# 2018-09-18	6.6667
# 2018-09-17	15.3846
# 2018-09-16	29.0323
# 2018-09-15	20.6897
# 2018-09-14	12.5000
# 2018-09-13	11.5385
# 2018-09-12	12.0000
# 2018-09-11	21.7391
# 2018-09-10	15.3846
# 2018-09-09	11.5385
# 2018-09-08	25.0000
# 2018-09-07	8.3333
# 2018-09-06	17.3913
# 2018-09-05	6.2500
# 2018-09-04	12.5000
# 2018-09-03	0.0000
# 2018-09-02	10.0000
# 2018-09-01	22.2222
# 2018-08-31	17.6471
# 2018-08-30	21.0526
# 2018-08-29	7.1429
# 2018-08-28	25.0000
# 2018-08-27	33.3333
# 2018-08-26	0.0000
# 2018-08-25	15.3846
# 2018-08-24	28.5714
# 2018-08-23	13.3333
# 2018-08-22	0.0000
# 2018-08-21	9.0909
# 2018-08-20	12.5000
# 2018-08-19	14.2857
# 2018-08-18	7.6923
# 2018-08-17	28.5714
# 2018-08-16	9.0909
# 2018-08-15	66.6667
# 2018-08-14	22.2222
# 2018-08-13	0.0000
# 2018-08-12	16.6667
# 2018-08-11	40.0000
# 2018-08-10	20.0000
# 2018-08-09	0.0000
# 2018-08-08	0.0000
# 2018-08-07	50.0000
# 2018-08-06	0.0000
# 2018-08-05	0.0000
# 2018-08-04	0.0000
# 2018-08-03	0.0000
# 2018-08-02	0.0000

