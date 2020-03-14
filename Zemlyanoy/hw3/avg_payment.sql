-- Посчитать средний платёж платящего пользователя
SELECT avg(payments.payment_sum) 
	FROM
		users 
    INNER JOIN 
		payments 
	ON users.user_id = payments.payment_id
;

-- Результат
-- 513.9591836734694