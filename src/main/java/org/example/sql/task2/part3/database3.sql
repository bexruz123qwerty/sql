create table categories(
    id serial primary key,
    name varchar(20) not null
);

create table products(
    id serial primary key,
    name varchar(45) not null,
    price numeric(10, 2) check (price > 0) not null
);