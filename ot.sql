CREATE VIEW order_stats AS
SELECT category_name, status, order_id
FROM order_items
inner join orders USING (order_id)
INNER JOIN products USING (product_id)
INNER JOIN product_categories USING (category_id);



select * from order_stats;
select * from order_stats
PIVOT(
    count(order_id) order_count
    for category_name
    in(
        'CPU' CPU,
        'Video Card' VideoCard,
        'Mother Board' MotherBoard,
        'Storage' Storage
        )
)
order by status;

select distinct product_id
from order_items
order by product_id;

select o.*, EXTRACT(YEAR FROM o.order_date) datesd from orders o where salesman_id is null;

SELECT o.customer_id, sum(quantity*unit_price) amount
FROM orders o, order_items oi
where o.order_id = oi.order_id
group by 
    o.customer_id
order by o.customer_id;



select customer_id,
sum(quantity * unit_price) amount
FROM orders
inner join order_items using (order_id)
where
    status = 'Shipped'
    and salesman_id IS NOT null and
    extract (year FROM order_date) = 2017
group by
    rollup(customer_id);
    
    
    
select
    product_id,
    product_name,
    list_price,
    standard_cost
from
    products
where list_price BETWEEN (select avg(list_price)-100 FROM products) AND (select avg(list_price)+100 FROM products);


CREATE TABLE parts(
    part_id INT GENERATED ALWAYS AS IDENTITY,
    part_name VARCHAR2(50) NOT NULL,
    capacity INT NOT NULL,
    cost DEC(15,2) NOT NULL,
    list_price DEC(15,2) NOT NULL,
    gross_margin AS ((list_price - cost) / cost),
    PRIMARY KEY(part_id)
);

INSERT INTO parts(part_name, capacity, cost, list_price)
VALUES('G.SKILL TridentZ RGB Series 16GB (2 x 8GB)', 16, 95,105);

INSERT INTO parts(part_name, capacity, cost, list_price)
VALUES('G.SKILL TridentZ RGB Series 32GB (4x8GB)', 32, 205,220);

INSERT INTO parts(part_name, capacity, cost, list_price)
VALUES('G.SKILL TridentZ RGB Series 16GB (1 x 8GB)', 8, 50,70);

select * from parts;