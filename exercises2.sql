select distinct usuarios.usuario_id, usuarios.nombre from usuarios
left join usuarios_libros 
on usuarios.usuario_id=usuarios_libros.usuario_id where usuarios_libros.libro_id is not null;

select distinct usuarios.usuario_id, usuarios.nombre from usuarios
left join usuarios_libros 
on usuarios.usuario_id=usuarios_libros.usuario_id where usuarios_libros.libro_id is null;


select usuarios.usuario_id, usuarios.nombre, count(usuarios_libros.libro_id) as Prestados
from usuarios
inner join usuarios_libros using(usuario_id) group by usuarios.usuario_id order by Prestados desc limit 5;

select libros.titulo, count(usuarios_libros.libro_id) as veces_prestados
from usuarios_libros
inner join libros
using(libro_id) 
where usuarios_libros.fecha_creacion >= curdate() - INTERVAL 30 day 
group by (libros.libro_id)
order by veces_prestados desc limit 5;

-- Obtener el título de todos los libros que no han sido prestados
select libros.titulo
from usuarios_libros
right join libros
using(libro_id) where usuarios_libros.libro_id is null;
-- Obtener la cantidad de libros prestados el día de hoy.
select count(libro_id) as "Libros prestados"
from usuarios_libros
where date(fecha_creacion)=curdate();


-- Obtener la cantidad de libros prestados por el autor con id 1.
select count(libro_id) as "Libros prestados"
from usuarios_libros where usuario_id=1;

-- Obtener el nombre completo de los cinco autores con más préstamos
select concat(autores.nombre," ",autores.apellido) as nombre_completo, count(usuarios_libros.libro_id) as prestamos
from autores
inner join libros using(autor_id)
inner join usuarios_libros using(libro_id) group by libros.autor_id order by prestamos desc limit 5;

-- Obtener el título del libro con más préstamos esta semana.
select libros.titulo as titulo, count(libro_id) as prestamos
from usuarios_libros
inner join libros
using (libro_id)
group by libro_id
order by prestamos desc limit 1;
