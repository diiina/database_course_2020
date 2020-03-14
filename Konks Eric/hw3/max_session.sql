SELECT login
FROM users
INNER JOIN sessions
ON users.user_id = sessions.user_id
GROUP BY login
ORDER BY COUNT(sessions.session_id) DESC
LIMIT 3;

-- Результат
-- login_57
-- login_9
-- login_83
