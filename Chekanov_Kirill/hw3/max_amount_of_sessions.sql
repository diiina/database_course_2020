
SELECT COUNT(session_id) as sessions_amount, login FROM sessions
INNER JOIN users ON users.user_id = sessions.user_id
GROUP BY sessions.user_id
ORDER BY sessions_amount DESC
LIMIT 3

/* result:
	147	login_57
	134	login_9
	133	login_83
*/