-- CREATE INDEX 
CREATE INDEX ses_id_dttm ON sessions(user_id, begin_dttm);

-- EXPLAIN DAU
EXPLAIN WITH RECURSIVE cte(dt) AS 
(
	SELECT MIN(CAST(begin_dttm AS DATE)) AS dt FROM sessions
	UNION ALL
	SELECT dt + INTERVAL 1 DAY
    FROM cte 
	WHERE dt + INTERVAL 1 DAY <= (SELECT MAX(CAST(begin_dttm AS DATE)) from sessions)
)
SELECT cte.dt, COUNT(DISTINCT sessions.user_id) AS user_count
FROM cte LEFT JOIN sessions ON 	
    cte.dt <= CAST(sessions.begin_dttm AS DATE)
	AND
    cte.dt + INTERVAL 1 DAY > CAST(sessions.begin_dttm AS DATE)
GROUP BY cte.dt
ORDER BY cte.dt;

-- Результат
/*
1	PRIMARY	<derived2>		ALL									3		100.00	Using filesort
1	PRIMARY	sessions		index		ses_id_dttm		8		3591	100.00	Using where; Using index
2	DERIVED	sessions		index		ses_id_dttm		8		3591	100.00	Using index
3	UNION	cte				ALL									2		100.00	Recursive; Using where
5	SUBQUERY	sessions	index		ses_id_dttm		8		3591	100.00	Using index
*/

-- Описание
/*
1.1) Внешний запрос cte формирующий JOIN. Будет просканирована вся таблица и еще сделан дополнительный проход, чтобы выяснить, как извлечь строки в порядке сортировки.
1.2) Внешний запрос sessions формирующий JOIN. Будет просканировано только дерево индексов(3591 из 3591 строк). Здесь индекс ускоряет запрос.
2) Первый SELECT внутри FROM к sessions перед UNION для поиска минимума. Будет просканировано только дерево индексов(3591 из 3591 строк). Здесь индекс ускоряет запрос.
3) Второй SELECT внутри cte после UNION. Будет просканирована вся таблица рекурсивно.
5) Подзапрос к sessions для поиска максимума. Будет просканировано только дерево индексов(3591 из 3591 строк). Здесь индекс ускоряет запрос.
*/

