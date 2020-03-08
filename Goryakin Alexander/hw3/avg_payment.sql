-- Посчитать средний платёж платящего пользователя

SELECT login, AVG(p.payment_sum) AS avg_payment_sum
FROM users AS u 
INNER JOIN payments AS p 
ON u.user_id = p.user_id 
GROUP BY u.user_id;

-- Результат

/* login_1	454.375
login_3	426.8
login_8	532.8571428571429
login_11	449
login_14	707
login_16	796
login_19	293
login_20	594.7777777777778
login_21	462.5
login_22	530.5
login_26	568
login_28	581
login_30	398
login_35	513.1
login_37	248.8
login_38	621.4
login_40	542.7777777777778
login_44	474.8
login_52	963.5
login_53	608
login_56	465.5
login_58	525.3333333333334
login_59	410.75
login_60	681.25
login_64	462.25
login_66	236.5
login_67	477.5
login_68	532.3333333333334
login_69	551.1111111111111
login_70	604.75
login_73	517.4
login_74	521.25
login_76	384.3333333333333
login_77	379
login_80	907
login_81	547.6666666666666
login_82	714.8
login_84	511.55555555555554
login_85	550.8
login_87	545.5
login_89	282.85714285714283
login_90	584
login_91	337.8
login_92	485.1111111111111
login_93	525.7777777777778
login_94	390.875
login_95	515.6
login_97	556.5
login_99	500.2857142857143 */