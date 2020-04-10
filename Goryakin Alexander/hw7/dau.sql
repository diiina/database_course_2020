-- DAU

WITH RECURSIVE dau(dt) AS (
	SELECT MIN(CAST(begin_dttm AS DATE)) AS dt FROM sessions
	UNION ALL
	SELECT dt + INTERVAL 1 DAY FROM dau
	WHERE dt + INTERVAL 1 DAY <= (SELECT MAX(CAST(begin_dttm AS DATE)) from sessions)
)
SELECT dau.dt, COUNT(DISTINCT sessions.user_id) AS user_count
FROM sessions RIGHT JOIN dau ON CAST(sessions.begin_dttm AS DATE) >= dau.dt 
AND CAST(sessions.begin_dttm AS DATE) < dau.dt + INTERVAL 1 DAY
GROUP BY dau.dt
ORDER BY dau.dt;

-- DAU result:
/*
+------------+------------+
| dt         | user_count |
+------------+------------+
| 2018-08-02 |          1 |
| 2018-08-03 |          2 |
| 2018-08-04 |          1 |
| 2018-08-05 |          2 |
| 2018-08-06 |          3 |
| 2018-08-07 |          2 |
| 2018-08-08 |          6 |
| 2018-08-09 |          6 |
| 2018-08-10 |          5 |
| 2018-08-11 |          5 |
| 2018-08-12 |          6 |
| 2018-08-13 |          6 |
| 2018-08-14 |          9 |
| 2018-08-15 |          6 |
| 2018-08-16 |         11 |
| 2018-08-17 |          7 |
| 2018-08-18 |         13 |
| 2018-08-19 |         14 |
| 2018-08-20 |          8 |
| 2018-08-21 |         11 |
| 2018-08-22 |         13 |
| 2018-08-23 |         15 |
| 2018-08-24 |         14 |
| 2018-08-25 |         13 |
| 2018-08-26 |         13 |
| 2018-08-27 |         12 |
| 2018-08-28 |         16 |
| 2018-08-29 |         14 |
| 2018-08-30 |         19 |
| 2018-08-31 |         17 |
| 2018-09-01 |         18 |
| 2018-09-02 |         20 |
| 2018-09-03 |         20 |
| 2018-09-04 |         16 |
| 2018-09-05 |         16 |
| 2018-09-06 |         23 |
| 2018-09-07 |         24 |
| 2018-09-08 |         24 |
| 2018-09-09 |         26 |
| 2018-09-10 |         26 |
| 2018-09-11 |         23 |
| 2018-09-12 |         25 |
| 2018-09-13 |         26 |
| 2018-09-14 |         24 |
| 2018-09-15 |         29 |
| 2018-09-16 |         31 |
| 2018-09-17 |         26 |
| 2018-09-18 |         30 |
| 2018-09-19 |         32 |
| 2018-09-20 |         35 |
| 2018-09-21 |         34 |
| 2018-09-22 |         30 |
| 2018-09-23 |         32 |
| 2018-09-24 |         35 |
| 2018-09-25 |         38 |
| 2018-09-26 |         37 |
| 2018-09-27 |         36 |
| 2018-09-28 |         34 |
| 2018-09-29 |         42 |
| 2018-09-30 |         41 |
+------------+------------+
60 rows in set (0.12 sec)
*/

-- EXPLAIN

EXPLAIN WITH RECURSIVE dau(dt) AS (
	SELECT MIN(CAST(begin_dttm AS DATE)) AS dt FROM sessions
	UNION ALL
	SELECT dt + INTERVAL 1 DAY FROM dau
	WHERE dt + INTERVAL 1 DAY <= (SELECT MAX(CAST(begin_dttm AS DATE)) from sessions)
)
SELECT dau.dt, COUNT(DISTINCT sessions.user_id) AS user_count
FROM dau RIGHT JOIN sessions ON CAST(sessions.begin_dttm AS DATE) >= dau.dt 
AND CAST(sessions.begin_dttm AS DATE) < dau.dt + INTERVAL 1 DAY
GROUP BY dau.dt
ORDER BY dau.dt;

-- EXPLAIN result:

/*

+----+-------------+------------+------------+------+---------------+------+---------+------+------+----------+------------------------+
| id | select_type | table      | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra                  |
+----+-------------+------------+------------+------+---------------+------+---------+------+------+----------+------------------------+
|  1 | PRIMARY     | <derived2> | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    3 |   100.00 | Using filesort         |
|  1 | PRIMARY     | sessions   | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 3591 |   100.00 | Using where            |
|  2 | DERIVED     | sessions   | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 3591 |   100.00 | NULL                   |
|  3 | UNION       | dau        | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    2 |   100.00 | Recursive; Using where |
|  5 | SUBQUERY    | sessions   | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 3591 |   100.00 | NULL                   |
+----+-------------+------------+------------+------+---------------+------+---------+------+------+----------+------------------------+
5 rows in set, 1 warning (0.00 sec)

*/

-- INDEX

CREATE INDEX uid_dttm ON sessions(user_id, begin_dttm);

-- optimization:

WITH RECURSIVE dau(dt) AS (
	SELECT MIN(CAST(sessions.begin_dttm AS DATE)) AS dt FROM sessions 
	UNION ALL 
	SELECT dt + INTERVAL 1 DAY FROM dau 
	WHERE dt + INTERVAL 1 DAY <= (SELECT MAX(CAST(begin_dttm AS DATE)) from sessions)
)
SELECT dau.dt, COUNT(DISTINCT sessions.user_id) AS user_count 
FROM dau RIGHT JOIN sessions ON CAST(sessions.begin_dttm AS DATE) >= dau.dt 
AND CAST(sessions.begin_dttm AS DATE) < dau.dt + INTERVAL 1 DAY 
GROUP BY dau.dt 
ORDER BY dau.dt;

-- optimization result: 

/*
+------------+------------+
| dt         | user_count |
+------------+------------+
| 2018-08-02 |          1 |
| 2018-08-03 |          2 |
| 2018-08-04 |          1 |
| 2018-08-05 |          2 |
| 2018-08-06 |          3 |
| 2018-08-07 |          2 |
| 2018-08-08 |          6 |
| 2018-08-09 |          6 |
| 2018-08-10 |          5 |
| 2018-08-11 |          5 |
| 2018-08-12 |          6 |
| 2018-08-13 |          6 |
| 2018-08-14 |          9 |
| 2018-08-15 |          6 |
| 2018-08-16 |         11 |
| 2018-08-17 |          7 |
| 2018-08-18 |         13 |
| 2018-08-19 |         14 |
| 2018-08-20 |          8 |
| 2018-08-21 |         11 |
| 2018-08-22 |         13 |
| 2018-08-23 |         15 |
| 2018-08-24 |         14 |
| 2018-08-25 |         13 |
| 2018-08-26 |         13 |
| 2018-08-27 |         12 |
| 2018-08-28 |         16 |
| 2018-08-29 |         14 |
| 2018-08-30 |         19 |
| 2018-08-31 |         17 |
| 2018-09-01 |         18 |
| 2018-09-02 |         20 |
| 2018-09-03 |         20 |
| 2018-09-04 |         16 |
| 2018-09-05 |         16 |
| 2018-09-06 |         23 |
| 2018-09-07 |         24 |
| 2018-09-08 |         24 |
| 2018-09-09 |         26 |
| 2018-09-10 |         26 |
| 2018-09-11 |         23 |
| 2018-09-12 |         25 |
| 2018-09-13 |         26 |
| 2018-09-14 |         24 |
| 2018-09-15 |         29 |
| 2018-09-16 |         31 |
| 2018-09-17 |         26 |
| 2018-09-18 |         30 |
| 2018-09-19 |         32 |
| 2018-09-20 |         35 |
| 2018-09-21 |         34 |
| 2018-09-22 |         30 |
| 2018-09-23 |         32 |
| 2018-09-24 |         35 |
| 2018-09-25 |         38 |
| 2018-09-26 |         37 |
| 2018-09-27 |         36 |
| 2018-09-28 |         34 |
| 2018-09-29 |         42 |
| 2018-09-30 |         41 |
+------------+------------+
60 rows in set (0.08 sec)
*/

-- EXAPLIN after optimisation:

EXPLAIN WITH RECURSIVE dau(dt) AS (
	SELECT MIN(CAST(sessions.begin_dttm AS DATE)) AS dt FROM sessions 
	UNION ALL 
	SELECT dt + INTERVAL 1 DAY FROM dau 
	WHERE dt + INTERVAL 1 DAY <= (SELECT MAX(CAST(begin_dttm AS DATE)) from sessions)
)
SELECT dau.dt, COUNT(DISTINCT sessions.user_id) AS user_count 
FROM dau RIGHT JOIN sessions ON CAST(sessions.begin_dttm AS DATE) >= dau.dt 
AND CAST(sessions.begin_dttm AS DATE) < dau.dt + INTERVAL 1 DAY 
GROUP BY dau.dt 
ORDER BY dau.dt;

-- EXPLAIN result after optimisation with INDEX:

/*
+----+-------------+------------+------------+-------+---------------+----------+---------+------+------+----------+----------------------------------------------+
| id | select_type | table      | partitions | type  | possible_keys | key      | key_len | ref  | rows | filtered | Extra                                        |
+----+-------------+------------+------------+-------+---------------+----------+---------+------+------+----------+----------------------------------------------+
|  1 | PRIMARY     | sessions   | NULL       | index | NULL          | uid_dttm | 8       | NULL | 3591 |   100.00 | Using index; Using temporary; Using filesort |
|  1 | PRIMARY     | <derived2> | NULL       | ALL   | NULL          | NULL     | NULL    | NULL |    3 |   100.00 | Using where                                  |
|  2 | DERIVED     | sessions   | NULL       | index | NULL          | uid_dttm | 8       | NULL | 3591 |   100.00 | Using index                                  |
|  3 | UNION       | dau        | NULL       | ALL   | NULL          | NULL     | NULL    | NULL |    2 |   100.00 | Recursive; Using where                       |
|  5 | SUBQUERY    | sessions   | NULL       | index | NULL          | uid_dttm | 8       | NULL | 3591 |   100.00 | Using index                                  |
+----+-------------+------------+------------+-------+---------------+----------+---------+------+------+----------+----------------------------------------------+
5 rows in set, 1 warning (0.00 sec)
*/

-- EXPLAIN result after optimisation without INDEX:

/*
+----+-------------+------------+------------+------+---------------+------+---------+------+------+----------+---------------------------------+
| id | select_type | table      | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra                           |
+----+-------------+------------+------------+------+---------------+------+---------+------+------+----------+---------------------------------+
|  1 | PRIMARY     | sessions   | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 3591 |   100.00 | Using temporary; Using filesort |
|  1 | PRIMARY     | <derived2> | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    3 |   100.00 | Using where                     |
|  2 | DERIVED     | sessions   | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 3591 |   100.00 | NULL                            |
|  3 | UNION       | dau        | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    2 |   100.00 | Recursive; Using where          |
|  5 | SUBQUERY    | sessions   | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 3591 |   100.00 | NULL                            |
+----+-------------+------------+------------+------+---------------+------+---------+------+------+----------+---------------------------------+
*/

-- EXPLAIN description:

/*
Использование индекса после оптимизации в данном случае не влияет на скорость выполнения запроса.

Во время выполнения запроса к базе делатся пять запросов:
1.1. Внешний select, выполняемый над таблицей sessions, таблица не делится на партиции. Производится Full Scan. Придется читать 3591 строку, из которых подходят 100% строк. Используется файловая сортировка с временной таблицей.
	* В случае использования индекса используются покрывающие индексы, производится Full Scan по индексу и указывается выбранный индекс.
1.2. Внешний select, выполняемый над таблицей <derived2>, таблица не делится на партиции. Производится Full Scan. Придется читать 3 строки, из которых подходят 100% строк. Сервер фильтрует строки, после фильтрации системой хранения.
2. Подзапрос во FROMв таблице sessions. Производится либо Full Scan, либо Full Scan по индексу. Придется читать 3591 строку, из которых подходят 100% строк. Возможно использование покрывающих индексов.
3. Производится UNION над таблицей dau. Производится Full Scan. Придется читать 3 строки, из которых подходят 100% строк. Используется рекрсивный вызов и сервер фильтрует строки, после фильтрации системой хранения.
5. В SELECT выполняется подзапрос в таблицу sessions. Производится либо Full Scan, либо Full Scan по индексу. Придется читать 3591 строку, из которых подходят 100% строк.
*/