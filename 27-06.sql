create database TiendaVirtual
use TiendaVirtual
--Creamos la tabla categoria productos
create table Categoria_Producto
(
id_categoria_P int identity(1,1) primary key,
nombre_categoria varchar(50) not null
);

--Creamos la tabla usuarios
create table Usuarios
(
id_usuario int identity(10000,1) primary key,
nombre varchar(50) not null,
apellido varchar(50) not null,
dni nchar(8) not null,
fecha_nacimiento date,
direccion varchar(100),
celular nchar(9)
);

--Creamos la Tabla Productos
create table Productos
(
id_producto int identity(100,1) primary key,
nombre_producto varchar(50) not null,
stock int not null,
id_categoria_P int  not null,
marca varchar(25) not null,
precio decimal(9,2)
Constraint fk_Categoria_P foreign key (id_categoria_P) references Categoria_Producto(id_categoria_P) 
);


--Creamos la tabla Compra
create table Compra
(
id_compra int identity(1000,1) primary key,
id_usuario int not null,
id_producto int not null,
estado varchar(25) check(estado='Pendiente' or estado='Cancelado' or estado='Entregado'),
fecha_compra date not null,
cantidad int,
Constraint fk_Usuario_id foreign key (id_usuario) references Usuarios(id_usuario) ,
Constraint fk_Productos_id foreign key (id_producto) references Productos(id_producto),

);



--Crear tabla Detalle Compra
create table Detalle_Compra
(
id_detalle__compra int identity(1000,1) primary key,
id_compra int not null,
cantidad int not null,
precio_total decimal(9,2),
Constraint fk_Compra_id foreign key (id_compra) references Compra(id_compra) 
);


go


--------------------------Procedimientos almacenados


-----Procedimiento para agregar Usuario
create procedure InsertarUsuario
(
@nombre varchar(50) ,
@apellido varchar(50) ,
@dni nchar(8),
@fecha_nacimiento date,
@direccion varchar(100),
@celular nchar(9)
)
as
begin try
	insert into Usuarios (nombre,apellido,dni,fecha_nacimiento,direccion,celular) 
	values(@nombre,@apellido,@dni,@fecha_nacimiento,@direccion,@celular)
end try
begin catch 
	select ERROR_MESSAGE() AS 'Error al insertar usuario'
end catch
go

execute InsertarUsuario 'Jean','Zarate',77200457,'09-04-2001','indeoendencia 345', 956867986


select * from Usuarios
-----Procedimiento para eliminar Usuario
go
create procedure EliminarUsuario
(
@id_usuario int
)
as
begin try
	delete Usuarios where id_usuario = @id_usuario
end try
begin catch 
	select ERROR_MESSAGE() AS 'Error al eliminar Usuario'
end catch
go

execute EliminarUsuario 10000

---------Procedimiento para actualizar
go
create procedure ActualizarUsuario
(
@id_usuario int ,
@nombre varchar(50),
@apellido varchar(50) ,
@direccion varchar(100),
@celular nchar(9) 

)
as
begin try
	update Usuarios set nombre = @nombre,
					    apellido = @apellido,
						direccion = @direccion,
						celular = @celular where id_usuario = @id_usuario
end try
begin catch 
	select ERROR_MESSAGE() AS 'Error al actualizar Usuario'
end catch
go

exec ActualizarUsuario  10001,'Jorge', 'Galban','Miraflores 204',234098855

-------Procedimiento para insertar Categoria
go 
create procedure InsertarCategoria
(
@nombre_categoria varchar(50)
)
as 
begin try
	insert into Categoria_Producto(nombre_categoria) values(@nombre_categoria)
end try
begin catch 
	select ERROR_MESSAGE() AS 'Error al insertar categoria'
end catch
go

exec InsertarCategoria herramientas

select * from Categoria_Producto

-------Procedimiento para eliminar Categoria
go 
create procedure EliminarCategoria
(
@id_categoria_P int
)
as 
begin try
		delete Categoria_Producto where id_categoria_P = @id_categoria_P
end try
begin catch 
	select ERROR_MESSAGE() AS 'Error al eliminar categoria'
end catch
go
exec EliminarCategoria 2

-------Procedimiento para actualizar Categoria
go 
create procedure ActualizarCategoria
(
@id_categoria_P int,
@nombre_categoria varchar(50)
)
as 
begin try
		update Categoria_Producto set nombre_categoria = @nombre_categoria where id_categoria_P = @id_categoria_P
end try
begin catch 
	select ERROR_MESSAGE() AS 'Error al actualizar categoria'
end catch
go

exec ActualizarCategoria 3, 'Deporte'

go
----------------Procedimiento para agregar producto
Create procedure InsertarProducto
(
@nombre_producto varchar(50) ,
@stock int ,
@id_categoria_P int,
@marca varchar(25),
@precio decimal(9,2)
)
as
begin  try
	Insert into Productos(nombre_producto,stock,id_categoria_P,marca,precio) values(@nombre_producto,@stock,
	@id_categoria_P,@marca,@precio)
end try
begin catch 
	select ERROR_MESSAGE() AS 'Error al insertar producto'
end catch
go

exec InsertarProducto 'microndas faster', 25,5,'faster',509.99
select * from Productos 

-----------------Procedimiento para eliminar producto
go
create procedure EliminarProducto
(
@id_producto int
)
as 
begin try
		delete Productos where id_producto = @id_producto
		
end try
begin catch 
	select ERROR_MESSAGE() AS 'Error al eliminar Producto'
end catch
go
exec EliminarProducto 101
 
 -----------------Procedimiento para actualizar producto
go
create procedure ActualizarProducto
(
@id_producto int ,
@nombre_producto varchar(50) ,
@stock int ,
@id_categoria_P int ,
@marca varchar(25) ,
@precio decimal(9,2)
)
as 
begin try
		update Productos set nombre_producto = @nombre_producto,
							 stock = @stock,
							 id_categoria_P= @id_categoria_P,
							 marca=@marca,
							 precio= @precio where id_producto= @id_producto;
end try
begin catch 
	select ERROR_MESSAGE() AS 'Error al actualizar Producto'
end catch
go

exec ActualizarProducto 102, 'Laptop xiaomi',8,1, 'Xiaomi', 2500.99

 -----------------Procedimiento para ingresar compra
 go
 Create procedure InsertarCompra
(
@id_usuario int ,
@id_producto int ,
@estado varchar(25) ,
@cantidad int
)
as
begin  try
	Insert into Compra(id_usuario,id_producto,estado,fecha_compra,cantidad) values(@id_usuario,@id_producto,
	@estado,GETDATE(),@cantidad)

end try
begin catch 
	select ERROR_MESSAGE() AS 'Error al agregar compra'
end catch
go

exec InsertarCompra 10001,106,'PENDIENTE',2
select * from Compra

 -----------------Procedimiento para actualizar compra

 go
 Create procedure ActualizarCompra
(
@id_compra int,
@estado varchar(25)
)
as
begin  try
	update Compra set estado = @estado where id_compra = @id_compra
	
end try
begin catch 
	select ERROR_MESSAGE() AS 'Error al actualizar compra'
end catch
go

exec ActualizarCompra 1013,'Pendiente'

 -----------------Procedimiento para agregar detalles compra
 go
 Create procedure agregardetallesCompra
(

@id_compra int,
@cantidad int ,
@precio_total decimal(9,2)
)
as
begin  try
	Insert into Detalle_Compra(id_compra,cantidad,precio_total) values(@id_compra,@cantidad,@precio_total)
end try
begin catch 
	select ERROR_MESSAGE() AS 'Error al agregar detalles de compra'
end catch
go
select * from Detalle_Compra
go
---------Trigger

create trigger realizar_compra
on Compra after insert as
begin 
	declare @cantidad int, @id_producto int,@id_compra int,@precio decimal(9,2)
	
	 Select @cantidad = (Select cantidad from inserted)
	 Select @id_producto = (Select id_producto from inserted)
	 Select @id_compra = (Select id_compra from inserted)

	 update Productos set stock = stock - @cantidad
	 where id_producto= @id_producto


	 Select @precio= precio from Productos
	 Declare @preciototal decimal(9,2) = @precio * @cantidad

	 insert into Detalle_Compra(id_compra,cantidad,precio_total) values (@id_compra,@cantidad,@preciototal)
	 
	
end

drop trigger realizar_compra
go
create trigger actualizarcompra_tg
on Compra after update as
begin 
	declare @cantidad int, @id_producto int, @estado varchar(20),@id_compra int,@precio decimal(9,2)
	
	 Select @cantidad = (Select cantidad from inserted)
	 Select @id_producto = (Select id_producto from inserted)
	 Select @estado = (Select estado from inserted)
	 Select @id_compra = (Select id_compra from inserted)
	 
	 if (@estado = 'Cancelado')
	 begin
		update Productos set stock = stock + @cantidad
		where id_producto= @id_producto

		delete Detalle_Compra where id_compra = @id_compra
	 end

	  if (@estado = 'Pendiente')
	 begin
		update Productos set stock = stock - @cantidad
		where id_producto= @id_producto

		Select @precio= precio from Productos
		Declare @preciototal decimal(9,2) = @precio * @cantidad
		insert into Detalle_Compra(id_compra,cantidad,precio_total) values (@id_compra,@cantidad,@preciototal)
	 end
	 
end

-----------Funcion
--Crear funcion del producto mas vendido 
go
create function ProductoVendido(@id_usuario int) returns int
as

begin
declare @cantidad_compras int
select @cantidad_compras = sum(cantidad) from Compra WHERE id_usuario = @id_usuario
return @cantidad_compras
end


go
select * from Compra

select nombre as nombre_usuario, dbo.ProductoVendido(10002) as cantidad from Usuarios where id_usuario= 10002


backup database TiendaVirtual to disk = 'D:\SQL2019\backupSQL\RespaldoTiendaVirtual.bak'
with differential 


