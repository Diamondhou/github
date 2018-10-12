/* ------------------------------10.09------------------------------------- */
/*建表语句*/
create table book(
	book_id int auto_increment primary key,
    book_name varchar(100) not null,
    book_price int not null
);
    insert into book(book_name,book_price)values('python',100);

/*删除表格*/ 
drop table 表名称   --删除表

/*数据库bookstore 表book 插入数据*/
    mysql -uroot -proot
    use bookstore
    select * from book;
    insert into book(book_name,book_price) values('java',110);
    insert into book(book_name,book_price) values('php',120);
    select * from book;
    update book set book_price = 150 where book_name = 'python'
    select * from book;
    delete from book where book_name = 'php';
	select * from book;

/*如果你有问题*/ 
cmd1:mysqld
cmd2:mysql -uroot -proot
/*如果你有问题*/ 

/*task1*/ 
创建emp表：包含empno ename salary
empno(整数 自动增长 主键)
ename(变长字符 最大长度30 非空)
salary(整数 非空)
录入数据：
Simth 100
Scott 200
Jim 300


/*answer1*/
create table emp(
	empno int auto_increment primary key,
    ename varchar(30) not null,
    salary int not null
);
insert into emp(ename,salary) values('Simth',100);
select * from emp;
insert into emp(ename,salary) values('Scott',200);
insert into emp(ename,salary) values('Jim',300);

/*insert into emp(ename,salary) values('Simth',100),('Scott',200),('Jim',300);*/

Show tables;
Desc emp;

查询salary大于150的员工
select * from emp where salary >150;
查询salary在150和300之间的员工
select * from emp where salary between 150 and 300;
只查询前两条记录
select * from emp limit 2;

/*task2*/
--student (stu_id stu_name stu_password)
create table student(
    stu_id int auto_increment primary key,
    stu_name varchar(30) not null,
    stu_password int not null
);
insert into student(stu_name,stu_password) values('Timothy',1503),('Jiazhe',3869),('Liu',5166);
select * from student;
update student set stu_name = 'Simth' where stu_name = 'Timothy';
update student set stu_name = 'Scott' where stu_name = 'Jiazhe';
update student set stu_name = 'Jim' where stu_name = 'Liu';

select * from student where stu_id = 3;
select min(salary) from emp;
select max(salary) from emp;
select avg(salary) from emp;
select stu_id from student;
select stu_name from student;
select stu_id,stu_name from student;
select stu_password,stu_name from student;

/*
用户的管理：
查看所有的用户：
*/
use mysql;
select user,password,host from user;

--user:
--password:
--host:
--localhost 代表允许本地连接
--% 代表允许从任意主机连接
select count(*) from user;

新建数据库用户：
grant all privileges on *.* to 'python'@'localhost' identified by 'root';
grant all privileges on *.* to 'python'@'%' identified by 'root';
select user,password,host from user;--查询用户
select count(*) from user;

grant all privileges on it.* to 'it_user'@'localhost' identified by 'root';
grant all privileges on it.* to 'it_user'@'%' identified by 'root';

mysql -upython -proot
show databases;
exit
mysql -upython -proot
create database sales;
show databases;
use sales; 

/* mysql Tip1*/
mysql -uroot -proot
use mysql;
select user,password,host from user;--查询用户
/* end */

use mysql
delete from user where user = 'python';


mysql -uit_user -proot

/* ------------------------------10.10-------------------------------------- */
mysql -uroot -proot
--查看命令的结束符 delimiter
status
delimiter $$
create database python $$
show databases $$
show create database python $$

create database java default character set utf8 $$
show create database java $$

--存储过程
use it $$
show tables $$
desc emp $$
select * from emp $$
create procedure proc1()
    begin
    select * from emp;
    end;
    $$

call proc1() $$

create procedure proc2(name varchar(30))
    begin
    select * from emp where ename = name;
    end;
    $$

call proc2('Jim') $$

drop procedure if exists proc3 $$
create procedure proc3(in sal int)  --括号里面的in可以省略
    begin
    select * from emp where salary = sal;
    end;
    $$

call proc3(100) $$

drop procedure if exists proc4 $$
create procedure proc4(in name varchar(30),in sal int)
    begin
    select * from emp where ename = name and salary = sal;
    end;
    $$

call proc4('Jim',300) $$

--break 
select * from emp $$

create table emp_log
    as
    select * from emp
    where 1 = 2
    $$

desc emp_log $$
select * from emp_log $$

create trigger emp_tr1 after delete on emp for each row
    begin
    insert into emp_log values(old.empno,old.ename,old.salary);
    end;
    $$

select * from emp $$
select * from emp_log $$
delete from emp where ename = 'Tom' $$
select * from emp $$
select * from emp_log $$
drop trigger emp_tr1 $$

drop trigger if exists emp_insert $$
create trigger emp_insert before insert on emp for each row
    begin
    insert into emp_log values(new.empno,new.ename,new.salary);
    end;
    $$

insert into emp(ename,salary)values('Rose',500)$$
select * from emp $$
select * from emp_log $$
drop trigger if exists emp_insert $$

--break2
create procedure proc5()
    begin
    declare name varchar(30);
    set name = 'Tom';
    select name;
    end;
    $$

call proc5 $$

create procedure proc6()
    begin
    declare age int default 1;
    select age;
    end;
    $$

call proc7(500,'java') $$

drop procedure if exists proc8 $$
create procedure proc8()
begin
declare v1 int default 10;
if v1 > 10 then
select 1;
else
select 2 as value;
end if;
end;
$$

--afternoon
mysql -uroot -proot
use it;
delimiter $$
create table emp1
    as
    select * from emp
    where 1 = 2
    $$

desc emp1 $$
select * from emp1 $$
show tables $$

select * from emp $$
drop procedure if exists proc1 $$
create procedure proc1()
    begin
    declare v1 int default 100;
    if v1 > 100 then
    insert into emp1 values(101,concat('user_',101),1001);
        elseif v1 = 100 then
        insert into emp1 values(101,concat('user_',100),1000);
            else
            insert into emp1 values(99,concat('user_',99),999);
                end if;
    end;
    $$

delimiter //
drop procedure if exists proc2 //

create procedure proc2()
    begin
    declare v1 int default 0;
    declare result varchar(255) default'';
    set v1 = 1;
    while v1 < 11 do 
    set result = concat('v1 = ',v1);
    select result as result;
    set v1 = v1 + 1;
    end while;
    end;
    //


    delimiter ;  --切换结束命令符为;

----------------lalalalalalalala

delete from emp1;  
select count(*) from emp1; 
select * from emp1 limit 10;  
desc emp1;  
/*
--删除emp1表中书库
--查询emp1表中有几个数据
--查询emp1 前十个数据
--查询emp1属性
*/


--二进制bin;
--八进制oct;
--十六进制hex;
--Select bin(数字)

select concat('python','java','.net',100); --合并
select concat('python','java','.net',100,null); --合并
select locate('world','hello world');
select lpad('hi',5,'?');  --从左边填充？
select rpad('hi',5,'?');  --从右边填充？
select left('python',3);  --左边三个字符 pyt
select right('python',3); --右边三个字符 hon
select substring('hello,world',4,5);  --从位置4开始数5个字符显示出来
select substring('hello,world',4);  --从位置4一直显示出来
select ltrim('  python');    --删除左边空格
select rtrim('python    ');  --删除右边空格
select length(ltrim('   python   '));  ---计算删除左面空格之后的长度
select length(ltrim(rtrim('   python   ')));  --删除右边和左边的空格再计数
select length('python'); --字符计数
select space(5);  --输入五个空格
select length(concat(space(3),'python',space(2))) as result;

