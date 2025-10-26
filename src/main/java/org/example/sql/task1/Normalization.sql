-- TASK 1
create table orders
(
    id          serial primary key,
    customer_id int references customers (id),
    product_id  int references products (id)
);

create table customers
(
    id    serial primary key,
    name  text not null,
    email text not null
);

create table products
(
    id    serial primary key,
    name  text           not null,
    price numeric(10, 2) not null
);


--TASK2

create table order_items
(
    order_id   int references orders (id),
    product_id int references products (id),
    quantity   int not null check (quantity > 0),
    primary key (order_id, product_id)
);

--TASK3

CREATE TABLE regions
(
    id   SERIAL primary key ,
    name TEXT not null unique
);

CREATE TABLE cities
(
    id        SERIAL primary key ,
    name      TEXT not null,
    region_id int references regions (id)
);

CREATE TABLE customers
(
    id      SERIAL primary key ,
    name    TEXT not null,
    email   TEXT unique ,
    city_id int references cities (id)
);
