-- 1) Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pt.category, SUM(od.quantity) AS Total_quantity
FROM
    pizza_types AS pt
        JOIN
    pizzas ON pt.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details AS od ON pizzas.pizza_id = od.pizza_id
GROUP BY pt.category
ORDER BY Total_quantity DESC;

-- 2) Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(order_time) AS PerHour, COUNT(order_id) AS order_count
FROM
    orders
GROUP BY PerHour;

-- 3) Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    category, COUNT(name) AS Total
FROM
    pizza_types
GROUP BY category;

-- 4) Group the orders by date and calculate the average number of pizzas ordered per day.
select round(avg(total_quantity),0) as NoPizzaOrderPerDay from
(select orders.order_date, sum(order_details.quantity) as total_quantity
from orders join order_details
on orders.order_id = order_details.order_id 
group by orders.order_date) as order_quantity;

-- 5) Determine the top 3 most ordered pizza types based on revenue.
select
