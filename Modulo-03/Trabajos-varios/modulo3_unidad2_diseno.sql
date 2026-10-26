create table clientes (
  id_cliente int,
  nombre varchar(100),
  perfil_bio varchar(max),
  fecha_registro date
  )

create table productos (
  id_producto int,
  descripcion varchar(255),
  precio decimal(10,2),
  esta_activo bit
  )

-- 
-- Se utilizaron datos "int" para los numeros enteros como los id que necesariamente van a ser enteros.
-- Se utilizaron datos varchar(100) y varchar(255) para texto que van a tener esa longitud como maximo.
-- Se utilizo varchar(max) ya que es una columna que va a incorporar un texto de longitud indeterminada.
-- Se utilizo date ya que se necesita aclarar la fecha y no un horario especifico.
-- Se utilizo decimal para determinar un precio con hasta un maximo de 2 decimales.
-- Se uitlizo bit para determinar de manera simple con 1 o 0, si el producto estaba activo o no.
