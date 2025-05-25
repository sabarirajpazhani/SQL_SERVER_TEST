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


-- Write a SQL query to display all employees who belong to the 'HR' department using JOINs (Employee and Department tables).
select emp.empName, dept.deptName
from Employee emp
inner join Department dept
on emp.deptID = dept.deptID
where dept.deptName = 'HR'

