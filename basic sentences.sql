--basic sentences select from where
--other form of used unique
/*create table users(
    user_id integer not null primary key AUTO_INCREMENT,
    user_name  varchar(25) not null,
    constraint unique(user_name)
)*/
--combination unique, we can used unique_combination
create table authors(
 author_id integer unsigned PRIMARY KEY AUTO_INCREMENT,
 first_name varchar(30) not null,
 last_name varchar(30) not null,
 pseudonym varchar(25) unique,
 sex ENUM('M', 'F'),
 birth_date DATE,
 enrollment varchar(50),
 country_origin varchar(40),
 create_date datetime default current_timestamp,
 constraint unique_combination unique(first_name, last_name, enrollment)
);
-- see all registers
select * from books;
-- see all in letter shape
select * from books\G;
-- select only few things
select title, pages from books\G;
-- select with where
select title, pages from books where title="El imperio";
-- operators available
/*
>
<
>=
<=
=
!= or <>
*/
-- operadores logicos
/*
and
or
not*/
-- and example
select * from books where title="El imperio" and author_id="1";
-- logic operator or
select * from books where title="El imperio" or author_id="1";
-- union or and and
select * from books where title="El imperio" and author_id="1" or author_id="2";


--datatype null
-- select null
-- the datatype null it dont response to where column_name=null
-- we must used not in where 
select * from authors where null_column is null;
-- reverse
select * from authors where null_column is not null;
-- other form, example: 
select * from authors where null_column <=> null;

-- registers range
-- date ranges
select * from books where publication_date between '2011-00-00' and '2022-00-00';
-- int ranges
select * from books where pages between 1 and 30;
-- varchar ranges
select * from books where title between 'ha' and 'hz';

--list searches
 --we can do this
 select * from books where title="El perro" or title="Hora de aventura";
 -- but is better, do this
select * from books where title in ("El perro", "Hora de aventura");
-- the same but with numbers
select * from books where pages in (83, 63);
-- with dates
select * from books where publication_date in ("2010-12-23", "2000-12-23");


-- get unique values
-- select distinct column_gets* from table_name;
--description
/*show only one match*/
--example with varchar
select distinct title from authors;
--example with numbers
select distinct pages from books;
--example with dates
select distinct publication_date from books;
-- Alias 
-- reserved word: as
--Description
/*
you can used the word for rename tables or columns, these renamings
will be show in the response, you can omitted the word "as" and only make a space
*/
--example with columns with as
select title as titulo from books;
-- example without as and with space
select title titulo from books;
-- example with tables
select libros.title from books as libros;
-- setence with everything learned
select libros.title as titulo from books as libros;
-- you can do this
select 3*4 as multiple;
select bks.pages-10 as result from books as bks; 


-- Update register
-- sentence
-- update table_name set column_name=new_value where condition
-- description
/*
 we can update a register, with new data, update all registers if not used "where"
*/
-- example with the table books
update books set sales=23, pages=20;
update books set pages=1;
update books set stock=20;
-- example update with where
update books set stock=50 where book_id=8;
update books set sales=100 where title="Hora de aventura";
-- update using between 
update books set sales=500 where book_id between 7 and 10;
set @initial_date="2010-12-01";
set @end_date="2021-12-01";
update books set stock=1000 where publication_date between @initial_date and @final_date;

-- delete registers
-- setence: delete from table_name where conditions;
/*Description: this sentence detele registers, caution
if you dont used where, everything is deleted
*/
--example
delete from books2;
--example with "where"
delete from boooks2 where book_id=2;
-- delete on cascade
-- we should in the table add the sentence "on delete cascade" in the part
-- where we used the foreign key
-- example
-- first,dro we deteled books table
create table books(
      book_id integer unsigned primary key AUTO_INCREMENT,
      author_id integer unsigned not null,
      title varchar(50) not null,
      book_description varchar(250),
      pages integer unsigned,
      publication_date date not null,
      create_date datetime default current_timestamp,
      foreign key (author_id) references authors(author_id) on delete cascade
);

-- now we can do
-- delete without problems, now the register is eliminated
-- now no need to delete registers in books
delete from authors where author_id=1; 


--Truncate table
--setence: truncate table table_name;
/*Description: restart definition table, this sentence restart the table, for example, restart count AUTO_INCREMENT,
is imposible get it back registers, the table crashes, destroy all metadatos, imposible to used "where"
*/
--examples
truncate table authors2;
truncate table books;
truncate table author;
