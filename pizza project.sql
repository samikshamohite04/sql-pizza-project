create database pizzahouse;
select * from pizzahouse.pizzas;
select * from pizzahouse.pizza_types;
select * from pizzahouse.orders;
select * from pizzahouse.order_details;

--Retrieve the total number of orders placed.
select count(*) as total_number_of_orders from pizzahouse.orders

--Calculate the total revenue generated from pizza sales.
 select 
 round(sum((order_details.quantity * pizzas.price),
 2) as total_revenue 
 from pizzahouse.order_details
 join 
pizzahouse.pizzas on pizzas.pizza_id = order_details.pizza_id 
 
 --Identify the highest-priced pizza.
 
 select pizza_types.name, pizzas.price
 from pizzahouse.pizza_types 
 join pizzahouse.pizzas
 on pizza_types.pizza_type_id = pizzas.pizza_type_id
 order by pizzas.price desc limit 1;
 
 ----Identify the most common pizza size ordered.
 select pizzas.size,count(order_details.order_details_id)
 from pizzahouse.pizzas
 join pizzahouse.order_details
 on pizzas.pizza_id = order_details.pizza_id
 group by pizzas.size  order by count desc;
 
 ----List the top 5 most ordered pizza types along with their quantities.
 select pizza_types.name,sum(order_details.quantity) as qunatity
 from
 pizzahouse.pizza_types 
 join pizzahouse.pizzas
 on pizza_types.pizza_type_id = pizzas.pizza_type_id
 join pizzahouse.order_details
 on order_details.pizza_id = pizzas.pizza_id
 group by pizzahouse.pizza_types.name
 order by pizzahouse.quantity decs limit 5;
 
 --Join the necessary tables to find the total quantity of each pizza category ordered.
 select pizza_types.category 
 sum(order_details.quantity) as quantity
 from pizza_types join pizzas
 on pizza_types.pizza_type_id = pizzas.pizza_type_id
 join pizzahouse.order_details
 on pizzahouse.order_details.pizza_id = pizzahouse.pizzas.pizza_id
 group by pizzahouse.pizza_types.category order by quantity desc
 
  
  --Determine the distribution of orders by hour of the day.
  select HOUR(order_time) as hour,count(order_id) as order_count
  from pizzahouse.orders
  group by HOUR (order_time);
  
  --Join relevant tables to find the category-wise distribution of pizzas.
  select category,count(name) from pizzahouse.pizza_types
  group by category
  
  --Group the orders by date and calculate the average number of pizzas ordered per day.
  select avg(quantity) from 
  (select order.date ,sum(order_details.quantity)
  from pizzahouse.orders join pizzahouse.order_details
  on orders.order_id = order_details.order_id
  group by orders.date) as order_quantity
  
  --Determine the top 3 most ordered pizza types based on revenue.
  select pizza_type.name;
  sum(order_details.quantity *pizzas.price) as revenue
  from pizza_type join pizzas
  on pizzas.pizza_type_id = pizza_type.pizza_type_id
  join order_details
  on order_details.pizza_id = pizzas.pizza_id
  group by pizza_type.name order by revenue desc limit 3;