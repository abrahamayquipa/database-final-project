CREATE DATABASE DATABASE_FINAL_PROJECT

USE DATABASE_FINAL_PROJECT

CREATE TABLE Proveedor(
	RUC CHAR(11) PRIMARY KEY CHECK(RUC >= 10000000000 AND RUC <= 99999999999),
	nombre VARCHAR(12) NOT NULL,
	telefono CHAR(9) NOT NULL CHECK(telefono >= 100000000 AND telefono <= 999999999) UNIQUE,
	productoProveido VARCHAR(15) NOT NULL
)

CREATE TABLE Empleado(
	DNI CHAR(8)  PRIMARY KEY CHECK(DNI >= 10000000 AND DNI <= 99999999),
	nombre VARCHAR(13) NOT NULL,
	apellidoPaterno VARCHAR(10) NOT NULL,
	apellidoMaterno VARCHAR(8) NOT NULL,
	telefono CHAR(9) NOT NULL CHECK(telefono >= 100000000 AND telefono <= 999999999),
	-- RECURSIVIDAD --
	DNI_FK CHAR(8) REFERENCES Empleado(DNI)
)

CREATE TABLE Cafeteria(
	idCafeteria VARCHAR(3) PRIMARY KEY CHECK(idCafeteria >= 0 AND idCafeteria <= 999),
	telefono CHAR(9) NOT NULL CHECK(telefono >= 100000000 AND telefono <= 999999999),
	aforo VARCHAR(2) NOT NULL CHECK(aforo >= 0 AND aforo <= 99),
	sede VARCHAR(10) NOT NULL
)

CREATE TABLE Turno(
	-- LLAVE COMPUESTA --
	DNI CHAR(8) REFERENCES Empleado,
	idCafeteria VARCHAR(3) REFERENCES Cafeteria,
	PRIMARY KEY(DNI, idCafeteria),

	horaInicio TIME NOT NULL,
	horaFin TIME NOT NULL
)

CREATE TABLE Producto(
	codigoProducto VARCHAR(3) PRIMARY KEY CHECK(codigoProducto >= 0 AND codigoProducto <= 100),
	nombre VARCHAR(10) NOT NULL,
	stock VARCHAR(3) NOT NULL CHECK(stock >= 0 AND stock <= 100),
	precio NUMERIC(6,2) NOT NULL CHECK(precio >= 0 AND precio <= 1000),
	fechaVencimiento DATE NOT NULL,
	peso NUMERIC(5,2) NOT NULL CHECK(peso >= 0 AND peso <= 100),
	-- LLAVE FORANEA --
	RUC CHAR(11) NOT NULL REFERENCES Proveedor
)

CREATE TABLE Almacen(
	codigoAlmacen VARCHAR(5) PRIMARY KEY CHECK(codigoAlmacen >= 10000 AND codigoAlmacen <= 99999),
	aforo VARCHAR(2) NOT NULL CHECK(aforo >= 0 AND aforo <= 99),
	capacidad VARCHAR(4) NOT NULL,
	-- LLAVE FORANEA --
	DNI CHAR(8) NOT NULL,
    idCafeteria VARCHAR(3) NOT NULL,
    FOREIGN KEY (DNI, idCafeteria) REFERENCES Turno(DNI, idCafeteria)
)

CREATE TABLE ProductoAlmacen(
	-- LLAVE COMPUESTA --
	codigoProducto VARCHAR(3) REFERENCES Producto,
	codigoAlmacen VARCHAR(5) REFERENCES Almacen,
	PRIMARY KEY(codigoProducto, codigoAlmacen)
)

CREATE TABLE AlmacenSeco(
	codigoAlmacen VARCHAR(5) PRIMARY KEY CHECK(codigoAlmacen >= 10000 AND codigoAlmacen <= 99999),
	codigoAlmacenFk VARCHAR(5) NOT NULL REFERENCES Almacen
)

CREATE TABLE AlmacenRefrigerado(
	codigoAlmacen VARCHAR(5) PRIMARY KEY CHECK(codigoAlmacen >= 10000 AND codigoAlmacen <= 99999),
	codigoAlmacenFk VARCHAR(5) NOT NULL REFERENCES Almacen
)

CREATE TABLE Reporte(
	numeroReporte VARCHAR(5) PRIMARY KEY,
	fecha DATE NOT NULL,
	hora TIME NOT NULL,
	tipoOperación VARCHAR(10) NOT NULL,
	nombreProducto VARCHAR(15) NOT NULL,
	CantidadFinal VARCHAR(4) CHECK(cantidadFinal >= 0 AND cantidadFinal <= 9999) NOT NULL,
	codigoAlmacen VARCHAR(5) NOT NULL REFERENCES Almacen
)

SELECT * FROM Producto