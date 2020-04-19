SELECT sessions.user_id, login 
FROM sessions, users  
WHERE sessions.user_id = users.user_id 
GROUP BY user_id 
ORDER BY COUNT(session_id) DESC 
LIMIT 3;

/*
  57 login_57
  9  login_9
  83 login_83
*/