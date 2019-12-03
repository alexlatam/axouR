﻿/*
**
 * Author:  EUTUXIA
 * Created: 26/02/2018
 */

CREATE DATABASE GENERALES;

/* TABLA DE CONFIGURACION GENERAL */
CREATE TABLE CONFIGURACION (
    ID INT AUTO_INCREMENT,
    ATRIBUTO VARCHAR(25),
    VALOR VARCHAR(250),
    ESTATUS INT,

    PRIMARY KEY (ID),
    UNIQUE (ATRIBUTO)
);
/* IMAGENES DE LA PAGINA PPAL */
/*
TIPO
1- Fotos del Banner principal
2- Fotos de instagram
*/
CREATE TABLE IMAGENES (
    ID INT AUTO_INCREMENT,
    URLIMAGEN VARCHAR(250),
    ENLACE VARCHAR(250),
    TIPO INT,
    TARGET VARCHAR(25),
    ESTATUS INT,

    PRIMARY KEY (ID),
    UNIQUE (URLIMAGEN)
);

CREATE TABLE ADMIN_USUARIOS (
    IDUSUARIO INT AUTO_INCREMENT,
    NOMBRE VARCHAR(25),
    CORREO VARCHAR(30),
    CLAVE VARCHAR(50),
    NIVEL  INT,
    CREADO_EN TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (IDUSUARIO),
    UNIQUE (CORREO)
);

INSERT INTO `USUARIOS`(`NOMBRE`, `CORREO`,`CLAVE`, `NIVEL` ) VALUES ('admin','admin', MD5('admin'), '1');

CREATE TABLE USUARIOS (
    IDUSUARIO INT AUTO_INCREMENT,
    NOMBRE VARCHAR(25),
    APELLIDO VARCHAR(25),
    DOCUMENTOID VARCHAR(30),
    TELEFONO VARCHAR(30),
    CORREO VARCHAR(30),
    CLAVE VARCHAR(50),
    CREADO_EN TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (IDUSUARIO),
    UNIQUE (CORREO)
);

CREATE TABLE PRODUCTOS (
    IDPRODUCTO INT AUTO_INCREMENT,
    IDCATEGORIA INT,
    IDMARCA INT,
    NOMBRE_P VARCHAR(30),
    DESCRIPCION VARCHAR(500),
    CANTIDAD INT,
    PRECIO FLOAT,
    CREADO_EN TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (IDPRODUCTO)

);
/* F A V O R I T O S */
CREATE TABLE FAVORITOS (
  IDFAVORITO INT AUTO_INCREMENT,
  USERID INT,
  MODELOID INT,
  CREADO_EN TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  PRIMARY KEY (IDFAVORITO)
);
/*ACTUALIZADO 14 DE AGOSTO 2019*/
/* CATEGORIA */
CREATE TABLE CATEGORIAS(
  IDCATEGORIA INT AUTO_INCREMENT,
  PADRE INT,
  NOMBRE VARCHAR(30),
  CREADO_EN TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  PRIMARY KEY (IDCATEGORIA),
  UNIQUE(NOMBRE)
);

/** M A R C A S **/
CREATE TABLE MARCAS(
    IDMARCA INT AUTO_INCREMENT,
    NOMBREMARCA VARCHAR(25),
    CREADO_EN TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (IDMARCA),
    UNIQUE (NOMBREMARCA)
);
/** T A L L A S **/
CREATE TABLE TALLAS(
    IDTALLA INT AUTO_INCREMENT,
    TALLA VARCHAR(25),
    CREADO_EN TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (IDTALLA),
    UNIQUE (TALLA)
);
/******sistema de compra y envios Rouxa******/
/*
ESTATUS
0-'Por Pagar'
1-'Pago Fallido';
2-'Pago pendiente';
3-'Por Buscar';
4-'Por empaquetar' ;
5-'Por enviar';
6-'Enviado';
7-'Completado';
10-'Bajo Revisión';
*/
CREATE TABLE PEDIDOS (
    IDPEDIDO INT AUTO_INCREMENT,
    EMAILUSER VARCHAR(50),
    ESTATUS INT,
    FECHAPEDIDO DATETIME,
    CREADO_EN TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (IDPEDIDO)
);
CREATE TABLE COMPRAS (
    IDCOMPRA INT AUTO_INCREMENT,
    PEDIDOID INT,
    MONTO DOUBLE,
    FECHAPAGO DATETIME,

    PRIMARY KEY (IDCOMPRA),
    FOREIGN KEY (PEDIDOID) REFERENCES PEDIDOS(IDPEDIDO)
    ON DELETE CASCADE
);

CREATE TABLE ITEMS (
    IDITEMS INT AUTO_INCREMENT,
    PEDIDOID INT,
    PRODUCTOID INT ,
    CANTIDAD INT UNSIGNED,
    PRECIO DOUBLE,

    PRIMARY KEY (IDITEMS),
    FOREIGN KEY (PEDIDOID) REFERENCES PEDIDOS(IDPEDIDO)
    ON DELETE CASCADE
);
CREATE TABLE ENVIOS (
    IDENVIO  INT AUTO_INCREMENT,
    PEDIDOID INT,
    ESTADO VARCHAR(30),
    MUNICIPIO VARCHAR(30),
    DIRECCION VARCHAR(200) ,
    CODIGOPOSTAL VARCHAR(20),
    RECEPTOR VARCHAR(30),
    CIRECEPTOR VARCHAR(40),
    TELFRECEPTOR VARCHAR(30),
    ENCOMIENDA VARCHAR(15),
    GUIA VARCHAR(50),

    PRIMARY KEY (IDENVIO),
    FOREIGN KEY (PEDIDOID) REFERENCES PEDIDOS(IDPEDIDO)
    ON DELETE CASCADE

);
/* TABLA DE MUNICIPIOS */
CREATE TABLE MUNICIPIOS (
    IDMUNICIPIO INT AUTO_INCREMENT,
    MUNICIPIO VARCHAR(255),
    ESTADO VARCHAR(255),

    PRIMARY KEY (IDMUNICIPIO)
);
/*
eSTATUS DEL TICKETS
ESTATUS=9
  POR USAR
ESTATUS=99
  USADO
ESTATUS!=(99 OR 9)
  ERROR
*/
CREATE TABLE TICKETS (
    IDTICKET VARCHAR(32),
    IDPEDIDO VARCHAR(32),
    ESTATUS INT,
    COMENTARIO TEXT,

    PRIMARY KEY (IDTICKET),
    FOREIGN KEY (IDPEDIDO) REFERENCES PEDIDOS(IDPEDIDO)
    ON DELETE CASCADE
);
/*
  Estutus
  0 - Pago por Validar.
  1 - Pago Exitoso.
  2-  Pago rechazado.
*/
CREATE TABLE PAGOS (
    IDPAGO INT AUTO_INCREMENT,
    IDPEDIDO VARCHAR(32),
    BANCOEMISOR VARCHAR(250),
    BANCORECEPTOR VARCHAR(250),
    MONTO DOUBLE,
    MONEDA VARCHAR(20),
    REFERENCIA VARCHAR (100),
    FECHAPAGO DATE,
    ESTATUS INT,

    PRIMARY KEY (IDPAGO),
    FOREIGN KEY (IDPEDIDO) REFERENCES PEDIDOS(IDPEDIDO)
    ON DELETE CASCADE
);


/******sistema de compra y envios Rouxa******/
CREATE TABLE VARIABLES (
    IDVARIABLE INT AUTO_INCREMENT,
    NOMBRE VARCHAR(10),
    VALUE INT,

    PRIMARY KEY (IDVARIABLE)
);
/*
SIMBOLOGIA

VPP-visitas de pagina principal
CS-compras solicitadas
CF-compras fallidas
CE-compras exitosas
CP-compras pendientes
*/
/*Creacion de variables iniciales */
INSERT INTO `VARIABLES`(`NOMBRE`, `VALUE`) VALUES ('VPP','0');
INSERT INTO `VARIABLES`(`NOMBRE`, `VALUE`) VALUES ('CS','0');
INSERT INTO `VARIABLES`(`NOMBRE`, `VALUE`) VALUES ('CF','0');
INSERT INTO `VARIABLES`(`NOMBRE`, `VALUE`) VALUES ('CE','0');
INSERT INTO `VARIABLES`(`NOMBRE`, `VALUE`) VALUES ('CP','0');

INSERT INTO `VARIABLES`(`NOMBRE`, `VALUE`) VALUES ('TASAUSD','1');
/*creacidon de tabla de falla - 24 de abril de 2018*/
CREATE TABLE FALLAS (
    IDFALLA  INT AUTO_INCREMENT,
    IDPEDIDO VARCHAR(32),
    REPORTERO VARCHAR (25),
    ESTATUS INT,
    ORIGEN VARCHAR(25),
    PROBLEMA VARCHAR(150),
    SOLUCION VARCHAR(150),
    FECHAFALLA DATETIME,
    FECHASOLUCION DATETIME,

    PRIMARY KEY (IDFALLA)
);
