CREATE DATABASE try;
USE try;

drop table employees;
drop table employee_audit;

CREATE TABLE employees (
Employee_id INT AUTO_INCREMENT PRIMARY KEY, 
name VARCHAR (100),
position VARCHAR (100),
salary DECIMAL (10, 2),
hire_date DATE
);

CREATE TABLE employee_audit (
audit_id INT AUTO_INCREMENT PRIMARY KEY,
employee_id INT,
name VARCHAR (100),
position VARCHAR (100), 
salary DECIMAL (10, 2),
hire_date DATE,
action_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO employees (name, position, salary, hire_date) 
VALUES ('John Doe','Software Engineer', 80000.00, '2022-01-15'),
('Jane Smith', 'Project Manager', 90000.00, '2021-05-22'),
('Alice Johnson', 'UX Designer', 75000.00, '2023-03-01');

select * from employees;

drop procedure new_employee_detail;

delimiter $$
create procedure new_employee_detail(in E_name varchar(100), in E_position varchar(100), in E_salary decimal(10,2), in E_hire_date date)
begin
     insert into employees(name,position,salary,hire_date)
     values (E_name,E_position,E_salary,E_hire_date);
end $$
delimiter ;

call new_employee_detail("Lara Dutta", "HR",75000.00,"2025-08-03");
call new_employee_detail("Shraddha Kapoor", "Brand Ambessador",1200000.00,"2021-08-03");
call new_employee_detail("Dakota Johnson", "CEO",12000000.00,"2019-08-03");

drop trigger if exists insert_emoplyee_detail;

delimiter $$
create trigger insert_emoplyee_detail
after insert on employees
for each row
begin
     insert into employee_audit(employee_id,name,position,salary,hire_date)
     values (new.employee_id,new.name,new.position,new.salary,new.hire_date);
end $$
delimiter ;

select * from employee_audit;