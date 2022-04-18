/*cursor make sentences of a data_list*/
-- example: 
-- increment the number of pages for book
delimiter //
create or replace procedure reasignar_hojas()
begin
    -- variables sacadas del registro 
       declare var_titulo varchar(50);
       declare var_libro_id int;
       declare var_paginas int;
    -- fin vars
    declare var_condicion int default 0;
    
    declare registro cursor for select paginas, libro_id, titulo from libros;

    declare continue handler for not found set var_condicion=1;


    open registro;
    
    recorrer:loop
        fetch registro into var_paginas, var_libro_id, var_titulo;
        if var_condicion=1 then
           LEAVE recorrer;
        end if;
        update libros set paginas=20 where libro_id=var_libro_id;
        select var_titulo as "Titulo", var_paginas as "Paginas anteriores";
    end loop recorrer;
    close registro;
end //
delimiter ;
;



-- put the categoria before the title
delimiter //
create or replace procedure cambiar_nombre()
begin
     -- variables to occuppy
        declare libro_id int;
        declare titulo varchar(25);
        declare categoria varchar(35);
        declare contador int default 0;
        declare titulo_nuevo varchar(250);
     -- end variables to occuppy
     -- variable del bucle
     declare var_condicion int default 0;
     declare registro cursor for select libros.libro_id, libros.titulo, categorias.nombre_categoria  
                                 from libros inner join categorias using(categoria_id);
     declare continue handler for not found set var_condicion=1;
     open registro;
     recorrer:loop
        fetch registro into libro_id, titulo, categoria;
        if var_condicion=1 then
           LEAVE recorrer;
        end if;
        select libro_id, titulo, categoria, contador;
        set titulo_nuevo=concat(categoria, " ",titulo);
        update libros set libros.titulo=titulo_nuevo where libros.libro_id=libro_id;
        select titulo as "Titulo anterior", titulo_nuevo as "Nuevo titulo"; 
        
     end loop recorrer;
     close registro;
end //
delimiter ;
call cambiar_nombre();




delimiter //
create or replace procedure titulos()
begin
    declare var_titulo varchar(150);
   
    declare var_condicion int default 0;
    declare registro cursor for select titulo from libros;
    declare continue handler for not found set var_condicion=1;
    
    open registro;
    recorrer: loop
        fetch registro into var_titulo;
        select var_titulo as Titulo;
    end loop recorrer;
    close registro;
end //
delimiter ;

-- random category 
delimiter //
create or replace procedure categoria_random()
begin 
    declare var_continuidad int default 0;
      declare var_libro_id int;
      declare var_categoria_id int;
      declare random_categoria int;
      declare opciones_posibles int;
      declare var_nombre_categoria varchar(150);
      declare var_titulo varchar(150);
      declare var_nueva_categoria varchar(150);

    declare registro cursor for select libros.titulo, libros.libro_id, libros.categoria_id, categorias.nombre_categoria
    from libros inner join categorias;
    declare continue handler for not found set var_continuidad=1;
    set opciones_posibles=(select count(categoria_id) from categorias)-1;
    open registro;
    recorrer: loop
        fetch registro into var_titulo, var_libro_id, var_categoria_id, var_nombre_categoria; 
        if var_continuidad=1 then
            LEAVE recorrer;
        end if;
        set random_categoria=round(rand()*opciones_posibles)+1;
        update libros set categoria_id=random_categoria where libro_id=var_libro_id;
        set var_nueva_categoria=(select nombre_categoria from categorias where categoria_id=random_categoria);
        select var_titulo as Titulo, var_nombre_categoria as "Categoria anterior", var_nueva_categoria as "Nueva categoria";
    end loop recorrer;
    close registro;
end //
delimiter ;
;
call categoria_random();
;