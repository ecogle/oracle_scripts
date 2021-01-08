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