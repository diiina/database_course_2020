LOAD DATA INFILE '/home/sav/Загрузки/DB-1/users.csv'
INTO TABLE tt.users
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
(user_id, login, @reg_dttm)
SET	reg_dttm = str_to_date(@reg_dttm, '%Y-%m-%d %T');

LOAD DATA INFILE '/home/sav/Загрузки/DB-1/sessions.csv'
INTO TABLE tt.sessions
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
(session_id, user_id, payment_sum, @payment_dttm)
SET payment_dttm = str_to_date(@payment_dttm, '%Y-%m-%d %T');

LOAD DATA INFILE '/home/sav/Загрузки/DB-1/payments.csv'
INTO TABLE tt.payments
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
(payments_id, user_id, @begin_dttm, @end_dttm)
SET begin_dttm = str_to_date(@begin_dttm, '%Y-%m-%d %T'),
	end_dttm = str_to_date(@end_dttm, '%Y-%m-%d %T');