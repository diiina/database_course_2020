LOAD DATA LOCAL INFILE '/home/exucutional/Projects/database_course_2020/Konks Eric/hw2/users.txt' INTO TABLE users
	FIELDS TERMINATED BY ',' LINES STARTING BY ';'
    
LOAD DATA LOCAL INFILE '/home/exucutional/Projects/database_course_2020/Konks Eric/hw2/payments.txt' INTO TABLe payments
	FIELDS TERMINATED BY ',' LINES STARTING BY ';';
    
LOAD DATA LOCAL INFILE '/home/exucutional/Projects/database_course_2020/Konks Eric/hw2/sessions.txt' INTO TABLE sessions
	FIELDS TERMINATED BY ',' LINES STARTING by ';';
