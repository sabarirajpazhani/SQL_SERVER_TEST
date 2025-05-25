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

