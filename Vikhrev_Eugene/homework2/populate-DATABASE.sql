USE UserPaymentSession;

LOAD DATA
INFILE '/Users/flylikesoarin/Projects/Track-Mail/2019-2-Track-Databases-E-Vihrev/database_course/Vikhrev_Eugene/homework2/users.csv'
INTO TABLE users
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';

LOAD DATA
INFILE '/Users/flylikesoarin/Projects/Track-Mail/2019-2-Track-Databases-E-Vihrev/database_course/Vikhrev_Eugene/homework2/payments.csv'
INTO TABLE payments
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';

LOAD DATA
INFILE '/Users/flylikesoarin/Projects/Track-Mail/2019-2-Track-Databases-E-Vihrev/database_course/Vikhrev_Eugene/homework2/sessions.csv'
INTO TABLE sessions
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';
