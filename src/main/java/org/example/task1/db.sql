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

SELECT
    e.id AS employee_id,
    e.name AS employee_name,
    COALESCE(d.name, 'No Department') AS department_name
FROM employees e
         LEFT JOIN departments d
                   ON e.department_id = d.id;

SELECT
    e.name AS employee_name,
    m.name AS manager_name
FROM employees e
         JOIN employees m
              ON e.manager_id = m.id;

SELECT d.id AS department_id,
       d.name AS department_name
FROM departments d
         LEFT JOIN employees e
                   ON d.id = e.department_id
WHERE e.id IS NULL;

SELECT
    o.id AS order_id,
    p.name AS product_name,
    oi.quantity
FROM orders o
         LEFT JOIN order_items oi
                   ON o.id = oi.order_id
         LEFT JOIN products p
                   ON oi.product_id = p.id;

SELECT
    d.id AS department_id,
    d.name AS department_name,
    o.id AS order_id,
    o.order_date,
    o.amount
FROM departments d
         LEFT JOIN employees e
                   ON d.id = e.department_id
         LEFT JOIN orders o
                   ON e.id = o.employee_id
ORDER BY d.id, o.id;

SELECT
    c.id AS customer_id,
    c.name AS customer_name,
    p.id AS product_id,
    p.name AS product_name
FROM customers c
         CROSS JOIN products p
         LEFT JOIN orders o
                   ON o.customer_id = c.id
         LEFT JOIN order_items oi
                   ON oi.order_id = o.id
                       AND oi.product_id = p.id
WHERE oi.id IS NULL;

SELECT
    p.id,
    p.name,
    p.price
FROM products p
         LEFT JOIN order_items oi
                   ON p.id = oi.product_id
WHERE oi.id IS NULL;

SELECT
    COUNT(*) AS total_orders,
    SUM(amount) AS total_revenue
FROM orders;

SELECT
    d.id AS department_id,
    d.name AS department_name,
    AVG(e.salary) AS avg_salary,
    MAX(e.salary) AS max_salary
FROM departments d
         LEFT JOIN employees e
                   ON d.id = e.department_id
GROUP BY d.id, d.name
ORDER BY d.id;

SELECT
    o.id AS order_id,
    SUM(oi.quantity) AS total_products,
    COUNT(DISTINCT oi.product_id) AS unique_items
FROM orders o
         LEFT JOIN order_items oi
                   ON o.id = oi.order_id
GROUP BY o.id
ORDER BY o.id;

SELECT
    p.id AS product_id,
    p.name AS product_name,
    SUM(p.price * oi.quantity) AS total_revenue
FROM products p
         JOIN order_items oi
              ON p.id = oi.product_id
GROUP BY p.id, p.name
ORDER BY total_revenue DESC
LIMIT 3;

SELECT
    COUNT(DISTINCT customer_id) AS customers_with_orders
FROM orders
WHERE customer_id IS NOT NULL;

ALTER TABLE employees
    ADD COLUMN first_name VARCHAR(50),
    ADD COLUMN last_name VARCHAR(50);

SELECT
    first_name || ' ' || last_name AS full_name
FROM employees;

SELECT
    TO_CHAR(order_date::timestamp, 'DD.MM.YYYY HH24:MI') AS formatted_order_date
FROM orders;

SELECT *
FROM orders
WHERE order_date < CURRENT_DATE - INTERVAL '30 days';
