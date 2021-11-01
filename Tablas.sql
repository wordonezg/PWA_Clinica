SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `Pacientes`;
DROP TABLE IF EXISTS `Medicamentos`;
DROP TABLE IF EXISTS `Farmaceuticas`;
DROP TABLE IF EXISTS `HistorialMedico`;
DROP TABLE IF EXISTS `Empleados`;
DROP TABLE IF EXISTS `Puestos`;
DROP TABLE IF EXISTS `Clinicas`;
DROP TABLE IF EXISTS `Internados`;
DROP TABLE IF EXISTS `Habitaciones`;
DROP TABLE IF EXISTS `ClinicaHabitacion`;
DROP TABLE IF EXISTS `InventarioClinica`;
DROP TABLE IF EXISTS `Citas`;
DROP TABLE IF EXISTS `Compras`;
DROP TABLE IF EXISTS `Ventas`;
DROP TABLE IF EXISTS `CompraDetalles`;
DROP TABLE IF EXISTS `Proveedores`;
DROP TABLE IF EXISTS `VentaDetalles`;
DROP TABLE IF EXISTS `Cientes`;
DROP TABLE IF EXISTS `InternadoDetalles`;
DROP TABLE IF EXISTS `Servicios`;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE `Pacientes` (
	`IdPaciente` INT NOT NULL,
	`Nombres` VARCHAR(150) NOT NULL,
	`Apellidos` VARCHAR(150) NOT NULL,
	`FechaNacimiento` DATE NOT NULL,
	`Dpi` VARCHAR(20) NOT NULL,
	`Telefono` VARCHAR(15) NOT NULL,
	`Direccion` VARCHAR(200) NOT NULL,
	`Email` VARCHAR(80) NOT NULL,
	`Nit` VARCHAR(15) NOT NULL,
	PRIMARY KEY (`IdPaciente`)
);

CREATE TABLE `Medicamentos` (
	`CodigoMedicamento` INT NOT NULL,
	`Nombre` VARCHAR(100) NOT NULL,
	`Descripcion` VARCHAR(250) NOT NULL,
	`FechaProduccion` DATE NOT NULL,
	`FechaVencimiento` DATE NOT NULL,
	`IdFarmaceutica` INT NOT NULL,
	`Costo` DECIMAL(8,2) NOT NULL,
	`PrecioVenta` DECIMAL(8,2) NOT NULL,
	PRIMARY KEY (`CodigoMedicamento`)
);

CREATE TABLE `Farmaceuticas` (
	`IdFarmaceutica` INT NOT NULL,
	`Nombre` VARCHAR(100) NOT NULL,
	`Direccion` VARCHAR(200) NOT NULL,
	`Telefono` VARCHAR(15) NOT NULL,
	`Email` VARCHAR(80) NOT NULL,
	PRIMARY KEY (`IdFarmaceutica`)
);

CREATE TABLE `HistorialMedico` (
	`IdHistorial` INT NOT NULL,
	`IdPaciente` INT NOT NULL,
	`Examen` VARCHAR(500) NOT NULL,
	`Fecha` DATETIME NOT NULL,
	`Diagnostico` VARCHAR(500) NOT NULL,
	PRIMARY KEY (`IdHistorial`)
);

CREATE TABLE `Empleados` (
	`CodigoEmpleado` INT NOT NULL,
	`Nombres` VARCHAR(150) NOT NULL,
	`Apellidos` VARCHAR(150) NOT NULL,
	`FechaNacimiento` DATE NOT NULL,
	`Dpi` VARCHAR(20) NOT NULL,
	`Telefono` VARCHAR(15) NOT NULL,
	`CodigoPuesto` INT NOT NULL,
	`IdClinica` INT NOT NULL,
	PRIMARY KEY (`CodigoEmpleado`)
);

CREATE TABLE `Puestos` (
	`CodigoPuesto` INT NOT NULL,
	`Nombre` VARCHAR(100) NOT NULL,
	PRIMARY KEY (`CodigoPuesto`)
);

CREATE TABLE `Clinicas` (
	`IdClinica` INT NOT NULL,
	`Nombre` VARCHAR(100) NOT NULL,
	`Direccion` VARCHAR(200) NOT NULL,
	`Telefono` VARCHAR(15) NOT NULL,
	PRIMARY KEY (`IdClinica`)
);

CREATE TABLE `Internados` (
	`CodigoInternado` INT NOT NULL,
	`IdClinica` INT NOT NULL,
	`IdPaciente` INT NOT NULL,
	`FechaInternado` DATETIME NOT NULL,
	`IdHabitacion` INT NOT NULL,
	`FechaEgreso` DATETIME NOT NULL,
	PRIMARY KEY (`CodigoInternado`)
);

CREATE TABLE `Habitaciones` (
	`IdTipoHabitacion` INT NOT NULL,
	`TipoHabitacion` VARCHAR(100) NOT NULL,
	`PrecioNoche` DECIMAL(8,2) NOT NULL,
	PRIMARY KEY (`IdTipoHabitacion`)
);

CREATE TABLE `ClinicaHabitacion` (
	`IdHabitacion` INT NOT NULL,
	`IdClinica` INT NOT NULL,
	`IdTipoHabitacion` INT NOT NULL,
	`NoHabitacion` INT NOT NULL,
	`Capacidad` INT NOT NULL,
	PRIMARY KEY (`IdHabitacion`)
);

CREATE TABLE `InventarioClinica` (
	`RowId` INT NOT NULL,
	`CodigoMedicamento` INT NOT NULL,
	`IdClinica` INT NOT NULL,
	`Existencia` INT NOT NULL,
	`Lote` VARCHAR(20) NOT NULL,
	PRIMARY KEY (`RowId`)
);

CREATE TABLE `Citas` (
	`CodigoCita` INT NOT NULL,
	`FechaHora` DATETIME NOT NULL,
	`IdPaciente` INT NOT NULL,
	`IdClinica` INT NOT NULL,
	`FechaCita` INTEGER NOT NULL
);

CREATE TABLE `Compras` (
	`NoCompra` INT NOT NULL,
	`FechaHora` DATETIME NOT NULL,
	`Direccion` VARCHAR(200) NOT NULL,
	`CodigoProveedor` INT NOT NULL,
	`IdClinica` INT NOT NULL,
	PRIMARY KEY (`NoCompra`)
);

CREATE TABLE `Ventas` (
	`NoVenta` INT NOT NULL,
	`FechaHora` DATETIME NOT NULL,
	`Direccion` VARCHAR(200) NOT NULL,
	`CodigoCliente` INT NOT NULL,
	`IdClinica` INT NOT NULL,
	PRIMARY KEY (`NoVenta`)
);

CREATE TABLE `CompraDetalles` (
	`RowId` INT NOT NULL,
	`NoCompra` INT NOT NULL,
	`Linea` INT NOT NULL,
	`CodigoMedicamento` INT NOT NULL,
	`PrecioUnitario` DECIMAL(8,2) NOT NULL,
	`Cantidad` INT NOT NULL,
	`Lote` VARCHAR(20) NOT NULL,
	PRIMARY KEY (`RowId`)
);

CREATE TABLE `Proveedores` (
	`CodigoProveedor` INT NOT NULL,
	`Nombre` VARCHAR(100) NOT NULL,
	`Nit` VARCHAR(15) NOT NULL,
	`Telefono` VARCHAR(15) NOT NULL,
	`Direccion` VARCHAR(200) NOT NULL,
	PRIMARY KEY (`CodigoProveedor`)
);

CREATE TABLE `VentaDetalles` (
	`RowId` INT NOT NULL,
	`NoVenta` INT NOT NULL,
	`Linea` INT NOT NULL,
	`CodigoMedicamento` INT NOT NULL,
	`PrecioUnitario` DECIMAL(8,2) NOT NULL,
	`Cantidad` INT NOT NULL,
	`Lote` VARCHAR(20) NOT NULL,
	PRIMARY KEY (`RowId`)
);

CREATE TABLE `Cientes` (
	`CodigoCliente` INT NOT NULL,
	`Nombres` VARCHAR(150) NOT NULL,
	`Apellidos` VARCHAR(150) NOT NULL,
	`Nit` VARCHAR(15) NOT NULL,
	`Telefono` VARCHAR(15) NOT NULL,
	`Direccion` VARCHAR(200) NOT NULL,
	`Email` VARCHAR(80) NOT NULL,
	PRIMARY KEY (`CodigoCliente`)
);

CREATE TABLE `InternadoDetalles` (
	`RowId` INT NOT NULL,
	`CodigoInternado` INT NOT NULL,
	`Linea` INT NOT NULL,
	`CodigoServicio` INT NOT NULL,
	`Cantidad` INT NOT NULL,
	`PrecioUnitario` Decimal(8,2) NOT NULL,
	PRIMARY KEY (`RowId`)
);

CREATE TABLE `Servicios` (
	`CodigoServicio` INT NOT NULL,
	`Descripcion` VARCHAR(300) NOT NULL,
	PRIMARY KEY (`CodigoServicio`)
);

ALTER TABLE `Medicamentos` ADD FOREIGN KEY (`IdFarmaceutica`) REFERENCES `Farmaceuticas`(`IdFarmaceutica`);
ALTER TABLE `Empleados` ADD FOREIGN KEY (`CodigoPuesto`) REFERENCES `Puestos`(`CodigoPuesto`);
ALTER TABLE `Empleados` ADD FOREIGN KEY (`IdClinica`) REFERENCES `Clinicas`(`IdClinica`);
ALTER TABLE `Internados` ADD FOREIGN KEY (`IdHabitacion`) REFERENCES `ClinicaHabitacion`(`IdHabitacion`);
ALTER TABLE `ClinicaHabitacion` ADD FOREIGN KEY (`IdClinica`) REFERENCES `Clinicas`(`IdClinica`);
ALTER TABLE `ClinicaHabitacion` ADD FOREIGN KEY (`IdTipoHabitacion`) REFERENCES `Habitaciones`(`IdTipoHabitacion`);
ALTER TABLE `InventarioClinica` ADD FOREIGN KEY (`CodigoMedicamento`) REFERENCES `Medicamentos`(`CodigoMedicamento`);
ALTER TABLE `InventarioClinica` ADD FOREIGN KEY (`IdClinica`) REFERENCES `Clinicas`(`IdClinica`);
ALTER TABLE `Compras` ADD FOREIGN KEY (`IdClinica`) REFERENCES `Empleados`(`IdClinica`);
ALTER TABLE `Ventas` ADD FOREIGN KEY (`CodigoCliente`) REFERENCES `Cientes`(`CodigoCliente`);
ALTER TABLE `Ventas` ADD FOREIGN KEY (`IdClinica`) REFERENCES `Clinicas`(`IdClinica`);
ALTER TABLE `CompraDetalles` ADD FOREIGN KEY (`NoCompra`) REFERENCES `Compras`(`NoCompra`);
ALTER TABLE `VentaDetalles` ADD FOREIGN KEY (`CodigoMedicamento`) REFERENCES `Medicamentos`(`CodigoMedicamento`);
ALTER TABLE `VentaDetalles` ADD FOREIGN KEY (`NoVenta`) REFERENCES `Ventas`(`NoVenta`);
ALTER TABLE `InternadoDetalles` ADD FOREIGN KEY (`CodigoInternado`) REFERENCES `Internados`(`CodigoInternado`);
ALTER TABLE `InternadoDetalles` ADD FOREIGN KEY (`CodigoServicio`) REFERENCES `Servicios`(`CodigoServicio`);