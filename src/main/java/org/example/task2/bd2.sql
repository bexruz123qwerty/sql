CREATE TABLE students
(
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name  VARCHAR(50) NOT NULL,
    birth_date DATE        NOT NULL,
    email      VARCHAR(100) UNIQUE,
    group_id   INT         NOT NULL
);

insert into students(first_name, last_name, birth_date, email, group_id)
values ('Bexruz', 'Axmedov', '2005-08-28', 'bexruz@gmail.com', '1');
insert into  students(first_name, last_name, birth_date, email, group_id)values ('Bexruz', 'Axmedov', '2005-08-28', 'bexruz1@gmail.com', '2');

select *
from students;

SELECT first_name, count(*)
FROM students
GROUP BY first_name
HAVING COUNT(*) > 1;
