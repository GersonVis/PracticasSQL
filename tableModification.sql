-- Instructions for modifying tables
-- alter table
-- add column to table books, with the following characteristics,nmes sales, type int, not null, not negative
-- begint null, puts 0
-- note, existing data, put zero, but you can insert without the new column
alter table books add sales int unsigned not null;
-- add column with default value 10, not null, int type
alter table books add stock int unsigned not null default 10; 
-- delete column stock, with the following sentence
-- alter table table_name drop column_name
-- example
alter table books drop column stock;
-- rename table with the following sentence
-- alter table table_name rename new_table_name;
alter table books rename book;
-- we return to original name
alter table book rename books;
-- modify the data type
-- alter table table_name modify column_name new_datatype
alter table books modify email int;
-- other examples of alter table
alter table books add email varchar(25) not null default '';
alter table books add email varchar(25) not null default '' unique;
alter table books drop column email;
-- add column primary key
-- alter table table_name add column_name int not null primary key auto_increment;
-- example:
alter table users add user_id int not null PRIMARY KEY AUTO_INCREMENT; 
-- alter table with foreign key
-- create the column in the table
-- alter table table_name add constraint constraint_name foreign key(column_name) references table_name(colum_name)
alter table users add book_id int unsigned;
alter table users add constraint user_book foreign key(book_id) references books(book_id);
-- delete foreign key
-- alter table table_name drop foreign key column_name;
alter table users drop foreign key book_id;
-- delete column
alter table users drop column book_id;