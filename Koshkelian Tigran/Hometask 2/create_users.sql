CREATE TABLE Users(
    user_id  INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    login    VARCHAR(100) NOT NULL,
    reg_dttm TIMESTAMP NOT NULL
);