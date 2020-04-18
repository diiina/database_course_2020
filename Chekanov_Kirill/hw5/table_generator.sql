CREATE TABLE `instructors` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL
);

CREATE TABLE `students` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `specialization_id` int,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255),
  `studak_number` int NOT NULL
);

CREATE TABLE `visit` (
  `user_id` int,
  `lesson_id` int,
  `visit_date` date NOT NULL
);

CREATE TABLE `lesson` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `instructor_id` int,
  `specialization_id` int,
  `week_day` ENUM ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday') NOT NULL,
  `lesson_time` ENUM ('9.00 - 10.25', '10.45 - 12.10', '13.55 - 15.20', '15.30 - 16.55', '17.05 - 18.30') NOT NULL
);

CREATE TABLE `student_schedule` (
  `student_id` int,
  `pair_id` int,
  `semester_id` int
);

CREATE TABLE `specialization` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL
);

CREATE TABLE `spec_to_insructors` (
  `instructor_id` int,
  `specialization_id` int
);

CREATE TABLE `semester` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `semester_start` date NOT NULL,
  `semester_end` date NOT NULL
);

ALTER TABLE `students` ADD FOREIGN KEY (`specialization_id`) REFERENCES `specialization` (`id`);

ALTER TABLE `visit` ADD FOREIGN KEY (`user_id`) REFERENCES `students` (`id`);

ALTER TABLE `visit` ADD FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`id`);

ALTER TABLE `student_schedule` ADD FOREIGN KEY (`student_id`) REFERENCES `students` (`id`);

ALTER TABLE `student_schedule` ADD FOREIGN KEY (`pair_id`) REFERENCES `lesson` (`id`);

ALTER TABLE `spec_to_insructors` ADD FOREIGN KEY (`instructor_id`) REFERENCES `instructors` (`id`);

ALTER TABLE `spec_to_insructors` ADD FOREIGN KEY (`specialization_id`) REFERENCES `specialization` (`id`);

ALTER TABLE `lesson` ADD FOREIGN KEY (`instructor_id`) REFERENCES `instructors` (`id`);

ALTER TABLE `student_schedule` ADD FOREIGN KEY (`semester_id`) REFERENCES `semester` (`id`);

ALTER TABLE `lesson` ADD FOREIGN KEY (`specialization_id`) REFERENCES `specialization` (`id`);

