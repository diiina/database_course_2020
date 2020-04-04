USE database_course;

-- Посчитать средний платёж платящего пользователя
SELECT AVG(avg_payment_sum) 
FROM (
	SELECT payments.user_id, AVG(payments.payment_sum) AS avg_payment_sum
	FROM payments INNER JOIN users ON payments.user_id = users.user_id GROUP BY	payments.user_id
    ) AS avg_payment;

-- Результат
-- AVG(avg_payment_sum)
-- '519.6095319080011'
