drop table students;

CREATE TABLE students
(
    student_id INT PRIMARY KEY,
    full_name  VARCHAR(100),
    age        INT,
    group_id   INT
);

CREATE TABLE groups
(
    group_id   INT PRIMARY KEY,
    group_name VARCHAR(50)
);

CREATE TABLE subjects
(
    subject_id   INT PRIMARY KEY,
    subject_name VARCHAR(50)
);

CREATE TABLE grades
(
    grade_id   INT PRIMARY KEY,
    student_id INT,
    subject_id INT,
    grade      INT,
    FOREIGN KEY (student_id) REFERENCES students (student_id),
    FOREIGN KEY (subject_id) REFERENCES subjects (subject_id)
);


--1
insert into students(student_id, full_name, age, group_id) values (1, 'Bexruz Axmedov', 20, 1);
insert into students(student_id, full_name, age, group_id) values (4, 'Bexruz Axmedov', 50, 1);
insert into students(student_id, full_name, age, group_id) values (5, 'Bexruz Axmedov', 10, 1);
insert into groups(group_id, group_name) values (1, 'RANDOM GROUP NAME');
insert into subjects (subject_id, subject_name) values (1, 'Math');
insert into grades(grade_id, student_id, subject_id, grade) values (3, 1, 1, 100);
insert into grades(grade_id, student_id, subject_id, grade) values (4, 4, 1, 50);

select * from students;
select * from groups;
select * from subjects;
select * from grades;


--2
select count(student_id) from students;

--3
select avg(age) from students;

--4
select min(age) from students;
select max(age) from students;

--5
select count(grade) from grades;

--6
select group_id, count(student_id) from students
group by group_id;

--7
select group_id, avg(age) from students
group by group_id;

--8
select subject_id, avg(grade) from grades
group by subject_id;

--9 я без понятия как это делать
select count(student_id) from grades
group by subject_id
having grade is not null;

--10 без join я не знаю как это сделать
select group_name, COUNT(student_id)
from groups
join students s on s.student_id = s.group_id
group by group_name
having count(s.student_id) > 1;

--11
select student_id, avg(grade) from grades
group by student_id
having avg(grade) > 8;

--12
select s.student_id, avg(grade) from students s
join grades g on s.student_id = g.student_id
group by s.student_id
having avg(grade) > 8.5