-- -------------------
-- correlated query --
-- -------------------

-- query-1 Find products whose price are higher than the average MSRP of all the products in that productLine 
select * from products p where MSRP >(
				select avg(MSRP) from products where productLine=p.productLine);
                
-- query-2 FInd products that have the highest price within their respective product lines 
select * from products p where MSRP =(
				select max(MSRP) from products where productLine=p.productLine);

-- query-3 Select customers who have made any payments
select * from customers where customerNumber in (
				select distinct(customerNumber) from payments);
                
-- converting it into correlated query using EXISTS keyword
select * from customers c where EXISTS (
				select customerNumber from payments where customerNumber= c.customerNumber);

-- Writing subQuery in SELECT statement; 
select *, (select avg(amount) from payments) as avg_amount, amount- (select avg_amount) as difference_from_avg from payments;

-- Writing subQuery in FROM clause; 
select * from (select *, 
				(select avg(amount) from payments) as avg_amount, 
                amount- (select avg_amount) as difference_from_avg 
                from payments) as invoice_summary 
		where difference_from_avg>0 ;

