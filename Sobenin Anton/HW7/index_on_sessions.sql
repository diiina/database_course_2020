CREATE INDEX uid_dttm_idx ON sessions (user_id ASC, begin_dttm);

-- ускорение выполнения запроса DAU с 0.002537 до 0.001055 сек на клиентской стороне
-- table lock уменьшился с 0.001174 до 0.00035 на серверной части
