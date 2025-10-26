create table customers (
    id serial primary key,
    name  varchar(20) not null,
    email varchar(45) unique not null
);

create table products (
    id serial primary key,
    name varchar(45) not null,
    price numeric(10, 2) check (price > 0) not null
);

create table orders (
    id serial primary key,
    amount numeric(10, 2) not null,
    date timestamp default current_timestamp,
    customer_id int not null references customers (id)
);

create table order_items (
    order_id   int not null references orders (id) on delete cascade,
    product_id int not null references products (id),
    primary key (order_id, product_id)
);