use school;
drop table books;
drop table authors;
show tables from school;

create table authors(
 author_id integer unsigned PRIMARY KEY AUTO_INCREMENT,
 first_name varchar(30) not null,
 last_name varchar(30) not null,
 pseudonym varchar(25) unique,
 sex ENUM('M', 'F'),
 birth_date DATE,
 country_origin varchar(40),
 create_date datetime default current_timestamp
);

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
create table users(
      user_id int unsigned primary key AUTO_INCREMENT,
      first_name varchar(25) not null,
      last_name varchar(25),
      user_name varchar(25) not null,
      email varchar(25) not null,
      creation_date datetime default current_timestamp
);

create table usuarios_libros(
    libro_id int unsigned not null,
    usuario_id int unsigned not null,
    
    foreign key(libro_id) references libros(libro_id),
    foreign key(usuario_id) references usuarios(usuario_id),
    fecha_creacion datetime default current_timestamp
);
insert into usuarios
-- foreign key (author_id) references authors(author_id)
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
-- this is wrong, dont exist the author id
-- this is integration reference, we can´t used keys that don´t exist
-- we get the following wrong
--ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`school`.`books`, CONSTRAINT `books_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `authors` (`author_id`))
insert into books(author_id, title, book_description, pages, publication_date)
values(3, "Hora de aventura", "Book about a child", 83, "2010-12-23");

insert into users values(null, "Gerson", "Visoso", "ghostlife", "visoso@gmail.com", null),
                         (null, "Juan", "Castro", "runFast", "runfast@gmail.com", null);


create table usuarios_libros(
    libro_id int unsigned not null,
    usuario_id int unsigned not null,
    
    foreign key(libro_id) references libros(libro_id),
    foreign key(usuario_id) references usuarios(usuario_id),
    fecha_creacion datetime default current_timestamp
);
insert into usuarios values(1,1), (2,1), (3,1);