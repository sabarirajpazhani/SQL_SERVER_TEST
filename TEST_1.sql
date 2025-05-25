create database Employee;
create database Department;

create table Employee(
	empid int primary key,
	empName varchar(20),
	empSalary int,
	deptID int,
	foreign key (deptID) references Department(deptID)
);

create table Department(
	deptID int primary key,
	deptName varchar(10),
);

insert into Department (deptID,DeptName) values 
(1, 'HR'),
(2,'Finance'),
(3,'Dev');

insert into Employee (empid, empName, empSalary,deptID) values
(1, 'A', 50000, 1),
(2, 'B', 30000,2),
(3, 'C', 55000,1),
(4, 'D', 60000,3),
(5, 'F', 65000,3);

select * from employee;
select * from Department;

--section A

--1. Write a SQL query to get the names and salaries of the top 3 highest-paid employees from the Employee table.
select top 3 empName, empSalary from Employee
order by empSalary DESC;

--2. Write a SQL query to display all employees who belong to the 'HR' department using JOINs (Employee and Department tables).
select emp.empName, dept.deptName
from Employee emp
inner join Department dept
on emp.deptID = dept.deptID
where dept.deptName = 'HR'

--3. Display department-wise total salary using aggregation.
select dept.deptName , SUM(emp.empSalary) as TotalSalary 
FROM Employee emp
right join Department dept
on emp.deptID = dept.deptID
group by deptName;

--4. Fetch employee names whose name starts with ‘S’ and ends with ‘a’.
--for this question i will update my table employee name
update Employee
set 
empName = case
	when empid = 1 then 'Abilash'
	when empid = 2 then 'Subha'
	when empid = 3 then 'Sharmila'
	when empid = 4 then 'Thamizh'
	when empid = 5 then 'Akash'
	else
	empName
end;

select empName from Employee 
where empName like 'S%' and empName like '%a';

--5. Write a query to find the second highest salary from the Employee table without using TOP or LIMIT.
select max(empSalary) from Employee
where empSalary <(select max(empSalary) from Employee);

--6. Create a table Customer with fields
create table Customer (
	ID int primary key,
	Name varchar(40),
	Email varchar(50),
	CreatedDate date default GETDATE()
);

--7. Write a stored procedure to get all employees working in a given department (department name is input).
create procedure employees(
	@dept varchar(50) 
) AS
begin 
select * from Employee 
inner join Department
on Employee.deptID = Department.deptID
where Department.deptName = @dept
end;

exec employees 'HR';

--8. Write a query to fetch all records from Orders table placed in the last 7 days.
create table Orders(
	orderID int primary key,
	productName varchar(50),
	price int,
	orderedDate DATE
);
insert into Orders (orderID,productName,price,orderedDate)
values
(101,'Mobile',50000,'2025-03-02'),
(102,'Laptop',65000,'2025-04-01'),
(103,'Earpods',2000,'2025-05-24');

select * from orders
where orderedDate >= dateadd(day,-7,getdate());

-- section B
--9. 
/*Entities:
- Student (ID, Name, Email)
- Course (CourseID, Title)
- Enrollment (StudentID, CourseID, EnrollmentDate)

Relationships:
- A student can enroll in many courses.
- A course can have many students.*/

create table Student (
	StudID int Primary key,
	StudName varchar(40),
	Email varchar(50)
);

create table Course (
	CourseID int Primary key,
	Title varchar(30)
);

create table Entrollment(
	StudID int,
	CourseID int,
	EnrollmentDate Date,
	primary key(StudID,CourseID),
	foreign key (StudID) references Student(StudID),
	foreign key (CourseID) references Course(CourseID)
);

/*Q10. You are given an ER model:
Product <---- OrderDetails ----> Order
Design these tables with proper keys assuming:

Product has: ID, Name, Price

Order has: OrderID, CustomerID, OrderDate

OrderDetails includes Quantity and UnitPrice*/

create table Product(
	productID int primary key,
	productName varchar(20),
	productPrice int
);

create table orderProd(
	orderID int primary key,
	customerID int,
	orderDate date,
);

create table OrderDetails (
	orderID int,
	productID int,
	quantity int check(quantity > 0),
	unitPrice decimal(10,2),
	foreign key (orderID) references orderProd(orderID),
	foreign key (productID) references Product(productID)
);

--11. What is the purpose of a junction table? Explain with a Many-to-Many relationship scenario.
--Answer: Ternary operator is used to handle the many to many relationship between two tables
-- Because of many to many relationship is not directly used in the sql server

create table Product(
	productID int primary key,
	productName varchar(20),
	productPrice int
);

create table orderProd(
	orderID int primary key,
	customerID int,
	orderDate date,
);

create table OrderDetails (
	orderID int,
	productID int,
	quantity int check(quantity > 0),
	unitPrice decimal(10,2),
	foreign key (orderID) references orderProd(orderID),
	foreign key (productID) references Product(productID)
);

-- this query is also the example of junciton table. The juunction table is OrderDetails

--SECTION C
--12. What is the difference between WHERE and HAVING?
/* where is used to filter the records using specific conditions where as HAVING is used to filter the grouped data.
HAVING is word with GROUP BY . WHERE can't work with aggregate function but HAVING id only work with only aggregate functions

13. Define a view and explain when you would use one. Can we update a view?
view is the virtual table. it does not store the data physically.
it is used in the case of we want to execuite the particukar query for particular case then we can use the view concept. 
for example : implementing row level security, hiding the complexity, implementing column level security

Yes we can also update the view
view name is vwAllEmployee
UPDATE vwAllEmployee
SET Name = 'raj'
where id = 1;

14.What are ACID properties in transactions?

ACID properties is the set of rules which is used to tell how the database table must be. i.e. the principle is 'do everything, do nothing'
A- Atomicity
C- Confientiality
I- Isolation
D- Durability

15. What is the difference between DELETE, TRUNCATE, and DROP?
DELETE  - Used to delete the particular row permenently\
TRUNCATE - used to delete the records but it have the structure of the table
DROP - used to delete the entire table and database permenently
