SELECT AVG(avg_payment) 
FROM (SELECT payments.user_id, AVG(payment_sum) AS avg_payment
FROM payments
INNER JOIN users
ON payments.user_id = users.user_id
GROUP BY users.user_id) AS avg_payments;

-- Результат
-- 519.828117913832
