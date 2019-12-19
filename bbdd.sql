﻿/*
**
 * Author:  EUTUXIA
 * Created: 19/12/2019
 */

CREATE DATABASE ROUXA;

USE ROUXA;
/* TABLA DE CONFIGURACION GENERAL */
CREATE TABLE CONFIGURACION (
    ID INT AUTO_INCREMENT,
    ATRIBUTO VARCHAR(25),
    VALOR VARCHAR(250),
    ESTATUS INT DEFAULT 0,

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
    ESTATUS INT DEFAULT 0,

    PRIMARY KEY (ID),
    UNIQUE (URLIMAGEN)
);

CREATE TABLE ADMIN_USUARIOS(
    IDUSUARIO INT AUTO_INCREMENT,
    NOMBRE VARCHAR(25),
    CORREO VARCHAR(30),
    CLAVE VARCHAR(50),
    NIVEL  INT,
    CREADO_EN TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (IDUSUARIO),
    UNIQUE (CORREO)
);

INSERT INTO `ADMIN_USUARIOS`(`NOMBRE`, `CORREO`,`CLAVE`, `NIVEL` ) VALUES ('admin','admin', MD5('admin'), '1');

CREATE TABLE USUARIOS (
    IDUSUARIO INT AUTO_INCREMENT,
    NOMBRE VARCHAR(25),
    APELLIDO VARCHAR(25),
    DOCUMENTOID VARCHAR(30),
    TELEFONO VARCHAR(30),
    RAZONSOCIAL VARCHAR(255),
    RIFCI VARCHAR(255),
    DIRFISCAL VARCHAR(255),
    CORREO VARCHAR(30),
    CLAVE VARCHAR(50),
    CREADO_EN TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (IDUSUARIO),
    UNIQUE (CORREO)
);

CREATE TABLE PRODUCTOS (
    IDPRODUCTO INT AUTO_INCREMENT,
    NOMBRE_P VARCHAR(30),
    DESCRIPCION TEXT,
    GENERO VARCHAR(30),
    CATEGORIAID INT,
    PRECIO FLOAT,
    MATERIAL VARCHAR(25),
    MARCAID INT,
    MANGA INT,
    CUELLO INT,
    ESTATUS INT DEFAULT 0,
    CREADO_EN TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (IDPRODUCTO)
);
CREATE TABLE MODELOS(
    IDMODELO INT AUTO_INCREMENT,
    IDPRODUCTO INT,
    COLOR1 INT,
    COLOR2 INT,
    IMAGEN VARCHAR(50),
    CREADO_EN TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (IDMODELO)
);
CREATE TABLE INVENTARIO(
    IDINVENTARIO INT AUTO_INCREMENT,
    IDMODELO INT,
    TALLAID INT,
    CANTIDAD INT,
    PESO DOUBLE,
    CREADO_EN TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (IDINVENTARIO)
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
  ESTATUS INT DEFAULT 0,
  CREADO_EN TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  PRIMARY KEY (IDCATEGORIA),
  UNIQUE(NOMBRE)
);

/** M A R C A S **/
CREATE TABLE MARCAS(
    IDMARCA INT AUTO_INCREMENT,
    NOMBREMARCA VARCHAR(25),
    ESTATUS INT DEFAULT 0,
    CREADO_EN TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (IDMARCA),
    UNIQUE (NOMBREMARCA)
);
/** T A L L A S **/
CREATE TABLE TALLAS(
    IDTALLA INT AUTO_INCREMENT,
    TALLA VARCHAR(10),
    ESTATUS INT DEFAULT 0,
    CREADO_EN TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (IDTALLA),
    UNIQUE (TALLA)
);
/** C O L O R E S **/
CREATE TABLE COLOR(
    IDCOLOR INT AUTO_INCREMENT,
    HEX VARCHAR(7),
    COLOR VARCHAR(15),
    ESTATUS INT DEFAULT 0,
    CREADO_EN TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (IDCOLOR),
    UNIQUE (COLOR)
);
/******sistema de compra y envios Rouxa******/
/*
ESTATUS
0-'Por Pagar'
1-'Pago Fallido';
2-'Pago pendiente';
3-'Por Buscar';
4-'Por empaquetar';
5-'Por enviar';
6-'Enviado';
7-'Completado';
8-'Cancelado';
10-'Bajo Revisión';
*/
CREATE TABLE PEDIDOS (
    IDPEDIDO INT AUTO_INCREMENT,
    EMAILUSER VARCHAR(30),
    ESTATUS INT DEFAULT 0,
    FECHAPEDIDO DATETIME,
    TEXTO VARCHAR(150),
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
    INVENTARIOID INT ,
    CANTIDAD INT UNSIGNED,
    PRECIO DOUBLE,

    PRIMARY KEY (IDITEMS),
    FOREIGN KEY (PEDIDOID) REFERENCES PEDIDOS(IDPEDIDO)
    ON DELETE CASCADE
);
CREATE TABLE ENVIOS (
    IDENVIO INT AUTO_INCREMENT,
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
    FACTFISCAL INT,

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
/*Insercion de municipios */
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Simón Bolívar','Anzoategui');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Anaco','Anzoategui');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Aragua','Anzoategui');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Diego Bautista Urbaneja','Anzoategui');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Fernando de Peñalver','Anzoategui');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Francisco del Carmen Carvajal','Anzoategui');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Francisco de Miranda','Anzoategui');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Guanta','Anzoategui');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Independencia','Anzoategui');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Jose Gregorio Monagas','Anzoategui');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Juan Antonio Sotillo','Anzoategui');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Juan Manuel Cajigal','Anzoategui');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Libertad','Anzoategui');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Manuel Ezequiel Bruzual','Anzoategui');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Pedro Maria Freites','Anzoategui');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Píritu','Anzoategui');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('San Jose de Guanipa','Anzoategui');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('San Juan de Capistrano','Anzoategui');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Santa Ana','Anzoategui');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Simón Rodríguez','Anzoategui');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Sir Arthur Mc Gregor','Anzoategui');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Atures','Anzoategui');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Alto Orinoco','Anzoategui');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Atabapo','Anzoategui');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Autana','Anzoategui');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Manapiare','Anzoategui');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Maroa','Anzoategui');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Río Negro','Anzoategui');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('San Fernando','Apure');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Achaguas','Apure');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Biruaca','Apure');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Muñoz','Apure');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Paéz','Apure');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Pedro Camejo','Apure');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Rómulo Gallegos','Apure');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Girardot','Aragua');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Bolívar','Aragua');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Camatagua','Aragua');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Francisco Linares Alcántara','Aragua');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Jose Ángel Lamas','Aragua');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Jose Félix Ribas','Aragua');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Jose Rafael Revenga','Aragua');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Libertador','Aragua');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Mario Birceño Iragorry','Aragua');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Ocumare','Aragua');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('San Casimiro','Aragua');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('San Sebastián','Aragua');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Santiago Mariño','Aragua');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Santos Michelena','Aragua');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Sucre','Aragua');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Tovar','Aragua');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Urdaneta','Aragua');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Zamora','Aragua');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Barinas','Barinas');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Alberto Arvelo Torrealba','Barinas');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Andres Eloy Blanco','Barinas');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Antonio Jose de Sucre','Barinas');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Arismendi','Barinas');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Bolívar','Barinas');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Cruz Paredes','Barinas');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Ezequiel Zamora','Barinas');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Obispos','Barinas');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Pedraza','Barinas');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Rojas','Barinas');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Sosa','Barinas');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Heres','Bolivar');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Angostura','Bolivar');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Caroní','Bolivar');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Cedeño','Bolivar');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('El Callao','Bolivar');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Gran Sabana','Bolivar');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Padre Pedro Chien','Bolivar');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Piar','Bolivar');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Roscio','Bolivar');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Sifontes','Bolivar');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Sucre','Bolivar');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Valencia','Carabobo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Bejuma','Carabobo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Carlos Arvelo','Carabobo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Diego Ibarra','Carabobo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Guacara','Carabobo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Juan Jose Mora','Carabobo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Libertador','Carabobo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Los Guayos','Carabobo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Miranda','Carabobo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Montalbán','Carabobo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Naguanagua','Carabobo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Puerto Cabello','Carabobo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('San Diego','Carabobo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('San Joaquin','Carabobo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Ezequiel Zamora','Cojedes');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Anzoategui','Cojedes');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Girardot','Cojedes');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Lima Blanco','Cojedes');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Pao de San Juan Bautista','Cojedes');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Ricaurte','Cojedes');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Rómulo Gallegos','Cojedes');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Tinaco','Cojedes');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Tinaquillo','Cojedes');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Tucupita','Delta Amacuro');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Antonio Diaz','Delta Amacuro');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Casacoima','Delta Amacuro');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Pedernales','Delta Amacuro');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Miranda','Falcon');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Acosta','Falcon');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Bolívar','Falcon');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Buchivacoa','Falcon');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Cacique Manuare','Falcon');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Carirubana','Falcon');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Colina','Falcon');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Dabajuro','Falcon');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Democracia','Falcon');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Falcón','Falcon');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Federación','Falcon');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Jacura','Falcon');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Los Teques','Falcon');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Mauroa','Falcon');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Monseñor Iturriza','Falcon');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Palama Sola','Falcon');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Petit','Falcon');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Píritu','Falcon');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('San Francisco','Falcon');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Silva','Falcon');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Sucre','Falcon');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Tocópero','Falcon');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Union','Falcon');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Urumaco','Falcon');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Zamora','Falcon');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Libertador','Distrito Capital');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Juan German Roscio','Guarico');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Camaguán','Guarico');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Chaguaramas','Guarico');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('El Socorro','Guarico');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Infante','Guarico');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Las Mercades','Guarico');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Mellado','Guarico');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Miranda','Guarico');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Monagas','Guarico');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Ortiz','Guarico');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Ribas','Guarico');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('san Geronimo de Guayabal','Guarico');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('San Jose de Guaribe','Guarico');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Santa Maria de Ipire','Guarico');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Zaraza','Guarico');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Iribarren','Lara');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Andrés Eloy Blanco','Lara');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Crespo','Lara');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Jimenéz','Lara');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Morán','Lara');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Palavecino','Lara');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Simón Planas','Lara');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Torres','Lara');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Urdaneta','Lara');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Libertador','Merida');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Alberto Adriani','Merida');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Andrés Bello','Merida');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Antonio Pinto Salinas','Merida');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Aricagua','Merida');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Arzobispo Chacón','Merida');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Campo Elías','Merida');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Caracciolo Parra Olmedo','Merida');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Cardenal Quintero','Merida');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Guaraque','Merida');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Julio César Salas','Merida');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Justo Briceño','Merida');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Miranda','Merida');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Obispo Ramos de Lora','Merida');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Padre Noguera','Merida');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Pueblo Llano','Merida');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Rangel','Merida');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Rivas Dávila','Merida');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Santos Marquina','Merida');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Sucre','Merida');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Tovar','Merida');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Tulio Febres Cordero','Merida');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Zea','Merida');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Guaicaipuro','Miranda');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Acevedo','Miranda');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Andrés Bello','Miranda');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Baruta','Miranda');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Brión','Miranda');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Buroz','Miranda');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Carrizal','Miranda');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Chacao','Miranda');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Cristóbal Rojas','Miranda');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('El Hatillo','Miranda');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Independencia','Miranda');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Los Salias','Miranda');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Páez','Miranda');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Paz Castillo','Miranda');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Pedro Gual','Miranda');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Plaza','Miranda');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Simón Bolívar','Miranda');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Sucre','Miranda');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Tomás Lander','Miranda');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Urdaneta','Miranda');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Zamora','Miranda');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Maturín','Monagas');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Acosta','Monagas');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Aguasay','Monagas');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Bolívar','Monagas');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Caripe','Monagas');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Cedeño','Monagas');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Ezequiel Zamora','Monagas');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Libertador','Monagas');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Piar','Monagas');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Punceres','Monagas');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Santa Bárbara','Monagas');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Sotillo','Monagas');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Uracoa','Monagas');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Arismendi','Nueva Esparta');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Antolín del Campo','Nueva Esparta');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Díaz','Nueva Esparta');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('García','Nueva Esparta');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Gómez','Nueva Esparta');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Maneiro','Nueva Esparta');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Marcano','Nueva Esparta');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Mariño','Nueva Esparta');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Península de Macanao','Nueva Esparta');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Tubores','Nueva Esparta');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Villalba','Nueva Esparta');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Guanare','Portuguesa');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Agua Blanca','Portuguesa');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Araure','Portuguesa');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Esteller','Portuguesa');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Guanarito','Portuguesa');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Monseñor José Vicente de Unda','Portuguesa');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Ospino','Portuguesa');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Páez','Portuguesa');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Papelón','Portuguesa');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('San Genaro de Boconoito','Portuguesa');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('San Rafael de Onoto','Portuguesa');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Santa Rosalía','Portuguesa');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Sucre','Portuguesa');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Turén','Portuguesa');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Sucre','Sucre');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Andrés Eloy Blanco','Sucre');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Andrés Mata','Sucre');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Arismendi','Sucre');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Benítez','Sucre');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Bermúdez','Sucre');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Bolívar','Sucre');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Cajigal','Sucre');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Cruz Salmerón Acosta','Sucre');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Libertador','Sucre');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Mariño','Sucre');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Mejía','Sucre');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Montes','Sucre');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Ribero','Sucre');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Valdez','Sucre');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('San Cristóbal','Táchira');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Andrés Bello','Táchira');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Antonio Rómulo Costa','Táchira');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Ayacucho','Táchira');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Bolívar','Táchira');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Cárdenas','Táchira');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Córdoba','Táchira');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Fernández Feo','Táchira');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Fernando de Miranda','Táchira');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('García de Hevia','Táchira');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Guásimos','Táchira');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Independencia','Táchira');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Jáuregui','Táchira');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('José María Vargas','Táchira');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Junín','Táchira');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Libertad','Táchira');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Libertador','Táchira');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Lobatera','Táchira');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Michelena','Táchira');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Panamericano','Táchira');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Pedro María de Ureña','Táchira');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Rafael Urdaneta','Táchira');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Samuel Darío Maldonado','Táchira');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('San Judas Tadeo','Táchira');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Seboruco','Táchira');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Simón Rodríguez','Táchira');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Sucre','Táchira');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Torbes','Táchira');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Uribante','Táchira');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Trujillo','Trujillo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Andrés Bello','Trujillo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Boconó','Trujillo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Bolívar','Trujillo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Candelaria','Trujillo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Carache','Trujillo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Escuque','Trujillo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('J. Felipe Márquez Cañizales','Trujillo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Juan Vicente Campo Elías','Trujillo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('La CEiba','Trujillo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Miranda','Trujillo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Monte Carmelo','Trujillo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Motatán','Trujillo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Pampán','Trujillo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Pampanito','Trujillo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Rafael Rangel','Trujillo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('San Rafael de Carvajal','Trujillo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Sucre','Trujillo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Urdaneta','Trujillo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Valera','Trujillo');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Vargas','Vargas');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('San Felipe','Yaracuy');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Arístides Bastidas','Yaracuy');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Bolívar','Yaracuy');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Bruzual','Yaracuy');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Cocorote','Yaracuy');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Independencia','Yaracuy');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('José Antonio Páez','Yaracuy');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('La Trinidad','Yaracuy');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Manuel Monge','Yaracuy');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Nirgua','Yaracuy');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Peña','Yaracuy');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Sucre','Yaracuy');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Urachiche','Yaracuy');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Veroes','Yaracuy');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Maracaibo','Zulia');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Almirante Padilla','Zulia');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Baralt','Zulia');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Cabimas','Zulia');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Catatumbo','Zulia');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Colón','Zulia');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Francisco Javier Pulgar','Zulia');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Guajira','Zulia');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Jesús María Semprún','Zulia');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('La Cañada de Urdaneta','Zulia');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Lagunillas','Zulia');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Lossada','Zulia');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Machiques de Perijá','Zulia');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Mara','Zulia');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Miranda','Zulia');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Rosario de Perijá','Zulia');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('San Francisco','Zulia');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Santa Rita','Zulia');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Simón Bolívar','Zulia');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Sucre','Zulia');
INSERT INTO `MUNICIPIOS`(`MUNICIPIO`, `ESTADO`) VALUES ('Valmore Rodríguez','Zulia');


/*
  Estatus
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
    ESTATUS INT DEFAULT 0,

    PRIMARY KEY (IDPAGO)
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
    ESTATUS INT DEFAULT 0,
    ORIGEN VARCHAR(25),
    PROBLEMA VARCHAR(150),
    SOLUCION VARCHAR(150),
    FECHAFALLA DATETIME,
    FECHASOLUCION DATETIME,

    PRIMARY KEY (IDFALLA)
);
