SELECT U.user_id, U.login, sum(P.payment_sum) as total_payments
FROM users U JOIN payments P
ON U.user_id = P.user_id
GROUP BY U.user_id
ORDER BY total_payments DESC
LIMIT 3;