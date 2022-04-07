--text file with sql sentences
--use database
use school;
/*What type of identities?: authors
*/
create table authors(
 author_id int,
 first_name varchar(30),
 last_name varchar(30),
 sex char(1),
 birth_date DATE,
 country_origin varchar(40)
);
--show tables database
show tables;
--Show column information
show columns from author;
--or
desc author;
--create table from other
--create table table_name_new like source_table_name
create table user like authors;
--insert into table, insert log
insert into authors(author_id, first_name, last_name, sex, birth_date, country_origin)
values(1, "Test author", "Test autor", "M", "2022-01-30", "México");
--see all registers
select * from authors;
--insert into with only 3 values
insert into authors(author_id, first_name, last_name)
values(1, "Test author", "Test autor");
--multiple inserts
insert into authors(author_id, first_name, last_name, sex, birth_date, country_origin)
values
(1, "Test author", "Test autor", "M", "2022-01-30", "México"),
(2, "Test author", "Test autor", "M", "2022-01-30", "México"),
(3, "Test author", "Test autor", "M", "2022-01-30", "México"),
(4, "Test author", "Test autor", "M", "2022-01-30", "México"),
(5, "Test author", "Test autor", "M", "2022-01-30", "México"),
(6, "Test author", "Test autor", "M", "2022-01-30", "México");
--run sql file
--source name file
source practiceOne.sql;
--conditionals in database, use reserved word "if exists"
--drop with conditional
drop database if exists school;
--create with conditional
--you can put not make true the false condition
create database if not exists school;
--execute sentences directly from the console
mysql -u root -p nameDatabase -e "select * authors;"
--show databases
show databases;