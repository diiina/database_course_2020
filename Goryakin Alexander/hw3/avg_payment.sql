-- Посчитать средний платёж платящего пользователя

SELECT AVG(ps.payment_sum) FROM (SELECT login, SUM(p.payment_sum) AS payment_sum
FROM users AS u 
INNER JOIN payments AS p 
ON u.user_id = p.user_id 
GROUP BY u.user_id) AS ps;

-- Результат

/* 2830.591836734694 */