create table customers(
    id serial primary key,
    name varchar(20) not null,
    email varchar(45) unique not null
);

create table orders(
    id serial primary key,
    amount numeric(10, 2) not null,
    date timestamp default current_timestamp,
    customer_id int not null references customers(id)
);