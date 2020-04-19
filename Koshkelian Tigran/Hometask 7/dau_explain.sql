# Вывести EXPLAIN для dau
EXPLAIN
WITH RECURSIVE dates(date) AS (
	SELECT CAST(MAX(begin_dttm) AS DATE) date
	FROM Sessions
	UNION ALL
	SELECT date + INTERVAL 1 DAY FROM dates
	WHERE date + INTERVAL 1 DAY <= (
	            SELECT CAST(MAX(begin_dttm) AS DATE)
	            FROM Sessions
	        )
)
SELECT dates.date 'Day',
       COUNT(DISTINCT sessions.user_id) DAU
FROM dates LEFT JOIN Sessions
    ON CAST(sessions.begin_dttm AS DATE) >= dates.date
        AND CAST(sessions.begin_dttm AS DATE) < dates.date + INTERVAL 1 WEEK
GROUP BY dates.date
ORDER BY dates.date DESC;

# Initial:

# +--+-----------+----------+----------+----+-------------+----+-------+----+----+--------+----------------------+
# |id|select_type|table     |partitions|type|possible_keys|key |key_len|ref |rows|filtered|Extra                 |
# +--+-----------+----------+----------+----+-------------+----+-------+----+----+--------+----------------------+
# |1 |PRIMARY    |<derived2>|NULL      |ALL |NULL         |NULL|NULL   |NULL|3   |100     |Using filesort        |
# |1 |PRIMARY    |Sessions  |NULL      |ALL |NULL         |NULL|NULL   |NULL|3591|100     |Using where           |
# |2 |DERIVED    |Sessions  |NULL      |ALL |NULL         |NULL|NULL   |NULL|3591|100     |NULL                  |
# |3 |UNION      |dates     |NULL      |ALL |NULL         |NULL|NULL   |NULL|2   |100     |Recursive; Using where|
# |5 |SUBQUERY   |Sessions  |NULL      |ALL |NULL         |NULL|NULL   |NULL|3591|100     |NULL                  |
# +--+-----------+----------+----------+----+-------------+----+-------+----+----+--------+----------------------+

# Optimized:

# +--+-----------+----------+----------+-----+-------------+----------+-------+----+----+--------+----------------------+
# |id|select_type|table     |partitions|type |possible_keys|key       |key_len|ref |rows|filtered|Extra                 |
# +--+-----------+----------+----------+-----+-------------+----------+-------+----+----+--------+----------------------+
# |1 |PRIMARY    |<derived2>|NULL      |ALL  |NULL         |NULL      |NULL   |NULL|3   |100     |Using filesort        |
# |1 |PRIMARY    |Sessions  |NULL      |ALL  |NULL         |NULL      |NULL   |NULL|3591|100     |Using where           |
# |2 |DERIVED    |Sessions  |NULL      |index|NULL         |date_index|4      |NULL|3591|100     |Using index           |
# |3 |UNION      |dates     |NULL      |ALL  |NULL         |NULL      |NULL   |NULL|2   |100     |Recursive; Using where|
# |5 |SUBQUERY   |Sessions  |NULL      |index|NULL         |date_index|4      |NULL|3591|100     |Using index           |
# +--+-----------+----------+----------+-----+-------------+----------+-------+----+----+--------+----------------------+

# Description

# Запрос 1.1: запрос таблицы dates при формировании JOIN в основном запросе. Прочтено 3 строки из 3 с использованием файловой сортировки.
# Запрос 1.2: запрос таблицы sessions при формировании JOIN в основном запросе. Прочтено 3591 строк из 3591 с использованием.
# Запрос 2: запрос к sessions внутри JOIN. На этом этапе индекс ускоряет работу, позволяя производить соответствующие сравнения бинпоиском.
# Запрос 3: выполняется UNION ALL внутри dates. Прочтено 2 строки из 2 на каждом шаге рекурсии.
# Запрос 5: основной SELECT в подзапросе. Прочтено 3591 строк из 3591 с использованием индекса.