create database internship;
CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    product_id INT,
    order_date VARCHAR(20)
);
INSERT INTO orders (order_id, customer_id, product_id, order_date) VALUES
(101, 1, 1, '01-03-2024'),
(102, 1, 2, '02-03-2024'),
(103, 2, 4, '03-03-2024'),
(104, 3, 3, '04-03-2024'),
(105, 2, 5, '05-03-2024');
use internship;
show tables;
select * from orders;



drop database moviesdb;
drop database internship;
drop table products2;

CREATE TABLE products2 (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price INT
);
INSERT INTO products2 (product_id, product_name, category, price) VALUES
(1, 'Laptop', 'Electronics', 900),
(2, 'Headphones', 'Electronics', 150),
(3, 'Coffee Mug', 'Home', 20),
(4, 'Tablet', 'Electronics', 350),
(5, 'Vacuum Cleaner', 'Home', 120);


show tables;

select * from products2;



CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

INSERT INTO customers (customer_id, name, email) VALUES
(1, 'Alice Smith', 'alice@example.com'),
(2, 'Bob Johnson', 'bob@example.com'),
(3, 'Charlie Lee', 'charlie@example.com');


select * from customers;
show tables;






alter table products2 
rename to products;

-- 1) Find all customers who have made more than two orders in total.
select * from customers;
select * from orders;

select c.name , count(o.customer_id) as cp
from customers c
join orders o
on c.customer_id = o.customer_id
group by c.customer_id
having cp>1;

-- 1) b) List customer names, total amount spent, and total number of orders for each customer who has made purchases. Sort the results by total amount spent in descending order.

select c.name ,sum(p.price) as total_amount, count(o.customer_id) as total_orders
from customers c
join orders o
on c.customer_id = o.customer_id
join products p
on p.product_id = o.product_id
group by o.customer_id 
order by total_orders desc;
-- sum gives total_amount spend 
-- count counts the no.of orders placed
-- orderby sorts the names in the descending order





select * from products;
select * from orders;
-- 2) a) Find all products that have been ordered more than twice. List the product names, total orders, and total revenue generated for each of these products.
select p.product_name , count(o.order_id) as total_order , sum(p.price) as total_revenue
from products p 
join orders o 
on p.product_id = o.product_id
group by p.product_id
having  total_order > 2;
-- count counts the no.of orders 
-- sum gives the total_revenue
-- having total_order >2 gives the products that have been ordered twice


--  2) b) Show the average price of products for each product category.
select * from products;

select category , avg(price) as avg_price
from products
group by category;

-- avg calculates the average price based on category



-- 3)  Identify the top 3 selling products by total revenue. Return the product names and the total revenue for each of these products.
select product_name , sum(price) as total_revenue 
from products
group by product_name 
order by total_revenue desc
limit 3;
-- sum is used to find the total_revenue by each product
-- order by desc sorts the data in the descending order
-- limit 3 gives on the top 3 products

--  4) Find out which month has the highest total sales revenue. Include the month and total revenue in your result.
select * from orders;
select extract( month from o.order_date) as month, sum(p.price) as total_revenue 
from orders o
join products p
on o.product_id = p.product_id
group by month
order by total_revenue desc
limit 1;
-- " extract( month from o.order_date) as month, sum(p.price) as total_revenue " , extract is used to get the month from orderdate and sum is used to calculate the total_revenue


-- 5)  Create a customer segmentation based on their total spend:
select * from customers;
select * from products;

select c.name , 
case when sum(p.price)>1000 then "high value"
when sum(p.price) between 500 and 1000 then "medium value"
else "low value"
end as customer_segmentation
from customers c
join orders o
on c.customer_id = o.customer_id 
join products p
on p.product_id = o.product_id
group by c.customer_id
;
-- case when is used to segment the data just like if else in python.



SET SQL_SAFE_UPDATES = 0;

UPDATE orders
SET order_date = STR_TO_DATE(order_date, '%d-%m-%Y');

SET SQL_SAFE_UPDATES = 1;





-- 6) Find the average order value for all orders made in March 2024.
select avg(products.price) as avg_order_value
from orders
join products on orders.product_id = products.product_id
where extract(month from order_date) = 3 and EXTRACT(year from  order_date) = 2024;
-- avg(products.price) calculates average of the product price
-- "where extract(month from order_date) = 3 and EXTRACT(year from  order_date) = 2024 " extracts month = march and year = 2024





-- 7) For each customer, list the products they ordered along with the date of order.
select * from customers;
select * from products;
select * from orders;

select c.name, p.product_name , o.order_date 
from customers c
join orders o on c.customer_id = o.customer_id
join products p on p.product_id = o.product_id 

;
-- join the customers, orders, and products tables to get the product and order details for each customer.

-- order by customers.name, orders.order_date sorts the results first by customer and then by order date.