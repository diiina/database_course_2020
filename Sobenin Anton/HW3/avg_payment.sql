-- Посчитать средний платёж платящего пользователя
SELECT u.login, AVG(p.payment_sum) as avg_payments
	FROM users AS u
    INNER JOIN payments as p
    ON u.user_id = p.user_id
    GROUP BY u.user_id
    HAVING avg_payments > 0
;

-- Результат
/*
# login,avg_payments
login_1,454.3750
login_3,426.8000
login_8,532.8571
login_11,449.0000
login_14,707.0000
login_16,796.0000
login_19,293.0000
login_20,594.7778
login_21,462.5000
login_22,530.5000
login_26,568.0000
login_28,581.0000
login_30,398.0000
login_35,513.1000
login_37,248.8000
login_38,621.4000
login_40,542.7778
login_44,474.8000
login_52,963.5000
login_53,608.0000
login_56,465.5000
login_58,525.3333
login_59,410.7500
login_60,681.2500
login_64,462.2500
login_66,236.5000
login_67,477.5000
login_68,532.3333
login_69,551.1111
login_70,604.7500
login_73,517.4000
login_74,521.2500
login_76,384.3333
login_77,379.0000
login_80,907.0000
login_81,547.6667
login_82,714.8000
login_84,511.5556
login_85,550.8000
login_87,545.5000
login_89,282.8571
login_90,584.0000
login_91,337.8000
login_92,485.1111
login_93,525.7778
login_94,390.8750
login_95,515.6000
login_97,556.5000
login_99,500.2857
*/