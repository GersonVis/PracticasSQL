-- show engines
-- sentence: show engines;
/* description: show the database motor storage*/
show engines;
-- set storage_engine
-- sentence: set storage_engine=motordb;
/* description: change the STORE ENGINE */

set storage_engine=innodb;

-- create table with specific engine storage;
-- sentence: create name_table(columns) engine=engine_storage;
-- example:

create table innodb_table(name_anything varchar(25)) engine=innodb;

-- events
-- we make activate the events with the next sentence
set global event_scheduler=on;


-- create event
-- sentence: create event name_event on schedule at condition do sentences:
/* Description: make when the time comes */
-- examples:
-- insert registers after a five minutes
create event after_five_minutes
on schedule at current_timestamp + interval 1 minute
do insert into test values("evento lanzado", now());
-- insert and show content table
delimiter //
create event insertar_y_ver_tabla
on schedule at current_timestamp+interval 1 minute
do
begin 
   insert into test values("insertar y ver table", now());
   select * from test;
end //
delimiter ;

-- show events
-- sentence: show events;
/* description: show create events*/
show events;


-- drop event 
-- sentence: drop event event_name
/* description: cancel event */
-- example:
-- delete event guardar
delimiter //
create event guardar
on schedule at current_timestamp+interval 1 minute
do 
begin
   insert into test values("evento guardar", now());
   select * from test;
end //
delimiter ;
drop event guardar;

-- on completion preserve
-- sentence: create event event name on schedule at time on completion preserve do begin end;
-- example: 
delimiter //
create event evento_preservado
on schedule at current_timestamp + interval 1 minute
on completion preserve
do
begin 
   truncate test;
end //
delimiter ;

delimiter //
create event pr
on schedule at current_timestamp+interval 1 minute
on completion preserve
do 
begin
   truncate test;
end //
delimiter ;

-- every
-- description: do the event so event
set @contador=0;


delimiter //
create event registrar_suma
on schedule every 1 minute starts current_timestamp+interval 1 minute
ends current_timestamp+interval 5 minute
do
begin 
   insert into test values(concat("contador:", " ", @contador), now());
   set @contador=@contador+1;
end //
delimiter ;



create or replace event sumar
on schedule every 1 minute starts current_timestamp + interval 1 minute
ends current_timestamp + interval 5 minute
on completion preserve
do call sumar(@contador);

--every 20 secons
create or replace event sumar
on schedule every 20 second starts current_timestamp + interval 1 minute
ends current_timestamp + interval 5 minute
on completion preserve
do call sumar(@contador);

-- stop process
-- sentence: alter event disabled;
-- example:
alter event sumar disabled;
-- resume process
alter event sumar enable;

-- stop all process
 set global event_scheduler=off;

delimiter //
create or replace event actu
on schedule every 20 second starts current_timestamp + interval 1 minute
ends current_timestamp + interval 5 minute
 do
 begin
    set @valor=0;
    set @valor=(select variables.valor from variables where variables.nombre_variable="contador");
    call actualizar("contador", @valor+1, @valor);
    insert into test values(@valor, now());
 end //
 delimiter ;
 ;

 select * from test;