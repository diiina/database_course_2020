SELECT AVG(p.payment) 
FROM (SELECT user_id, SUM(payment_sum) as payment 
FROM payments 
GROUP BY user_id) AS p;

/*
2813.9591836734694
*/