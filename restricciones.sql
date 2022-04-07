/*the restriction are for not insert
corrupt logs*/
--we can´t insert register, with incorrect type
--author_id is of type int
--this is wrong
set @@SESSION.sql_mode='STRICT_TRANS_TABLES';
--or global
set @@GLOBAL.sql_mode='STRICT_TRANS_TABLES';
--this is wrong
insert into authors(author_id) values("gerson");
--it fills it all with null
insert into authors() values();
--change the mode to  strict mode

--constraint not null
create table authors(
 author_id int not null,
 first_name varchar(30) not null,
 last_name varchar(30) not null,
 sex char(1),
 birth_date DATE,
 country_origin varchar(40)
);
--we insert registers
insert into authors(author_id, first_name, last_name, sex, birth_date, country_origin)
values
(1, "Test author", "Test autor", "M", "2022-01-30", "México"),
(2, "Test author", "Test autor", "M", "2022-01-30", "México"),
(3, "Test author", "Test autor", "M", "2022-01-30", "México"),
(4, "Test author", "Test autor", "M", "2022-01-30", "México"),
(5, "Test author", "Test autor", "M", "2022-01-30", "México"),
(6, "Test author", "Test autor", "M", "2022-01-30", "México");
--we add the attribute pseudonym, with constraint not repeat 
create table authors(
 author_id int not null,
 first_name varchar(30) not null,
 last_name varchar(30) not null,
 pseudonym varchar(25) unique,
 sex char(1),
 birth_date DATE,
 country_origin varchar(40)
);
--we add the new registers with the new changes
insert into authors(author_id, first_name, pseudonym, last_name, sex, birth_date, country_origin)
values
(1, "Test author", "Test pseudonym", "Test autor", "M", "2022-01-30", "México"),
(2, "Test author", "Test pseudonym", "Test autor", "M", "2022-01-30", "México"),
(3, "Test author", "Test pseudonym", "Test autor", "M", "2022-01-30", "México"),
(4, "Test author", "Test pseudonym", "Test autor", "M", "2022-01-30", "México"),
(5, "Test author", "Test pseudonym", "Test autor", "M", "2022-01-30", "México"),
(6, "Test author", "Test pseudonym", "Test autor", "M", "2022-01-30", "México");
--we will have the next wrong  "Duplicate entry 'Test pseudonym' for key 'pseudonym'"
--we can do, don't insert unique attribute
insert into authors(author_id, first_name, last_name, sex, birth_date, country_origin)
values
(1, "Test author", "Test autor", "M", "2022-01-30", "México"),
(2, "Test author", "Test autor", "M", "2022-01-30", "México"),
(3, "Test author", "Test autor", "M", "2022-01-30", "México");
--insert real author
insert into authors(author_id, first_name, last_name, pseudonym, sex, birth_date, country_origin)
values(10, 'Stephen Edwin', 'King', 'Richard Batchmann', 'M', '197-09-27', 'USA');
--if we try to insert the same register, we will get the following wrong
-- Duplicate entry 'Richard Batchmann' for key 'pseudonym'


--Default values
--use the word default
create table authors(
 author_id int not null,
 first_name varchar(30) not null,
 last_name varchar(30) not null,
 pseudonym varchar(25) unique,
 sex char(1),
 birth_date DATE,
 country_origin varchar(40),
 create_date datetime default current_timestamp
);
--know the exactly time
select current_timestamp;
--or
select now();
--insert register with negative number, example
insert into authors(author_id, first_name, last_name, pseudonym, sex, birth_date, country_origin)
values(-10, 'Stephen Edwin', 'King', 'Richard Batchmann', 'M', '197-09-27', 'USA');
--prevent the insert negative numbers with the word unsigned
create table authors(
 author_id int unsigned not null,
 first_name varchar(30) not null,
 last_name varchar(30) not null,
 pseudonym varchar(25) unique,
 sex char(1),
 birth_date DATE,
 country_origin varchar(40),
 create_date datetime default current_timestamp
);
--the system show the folling wrong
--ERROR 1264 (22003): Out of range value for column 'author_id' at row 1
insert into authors(author_id, first_name, last_name, pseudonym, sex, birth_date, country_origin)
values(-10, 'Stephen Edwin', 'King', 'Richard Batchmann', 'M', '197-09-27', 'USA');

--type enum
/*Description: Enum if for short options, less five, three, two, the options will not change*/
--we will change the sex attribute for two options, M and F
create table authors(
 author_id int unsigned not null,
 first_name varchar(30) not null,
 last_name varchar(30) not null,
 pseudonym varchar(25) unique,
 sex ENUM('M', 'F'),
 birth_date DATE,
 country_origin varchar(40),
 create_date datetime default current_timestamp
);
--this is incorrect, the j isn´t option
insert into authors(author_id, first_name, last_name, pseudonym, sex, birth_date, country_origin)
values(1, 'Stephen Edwin', 'King', 'Richard Batchmann', 'J', '197-09-27', 'USA');
--this is correct, you can just occupy the M or the F
insert into authors(author_id, first_name, last_name, pseudonym, sex, birth_date, country_origin)
values(1, 'Stephen Edwin', 'King', 'Richard Batchmann', 'M', '197-09-27', 'USA');


--primary keys
--you can not repeat this attibute, no need to use not null and unique, becouse
-- the reserved word 'primary key' is already not null and is not repeat
--reserved word PRIMARY KEY, AUTO_INCREMENT, it increment the register, you dont need to do anything
create table authors(
 author_id int unsigned PRIMARY KEY AUTO_INCREMENT,
 first_name varchar(30) not null,
 last_name varchar(30) not null,
 pseudonym varchar(25) unique,
 sex ENUM('M', 'F'),
 birth_date DATE,
 country_origin varchar(40),
 create_date datetime default current_timestamp
);
--is not need used the primary key name in the insert 
insert into authors(first_name, last_name, pseudonym, sex, birth_date, country_origin)
values('Stephen Edwin', 'King', 'Richard Batchmann', 'M', '1907-09-27', 'USA'),
      ('John locke', 'Morga', 'Mercurio', 'F', '2000-09-27', 'France');
--foreign key
--we create the books table
create table books(
      book_id integer unsigned primary key AUTO_INCREMENT,
      title varchar(50) not null,
      book_description varchar(250),
      pages integer unsigned,
      publication_date date not null,
      create_date datetime default current_timestamp
)
-- add the foreign key to the table, we must use "foreign key" followed him by the attribute name
-- example statement foreign key (column) references table_name(reference_column)
-- first create table with primay key and after the table with foreign key
create table books(
      book_id integer unsigned primary key AUTO_INCREMENT,
      author_id integer unsigned not null,
      title varchar(50) not null,
      book_description varchar(250),
      pages integer unsigned,
      publication_date date not null,
      create_date datetime default current_timestamp,
      foreign key(author_id) references to authors(author_id)
)
-- we insert register first in the table with primary key
insert into authors(first_name, last_name, pseudonym, sex, birth_date, country_origin)
values('Stephen Edwin', 'King', 'Richard Batchmann', 'M', '1907-09-27', 'USA'),
      ('John locke', 'Morga', 'Mercurio', 'F', '2000-09-27', 'France');
-- insert registers into table books, remember the foreign key is a reference to authors, must exist
insert into books(author_id, title, book_description, pages, publication_date)
values(1, "Hora de aventura", "Book about a child", 83, "2010-12-23"),
      (1, "Hora de aventura", "Book about a child", 63, "2000-12-23"),
      (2, "Juego de tronos", "Book about the powe", 43, "2020-12-23"),
      (2, "El imperio", "Book about the war", 23, "2012-12-23");