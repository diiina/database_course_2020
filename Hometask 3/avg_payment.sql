# Вывести средний платёж для всех платящих пользователей

SELECT login, AVG(payment_sum)
FROM Payments JOIN Users on Payments.user_id = Users.user_id
GROUP BY Users.user_id