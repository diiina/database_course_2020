-- Вывести логины трёх пользователей с наибольшим количеством сессий
SELECT login, COUNT(s.session_id) AS sessions_count
	FROM users AS u
	INNER JOIN sessions AS s
	ON u.user_id = s.user_id
	GROUP BY u.user_id
	ORDER BY sessions_count DESC
	LIMIT 3;

-- Результат
-- # login,sessions_count
-- 1 login_57,147
-- 2 login_9,134
-- 3 login_83,133
