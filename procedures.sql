-- create procedure
-- sentece: create procedure procedure_name 
-- begin
--  logic
-- end
/* description: is a function but without return */

-- make producedure reduce in one and to update prestamo
delimiter //
create or replace procedure hacer_prestamo(usuario_id int, libro_id int)
begin
   insert into prestamos(usuario_id, libro_id) values(usuario_id, libro_id);
   update libros set stock=stock-1 where libros.libro_id=libro_id;
   select * from libros where libros.libro_id=libro_id;
   select * from prestamos where prestamos.usuario_id=usuario_id and prestamos.libro_id=libro_id;
end //
delimiter ;

-- other examples
delimiter //
create procedure restablecer_prestamos()
begin
   truncate table prestamos;
end//
delimiter ;


-- call procedure_name
-- sentence: call procedure_name(vals);
/* Description: Call a procedure with vals in constructor */
-- example:
call hacer_prestamo(1,2);

-- drop procedure;
-- sentence: drop procedure procedure_name;
/* description: Delete procedure */
-- example:
drop procedure hacer_prestamo;


-- get data of a procedure
-- sentence:
-- set @name_var;
-- create procedure name_procedure(out name_var)
-- begin
--  logic
--  set name_var=consult;
-- end;
/* Description: get value changed inside a procedure */
-- example:
-- get the title of the borrowed book
set @titulo="";
delimiter //
create or replace procedure prestar(usuario_id int, libro_id int, out titulo varchar(200))
begin
   insert into libros_usuarios(usuario_id, libro_id) values(usuario_id, libro_id);
   update libros set stock=stock-1 where libros.libro_id=libro_id;
   set titulo=(select libros.titulo from libros where libros.libro_id=libro_id);
end //
delimiter ;
call prestar(1,4,@titulo);
select @titulo;

-- IF ELSEIF ELSE
-- sentence IF conditions then elseif condition then sentences else sentences end if;
/* Description: Logic sentences with conditions */
-- example:

-- make a loand if the user has less than five loans and get book title, if he has two loans show "you have one more loan"
delimiter //
create or replace procedure prestamo_posible(usuario_id int, libro_id int, out titulo varchar(25))
begin
  declare pr_he integer;
  set pr_he=(select count(libros_usuarios.usuario_id) from libros_usuarios where libros_usuarios.usuario_id=usuario_id);
  select pr_he as Conteo;
  if pr_he<4 then
     insert into libros_usuarios(usuario_id, libro_id) values(usuario_id, libro_id);
     select "Prestamo realizado" as Mensaje;
  elseif pr_he<5 then
      set titulo=NULL;
      insert into libros_usuarios(usuario_id, libro_id) values(usuario_id, libro_id);
      select "Este es tu último prestamo" as Advertencia;
  else
      set titulo=NULL;
      select "No tienes prestamos disponibles" as Mensaje;
   end if;
end//
truncate libros_usuarios//
delimiter ;

call prestamos_a_usuarios();
call prestamo_posible(1,2, @titulo);
-- other examples
delimiter //
create or replace procedure prestamos_a_usuarios()
begin
  select usuario_id, count(usuario_id) from libros_usuarios group by usuario_id; 
end//
delimiter ;


-- case use
-- sentence case 
-- when condition then
-- when condition then
-- when condition then
-- else;
-- end case;
/* Description: makes conditios for each case */
-- example:
-- get book category
set @cantidad_libros=0;
delimiter //
create or replace procedure categoria(categoria varchar(25), out cantidad_libros int)
begin
    case
       when categoria="terror" then
         select * from terror;
       when categoria="comedia" then
         select * from comedia;
       when categoria="aventura" then
         select * from aventura;
       else
         select * from categoria;
    end case;
end//
delimiter ;

-- while
-- sentence: while condition do logic end while;
/* bucle if the condition is true, end if is false */
-- example:
-- get a random book from a random category
set @libro="";
delimiter //
create or replace procedure random_book(out libro varchar(25))
begin
    declare categoria_random varchar(250);
    declare categorias_posibles int;
    declare random_posicion int;
    declare libros_posibles int;
    set categorias_posibles=(select count(*) from categorias);
    set random_posicion=round(rand()*(categorias_posibles-1));
    set categoria_random=(select categoria_id from categorias order by nombre_categoria limit random_posicion, 1);
    set libros_posibles=(select count(categoria_id) from libros where categoria_id=categoria_random);
    set random_posicion=round(rand()*(libros_posibles-1));
    set libro=(select titulo from libros where categoria_id=categoria_random limit random_posicion, 1);
    select libro as "Titulo", (select nombre_categoria from categorias where categoria_id=categoria_random) as Categoria; 
end //
delimiter ;
call random_book(@libro);
select @libro;
;

function 
 -- set titulo=(select titulo from categoria_random limit 1);
 -- set categoria_random=(select categoria from categorias order by categoria limit count());
    declare libro_ramdon varchar(40);
    select * from libros;

delimiter //
create or replace function numero_random(inicio int, maximo int)
returns int
begin
  return inicio+round(rand()*maximo);
end//
delimiter ;

-- get 4 random books
--  example
delimiter //
set @libro="";
create or replace procedure obtener_random_books(cantidad int)
begin
  declare contador int;
  set contador=0;
  while contador<=cantidad do
     call random_book(@libro);
     set contador=contador+1;
  end while;
end//
delimiter ;
;
-- Repeat
-- sentece: repeat logic until condition_false end repeat;
/* description: does while the condition is false */
delimiter //
create or replace procedure categoria_random(cantidad int)
begin
  declare numero_random int;
  declare casos_posibles int;
  declare contador int;
  set contador=0;
  set casos_posibles=(select count(categoria_id) from categorias)-1;
  repeat 
    set contador=contador+1;
    set numero_random=round(rand()*casos_posibles);
    select * from categorias order by categoria_id limit numero_random, 1;
  until contador>=cantidad end repeat;
end //
delimiter ;
call categoria_random(5);
;

delimiter //
create or replace procedure sumar(out contador int)
begin 
    insert into test values(concat("contador: ", " ", @contador), now());
    set contador=contador+1;
end //
delimiter ;

set @valor="";

delimiter //
create or replace procedure actualizar(variable varchar(25), nuevo_valor varchar(25), out valor varchar(50))
begin
  if (select count(*) from variables where variables.nombre_variable=variable)=0 then
     insert into variables values(variable, nuevo_valor);
  else
     -- update variables set variables.valor=nuevo_valor where variables.nombre_variable=nuevo_valor;
      update variables set variables.valor=nuevo_valor where variables.nombre_variable=variable;   
  end if;
  set valor=(select variables.valor from variables where variables.nombre_variable=variable);
end //
delimiter ;
call actualizar("ger", "son", @valor);
select @valor;
select * from variables;
;

 