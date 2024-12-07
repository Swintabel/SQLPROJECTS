
use school;

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

---------------------------
Delimiter //

create procedure school.findB()
BEGIN
	select * from students where `name` like '%B';
  
END //

Delimiter ;

------------------------
Delimiter //

create procedure school.orderMark()
BEGIN
	select * from students order by mark desc;
END //

Delimiter ;

------------------------
Delimiter //

create procedure school.grade()
BEGIN
	select grade, count(*) from students group by grade;
END //

Delimiter ;

------------------------
Delimiter //

create procedure school.modify()
BEGIN
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

END //

Delimiter ;

------------------------
Delimiter //

create procedure school.joins()
BEGIN
	select * from students 
	join modules
	on students.moduleId=modules.moduleID;
END //

Delimiter ;

------------------------
Delimiter //

drop procedure if exists CreateNUser;
create procedure school.CreateNUser()
BEGIN
 create user IF NOT exists 'UserN' identified by 'password';

 GRANT SELECT ON school.* TO 'UserN';
END //

Delimiter ;

call schoool.`mark`();