set @libros_con_seudonimo=(select count(libro_id)
from libros 
where autor_id in (select autor_id from autores where seudonimo is not null));

set @libros_sin_seudonimo=(select count(libro_id)
from libros where autor_id in (select autor_id from autores where seudonimo is null));

select @libros_con_seudonimo as "Con seudonimio", @libros_sin_seudonimo as "Sin seudonimio";

select count(libro_id) from libros where year(fecha_publicacion) between 2000 and 2005;

select titulo, ventas from libros order by ventas asc limit 5;
select titulo, ventas from libros 
where fecha_publicacion between curdate() - interval 10 year and curdate() order by ventas asc limit 5;

select title from books where author_id in(1,2,3);

select autor_id as autor, sum(ventas) from libros where autor_id in (1,2,3) group by autor_id;

select titulo,paginas from libros order by paginas desc limit 1;
select titulo from libros where titulo like("La%");
select titulo from libros where titulo regexp '^La.{1,}a$';
update libros set stock=0 where year(fecha_publicacion)<1995;

select if(
    exists(select libro_id from libros where libro_id=1 and stock>5),
    "Diposnible",
    "No disponible"
)as "Diponibilidad";

select titulo, fecha_publicacion from libros order by fecha_publicacion desc;

select nombre from autores where year(fecha_nacimiento)>1950;

select concat(nombre," ",apellido) as "Nombre completo", year(curdate())-year(fecha_nacimiento) as edad from autores; 

select concat(nombre, " ", apellido) as "Nombre completo" from autores where autor_id 
in(select autor_id from libros where year(fecha_publicacion)>2005);


select autor_id, sum(ventas) as ventas from libros group by autor_id having sum(ventas)>100000; 

delimiter //
create function puedo_prestar(libro_comprobar int)
returns varchar(20)
begin
  return if(exists(select libro_id from libros where libro_id=libro_comprobar and stock>1), "Disponible", "No disponible");
end//
delimiter ;
select titulo, ventas, max(ventas) from libros where ventas>900000 group by autor_id order by ventas desc;