--Basic:
--Retrieve the total number of orders placed.
	SELECT
	COUNT(order_id) AS TotalOrders
	FROM dbo.orders
--Calculate the total revenue generated from pizza sales.
	SELECT 
	SUM(order_details.quantity*pizzas.price) AS TotalRevenue
	FROM dbo.order_details
	JOIN dbo.pizzas
	ON order_details.pizza_id=pizzas.pizza_id

--Identify the highest-priced pizza.
	SELECT
	TOP 1 pizza_types.name,
	ROUND(pizzas.price,2) AS highestpricedpizza
	FROM dbo.pizzas
	JOIN dbo.pizza_types
	ON pizzas.pizza_type_id=pizza_types.pizza_type_id
	ORDER BY pizzas.price DESC
	
--Identify the most common pizza size ordered.
  SELECT
  TOP 1 SUM(order_details.quantity) as CommonSize,
  pizzas.size
  FROM dbo.order_details
  JOIN dbo.pizzas
  ON order_details.pizza_id=pizzas.pizza_id
  GROUP BY pizzas.size
  ORDER BY SUM(order_details.quantity) DESC

--List the top 5 most ordered pizza types along with their quantities.
  SELECT TOP 5
  dbo.pizza_types.name AS PizzaType,
  SUM(dbo.order_details.quantity) AS TotalQuantity
  FROM dbo.order_details
  JOIN dbo.pizzas
  ON dbo.order_details.pizza_id = dbo.pizzas.pizza_id
  JOIN dbo.pizza_types
  ON dbo.pizzas.pizza_type_id = dbo.pizza_types.pizza_type_id
  GROUP BY dbo.pizza_types.name
  ORDER BY SUM(dbo.order_details.quantity) DESC;


--Intermediate:
--Join the necessary tables to find the total quantity of each pizza ordered.
	SELECT 
	SUM(quantity) AS Total_Quantity,
	pt.name
	FROM dbo.order_details as od
	JOIN dbo.pizzas as p
	ON od.pizza_id=p.pizza_id
	JOIN dbo.pizza_types as pt
	ON pt.pizza_type_id=p.pizza_type_id
	GROUP BY pt.name
--Determine the distribution of orders by hour of the day.
  SELECT
  DATEPART(HOUR,time) AS order_hour,
  COUNT(*) AS order_count
  FROM dbo.orders
  GROUP BY DATEPART(HOUR,time)
  ORDER BY order_hour

--Join relevant tables to find the category-wise distribution of pizzas.
  SELECT pt.category,COUNT(*) AS pizza_count
  FROM dbo.pizza_types AS pt
  JOIN dbo.pizzas AS p
  ON pt.pizza_type_id=p.pizza_type_id
  JOIN order_details AS od
  ON od.pizza_id=p.pizza_id
  GROUP BY pt.category

--Group the orders by date and calculate the average number of pizzas ordered per day.
	SELECT AVG(pizza_quantity) AS pizza_day
	FROM (
			SELECT o.date,SUM(od.quantity) AS pizza_quantity
			FROM dbo.orders as o
			JOIN dbo.order_details AS od
			ON o.order_id=od.order_id
			GROUP BY o.date) AS daily_orders
--Determine the top 3 most ordered pizza types based on revenue.
	SELECT TOP 3 p.pizza_type_id,pt.name,SUM(od.quantity*p.price) AS revenue
	FROM pizza_types AS pt
	JOIN dbo.pizzas AS p
	ON pt.pizza_type_id=p.pizza_type_id
	JOIN dbo.order_details AS od
	ON p.pizza_id=od.pizza_id
	GROUP BY p.pizza_type_id,pt.name
	ORDER BY revenue DESC



Advanced:
--Calculate the percentage contribution of each pizza type to total revenue.
	SELECT p.pizza_type_id,SUM(od.quantity*p.price) AS revenue,
	SUM(od.quantity * p.price) * 100.0/ SUM(SUM(od.quantity * p.price)) OVER () AS revenue_percentage
	FROM dbo.pizzas AS p
	JOIN dbo.order_details AS od
	ON p.pizza_id=od.pizza_id
	JOIN dbo.pizza_types AS pt
	ON p.pizza_type_id=pt.pizza_type_id
	GROUP BY p.pizza_type_id	
