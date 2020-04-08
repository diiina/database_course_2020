# Clear database

DELETE FROM ResultsPilots;
DELETE FROM ResultsTeams;
DELETE FROM CarPilot;
DELETE FROM TeamPilot;
DELETE FROM GrandPrixRes;
DELETE FROM Cars;
DELETE FROM Engines;
DELETE FROM Chassis;
DELETE FROM Manufacturers;
DELETE FROM Teams;
DELETE FROM Grand_prix;
DELETE FROM Championships;
DELETE FROM Circuits;
DELETE FROM Pilots;
DELETE FROM Locations;
DELETE FROM Countries;


# Drop all procedures

DROP PROCEDURE IF EXISTS generate_teams;
DROP PROCEDURE IF EXISTS generate_team_pilot;
DROP PROCEDURE IF EXISTS generate_manufacturers;
DROP PROCEDURE IF EXISTS generate_chassis;
DROP PROCEDURE IF EXISTS generate_engines;
DROP PROCEDURE IF EXISTS generate_cars;
DROP PROCEDURE IF EXISTS generate_car_pilot;
DROP PROCEDURE IF EXISTS generate_circuits;
DROP PROCEDURE IF EXISTS generate_championships;
DROP PROCEDURE IF EXISTS generate_grand_prix;
DROP PROCEDURE IF EXISTS generate_grand_prix_res;
DROP PROCEDURE IF EXISTS generate_pilots_results;
DROP PROCEDURE IF EXISTS generate_teams_results;



# Create procedures to generate data

INSERT INTO `Countries` VALUES
('1','Anguilla'),
('2','Saint Pierre and Miquelon'),
('3','Romania'),
('4','Afghanistan'),
('5','Jersey'),
('6','Morocco'),
('7','Antigua and Barbuda'),
('8','Somalia'),
('9','China'),
('10','Slovenia'),
('11','Guadeloupe'),
('12','South Georgia and the South Sandwich Islands'),
('13','Palestinian Territory'),
('14','Colombia'),
('15','Oman'),
('16','Nauru'),
('17','Mauritania'),
('18','Christmas Island'),
('19','Suriname'),
('20','New Zealand'),
('21','Lao People\'s Democratic Republic'),
('22','Peru'),
('23','Holy See (Vatican City State)'),
('24','Finland'),
('25','Thailand'),
('26','Cuba'),
('27','Denmark'),
('28','Norfolk Island'),
('29','Mauritania'),
('30','Mauritania'),
('31','Barbados'),
('32','Tanzania'),
('33','Egypt'),
('34','Lao People\'s Democratic Republic'),
('35','United States Virgin Islands'),
('36','Ukraine'),
('37','Swaziland'),
('38','Germany'),
('39','Malaysia'),
('40','Djibouti'),
('41','Trinidad and Tobago'),
('42','Libyan Arab Jamahiriya'),
('43','Guinea-Bissau'),
('44','Singapore'),
('45','Kyrgyz Republic'),
('46','Bosnia and Herzegovina'),
('47','Serbia'),
('48','Jersey'),
('49','Spain'),
('50','Macao'),
('51','Ecuador'),
('52','Saint Kitts and Nevis'),
('53','Bhutan'),
('54','Papua New Guinea'),
('55','Kuwait'),
('56','Kenya'),
('57','Mali'),
('58','Cocos (Keeling) Islands'),
('59','Austria'),
('60','Spain'),
('61','Saint Barthelemy'),
('62','Saint Barthelemy'),
('63','Mali'),
('64','Costa Rica'),
('65','Thailand'),
('66','Bhutan'),
('67','Cambodia'),
('68','Northern Mariana Islands'),
('69','Mauritania'),
('70','Latvia'),
('71','Tajikistan'),
('72','Maldives'),
('73','Belize'),
('74','Uganda'),
('75','Macao'),
('76','Tanzania'),
('77','Suriname'),
('78','Macedonia'),
('79','Ecuador'),
('80','Algeria'),
('81','Ireland'),
('82','Iceland'),
('83','Slovenia'),
('84','Pitcairn Islands'),
('85','Mauritania'),
('86','Brazil'),
('87','Slovakia (Slovak Republic)'),
('88','Gabon'),
('89','Turks and Caicos Islands'),
('90','Antarctica (the territory South of 60 deg S)'),
('91','Papua New Guinea'),
('92','United Arab Emirates'),
('93','Djibouti'),
('94','Bolivia'),
('95','Ukraine'),
('96','Bangladesh'),
('97','Saudi Arabia'),
('98','Venezuela'),
('99','Cambodia'),
('100','Niger');

INSERT INTO `Locations` VALUES
('1','Stromanland','1'),
('2','East Shemar','2'),
('3','North Maggieton','3'),
('4','DuBuquefurt','4'),
('5','Kuphalfurt','5'),
('6','Lake Cade','6'),
('7','Jorgemouth','7'),
('8','Lake Nathan','8'),
('9','East Nyah','9'),
('10','North Raphaellestad','10'),
('11','Lake Hardyberg','11'),
('12','Lake Camron','12'),
('13','Wolfstad','13'),
('14','Gradyburgh','14'),
('15','Darlenehaven','15'),
('16','Faheyport','16'),
('17','Beckertown','17'),
('18','North Yolanda','18'),
('19','East Botown','19'),
('20','Blandaside','20'),
('21','Jaskolskifort','21'),
('22','Bruenburgh','22'),
('23','West Bertastad','23'),
('24','West Otha','24'),
('25','Chaunceyfurt','25'),
('26','West Vaughn','26'),
('27','Artbury','27'),
('28','Port Karelleberg','28'),
('29','Runolfsdottirfort','29'),
('30','Emilioland','30'),
('31','New Francohaven','31'),
('32','Lake Mohammedmouth','32'),
('33','East Donaldside','33'),
('34','Rubenview','34'),
('35','North Orvilletown','35'),
('36','New Cleveton','36'),
('37','East Edashire','37'),
('38','East Annette','38'),
('39','East Jaquanborough','39'),
('40','Sisterport','40'),
('41','Purdyland','41'),
('42','North Kiarraland','42'),
('43','Browntown','43'),
('44','Port Deliaborough','44'),
('45','Ortizshire','45'),
('46','Champlinhaven','46'),
('47','Conntown','47'),
('48','Kellenchester','48'),
('49','East Leannmouth','49'),
('50','Dickensfort','50'),
('51','Port Jermey','51'),
('52','New Prestonport','52'),
('53','Bridgetton','53'),
('54','Rosenbaumview','54'),
('55','West Romaineburgh','55'),
('56','Port Kelvin','56'),
('57','South Allan','57'),
('58','Port Janickton','58'),
('59','Willville','59'),
('60','Port Filomena','60'),
('61','Carleystad','61'),
('62','Lilianshire','62'),
('63','New Anthonyton','63'),
('64','West Ginatown','64'),
('65','North Garrett','65'),
('66','Port Ninafort','66'),
('67','Lake Ari','67'),
('68','North Marcella','68'),
('69','Robertsville','69'),
('70','North Wilfridstad','70'),
('71','East Broderickfort','71'),
('72','East Antonette','72'),
('73','Cruickshankchester','73'),
('74','Kihnview','74'),
('75','East Levi','75'),
('76','East Nadia','76'),
('77','Port Tressie','77'),
('78','West Hermannport','78'),
('79','Lake Domenicaville','79'),
('80','Lemuelfurt','80'),
('81','Port Dina','81'),
('82','Port Abel','82'),
('83','North Liliane','83'),
('84','Marcellafort','84'),
('85','Ritchiefort','85'),
('86','North Norberto','86'),
('87','Marlonmouth','87'),
('88','Port Leatha','88'),
('89','East Madilynside','89'),
('90','Wuckertport','90'),
('91','Zemlakberg','91'),
('92','West Morganbury','92'),
('93','East Marilyneport','93'),
('94','Schuylerburgh','94'),
('95','Jedfort','95'),
('96','New Murray','96'),
('97','Port Chanel','97'),
('98','Beerchester','98'),
('99','Lake Lizaborough','99'),
('100','Lake Coltentown','100'),
('101','Friedaville','1'),
('102','Lake Jarrodberg','2'),
('103','South Christy','3'),
('104','East Ellenchester','4'),
('105','Lake Makenna','5'),
('106','Wardhaven','6'),
('107','East Etha','7'),
('108','Pollichberg','8'),
('109','Ernieland','9'),
('110','Chesleyberg','10'),
('111','Lake Loyce','11'),
('112','South Christopher','12'),
('113','Geovanytown','13'),
('114','Port Jennings','14'),
('115','South Roxanneville','15'),
('116','East Ritatown','16'),
('117','South Alessandramouth','17'),
('118','Marjolaineside','18'),
('119','Rowanshire','19'),
('120','South Frederikport','20'),
('121','Margarettaview','21'),
('122','Zacherytown','22'),
('123','North Flossie','23'),
('124','West Nadia','24'),
('125','Roobmouth','25'),
('126','West Dayton','26'),
('127','Glovertown','27'),
('128','East Jadenview','28'),
('129','North Delphineberg','29'),
('130','East Kyraside','30'),
('131','Durganmouth','31'),
('132','East Alexys','32'),
('133','Freidaburgh','33'),
('134','Madgestad','34'),
('135','West Rene','35'),
('136','West Eddview','36'),
('137','Lurlinefurt','37'),
('138','North Adahburgh','38'),
('139','Lake Malcolm','39'),
('140','South Lydastad','40'),
('141','Lake Randy','41'),
('142','South Reese','42'),
('143','East Stewart','43'),
('144','Schaeferstad','44'),
('145','Georgettefort','45'),
('146','West Edyth','46'),
('147','North Tessfurt','47'),
('148','West Christiana','48'),
('149','Toniborough','49'),
('150','Domenicoport','50'),
('151','Port Kari','51'),
('152','Laurenhaven','52'),
('153','Braxtonborough','53'),
('154','West Luisside','54'),
('155','Jonesfort','55'),
('156','Thelmamouth','56'),
('157','Port Ludwig','57'),
('158','Schneiderhaven','58'),
('159','Weberhaven','59'),
('160','Krishaven','60'),
('161','West Amalia','61'),
('162','Valentinview','62'),
('163','New Kade','63'),
('164','South Nelliefort','64'),
('165','Lake Brookland','65'),
('166','Waelchiland','66'),
('167','Lilafort','67'),
('168','Howellbury','68'),
('169','South Nels','69'),
('170','East Hannahhaven','70'),
('171','Marksfurt','71'),
('172','North Twilaton','72'),
('173','Gradyhaven','73'),
('174','East Wayne','74'),
('175','Port Gilberto','75'),
('176','Lake Judson','76'),
('177','New Dennisburgh','77'),
('178','Toyview','78'),
('179','East Nakia','79'),
('180','Sabrinahaven','80'),
('181','Juliafort','81'),
('182','Eichmannburgh','82'),
('183','New Meaghan','83'),
('184','Salliestad','84'),
('185','New Lucie','85'),
('186','Romagueraside','86'),
('187','Keelingborough','87'),
('188','North Desmond','88'),
('189','Adrianafurt','89'),
('190','Port Dallinchester','90'),
('191','Joelstad','91'),
('192','South Gunnar','92'),
('193','Lunabury','93'),
('194','Theresatown','94'),
('195','Lake Ronaldo','95'),
('196','Eliantown','96'),
('197','New Amiya','97'),
('198','New Katelinside','98'),
('199','Port Priscillafort','99'),
('200','Dantefort','100');

INSERT INTO `Pilots` VALUES
('1','Shaylee','Bode','1991-01-03','1'),
('2','Cole','Spinka','1999-07-16','2'),
('3','Winnifred','Weissnat','1985-01-31','3'),
('4','Elfrieda','Denesik','1995-08-22','4'),
('5','Jana','Bartell','1990-02-01','5'),
('6','Kavon','Kulas','1999-10-14','6'),
('7','Rachel','Hodkiewicz','1988-12-15','7'),
('8','Chyna','Schaden','1982-07-16','8'),
('9','Unique','Botsford','1992-01-18','9'),
('10','Roger','Gleichner','1991-04-18','10'),
('11','Maybelle','Pfannerstill','1991-10-22','11'),
('12','Erica','Aufderhar','1999-10-02','12'),
('13','Christ','Greenholt','1980-11-25','13'),
('14','Clark','Bechtelar','1983-07-04','14'),
('15','Millie','Schiller','1996-06-10','15'),
('16','Caden','Cole','1996-02-26','16'),
('17','Florencio','Bernhard','1991-03-23','17'),
('18','Zachary','Hammes','1993-07-29','18'),
('19','Chasity','Brakus','1980-07-26','19'),
('20','Norbert','Morissette','1981-09-08','20'),
('21','Frank','Fritsch','1994-04-13','21'),
('22','Velma','McLaughlin','1983-12-25','22'),
('23','Deborah','Rodriguez','1981-12-20','23'),
('24','Caitlyn','Kshlerin','1988-07-02','24'),
('25','Lorine','Keeling','1981-11-21','25'),
('26','Alvis','Anderson','1984-02-08','26'),
('27','Gabe','Kunde','1998-07-04','27'),
('28','Price','Howell','1996-10-06','28'),
('29','Eulah','Rodriguez','1989-07-20','29'),
('30','Elvie','Schuppe','1989-01-09','30'),
('31','Kian','Sauer','1983-12-29','31'),
('32','Brendon','Ferry','1996-12-26','32'),
('33','Hector','Kunde','1990-02-05','33'),
('34','Chelsea','Heaney','1990-09-06','34'),
('35','Aurelia','Upton','1983-09-25','35'),
('36','Lukas','Pacocha','1988-04-16','36'),
('37','Emmy','Schmeler','1983-05-01','37'),
('38','David','Price','1995-06-02','38'),
('39','Donnell','Bednar','1984-02-21','39'),
('40','Gerardo','Hermiston','1981-10-02','40'),
('41','Carlos','Bogisich','1998-08-07','41'),
('42','Jude','Veum','1983-02-02','42'),
('43','Libbie','Tillman','1983-04-16','43'),
('44','Lilly','Keeling','1999-11-26','44'),
('45','Viola','Hilpert','1986-12-31','45'),
('46','Sim','Shanahan','1992-12-02','46'),
('47','Hildegard','Morissette','1988-02-22','47'),
('48','Edyth','Fritsch','1988-01-15','48'),
('49','Devonte','Gislason','1999-12-15','49'),
('50','Montana','Mraz','1989-10-15','50'),
('51','Lelah','Trantow','1989-07-08','51'),
('52','Arvel','Anderson','1996-07-20','52'),
('53','Jalyn','Morar','1991-11-23','53'),
('54','Jalen','Gutkowski','1994-12-20','54'),
('55','Vanessa','Nikolaus','1996-06-30','55'),
('56','Sheila','Kozey','1986-12-28','56'),
('57','Gage','Hoppe','1999-10-13','57'),
('58','Dayne','Lehner','1994-07-30','58'),
('59','Effie','Feil','1990-06-22','59'),
('60','Connor','Wintheiser','1997-05-31','60'),
('61','Hollie','Monahan','1995-11-25','61'),
('62','Danyka','Brekke','1980-08-25','62'),
('63','Irwin','Weimann','1997-02-06','63'),
('64','Matt','Baumbach','1998-07-19','64'),
('65','Meghan','Purdy','2000-02-03','65'),
('66','Friedrich','Botsford','1991-08-18','66'),
('67','Kayden','Schumm','1980-08-09','67'),
('68','Elenor','Carter','1995-01-18','68'),
('69','Bud','Jakubowski','1994-08-12','69'),
('70','Christiana','Ruecker','1989-04-21','70'),
('71','Alena','Corkery','1992-08-25','71'),
('72','Lia','Leuschke','1980-06-15','72'),
('73','Orie','Green','1996-07-21','73'),
('74','Lucinda','Satterfield','1995-06-09','74'),
('75','Laverna','Douglas','1994-04-18','75'),
('76','Andreane','Roberts','1988-11-13','76'),
('77','Carolina','Mohr','1997-10-04','77'),
('78','Rhea','Schaden','1994-05-17','78'),
('79','Marcus','Mraz','1983-08-05','79'),
('80','Ruben','Waters','1996-08-05','80'),
('81','Jennifer','Goodwin','1982-09-14','81'),
('82','Selina','Rohan','1982-12-31','82'),
('83','Yasmin','Tromp','1997-05-23','83'),
('84','Vincenza','Legros','1995-08-06','84'),
('85','Haley','Renner','1985-05-26','85'),
('86','Deondre','Schowalter','1988-12-14','86'),
('87','Gage','Schneider','1988-08-27','87'),
('88','Jaeden','Zboncak','1986-02-19','88'),
('89','Selmer','Friesen','1995-07-17','89'),
('90','Reese','Denesik','1982-05-05','90'),
('91','Heath','Bashirian','1996-04-21','91'),
('92','Shaylee','Dooley','1994-12-18','92'),
('93','Rose','Parisian','1992-04-04','93'),
('94','Pedro','Lakin','1983-12-11','94'),
('95','Logan','Larkin','1983-12-01','95'),
('96','Reta','Fisher','1998-03-20','96'),
('97','Enrico','Bahringer','1987-03-23','97'),
('98','Shirley','Schaefer','1984-12-04','98'),
('99','Columbus','Hammes','1985-10-04','99'),
('100','Timothy','Fahey','1986-01-03','100'),
('101','Orlo','Wolff','1983-07-30','101'),
('102','Roxane','Rosenbaum','1990-06-02','102'),
('103','Lonny','Hamill','1982-06-18','103'),
('104','Isaiah','Mraz','1983-11-02','104'),
('105','Tiffany','Kemmer','1983-10-02','105'),
('106','Josiane','Schowalter','1998-04-13','106'),
('107','Jack','Fisher','1992-03-15','107'),
('108','Faustino','Weber','1986-01-28','108'),
('109','Buford','Lockman','1995-08-20','109'),
('110','Julian','Grant','1992-12-08','110'),
('111','Delmer','Brekke','1997-06-18','111'),
('112','Christine','Thompson','1990-09-09','112'),
('113','Isai','Boyle','1994-11-21','113'),
('114','Liam','O\'Reilly','1986-07-13','114'),
('115','Audreanne','Stracke','1997-01-03','115'),
('116','Jaiden','Waters','1989-12-31','116'),
('117','Amos','Morissette','1991-06-27','117'),
('118','Genevieve','Waelchi','1991-07-24','118'),
('119','Ardella','Hauck','1995-03-05','119'),
('120','Amber','Borer','1995-07-29','120'),
('121','Geoffrey','Howe','1997-04-26','121'),
('122','Ryann','D\'Amore','1985-04-10','122'),
('123','Candice','Schmeler','1985-05-15','123'),
('124','Mohammed','Mayert','1990-03-26','124'),
('125','Hillard','Stamm','1994-11-08','125'),
('126','Elfrieda','Beahan','1988-10-10','126'),
('127','Hector','Ondricka','1985-11-23','127'),
('128','Corbin','Champlin','1989-04-25','128'),
('129','Gregory','Lemke','1981-11-02','129'),
('130','Lon','Kertzmann','1985-10-12','130'),
('131','Manuela','Kovacek','1990-11-29','131'),
('132','Veronica','Schulist','1992-07-25','132'),
('133','Robbie','Gleason','1990-07-15','133'),
('134','Donato','Braun','1992-06-03','134'),
('135','Helen','Rolfson','1985-04-26','135'),
('136','Violet','Lakin','1997-03-26','136'),
('137','Dallas','Bechtelar','1987-05-04','137'),
('138','Myrl','O\'Hara','1987-04-30','138'),
('139','Mozell','Grimes','1989-12-17','139'),
('140','Pattie','Schroeder','1993-08-23','140'),
('141','Barrett','McDermott','1985-10-18','141'),
('142','Jovani','O\'Kon','1995-02-05','142'),
('143','Hal','Hermiston','1997-01-01','143'),
('144','Jacques','Jaskolski','1984-02-27','144'),
('145','Bonnie','Hermann','1993-01-18','145'),
('146','Mauricio','Hills','1990-01-23','146'),
('147','Trystan','Hagenes','1993-12-17','147'),
('148','Marisa','Hammes','1988-10-10','148'),
('149','Jamir','Ward','1986-09-29','149'),
('150','Fabian','Vandervort','1994-03-29','150'),
('151','Cydney','Becker','1993-07-12','151'),
('152','Rhiannon','Kulas','1983-03-22','152'),
('153','Martine','Morar','1985-03-16','153'),
('154','Rex','Smith','1996-11-24','154'),
('155','Lenny','Monahan','1995-06-23','155'),
('156','Zane','Bayer','1991-08-09','156'),
('157','Tracey','Dietrich','1986-03-20','157'),
('158','Raphael','Weissnat','1984-11-11','158'),
('159','Emilia','Labadie','1993-01-18','159'),
('160','Marjolaine','Jacobi','1986-05-16','160'),
('161','Josiah','Swift','1992-01-13','161'),
('162','Tanner','Fay','1987-10-07','162'),
('163','Carrie','Witting','1991-08-26','163'),
('164','Angus','Romaguera','1998-05-21','164'),
('165','Evangeline','Tillman','1995-03-07','165'),
('166','Micheal','Sawayn','1998-10-26','166'),
('167','Molly','Grady','1982-12-28','167'),
('168','Josh','Stiedemann','1990-09-17','168'),
('169','Austyn','Graham','1987-03-28','169'),
('170','Lucienne','Witting','1981-06-26','170'),
('171','Maverick','Senger','1990-01-28','171'),
('172','Mackenzie','Hermann','1990-08-27','172'),
('173','Carson','Luettgen','1993-04-14','173'),
('174','Larissa','Schiller','1991-12-09','174'),
('175','Freda','Lehner','1980-08-20','175'),
('176','Jaylin','Grady','1994-04-16','176'),
('177','Kay','Hirthe','1983-08-06','177'),
('178','Daryl','Braun','1994-09-08','178'),
('179','Vickie','Lang','1983-05-03','179'),
('180','Demario','Vandervort','1988-05-01','180'),
('181','Horace','Rutherford','1982-05-06','181'),
('182','Vern','Nitzsche','1994-03-02','182'),
('183','Sarina','Bechtelar','1998-10-29','183'),
('184','Summer','Jenkins','1992-07-30','184'),
('185','Maud','Grady','1984-07-31','185'),
('186','Brant','Huels','1981-08-11','186'),
('187','Lane','Haag','1994-10-30','187'),
('188','Marcelo','Wilderman','1987-07-29','188'),
('189','Alvah','O\'Reilly','1999-11-29','189'),
('190','Winston','Jenkins','1994-03-05','190'),
('191','Adolph','Waters','1987-06-28','191'),
('192','Romaine','Cummings','1992-10-16','192'),
('193','Burnice','Botsford','1997-03-15','193'),
('194','Petra','Reinger','1987-12-11','194'),
('195','Lauriane','McLaughlin','1984-05-28','195'),
('196','Sadye','Langosh','1988-03-08','196'),
('197','Damon','Kuhlman','1984-07-22','197'),
('198','Dorian','Pfeffer','1985-06-15','198'),
('199','Lemuel','Feest','1990-09-04','199'),
('200','Braden','Reichert','1995-02-18','200'),
('201','Berneice','Reynolds','1989-12-25','1'),
('202','Tanner','Halvorson','1981-06-12','2'),
('203','Gisselle','Quitzon','1986-05-07','3'),
('204','Hillard','Schmidt','1982-10-20','4'),
('205','Jamie','Franecki','1981-12-16','5'),
('206','Elijah','Rosenbaum','1996-02-08','6'),
('207','Albin','Durgan','1995-03-11','7'),
('208','Heaven','Hickle','1995-11-19','8'),
('209','Mac','Schoen','1999-10-04','9'),
('210','Dejuan','Gutkowski','1994-08-12','10'),
('211','Alicia','Goldner','1984-02-03','11'),
('212','Mose','Schinner','1984-08-02','12'),
('213','Leonora','Bernhard','1988-05-05','13'),
('214','Wyatt','Stark','1990-09-18','14'),
('215','Jaylen','Gaylord','1986-01-18','15'),
('216','Mark','Jast','1982-10-02','16'),
('217','Sally','Adams','1994-12-15','17'),
('218','Corene','Jakubowski','1998-04-25','18'),
('219','Aurelia','Cormier','1984-11-03','19'),
('220','Muriel','Barrows','1990-11-26','20'),
('221','Carissa','Walter','1982-04-11','21'),
('222','Flavio','Kiehn','1982-01-16','22'),
('223','Roxanne','Rutherford','1992-03-06','23'),
('224','Jameson','Terry','1994-07-03','24'),
('225','Marianna','Carroll','1989-04-04','25'),
('226','Maryse','Greenfelder','1999-05-15','26'),
('227','Bradley','Frami','1995-11-24','27'),
('228','Shannon','Rice','1991-12-31','28'),
('229','Zachary','Smith','1985-12-11','29'),
('230','Ashleigh','Bode','1984-05-16','30'),
('231','Keith','Labadie','1994-01-11','31'),
('232','Antonio','Hauck','1991-12-03','32'),
('233','Howell','Dicki','1991-06-19','33'),
('234','Garland','Sipes','1986-09-18','34'),
('235','Fannie','Pouros','1984-11-25','35'),
('236','Lorena','Rau','1984-09-13','36'),
('237','Marjolaine','Murphy','1999-03-26','37'),
('238','Kenna','Hessel','1999-06-09','38'),
('239','Foster','Goodwin','1990-10-20','39'),
('240','Conner','Hackett','1983-04-15','40'),
('241','Nelson','Predovic','1986-03-11','41'),
('242','Velma','Nienow','1988-02-18','42'),
('243','Benny','Daugherty','1984-02-09','43'),
('244','Stevie','Heidenreich','1983-06-26','44'),
('245','Kelsi','Lynch','1987-04-02','45'),
('246','Leonora','Boyer','2000-03-06','46'),
('247','Tina','Kris','1991-05-02','47'),
('248','Jerad','Larkin','1991-04-03','48'),
('249','Dandre','Lemke','1990-09-03','49'),
('250','Frances','Prosacco','1982-06-30','50'),
('251','Simeon','Russel','1991-10-20','51'),
('252','Kari','Hickle','1985-02-23','52'),
('253','Bennett','Kuphal','1983-05-29','53'),
('254','Treva','Gutmann','1981-08-15','54'),
('255','Yasmin','Ratke','2000-02-26','55'),
('256','Lamar','Wisozk','1990-11-26','56'),
('257','Morris','Tromp','1989-12-10','57'),
('258','Tristin','Carter','1994-01-29','58'),
('259','Jamar','Ullrich','1988-07-30','59'),
('260','Britney','Streich','1996-07-13','60'),
('261','Rebecca','Schumm','1988-11-06','61'),
('262','Mya','Hegmann','1999-06-12','62'),
('263','Al','Stiedemann','1985-09-17','63'),
('264','Muriel','Hartmann','1997-05-21','64'),
('265','Verner','Halvorson','1993-03-03','65'),
('266','Doyle','Russel','2000-03-25','66'),
('267','Leonora','Jakubowski','1993-08-12','67'),
('268','Sincere','Torphy','1984-07-05','68'),
('269','Cayla','Orn','1997-12-15','69'),
('270','Lorenza','Hayes','1992-03-02','70'),
('271','Demarcus','Rempel','1993-07-18','71'),
('272','Edwin','Grant','1996-06-18','72'),
('273','Rowena','Dooley','1983-08-15','73'),
('274','Ezekiel','Nicolas','1980-12-25','74'),
('275','Amina','Koch','1989-01-07','75'),
('276','Elisa','Bosco','1991-10-08','76'),
('277','Josianne','Torphy','1990-09-25','77'),
('278','Krista','Bashirian','1983-07-03','78'),
('279','Jamaal','Labadie','1995-11-01','79'),
('280','Rodrigo','Douglas','1984-02-22','80'),
('281','Retha','Moen','1999-07-08','81'),
('282','Ayana','Goldner','1981-12-10','82'),
('283','Salma','Turner','1997-10-22','83'),
('284','Judge','Wiza','1983-12-20','84'),
('285','Vergie','Deckow','1994-03-28','85'),
('286','Helga','Lesch','1982-02-05','86'),
('287','Valentina','Grimes','1990-07-01','87'),
('288','Alexandrine','Kunze','1997-12-08','88'),
('289','Nicola','Orn','1985-01-08','89'),
('290','Fernando','Miller','1985-06-22','90'),
('291','Lucius','Cronin','1997-03-16','91'),
('292','Josiah','Kshlerin','1983-08-02','92'),
('293','Markus','Ondricka','1995-05-17','93'),
('294','Alberta','Crooks','1995-10-09','94'),
('295','Makayla','Kreiger','1993-02-11','95'),
('296','Savanna','Baumbach','1989-02-22','96'),
('297','Robin','Johns','1981-03-09','97'),
('298','Brayan','Turcotte','1982-01-02','98'),
('299','Ted','Streich','1993-10-18','99'),
('300','Tobin','Durgan','1986-06-20','100');

CREATE PROCEDURE generate_teams(IN count INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE max_country INT;
    DECLARE country INT;

    SET max_country = (SELECT count(distinct country_id) FROM Countries);

    WHILE i <= count
        DO
            SET country = FLOOR(1 + RAND() * (max_country - 0.5));

            INSERT INTO Teams
            VALUES (i,
                    CONCAT('team_', CAST(i AS CHAR(10))),
                    country,
                    CONCAT('http://team', CAST(i AS CHAR(10)), '.com'));

            SET i = i + 1;
        END WHILE;
END;

CREATE PROCEDURE generate_team_pilot(IN count INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE max_team INT;
    DECLARE max_pilot INT;
    DECLARE pilot INT;
    DECLARE team INT;
    DECLARE begin DATE;
    DECLARE end DATE;
    DECLARE all_time INT;

    DECLARE CONTINUE HANDLER FOR 1062
        SET i = i - 1;

    SET max_team = (SELECT count(distinct team_id) FROM Teams);
    SET max_pilot = (SELECT count(distinct pilot_id) FROM Pilots);
    SET all_time = UNIX_TIMESTAMP('2020-04-01 00:00:00') - UNIX_TIMESTAMP('2000-01-01 00:00:00');

    WHILE i <= count
        DO
            SET pilot = FLOOR(1 + RAND() * (max_pilot - 0.5));
            SET team = FLOOR(1 + RAND() * (max_team - 0.5));
            SET begin = DATE(
                    FROM_UNIXTIME(
                                UNIX_TIMESTAMP('2000-01-01 00:00:00') +
                                (i - 0.9) * all_time / count +
                                FLOOR(
                                        RAND() * 0.8 * all_time / count
                                    )
                        )
                );
            SET end = DATE(
                    FROM_UNIXTIME(
                                UNIX_TIMESTAMP(begin) +
                                FLOOR(
                                            RAND() *
                                            (
                                                    UNIX_TIMESTAMP('2020-04-01 00:00:00') -
                                                    UNIX_TIMESTAMP(begin)
                                                )
                                    )
                        )
                );

            INSERT INTO TeamPilot
            VALUES (pilot,
                    team,
                    begin,
                    end);

            SET i = i + 1;
        END WHILE;
END;

CREATE PROCEDURE generate_manufacturers(IN count INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE max_country INT;
    DECLARE country INT;

    SET max_country = (SELECT count(distinct country_id) FROM Countries);

    WHILE i <= count
        DO
            SET country = FLOOR(1 + RAND() * (max_country - 0.5));

            INSERT INTO Manufacturers
            VALUES (i,
                    CONCAT('manufacturer_', CAST(i AS CHAR(10))),
                    CONCAT('http://manufacturer', CAST(i AS CHAR(10)), '.com'),
                    country);

            SET i = i + 1;
        END WHILE;
END;

CREATE PROCEDURE generate_chassis(IN count INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE max_manufacturer INT;
    DECLARE manufacturer INT;
    DECLARE year INT;

    SET max_manufacturer = (SELECT count(distinct manufacturer_id) FROM Manufacturers);

    WHILE i <= count
        DO
            SET manufacturer = FLOOR(1 + RAND() * (max_manufacturer - 0.5));
            SET year = FLOOR(2000 + RAND() * (21 - 0.5));

            INSERT INTO Chassis
            VALUES (i,
                    manufacturer,
                    CONCAT('chassis_', CAST(i AS CHAR(10))),
                    year);

            SET i = i + 1;
        END WHILE;
END;

CREATE PROCEDURE generate_engines(IN count INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE max_manufacturer INT;
    DECLARE manufacturer INT;
    DECLARE year INT;
    DECLARE volume DECIMAL(2, 1);
    DECLARE power INT;
    DECLARE frequency INT;

    SET max_manufacturer = (SELECT count(distinct manufacturer_id) FROM Manufacturers);

    WHILE i <= count
        DO
            SET manufacturer = FLOOR(1 + RAND() * (max_manufacturer - 0.5));
            SET year = FLOOR(2000 + RAND() * (21 - 0.5));
            SET volume = 3 + RAND() * 2;
            SET power = FLOOR(300 + RAND() * 200);
            SET frequency = FLOOR(3000 + RAND() * 2000);

            INSERT INTO Engines
            VALUES (i,
                    manufacturer,
                    CONCAT('engine_', CAST(i AS CHAR(10))),
                    year,
                    volume,
                    power,
                    frequency);

            SET i = i + 1;
        END WHILE;
END;

CREATE PROCEDURE generate_cars(IN count INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE max_chassis INT;
    DECLARE max_engine INT;
    DECLARE chassis INT;
    DECLARE engine INT;
    SET max_chassis = (SELECT count(distinct chassis_id) FROM Formula_1.Chassis);
    SET max_engine = (SELECT count(distinct engine_id) FROM Engines);
    WHILE i <= count
        DO
            SET chassis = FLOOR(1 + RAND() * (max_chassis - 0.5));
            SET engine = FLOOR(1 + RAND() * (max_engine - 0.5));
            INSERT INTO Cars
            VALUES (
                    i,
                    CONCAT('car_', CAST(i AS CHAR(10))),
                    chassis,
                    engine
                    );
            SET i = i + 1;
        END WHILE;
END;

CREATE PROCEDURE generate_car_pilot(IN count INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE max_car INT;
    DECLARE max_pilot INT;
    DECLARE pilot INT;
    DECLARE car INT;
    DECLARE begin DATE;
    DECLARE end DATE;
    DECLARE all_time INT;

    DECLARE CONTINUE HANDLER FOR 1062
        SET i = i - 1;

    SET max_car = (SELECT count(distinct car_id) FROM Cars);
    SET max_pilot = (SELECT count(distinct pilot_id) FROM Pilots);
    SET all_time = UNIX_TIMESTAMP('2020-04-01 00:00:00') - UNIX_TIMESTAMP('2000-01-01 00:00:00');

    WHILE i <= count
        DO
            SET pilot = FLOOR(1 + RAND() * (max_pilot - 0.5));
            SET car = FLOOR(1 + RAND() * (max_car - 0.5));
            SET begin = DATE(
                    FROM_UNIXTIME(
                                UNIX_TIMESTAMP('2000-01-01 00:00:00') +
                                (i - 0.9) * all_time / count +
                                FLOOR(
                                        RAND() * 0.8 * all_time / count
                                    )
                        )
                );
            SET end = DATE(
                    FROM_UNIXTIME(
                                UNIX_TIMESTAMP(begin) +
                                FLOOR(
                                            RAND() * (
                                                UNIX_TIMESTAMP('2020-04-01 00:00:00') -
                                                UNIX_TIMESTAMP(begin)
                                            )
                                    )
                        )
                );

            INSERT INTO CarPilot (pilot_id, car_id, date_begin, date_end)
            VALUES (pilot,
                    car,
                    begin,
                    end);

            SET i = i + 1;
        END WHILE;
END;

CREATE PROCEDURE generate_circuits(IN count INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE max_location INT;
    DECLARE location INT;
    DECLARE length DECIMAL(4, 2);

    SET max_location = (SELECT count(distinct location_id) FROM Locations);

    WHILE i <= count
        DO
            SET location = FLOOR(1 + RAND() * (max_location - 0.5));
            SET length = 4 + RAND() * 2;

            INSERT INTO Circuits
            VALUES (i,
                    CONCAT('circuit_', CAST(i AS CHAR(10))),
                    location,
                    length);

            SET i = i + 1;
        END WHILE;
END;

CREATE PROCEDURE generate_championships(IN count INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE begin DATE;
    DECLARE end DATE;
    DECLARE all_time INT;
    SET all_time = UNIX_TIMESTAMP('2020-04-01 00:00:00') - UNIX_TIMESTAMP('2000-01-01 00:00:00');
    WHILE i <= count
        DO
            SET begin = DATE(
                    FROM_UNIXTIME(
                                UNIX_TIMESTAMP('2000-01-01 00:00:00') +
                                (i - 0.9) * all_time / count +
                                FLOOR(
                                        RAND() * 0.8 * all_time / count
                                    )
                        )
                );
            SET end = DATE(
                    FROM_UNIXTIME(
                                UNIX_TIMESTAMP(begin) +
                                FLOOR(RAND() *
                                      FLOOR(
                                              all_time / count
                                          )
                                    )
                        )
                );
            INSERT INTO Championships
            VALUES (i,
                    CONCAT('championship_', CAST(i AS CHAR(10))),
                    begin,
                    end);
            SET i = i + 1;
        END WHILE;
END;

CREATE PROCEDURE generate_grand_prix(IN count INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE max_championship INT;
    DECLARE max_circuit INT;
    DECLARE championship INT;
    DECLARE circuit INT;
    DECLARE championship_begin INT;
    DECLARE championship_end INT;
    DECLARE begin DATE;
    DECLARE all_time INT;

    DECLARE CONTINUE HANDLER FOR 1062
        SET i = i - 1;

    SET max_championship = (SELECT count(distinct championship_id) FROM Championships);
    SET max_circuit = (SELECT count(distinct circuit_id) FROM Circuits);

    WHILE i <= count
        DO
            SET circuit = FLOOR(1 + RAND() * (max_circuit - 0.5));
            SET championship = FLOOR(1 + RAND() * (max_championship - 0.5));
            SET championship_begin = (SELECT UNIX_TIMESTAMP(date_begin)
                                      FROM Championships
                                      WHERE championship_id = championship);
            SET championship_end = (SELECT UNIX_TIMESTAMP(date_begin)
                                    FROM Championships
                                    WHERE championship_id = championship);
            SET all_time = championship_begin - championship_end;
            SET begin = DATE(
                    FROM_UNIXTIME(
                                championship_begin +
                                FLOOR(
                                        RAND() * all_time
                                    )
                        )
                );

            INSERT INTO Grand_prix
            VALUES (i,
                    CONCAT('grandprix_', CAST(i AS CHAR(10))),
                    championship,
                    circuit,
                    begin);

            SET i = i + 1;
        END WHILE;
END;

CREATE PROCEDURE generate_grand_prix_res()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT;
    DECLARE num_grand_prix INT;
    DECLARE max_pilot INT;
    DECLARE pilot INT;
    DECLARE res INT;
    DECLARE CONTINUE HANDLER FOR 1062
        SET j = j - 1;

    SET num_grand_prix = (SELECT count(distinct grandprix_id) FROM Grand_prix);
    SET max_pilot = (SELECT count(distinct pilot_id) FROM Pilots);

    WHILE i <= num_grand_prix
        DO
            SET j = 1;
            WHILE j <= 10
                DO
                    SET pilot = FLOOR(1 + RAND() * (max_pilot - 0.5));
                    # These rules change from time to time,
                    # so we need to keep both the place and the result
                    SET res = CASE j
                                  WHEN 1 THEN 25
                                  WHEN 2 THEN 18
                                  WHEN 3 THEN 15
                                  WHEN 4 THEN 12
                                  WHEN 5 THEN 10
                                  WHEN 6 THEN 8
                                  WHEN 7 THEN 6
                                  WHEN 8 THEN 4
                                  WHEN 9 THEN 2
                                  WHEN 10 THEN 1
                        END;

                    INSERT INTO GrandPrixRes
                    VALUES (i,
                            pilot,
                            res,
                            j);
                    SET j = j + 1;
                END WHILE;
            SET i = i + 1;
        END WHILE;
END;

CREATE PROCEDURE generate_pilots_results()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT;
    DECLARE num_championships INT;
    DECLARE max_pilot INT;
    DECLARE pilot INT;
    DECLARE CONTINUE HANDLER FOR 1062
        SET j = j - 1;

    SET num_championships = (SELECT count(distinct championship_id) FROM Championships);
    SET max_pilot = (SELECT count(distinct pilot_id) FROM Pilots);

    WHILE i <= num_championships
        DO
            SET j = 1;
            WHILE j <= 10
                DO
                    SET pilot = FLOOR(1 + RAND() * (max_pilot - 0.5));

                    INSERT INTO ResultsPilots
                    VALUES (i,
                            pilot,
                            j);

                    SET j = j + 1;
                END WHILE;
            SET i = i + 1;
        END WHILE;
END;

CREATE PROCEDURE generate_teams_results()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT;
    DECLARE num_championships INT;
    DECLARE max_team INT;
    DECLARE team INT;
    DECLARE CONTINUE HANDLER FOR 1062
        SET j = j - 1;

    SET num_championships = (SELECT count(distinct championship_id) FROM Championships);
    SET max_team = (SELECT count(distinct team_id) FROM Teams);

    WHILE i <= num_championships
        DO
            SET j = 1;
            WHILE j <= 10
                DO
                    SET team = FLOOR(1 + RAND() * (max_team - 0.5));

                    INSERT INTO ResultsTeams
                    VALUES (i,
                            team,
                            j);

                    SET j = j + 1;
                END WHILE;
            SET i = i + 1;
        END WHILE;
END;


# Call the procedures in the right order

CALL generate_teams(150);
CALL generate_team_pilot(500);
CALL generate_manufacturers(100);
CALL generate_chassis(100);
CALL generate_engines(100);
CALL generate_cars(300);
CALL generate_car_pilot(500);
CALL generate_circuits(200);
CALL generate_championships(100);
CALL generate_grand_prix(500);
CALL generate_grand_prix_res();
CALL generate_pilots_results();
CALL generate_teams_results();