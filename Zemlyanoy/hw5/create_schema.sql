CREATE SCHEMA IF NOT EXISTS `zemlyanoy_db`;

CREATE USER 'user' IDENTIFIED BY 'Abcd';

GRANT ALL ON `zemlyanoy_db`.* TO 'user';
