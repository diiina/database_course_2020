-- Посчитать средний платёж платящего пользователя
SELECT AVG(p.payment_sum)
	FROM users AS u
    INNER JOIN payments as p
    ON u.user_id = p.user_id
    WHERE p.payment_sum > 0;

-- Результат
-- # AVG(p.payment_sum)
-- 1 513.7000