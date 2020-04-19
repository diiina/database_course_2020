SELECT AVG(agregate_payment_sum) FROM 
(SELECT SUM(payments.payment_sum) as agregate_payment_sum 
FROM users RIGHT JOIN payments ON users.user_id = payments.user_id
GROUP BY users.user_id) as agregate_payment_sums

/*
result:

2813.9591836734694
*/