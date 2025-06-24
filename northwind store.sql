use northwind;

select customerid,ContactName
from customers;

select productname,unitprice
from products;

select * from employees
where HireDate >1994;

select * from orders
where year(orderdate) <1997;

select * from customers
where city = 'london';

select productname, unitsinstock
from products
where unitsinstock < 10;

select distinct country
from customers;

select * from suppliers
where country = 'usa';

select * from products
order by ProductName
limit 10;

select * from products
where UnitPrice between 20 and 50;

select concat(firstname, ' ',lastname) as fullname
from employees;

select c.categoryid , c.categoryname
from categories c
join products p on p.CategoryID = c.CategoryID;

select shippeddate,freight
from orders;

select city, count(customerid)
from customers
group by city;

select * from products
where Discontinued = 1;

select customerid,count(*) as totalorders
from orders
group by CustomerID;

select p.productname,s.companyname
from products p
join suppliers s on p.SupplierID = s.SupplierID
order by ProductName;

select c.categoryname,count(p.productname) as numofproduct
from categories c
join products p on c.CategoryID = p.CategoryID
group by c.CategoryName;

select * 
from customers
where CustomerID not in (select CustomerID from orders);

select e.employeeid,e.firstname,e.lastname,count(orderid)
from employees e
right join orders o on e .EmployeeID = o.EmployeeID
group by e.EmployeeID,e.FirstName,e.lastname;

select productid,productname,unitprice
from products
order by unitprice desc
limit 5;

select o.orderid,p.productname,od.quantity
from orders o
join `order details` od on o.orderid = od.orderid
join products p on od.productid = p.productID
order by o.orderid;

select customerid,sum(freight) as totalfreight
from orders
group by CustomerID;

SELECT p.productname, SUM(oi.quantity) AS total_quantityordered
FROM products p
JOIN `order details` oi ON p.productid = oi.productid
GROUP BY p.productname;

select orderid
from `order details`
group by OrderID
having count(*) > 3;

select e.firstname,e.lastname
from employees e
join orders o on e.EmployeeID = o.EmployeeID
where o.OrderID is null;

select *
from products p
where ProductID in(select ProductID from `order details`);

SELECT c.customerid,c.ContactName,count(orders.orderid) AS order_count
FROM customers c
JOIN orders ON c.customerid = orders.customerid
GROUP BY c.customerid,c.ContactName
HAVING COUNT(orders.orderid) > 5;

SELECT productid,productname,reorderlevel,unitsinstock
FROM products
WHERE reorderlevel > unitsinstock;

SELECT c.customerid,c.companyname,SUM(od.unitprice * od.quantity * (1 - od.discount)) AS total_amount
FROM customers c
JOIN orders o ON c.customerid = o.customerid
JOIN `order details` od ON o.orderid = od.orderid
GROUP BY c.customerid, c.companyname;

SELECT c.categoryid,c.categoryname,AVG(p.unitprice) AS averageprice
FROM categories c
JOIN products p ON c.categoryid = p.categoryid
GROUP BY c.categoryid, c.categoryname;

SELECT p.productid,p.productname,SUM(od.quantity) AS totalquantity
FROM products p
JOIN `order details` od ON p.productid = od.productid
GROUP BY p.productid, p.productname
LIMIT 3;

SELECT DISTINCT c.customerid, c.companyname
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    JOIN `order details` od ON o.orderid = od.orderid
    JOIN products p ON od.productid = p.productid
    WHERE c.customerid = o.customerid AND p.productname = 'Chai');
    
    select e.employeeid,e.firstname,e.lastname,COUNT(o.orderid) AS ordercount
FROM employees e
JOIN orders o ON e.employeeid = o.employeeid
WHERE YEAR(o.orderdate) = 1997
GROUP BY e.employeeid, e.firstname, e.lastname;

SELECT e.FirstName,e.LastName, COUNT(o.orderid) as totalorders
FROM employees e
JOIN orders o ON e.employeeid = o.employeeid
WHERE o.orderdate BETWEEN '1997-01-01' AND '1997-12-31'
GROUP BY e.FirstName,e.LastName;

select p.productid,p.productname,SUM(od.unitprice * od.quantity * (1 - od.discount)) AS totalrevenue
FROM products p
JOIN `order details` od ON p.productid = od.productid
GROUP BY p.productid, p.productname;

SELECT productid,productname,unitprice,RANK() OVER (ORDER BY unitprice DESC) AS pricerank
FROM products;

SELECT o.orderid,SUM(od.quantity) AS totalquantity,SUM(od.unitprice * od.quantity * (1 - od.discount)) AS totalprice
FROM orders o
JOIN `order details` od ON o.orderid = od.orderid
GROUP BY o.orderid;

SELECT e.employeeid,e.firstname,e.lastname,YEAR(o.orderdate) AS orderyear,COUNT(o.orderid) AS ordercount
FROM employees e
JOIN orders o ON e.employeeid = o.employeeid
GROUP BY e.employeeid, e.firstname, e.lastname, YEAR(o.orderdate);

SELECT customerid,YEAR(orderdate) AS orderyear
FROM orders
WHERE YEAR(orderdate) BETWEEN 1996 AND 1998
GROUP BY customerid, YEAR(orderdate)
HAVING COUNT(DISTINCT orderyear) = 3;





