create database pizzasales;

use pizzasales;

-- Table "pizzas" and "pizza_types" are directly imported by "Table Data import Wizard"

create table orders(
order_id int not null,
order_date date not null,
order_time time not null,
primary key(order_id) );

select * from orders;

create table order_details(
order_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity int not null,
primary key(order_details_id) );

select count(*) from pizza_types;

select * from orders;

select * from order_details;

select * from pizzas;