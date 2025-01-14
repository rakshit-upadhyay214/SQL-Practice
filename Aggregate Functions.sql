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
                
