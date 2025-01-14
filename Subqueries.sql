-- ------------
-- SubQueries -
-- ------------

-- query-1 Find all cars with productName as "1917 Grand Touring Sedan"
select productName from products 
where productLine in (
			select productLine from products 
            where productName= "1917 Grand Touring Sedan");
            
-- query-2 Find cars that are costlier than "1936 Mercedes Benz 500k Roadster"
select * from products 
where productLine like "%cars" and MSRP >(
				select MSRP 
				from products 
				where productName="1936 Mercedes Benz 500k Roadster");
                
-- query-3 Find cars costlier than average cost of all cars
select * from products 
where productLine like "%cars" and MSRP >(
				select avg(MSRP)
				from products 
				where productLine like "%cars");
                
                                     
-- query-4 Find Customers who never placed an order (SUBQUERY)
select customerName from customers 
where customerNumber not in(select distinct(customerNumber) from orders);

-- query-4 Find Customers who never placed an order (JOINS)
select c.customerName from customers as c 
                    left join orders as o 
                    on c.customerNumber=o.customerNumber where orderNumber is null;
                    
-- customer who have ordered the product with product code "S18_1749"
select * from customers where customerNumber in (
				select customerNumber from orders where orderNumber in(
                select orderNumber from orderdetails where productCode="S18_1749"));
                
-- above question with join
select c.customerName, c.customerNumber from 
customers c join orders o
on c.customerNumber=o.customerNumber
join orderdetails od
on o.orderNumber=od.orderNumber
where od.productCode="S18_1749";

-- same above question with subquery and join both
select * from customers where customerNumber in (
								select orders.customerNumber from orders 
                                join orderdetails 
                                on orders.orderNumber= orderdetails.orderNumber 
                                where orderdetails.productCode="S18_1749");

