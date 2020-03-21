# Вывести средний платёж для всех платящих пользователей

SELECT AVG(help.user_sum) average
FROM (
        SELECT SUM(payment_sum) user_sum
        FROM Payments
        JOIN Users ON Payments.user_id = Users.user_id
        GROUP BY Users.user_id
    ) help

# 2813.9592
