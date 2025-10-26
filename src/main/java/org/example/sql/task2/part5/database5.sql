create table faculties (
    id serial primary key,
    name varchar(100) not null unique
);

create table groups (
    id serial primary key,
    name varchar(50) not null unique,
    faculty_id int references faculties (id) on delete set null
);

create table students (
    id serial primary key,
    name varchar(100) not null,
    group_id int references groups (id) on delete set null
);

create table teachers (
    id serial primary key,
    name varchar(100) not null
);

create table courses (
    id serial primary key,
    name varchar(100) not null,
    teacher_id int references teachers (id) on delete set null
);

create table student_courses (
    student_id int references students (id) on delete cascade,
    course_id  int references courses (id) on delete cascade,
    grade int check (grade between 1 and 5),
    primary key (student_id, course_id)
);
