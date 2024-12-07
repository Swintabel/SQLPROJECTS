----------------------
-- QUESTION 1
----------------------

create database school;

use school;

create table modules
(moduleId int primary key,
moduleName text
);

insert into modules values
( 1, 'Data Science'),
(2, 'Programming'),
(3, 'Data Engineering'),
(4, 'Project'),
(5, 'Machine Learning');


create table students
(student_id int primary key,
 `name` varchar(50), 
 moduleId int, 
 programme varchar(50), 
 mark int, 
 grade text, 
 `password` text,
foreign key(moduleId) references modules(moduleID));

insert into students values
( 1, 'James', 1, 'Data Science', 90, 'first', '123456'),
(2, 'Bob', 1, 'Data Science', 60, 'upper second', '45652'),
(3, 'Lucy', 1, 'Engineering', 75, 'first', '45456'),
(4, 'Jonathon', 2, 'Engineering', 60, 'upper second', '9988843'),
(5, 'Wang', 2, 'Data Science', 55, 'lower second', '9!!!G83'),
(6, 'Anna', 3, 'Maths', 55, 'lower second', '33@@2');

-----------------------
-- QUESTION  2
-----------------------
select * from students
where mark<60;

-----------------------
-- QUESTION  3
-----------------------
select * from students
where `name` like '%B';


-----------------------
-- QUESTION  4
-----------------------
select * from students 
order by mark desc;

-----------------------
-- QUESTION  5
-----------------------
select grade, count(*) from students
group by grade;


-----------------------
-- QUESTION  6
-----------------------
insert into modules values
( 6, 'Data Mining');

insert into students values
( 7, 'Obisi', 6, 'Data Mining', 85, 'first', '123wewhwe');

delete from students
where student_id= 7;

delete from modules
where moduleId= 6;

update students
set student_id=0
where student_id=1;


-----------------------
-- QUESTION  7
-----------------------
select * from students 
join modules
on students.moduleId=modules.moduleID;


-----------------------
-- QUESTION  8
-----------------------

create user IF NOT exists 'User0' identified by 'password';

GRANT SELECT ON school.* TO 'User0';

-----------------------
-- QUESTION  9
-----------------------

drop procedure if exists mark;

Delimiter //

create procedure school.mark()
BEGIN
	select * from students where mark<60 ;
    select * from students where `name` like '%B';
    select * from students order by mark desc;
    select grade, count(*) from students group by grade;
	insert into modules values
	( 6, 'Data Mining');

	insert into students values
	( 7, 'Obisi', 6, 'Data Mining', 85, 'first', '123wewhwe');

	delete from students
	where student_id= 7;

	delete from modules
	where moduleId= 6;

	update students
	set student_id=0
	where student_id=1;
    
	select * from students 
	join modules
	on students.moduleId=modules.moduleID;
    
	create user IF NOT exists 'UserN' identified by 'password';

	GRANT SELECT ON school.* TO 'UserN';
END //

Delimiter ;

call school.mark();
