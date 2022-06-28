use TiendaVirtual
select * from Categoria_Producto
select * from Usuarios
select * from Productos
select * from Compra
select * from Detalle_Compra


execute InsertarUsuario 'Jean','Zarate',77200457,'09-07-2001','indeoendencia 345', 956867986
exec ActualizarUsuario  10002,'Jose', 'zarate','idenpendencia 223',999336444
execute EliminarUsuario 10000


exec InsertarCategoria 'juguetes'
exec EliminarCategoria 7
exec ActualizarCategoria 7, 'jugueteria'


exec InsertarProducto 'destornillador', 100,6,'master',10.99
exec EliminarProducto 101
exec ActualizarProducto 107, 'paquete de destornilladores',50,6, 'master', 25.99

exec InsertarCompra 10002,103,'PENDIENTE',1

select nombre as nombre_usuario, dbo.ProductoVendido(10002) as cantidad from Usuarios where id_usuario= 10002
