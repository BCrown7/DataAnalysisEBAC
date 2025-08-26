CREATE TABLE dbo.Clientes (
	IdCliente INT NOT NULL IDENTITY,
	NombreCliente VARCHAR(255),
	PrimerApellido VARCHAR(255),
	SegundoApellido VARCHAR(255),
	Domicilio VARCHAR(255),
	Telefono VARCHAR(255),
	Email VARCHAR(255),
	PRIMARY KEY (IdCliente)
	);

CREATE TABLE dbo.Ordenes (
	IdOrden INT NOT NULL IDENTITY PRIMARY KEY,
	Fecha DATE,
	Cantidad INT,
	PrecioTotal DECIMAL(18,2),
	IdCliente INT NOT NULL,
	CONSTRAINT CHK_PrecioTotal CHECK (PrecioTotal>0),
	CONSTRAINT FK_OrdenCliente FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente),
	);

CREATE TABLE dbo.Puestos (
		IdPuesto INT NOT NULL IDENTITY PRIMARY KEY,
		NombrePuesto VARCHAR(255),
		Departamento VARCHAR(255),
		Sueldo DECIMAL (18,2),
		CONSTRAINT CHK_Sueldo CHECK (Sueldo>0),
		);

CREATE TABLE dbo.Empleados (
		IdEmpleado INT NOT NULL IDENTITY PRIMARY KEY,
		Nombre VARCHAR(150),
		PrimerApellido VARCHAR(150),
		SegundoApellido VARCHAR(150),
		FechaDeNacimiento DATE,
		Domicilio VARCHAR(255),
		Telefono INT,
		Email VARCHAR(255),
		FechaContratacion DATE,
		IdPuesto INT NOT NULL,
		CONSTRAINT FK_PuestoEmpleado FOREIGN KEY (IdPuesto) REFERENCES Puestos(IdPuesto)
		);

CREATE TABLE dbo.Sucursales (
	IdSucursal INT NOT NULL IDENTITY PRIMARY KEY,
	Domicilio VARCHAR(255),
	Horario VARCHAR(50),
	IdEmpleado INT NOT NULL,
	CONSTRAINT FK_EmpleadoSucursal FOREIGN KEY (IdEmpleado) REFERENCES Empleados(IdEmpleado)
	);

CREATE TABLE dbo.Proveedores (
	IdProveedor INT NOT NULL IDENTITY PRIMARY KEY,
	NombreProveedor VARCHAR(255),
	Contacto VARCHAR(50),
	Domicilio VARCHAR(255),
	Telefono VARCHAR(50),
	Email VARCHAR(150),
	IdSucursal INT NOT NULL,
	CONSTRAINT FK_ProveedorSucursal FOREIGN KEY (IdSucursal) REFERENCES Sucursales(IdSucursal)
	);

CREATE TABLE dbo.Productos (
	IdProducto INT NOT NULL IDENTITY PRIMARY KEY,
	NombreProducto VARCHAR(255),
	SKU VARCHAR(50),
	Categoria VARCHAR(255),
	PrecioProducto DECIMAL (18,2),
	Calidad VARCHAR(50),
	IdProveedor INT NOT NULL,
	CONSTRAINT CHK_PrecioProducto CHECK (PrecioProducto>0),
	CONSTRAINT FK_ProveedorProducto FOREIGN KEY (IdProducto) REFERENCES Proveedores(IdProveedor)
	);

CREATE TABLE dbo.DetalleOrden (
	IdOrdenDetalle INT NOT NULL IDENTITY PRIMARY KEY,
	Cantidad INT,
	PrecioUnitario DECIMAL(18,2),
	IdOrden INT NOT NULL,
	IdProducto INT NOT NULL,
	CONSTRAINT CHK_PrecioUnitario CHECK (PrecioUnitario>0),
	CONSTRAINT FK_OrdenDetalleOrden FOREIGN KEY (IdOrden) REFERENCES Ordenes(IdOrden),
	CONSTRAINT FK_ProductoDetalleOrden FOREIGN KEY (IdProducto) REFERENCES Productos(IdProducto),
	);