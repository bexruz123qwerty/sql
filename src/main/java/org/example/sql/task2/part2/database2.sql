create table departments(
    id serial primary key,
    dep_name varchar(50) unique not null
);


create table employees(
    id serial primary key,
    emp_name varchar(20) not null,
    emp_position varchar(45) not null,
    department_id int references departments(id) on delete set null
);
