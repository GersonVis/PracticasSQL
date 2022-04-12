-- JOIN
-- sentence: select alias_table1.column_name, alias_table2.column_name 
-- from table_name1 as alias_table1 inner join table_name2  as alias_table2
-- inner join common_column=common_column where conditions;
/* This sentence unites two or more tables they have to have some field in common */
-- example:
select lib.titulo, aut.nombre 
from autores as aut 
inner join libros as lib 
on lib.autor_id=aut.autor_id;
-- other examples

select lib.libro_id, lib.titulo, aut.nombre, aut.autor_id
from libros as lib
inner join autores as aut
using(autor_id);

-- USING
-- sentence: select alias_table1.column_name, alias_table2.column_name
-- from table1 as alias_table1 inner join table2 as alias_table2 using(column_name_union);
/* Description: we can used it only if it is the same column on the both sides */
-- example:
select lib.titulo, aut.nombre
from autores as aut
inner join libros as lib
using(autor_id);

-- left join or left outer join
-- sentence: select columns_name from table1 left join/left outer join table2 on table1.column_name=table2.column name;
/* Description: Shows the register in the firsts table, if the register doesn't exist it shows null*/
select usuarios.nombre, usuarios.usuario_id, usu_lib.libro_id
from usuarios
left join usuarios_libros as usu_lib
on usuarios.usuario_id=usu_lib.usuario_id;

select usuarios.nombre, usuarios.usuario_id, usu_lib.libro_id
from usuarios
left outer join usuarios_libros as usu_lib
on usuarios.usuario_id=usu_lib.usuario_id;

-- right join or right outer join
-- sentence: select tabla_a.column_a from table_a right join table_b on table_a.column_b=table_b.column_b;
/* Description: shows registers in the table on with registers in the table from and null if isn't */

select usuarios.nombre, usu_lib.libro_id from usuarios_libros as usu_lib 
right join usuarios
on usu_lib.usuario_id=usuarios.usuario_id where usu_lib.libro_id is not null; 

-- multiples joins
-- sentence: select table1.column_name from table1 inner join table2 on using(equal_column) inner join table3 on equal_column_table2=equeal_column_table2;
/* Join with different tables */
-- get the users that rent a book with autor without pseudonym in this month

select usu.nombre, lib.titulo, aut.nombre, aut.seudonimo from usuarios as usu
inner join usuarios_libros as usu_lib on usu.usuario_id=usu_lib.usuario_id 
and month(usu_lib.fecha_creacion)=month(curdate()) and year(usu_lib.fecha_creacion)=year(curdate())
inner join libros as lib using(libro_id)
inner join autores as aut on lib.autor_id=aut.autor_id and aut.seudonimo is null; 

-- CROSS JOIN
-- setence: select table1.column_name1 from table1 cross join table2 on table1.equal_column=table2.equal_column;
-- Description: make all posibles joins
-- example:
-- cross join libros autores, all posible combinatios:
select usu.usuario_id, lib.libro_id from usuarios as usu
cross join libros as lib;
-- insert all posible combinations into a table
insert into usuarios_libros(usuario_id, libro_id) select usuarios.usuario_id, libros.libro_id from usuarios cross join libros;git