/*
 the transactions works when if you want to go back to before the changes
*/
-- sentence: start transaction
-- sentences
-- commit if we want save changes/ rollback if we want dont save the changes
-- example
start transaction;
set @libro_id=1;
set @usuario_id=1;
update libros set stock=stock-1 where libro_id=@libro_id;
insert into libros_usuarios(usuario_id, libro_id) values(@libro_id, @usuario_id); 
commit;-- apply changes
-- or
rollback; -- cancel changes
/* if you make commit you cant make rollback*/
-- declare EXIT HANDLER FOR SQLEXCEPTION
-- BEGIN 
-- END;
/* do it if happen a error */
-- register wich user caused an error, when he tries to get a loan
delimiter //
create or replace procedure prestamo(usuario_id int, libro_id int)
begin 
    declare EXIT HANDLER FOR SQLEXCEPTION
    begin
       rollback;
       insert into error_prestamo(usuario_id) values (usuario_id);
       select * from error_prestamo;
    end;
    start transaction;
    insert into libros_usuarios(usuario_id, libro_id) values(usuario_id, libro_id);
    update libros set stock=stock-1 where libros.libro_id=libro_id;
    commit;
end //
delimiter ;
;

call prestamo(10, 3);
