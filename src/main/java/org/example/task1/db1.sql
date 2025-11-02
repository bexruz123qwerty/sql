CREATE TABLE sales
(
    id        SERIAL PRIMARY KEY,
    region    VARCHAR(20),
    amount    BIGINT,
    sale_date DATE
);

INSERT INTO sales (region, amount, sale_date)
VALUES ('North', 1000, '2024-01-01'),
       ('South', 700, '2024-01-02'),
       ('North', 500, '2024-01-03'),
       ('West', NULL, '2024-01-04'),
       ('South', 900, '2024-01-05'),
       ('North', 1500, '2024-01-06');

select region, sum(amount)
from sales
group by(region);

select region, avg(amount)
from sales
group by (region)
having count(*) > 1;


-- почему null больше чем 3000?
--почему null не на последнем месте по количеству?
select region, sum(amount) as total_sales
from sales
group by region
order by total_sales desc
limit 2;

select count(*)
from sales
where amount is null;

select region, avg(amount)
from sales
where amount > 0
group by region
having sum(amount) > (select avg(amount) from sales);