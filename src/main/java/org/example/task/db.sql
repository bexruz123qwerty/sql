CREATE TABLE departments
(
    id       SERIAL PRIMARY KEY,
    name     VARCHAR(50) NOT NULL,
    location VARCHAR(50)
);

CREATE TABLE employees
(
    id            SERIAL PRIMARY KEY,
    name          VARCHAR(50) NOT NULL,
    position      VARCHAR(50),
    salary        NUMERIC(10, 2),
    department_id INTEGER     REFERENCES departments (id) ON DELETE SET NULL,
    manager_id    INTEGER     REFERENCES employees (id) ON DELETE SET NULL
);

CREATE TABLE customers
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50)
);

CREATE TABLE orders
(
    id          SERIAL PRIMARY KEY,
    order_date  DATE    NOT NULL,
    amount      NUMERIC(10, 2),
    employee_id INTEGER REFERENCES employees (id) ON DELETE SET NULL,
    customer_id INTEGER REFERENCES customers (id) ON DELETE SET NULL
);

CREATE TABLE products
(
    id    SERIAL PRIMARY KEY,
    name  VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2)
);

CREATE TABLE order_items
(
    id         SERIAL PRIMARY KEY,
    order_id   INTEGER REFERENCES orders (id) ON DELETE CASCADE,
    product_id INTEGER REFERENCES products (id) ON DELETE SET NULL,
    quantity   INTEGER NOT NULL
);

select employees.name, employees.salary
from employees
where (employees.salary > (select avg(salary) from employees));

select products.name
from products
where (products.price > (select avg(price) from products));

select distinct departments.name
from departments
join employees on departments.id = employees.department_id
where employees.salary > 10000;

select customers.id,
       customers.name,
       count(orders.id) order_count
from customers
left join orders on customers.id = orders.customer_id
group by customers.id, customers.name;

select
    departments.id,
    departments.name,
    avg(employees.salary) avg_salary
from departments
join employees on departments.id = employees.department_id
group by departments.id, departments.name
order by avg_salary desc
limit 3;

select
    customers.id,
    customers.name
from customers
left join orders on customers.id = orders.customer_id
where orders.id is null;

select
    departments.id,
    departments.name
from departments
join employees on departments.id = employees.department_id
group by departments.id, departments.name
having min(employees.salary) > 5000;
