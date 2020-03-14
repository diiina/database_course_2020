-- Вывести логины трёх пользователей с наибольшим количеством сессий

SELECT login, COUNT(s.begin_dttm) AS session_count 
FROM users AS u 
INNER JOIN sessions AS s 
ON u.user_id = s.user_id 
GROUP BY u.user_id 
ORDER BY session_count DESC 
LIMIT 3;

-- Результат

/* login_57	147
login_9	134
login_83	133 */