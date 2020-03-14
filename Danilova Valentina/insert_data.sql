LOAD DATA INFILE '/var/lib/mysql-files/users.csv' INTO TABLE users
  FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n';
LOAD DATA INFILE '/var/lib/mysql-files/payments.csv' INTO TABLE payments
  FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n';
LOAD DATA INFILE '/var/lib/mysql-files/sessions.csv' INTO TABLE sessions
  FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n';
  