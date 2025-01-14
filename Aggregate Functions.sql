-- Aggregate Functions--

-- they are basically used for summarizinng data
-- max, min avg, count, sum

select max(amount) as highest_payment,
				min(amount) as loweest_payment,
                avg(amount) as average_payment,
                sum(amount) as total_payment from payments;
                
-- using count()
select count(*) as total_orders, 
				count(shippedDate) as shipped_orders, 
                count(*)- count(shippedDate) as pending_orders 
                from orders;
                
-- using functions on strings
select max(checkNumber) as highest_check_val, min(checknumber) as lowest_check_val from payments;

-- -----------
-- GROUP BY -
-- -----------

-- number of products in a particular product line
select productLine, count(*) from products group by productLine; 

-- count of empolyess, office code and location that work in the same office
select officeCode, city, postalCode, count(officeCode) as emp_count 
				from employees 
                join offices 
                using (officeCode) 
                group by officeCode;
                
-- diplay office details where count of employees is less than 3
select officeCode, city, postalCode, count(officeCode) as emp_count 
				from employees 
                join offices 
                using (officeCode) 
                group by officeCode
                having count(*)<3;
                
-- Example-1 Total Payments from each customer after a certain date
select customerNumber, count(*) as payment_count 
				from payments 
                where paymentDate > "2004-12-31"
                group by customerNumber;
                
-- Example-2 Value of each unique order sorted by total order values
select o.orderNumber, 
				sum(od.quantityOrdered*od.priceEach) as total_cost
                from orders o 
                join orderdetails od 
                using (orderNumber) 
                group by o.orderNumber
                order by total_cost desc;

-- select orderNumber, sum(quantityOrdered) as number_of_products, sum(priceEach) as total_ammount from orderdetails where orderNumber=10100;

-- Example-3 Country wise count of orders--
select country, o.orderDate, count(o.orderNumber) as order_count 
				from orders as o 
                left join customers as c 
                using (customerNumber) 
                group by c.country, o.orderDate
                order by c.country asc;

-- Example-4 Orders under each sales person-
select c.salesRepEmployeeNumber, e.firstName, count(orderNumber) as order_count
				from orders o left join 
				customers as c
				using(customerNumber)
				left join employees e
				on c.salesRepEmployeeNumber = e.employeeNumber
				group by salesRepEmployeeNumber
				order by order_count desc;

