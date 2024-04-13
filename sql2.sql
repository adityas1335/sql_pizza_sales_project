-- 1) Retrieve the total number of orders placed.
select count(order_id) as Total_Orders from orders;

-- 2)  Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS Total_Sales
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;
    
-- 3) Identify the highest-priced pizza.
SELECT 
    pt.name, p.price
FROM
    pizzas AS p
        JOIN
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
WHERE
    p.price = (SELECT 
            MAX(price)
        FROM
            pizzas);
            
--             OR
            
SELECT 
    pt.name, p.price
FROM
    pizzas AS p
        JOIN
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;

-- 4) Identify the most common pizza size ordered.
SELECT 
    p.size, SUM(od.quantity) AS total_quantity
FROM
    order_details AS od
        JOIN
    pizzas AS p ON p.pizza_id = od.pizza_id
GROUP BY p.size
ORDER BY total_quantity DESC
LIMIT 1;
    
-- 5)  List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pt.name, SUM(od.quantity) AS Total_quantity
FROM
    pizza_types AS pt
        JOIN
    pizzas ON pt.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details AS od ON pizzas.pizza_id = od.pizza_id
GROUP BY pt.name
ORDER BY Total_quantity DESC
LIMIT 5;