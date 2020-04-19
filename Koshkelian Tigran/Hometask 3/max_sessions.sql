# Вывести логины трёх пользователей с наибольшим количеством сессий

SELECT login
FROM Users JOIN Sessions ON Users.user_id = Sessions.user_id
GROUP BY Users.user_id
ORDER BY COUNT(session_id) DESC
LIMIT 3

# login_57
# login_9
# login_83
