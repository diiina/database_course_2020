USE UserPaymentSession;
CREATE TABLE IF NOT EXISTS payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    payment_sum DOUBLE NOT NULL,
    payment_dttm TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);