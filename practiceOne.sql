drop database if exists school;
create database if not exists school; 
use school;
create table authors(
 author_id int,
 first_name varchar(30),
 last_name varchar(30),
 sex char(1),
 birth_date DATE,
 country_origin varchar(40)
);
insert into authors(author_id, first_name, last_name, sex, birth_date, country_origin)
values
(1, "Test author", "Test autor", "M", "2022-01-30", "México"),
(2, "Test author", "Test autor", "M", "2022-01-30", "México"),
(3, "Test author", "Test autor", "M", "2022-01-30", "México"),
(4, "Test author", "Test autor", "M", "2022-01-30", "México"),
(5, "Test author", "Test autor", "M", "2022-01-30", "México"),
(6, "Test author", "Test autor", "M", "2022-01-30", "México");
select * from authors;