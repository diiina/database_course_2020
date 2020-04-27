SELECT avg(user_session_count.cnt) FROM (SELECT count(s.session_id) AS cnt FROM users U JOIN sessions S
ON U.user_id = S.user_id
GROUP BY U.user_id) AS user_session_count;