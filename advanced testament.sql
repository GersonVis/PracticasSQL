-- search by string
-- sentence like
/*Descriptio:
this sentence search string inner string,
we can used % in the end if we wan that start the string with the our condition
and we can used % in the start if we want that our string end with our condition
if our search is between not start, not end make this '%string%',
if we want used other type of conditions '___characters___'*/
-- we'll see registers that end with 'hora'
select * from books where title like('%hora');
-- we'll see registers that start with 'hora'
select * from books where title like('hora%');
-- we´ll see registers that have hora, dont care position
select * from books where title like('%hora%');
-- we'll see registers that have the word 'hora' but with 15 characters to the left
select * from books where title like('hora____________');
-- other examples
select * from books where title like('El_i%');
select * from books where title like('%i_p%');
select * from books where title like('%_io');
select * from books where title like('El_%');

-- regular expresions
-- sentence: select * from table_name where column_name regexp regular_expresion
-- example:
-- we'll see registers starting with E
select * from books where title regexp '^[E]';
-- we'll see registers have two spaces
select * from books where title regexp '.{1,}\ .{1,}\ .';

-- sort registers
-- setence: select * from table_name order by column_name/column_name2/... asc/desc
/* Description: sort the registers according to the information in the column, descending or ascending
using the word asc or desc*/
--example:
-- we will order according to the title of the book in descending order
select * from books order by title desc;
-- we'll order according publication_date and number of pages in ascending order
select * from books order by publication_date and pages asc;
-- we will order books according id and author_id in ascending order
select * from books order by book_id and author_id asc;


-- limit registers
-- setence: select * from column_name limit position_number, number_of_registers/limit number_of_registers;
/* Description: get the specified number of registers*/
-- example:
-- get top five
select * from books limit 5;
-- get top two starting at position 10
select * from books limit 10, 2;
-- other examples
select * from books order by title asc limit 2;
select * from books order by author_id desc limit 1, 2;


-- Agregation functions
-- this functions only work with are not null registers 
-- count, max, min, avg, sum
-- count
-- count the number of register, if we dont used where count non-null registers
-- example:
select count(*) as "Number of books" from books;
-- result: 4
select count(title) "Books with title" from books;
-- reult 4
-- count with where
-- number of registers with title start with "EL"
select count(*) as "Start with 'El'"from books where title like("El%");
-- number of books that have two spaces in the title
select count(*) as "Have 3 spaces" from books where title regexp '.{1,}\ .{1,}\ ';

-- avg
-- get the average of registers
-- sentence: select avg(integer_column_name) as column_name from table_name;
-- example:
-- get the average of the sales column
select avg(sales) as "Average sales" from books;
-- get the average of the pages column
select avg(pages) as "Average pages" from books;
-- other examples
select avg(sales) from books where title like ("El%");

-- max 
-- get the highest score
-- sentence: select max(column_name) from table_name;
-- example:
-- gets the biggest sale
select max(sales) from books;
-- gets the biggest sale when the author_id is two
select max(sales) from books where author_id=2;

-- min
-- get the smallest score
-- sentence: seelct min(column_name) from table_table where conditions;
-- example:
select min(sales) from books;

-- Group by
-- sentence: select columns_name from name_table group by column_name
/* create a group after the result, will do the operation by group
*/
-- example
-- get the sum of sales and order from smallest to largest
select author_id, sum(sales) as sum_sales from books group by(author_id) order by sum_sales desc;
-- get the lowest-selling book by an autor
select title, author_id, min(sales) as min_sales from books group by author_id;
-- average sales per author
select author_id, avg(sales) as avg_sales from books group by author_id;

-- HAVING
-- this help us by make conditios after a group by or agrupation functions
-- sentence: selct sum(sales) from books group by column_name having sum(column_name)>/</!=/= number or other condition;
-- example
-- get the author id with more than one thousand sales
select author_id, sum(sales) as sum_sales from books group by(author_id) having max(sum_sales)>300;
-- get the sales per author if they are less than three hundred
select author_id, min(sales) as min_sales from books group by(author_id) having min(sales)<300;

-- UNION
-- setence: sentence_one union sentence_two;
-- this sentence join the result of two sentences, the sentences must, used the same alias with "as"
-- return the same number of columns
-- example:
-- get the union between users and authors with alias full_name
select concat(first_name, " ", last_name) as "Full name" from authors
union
select concat(first_name, " ", last_name) as "Full name" from users;


-- sub queries
-- sentence sentence where (sentence2)
-- description: We can used the result in others consults
-- example
-- get the full name of authors with higher more than average sales

select concat(first_name, " ", last_name) as "Full name"
from authors 
where author_id 
in (select author_id from books group by author_id having avg(sales)>(select avg(sales) from books));
-- other form
set @sales_average=(select avg(sales) from books);
set @author_ids=(select author_id from books group by author_id having avg(sales)>@sales_average);

select concat(first_name, " ", last_name) as "Full name"
from authors 
where author_id 
in (@author_ids);

-- IF
-- sentence: select if(exist, if_true_condition, if_false_condition);
/*Description: This make sentences if is true, and sentences if its false*/
-- example:
select if(
    exists(select book_id from books where title="Guayabos"),
    'Exist',
    'Non exist'
) as "Condition";
