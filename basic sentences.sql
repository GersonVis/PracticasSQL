--basic sentences select from where
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
