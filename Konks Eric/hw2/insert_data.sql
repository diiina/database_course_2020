LOAD DATA LOCAL INFILE '/home/exucutional/users.csv' INTO TABLE users
	FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n';
    
LOAD DATA LOCAL INFILE '/home/exucutional/payments.csv' INTO TABLe payments
	FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n';
    
LOAD DATA LOCAL INFILE '/home/exucutional/sessions.csv' INTO TABLE sessions
	FIELDS TERMINATED BY ';' LINES TERMINATED by '\n';
