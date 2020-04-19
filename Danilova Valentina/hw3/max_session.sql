USE database_course;

-- Вывести логины трёх пользователей с наибольшим количеством сессий
SELECT users.user_id, COUNT(sessions.session_id) AS sessions_number
FROM users INNER JOIN sessions ON users.user_id = sessions.user_id GROUP BY sessions.user_id ORDER BY sessions_number DESC LIMIT 3;

-- Результат
-- # user_id, sessions_number
-- '57', '147'
-- '9', '134'
-- '83', '133'
