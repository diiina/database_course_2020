CREATE TABLE IF NOT EXISTS tt.payments
(
    payments_id INT AUTO_INCREMENT,
    user_id INT,
    payment_sum INT,
    payment_dttm TIMESTAMP,
    PRIMARY KEY (payments_id),
    FOREIGN KEY (user_id) REFERENCES tt.users (user_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
);
