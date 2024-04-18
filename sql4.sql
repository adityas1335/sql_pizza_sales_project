-- Calculate the percentage contribution of each pizza type to total revenue.

select
pt.name, round(sum(od.quantity*p.price)/(select sum(od.quantity*p.price) from pizzas as p
join order_details as od on p.pizza_id=od.pizza_id)*100,2) as RevenuePersentage
from pizza_types as pt
join pizzas as p on pt.pizza_type_id=p.pizza_type_id
join order_details as od on p.pizza_id=od.pizza_id
group by pt.name;

-- Calculate the percentage contribution of each category type to total revenue.

select
pt.category, round(sum(od.quantity*p.price)/(select sum(od.quantity*p.price) from pizzas as p
join order_details as od on p.pizza_id=od.pizza_id)*100,2) as RevenuePersentage
from pizza_types as pt
join pizzas as p on pt.pizza_type_id=p.pizza_type_id
join order_details as od on p.pizza_id=od.pizza_id
group by pt.category;

-- Analyze the cumulative revenue generated over time.

select order_date, sum(Revenue) over(order by order_date) as Cum_Revenue from (
select
o.order_date, round(sum(od.quantity*p.price),2) as Revenue
from orders as o
join order_details as od on o.order_id=od.order_id
join pizzas as p on od.pizza_id = p.pizza_id
group by o.order_date) as Total_Revenue;

--  Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select
category, name, Revenue from
(select
category, name, Revenue,
rank() over(partition by category order by revenue desc) as ranked 
from (
select
pt.category, pt.name, round(sum(od.quantity*p.price),2) as Revenue
from pizza_types as pt
join pizzas as p on pt.pizza_type_id=p.pizza_type_id
join order_details as od on p.pizza_id=od.pizza_id
group by pt.category, pt.name) as classified) as ranking
where ranked<=3;