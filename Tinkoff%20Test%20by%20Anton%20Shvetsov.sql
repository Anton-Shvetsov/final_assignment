drop table staff;
drop table jobtitles;

create table staff(
                   staff_id char(1) NOT NULL PRIMARY KEY,
                   name varchar(40) NOT NULL,
                   salary decimal(10,2),
                   email varchar(30),
                   birthday DATE,
                   jobtitle_id char(1)
               );

create table jobtitles(
                        jobtitle_id char(1) NOT NULL PRIMARY KEY,
                        name varchar(50) NOT NULL 
                        );
                        
insert into staff 
values(1,'Иванов Сергей',100000,'test@test.ru','1990-03-03',1);
insert into staff 
values(2,'Петров Пётр',60000,'petr@test.ru','2000-12-01',7);
insert into staff 
values(3,'Сидоров Василий',80000,'test@test.ru','1999-02-04',6);
insert into staff 
values(4,'Максимов Иван',70000,'ivan.m@test.ru','1997-10-02',4);
insert into staff 
values(5,'Попов Иван',120000,'popov@test.ru','2001-04-25',5);
select * from staff;

insert into jobtitles 
values(1,'Разработчик');
insert into jobtitles 
values(2,'Системный аналитик');
insert into jobtitles 
values(3,'Менеджер проектов');
insert into jobtitles 
values(4,'Системный администратор');
insert into jobtitles 
values(5,'Руководитель группы');
insert into jobtitles 
values(6,'Инженер тестирования');
insert into jobtitles 
values(7,'Сотрудник группы поддержки');
select * from jobtitles;

/* Найдем дубли в поле email из таблицы Sfaff: */
select email, count(email) as count from staff group by email having count > 1;

/* Определим возраст каждого сотрудника из таблицы Staff на момент запроса: */
select staff_id, name, birthday, 
    year(current_date) - year(birthday) - sign(dayofyear(current_date) < dayofyear(birthday)) as age 
    from staff;

/* Определим должность (Jobtitles.name) со вторым по величине уровнем зарплаты: */
select name, salary
       from (select jobtitles.name, staff.salary from jobtitles, staff 
             where jobtitles.jobtitle_id = staff.jobtitle_id 
             order by staff.salary desc limit 2)
       order by salary limit 1;