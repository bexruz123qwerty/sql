create table users (
    id serial primary key,
    name varchar(100) not null,
    email varchar(100) unique not null,
    created_at timestamp default current_timestamp
);

create table posts (
    id serial primary key,
    user_id int  references users (id) on delete cascade,
    text text not null,
    created_at timestamp default current_timestamp
);

create table comments (
    id serial primary key,
    post_id int  references posts (id) on delete set null,
    user_id int  references users (id) on delete set null,
    text text not null,
    created_at timestamp default current_timestamp
);

create table likes (
    id serial primary key,
    user_id int references users (id) on delete cascade,
    post_id int references posts (id) on delete cascade
);
