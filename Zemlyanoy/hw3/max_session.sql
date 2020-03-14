-- Вывести логины трёх пользователей с наибольшим количеством сессий
SELECT users.login, count(sessions.user_id)
	FROM
		users
	INNER JOIN
		sessions
	ON users.user_id = sessions.user_id
    GROUP BY users.user_id
    ORDER BY count(sessions.session_id) DESC
 	LIMIT 3
;

-- Результат
-- login_57 147
-- login_9 134
-- login_83 133