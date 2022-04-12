-- functions, always they have to return a datatype
-- the system have their own functions
-- we can used functions inner sentences how select, update or others

-- function on strings

-- CONCAT
-- sentence: select concat(first_column_name, second_column_name) from table_name where conditions;
-- example:
select concat(first_name, " ", last_name) as "Complete name" from authors;
-- used in conditions
select * from authors where concat(first_name, " ", last_name)="Stephen Edwin King"; 

-- lenght
-- sentence: select lenght(data or string_column_name);
-- example:
select length(title) as "length title" from books;
select length(title)+length(book_description) as "Length title" from books;
-- used length in conditions
select title from books where length(title)>10;

-- UPPER
-- sentence select upper(name_column) from books;
-- capital letters
-- example
select upper(first_name) from authors;
-- with conditions
select * from books where upper(title)="HORA DE AVENTURA";

-- LOWER    
-- sentence: select lower(column_name or data) from books where lower(title)=condition;
-- example:
select lower(book_descrition) from books;
-- lower with conditions
select lower(book_description) from books where lower(title) between "a" and "z";


--trim
-- setence: select trim(column_name or data);
-- remove prefix at start and end, default is space
-- example
select trim("             text with prefix           ");
-- left
-- sentence select left(data, number_of_characters);
-- get the specified chacteres number of characters
--example:
set @exampleString="abcdefghijk";
select left(@exampleString, 3);
select left(create_date, 4) as YEAR from books;
-- result "abc"

-- right
-- the same, but starting from the right
select right(@exampleString, 3);
select * from books where right(publication_date, 2)="23";
-- result: ijk

-- integer functions
-- rand
-- this function we can get, random  ingeger
-- sentence: select rand();
-- example
select rand();

-- round
-- round out the number to integer without decimals
-- setence: select round(data);
-- example:
select rand(round()*30);
select rand(4.3);

-- truncate
-- this return only the decimals we need
-- sentence: select truncate(data, decimals_number)
-- example
select truncate(rand(), 2);
select truncate(4.12345, 3);
-- 4.123

-- pow or power
-- this return the number power
-- sentence: selct pow(number, power);
-- example
select pow(2, 2);
-- 4
select pow("a", 2);
-- 0, strings always gives 0

-- with all
select round(pow(truncate(rand()*30, 2), 4)) as result;

-- functions with dates
-- now()
-- this return the datetime, day, month, year
-- example
set @today=now();
select @today as today;
-- curdate()
-- we will get the date, only the year, the month and the day
-- example
select curdate() as "Short date";
-- dayofweek()
-- we wil get the day on the week
-- example
select dayofweek(@today);
-- dayofmonth()
-- we will get the day on the month
-- example:
select dayofmonth(@today);
-- dayofyear()
-- we will the day on the year
-- example:
select dayofyear(@today);
-- date
-- this operation convert datetime to date
-- sentence: date(datetime);
-- example: 
select date(now());
-- operations with dates
-- plus and rest days or months or days
-- sentence: select date +/- interval 5 month/day/second;
-- example:
-- @today=2022-04-09 12:22:52
select @today + interval 5 month;
-- result: 2022-09-09 12:22:52
-- other examples
set @creationDate="2022-04-05";
set @startDate=@creationDate - interval 8 day;
set @endDate=@creationDate + interval 8 day;
select * from books where create_date between @startDate and @endDate;
-- get the register creates in weekend
select * from books where dayofweek(create_date) in (7,1);

-- functions conditions
-- if()
-- setence: select if(value, if_true_condition, if_not_true_condition);
-- this sentence return same if is true and return same if is false
-- example
select if(true=true, "The condition is true", "The condition is false");
-- result: THe condition is true
select if(true=false, "The condition is true", "The condition is false");
-- result: The condition is false
-- other examples
update books set pages=if(pages<50, round(rand()*100), pages) where book_id in (2,3,5);
select if(null_column is null,"is null", "isnt null") from books;
-- ifnull
-- conditions with nulls
-- it need two parameters, the column name or data and do make if it is true
-- sentence: select ifnull(data, make_for_true);
-- examples: 
update authors set null_column=ifnull(null_column, 10);
select ifnull(null_column,"is null") from books;  


-- create functions
-- setence: create function function_name(data type_data) returns data_type begin logic return datatype; end;
-- we can used ; becouse truncate sentence used delimiter //
-- example
delimiter //
create function its_expired(date_create date, date_check date, extension_days integer)
returns boolean
begin
set @date_expiry=date_create+interval extension_days day;
return date_check<@date_expiry;
end//
delimiter ;

-- delete function
-- drop function if exist function_name
-- example
drop function if exists its_expired;
update books set expired=its_expired(create_date, curdate(), 30);


-- operations with functions
-- list functions
-- show all functions in the system
-- example:
select name from mysql.proc where db=database() and type='FUNCTION';

-- delete function
-- sentence: drop function function_name;
-- example
drop function run;
-- or
drop function if exists run;

-- more example functions
delimiter //
create function random_pages(max_num_pages integer, min_num_pages integer)
returns integer
begin
set @maximun_quantity=(max_num_pages-min_num_pages);
set @random_pages=((round(rand()*@maximun_quantity))+min_num_pages);
return @random_pages;
end //
delimiter ;

