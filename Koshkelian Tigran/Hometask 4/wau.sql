# Вывести количество активных пользователей за неделю, для каждой недели
WITH RECURSIVE dates(date) AS (
	SELECT MIN(CAST(begin_dttm AS DATE)) date
	FROM Sessions
	UNION ALL
	SELECT date + INTERVAL 1 WEEK FROM dates
	WHERE date + INTERVAL 1 WEEK <= (
	            SELECT MAX(CAST(begin_dttm AS DATE))
	            FROM Sessions
	        )
)
SELECT dates.date 'Week start',
       COUNT(DISTINCT sessions.user_id) WAU
FROM dates Left JOIN Sessions
    ON CAST(sessions.begin_dttm AS DATE) >= dates.date
        AND CAST(sessions.begin_dttm AS DATE) < dates.date + INTERVAL 1 WEEK
GROUP BY dates.date
ORDER BY dates.date DESC;


# 2018-09-27	51
# 2018-09-20	50
# 2018-09-13	41
# 2018-09-06	35
# 2018-08-30	31
# 2018-08-23	22
# 2018-08-16	17
# 2018-08-09	11
# 2018-08-02	6

