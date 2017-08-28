
drop database if exists veterinaria;
create database veterinaria;

use veterinaria;

create table personas(
personaId int not null primary key,
nombre nvarchar(60) not null,
apellidos nvarchar(120) not null,
fecreg datetime default current_timestamp
);

##agregasd jasjkhd k saj nkjask uka sdnakjjk j
alter table personas add contra nvarchar(60);

create table tipoMascota(
mascotaTipoId int not null primary key,
mascotaTipo nvarchar(60)
);

create table mascotas(
mascotaId int not null primary key,
mascotaTipoId int not null,
personaId int not null,
nombre nvarchar(120),
fecreg datetime default current_timestamp,
constraint fk_MascotaId foreign key (mascotaTipoId) references tipoMascota(mascotaTipoId),
constraint fk_PersonaId foreign key (personaId) references personas(personaId)
);

drop view if exists vwPersonaMascotas;
create view vwPersonaMascotas
as
select p.personaId, concat(p.nombre, ' ', p.apellidos) as Cliente, 
	tm.mascotaTipo tipo, m.nombre, m.mascotaId
 from personas p
			inner join mascotas m on p.personaId = m.personaId
            inner join tipoMascota tm on m.mascotaTipoId = tm.mascotaTipoId;


select * from vwPersonaMascotas;


drop procedure if exists spGuardaCliente;
delimiter **
create procedure spGuardaCliente(in perID int, in nom nvarchar(120), in aps nvarchar(120), in psw nvarchar(60))
begin
declare IdPer int;
declare existe int;
declare msj nvarchar(200);

set IdPer = 0;

if perID = 0 then
	
    set existe = (select count(*) from personas where nombre = nom and apellidos = aps);
    
    
    if (existe = 0)  then

		set IdPer = (select ifnull(max(personaId), 0) + 1 from personas);
        
		insert into personas (personaId, nombre, apellidos, fecreg, contra)
					values(IdPer, nom, aps, current_timestamp(), md5(psw));
                    
		set msj =  'Cliente guardado con exito';
    
    else
		set msj =  'ese cliente ya esta dado de alta papu :v';

    end if;
    
else
set IdPer = perID;

	if((select count(*) from personas where nombre = nom and apellidos = aps) = 1) then
		set msj =  'actualizo';
        
        update personas set nombre = nom , apellidos = aps where personaId = perId;
        
        
    else
		set msj =  'no existe';
    end if;
end if;

select msj, IdPer;

end; **
delimiter ;

drop procedure if exists spTraeTodo;
delimiter **
create procedure spTraeTodo()
begin
	select *, concat('<a href="borraMascota.jsp?md="',(mascotaId*3),'a','&dp=','b',(personaId)*6) as borra from vwPersonaMascotas;
end; **
delimiter ;


drop procedure if exists spGuardaMascota;
delimiter **
create procedure spGuardaMascota(in masId int, in tipoMasId int, in nom nvarchar(120), in perId int)
begin
declare existe int;
declare msj nvarchar(200);
declare IdMascota int;
declare errorId int;

set errorId = 0;


##verificamos si existe la persona
set existe = (select count(*) from personas where personaId = perId);

if (existe = 1) then
	##validamos que la persona no tenga elmismo tipo y nombre de mascota
	set existe = (select count(*) from mascotas where personaId = perId and mascotaTipoId = tipoMasId  and nombre = nom);
    if(existe = 0) then
		## validamos que exista el tipo de Mascota
		set existe = (select count(*) from tipoMascota where mascotaTipoId = tipoMasId);
        
        if(existe = 1) then
			set IdMascota = (select ifnull(max(mascotaId), 0) + 1 from mascotas);
			insert into mascotas(mascotaId, mascotaTipoId, nombre, personaId)
					values (IdMascota, tipoMasId, nom, perId);
			set msj = 'mascota guardada :v';
		else
			set msj = 'no existe ese tipo de mascota';
            set errorId = 1;
        end if;
    else
		set msj = 'ya tienes una mascota con ese nombre y tipo';
        set errorId = 1;
    end if;
else
	set msj = 'no existe la persona';
    set errorId = 1;
end if;

select msj, perId, errorId;
end; **
delimiter ;


drop procedure if exists spBorraMascotaXnombre;
delimiter **
create procedure spBorraMascotaXnombre(in perId int, in nombreMas nvarchar(200), in tipo int)
begin
declare existe int;
declare msj nvarchar(200);
declare masId int;



end; **
delimiter ;






drop procedure if exists spBorraMascotaXid;
delimiter **
create procedure spBorraMascotaXid(in perId int, in masId int)
begin
declare existe int;
declare regreso varchar(200);

	set existe = (select count(*) from mascotas where personaId = perId and mascotaId = masId );
    if(existe = 1) then
		delete from mascotas where personaId = perId and mascotaId = masId;
        set regreso = 'mascota eliminada :V';
	else
		set regreso = concat( 'no existe esa mascota  de la persona con el id: ', perId);
    end if;
    
    ##call spGuardaBitacora(concat(regreso, sadsadsada));
    select regreso as Mensajito;
end; **
delimiter ;


delimiter **
create procedure spGuardaBitacora(in accion nvarchar(1000))
begin

	insert into bitacora values(accion);

end; **
delimiter ;


drop procedure if exists spValidaUsuario;
delimiter **
create procedure spValidaUsuario(in usr nvarchar(200), in psw  nvarchar(60))
begin
declare existe int;
declare msj nvarchar(200);
declare idPer int;


set existe = (select count(*) from personas where nombre = usr and contra = md5(psw));

if (existe = 1) then

	set msj = 'oc';
	select personaId as idPer, concat(nombre, ' ', apellidos) NombreC, msj from personas where nombre = usr and contra = md5(psw);

else
	set msj = 'no existe el papu :v';
	select 0 as idPer, msj;

end if;



end; **
delimiter ;


drop procedure if exists spDatosPersona;
delimiter $$
create procedure spDatosPersona(in idper int)
begin

	select *, concat('<b><i>', nombre, ' ', apellidos, '</i></b>') as NombreC from personas where personaId = idper;

end; $$
delimiter ;

insert into tipoMascota values(1, 'gato');
insert into tipoMascota values(2, 'perro');
insert into tipoMascota values(3, 'pez');

call spGuardaCliente(0, 'tarzan x2', 'Osiris x2', 'laMia x2');
call spGuardaMascota(0, 2, 'lentre las sombras', 2);
call spBorraMascotaXid(1, 1);
call spValidaUsuario('tarzan x2', 'laMia x2');
call spDatosPersona(3);

select * from tipoMascota;

select * from personas;
call spTraeTodo();













