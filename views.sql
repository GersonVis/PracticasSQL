-- VIEWS
-- sentence: create view name_view as
-- select column_name from table or you can make any sentence;
-- example:
-- view with the number of books rented per users
create VIEW cantidad_libros_prestados_vw as
select usuarios.usuario_id, usuarios.nombre, count(usuarios.usuario_id) from usuarios
inner join usuarios_libros on usuarios.usuario_id=usuarios_libros.usuario_id group by usuario_id;

-- drop view
-- sentence: drop view view_name
/* description: Delete a view */
-- example
drop view cantidad_libros_prestados_vw;

-- create or replace 
-- create or replace name view new view statement
-- makes changes in a view, replace sentences for new sentences
-- example:
create or replace VIEW cantidad_libros_prestados_vw as
select usuarios.usuario_id, usuarios.nombre, count(usuarios.usuario_id) as Total from usuarios
inner join usuarios_libros on usuarios.usuario_id=usuarios_libros.usuario_id group by usuario_id;