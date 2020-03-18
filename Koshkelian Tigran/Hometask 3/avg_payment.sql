# Вывести средний платёж для всех платящих пользователей

SELECT AVG(payment_sum)
FROM Payments JOIN Users on Payments.user_id = Users.user_id