DROP USER IF EXISTS u5;
CREATE USER u5 IDENTIFIED BY "u5";

DROP DATABASE IF EXISTS u5;
CREATE DATABASE u5 COLLATE utf8mb4_spanish_ci;

GRANT ALL PRIVILEGES ON u5.* TO u5;

USE u5;

CREATE TABLE socio (
    num_socio VARCHAR(4) PRIMARY KEY,
    nombre VARCHAR(20),
    apellido1 VARCHAR(20),
    apellido2 VARCHAR(20),
    telefono VARCHAR(9),
    domicilio VARCHAR(40),
    poblacion VARCHAR(20),
    fec_nac DATE
);

CREATE TABLE pelicula (
    codigo VARCHAR(4) PRIMARY KEY,
    titulo VARCHAR(50),
    duracion INTEGER,
    anyo VARCHAR(4),
    genero VARCHAR(20),
    precio_alquiler DECIMAL(4, 2)
);

CREATE TABLE copia_pelicula (
    id_copia VARCHAR(3) PRIMARY KEY,
    estado VARCHAR(10),
    observacion VARCHAR(300),
    pelicula VARCHAR(4),
	FOREIGN KEY (pelicula) REFERENCES pelicula(codigo) ON DELETE CASCADE
);

CREATE TABLE alquiler (
    copia_pel VARCHAR(3),
    socio VARCHAR(4),
    fec_alquila DATE,
    fec_devolucion DATE,
    CHECK (fec_alquila <= fec_devolucion),
	FOREIGN KEY (copia_pel) REFERENCES copia_pelicula(id_copia) ON DELETE CASCADE,
	FOREIGN KEY (socio) REFERENCES socio(num_socio) ON DELETE CASCADE,
    PRIMARY KEY (copia_pel, socio, fec_alquila)
);

CREATE TABLE socio_vip (
    num_socio VARCHAR(4) PRIMARY KEY,
    nombre VARCHAR(20),
    apellido1 VARCHAR(20),
    apellido2 VARCHAR(20),
    telefono VARCHAR(9),
    domicilio VARCHAR(40),
    poblacion VARCHAR(20),
    fec_nac DATE,
    trim_anyo_vip CHAR(10)
);

INSERT INTO socio VALUES ('1001','Pedro','Gutiérrez','Solero','950333222','C/Gran Vía, 33','Roquetas de Mar', '1970/11/16');
INSERT INTO socio VALUES ('1002','María','López','López','65565565','C/Nicaragua, 4','Aguadulce', '1981/05/22');
INSERT INTO socio VALUES ('1003','Rubén','Danco','Romero','950033022','C/Violeta, 3','Aguadulce', '1985/02/02');
INSERT INTO socio VALUES ('1004','Jesús','Estevan','Díaz','950342342','Plaza Central, 17','Roquetas de Mar', '1972/01/30');
INSERT INTO socio VALUES ('1005','Lucía','Cerros','Pla','611222333','C/Comercio, 22','Roquetas de Mar', '1992/07/12');
INSERT INTO socio VALUES ('1006','Marga','Jiménez','Ganga','744222333','C/Mercado, 178','El Parador', '1995/10/20');

INSERT INTO pelicula VALUES ('CRS','Cars2: Una aventura de espías',106,2011,'Animación',2.50);
INSERT INTO pelicula VALUES ('FRZ','Frozen: El reino del hielo',102,2013,'Animación',2.50);
INSERT INTO pelicula VALUES ('MPS','Lo imposible',107,2012,'Drama',2.00);
INSERT INTO pelicula VALUES ('HBB','El Hobbit: La batalla de los cinco ejércitos',160,2014,'Aventura',3.00);
INSERT INTO pelicula VALUES ('BGH','Big Hero 6',108,2014,'Animación',3.00);
INSERT INTO pelicula VALUES ('NCH','Noche en el museo: El secreto del Faraón',97,2014,'Aventura',3.00);
INSERT INTO pelicula VALUES ('HRL','Ahora los padres son ellos',98,2010,'Comedia',3.00);
INSERT INTO pelicula VALUES ('LRF','El Orfanato',100,2007,'Terror',1.50);

INSERT INTO copia_pelicula VALUES ('101', 'FUNCIONA',NULL, 'CRS');
INSERT INTO copia_pelicula VALUES ('102', 'FUNCIONA',NULL, 'CRS');
INSERT INTO copia_pelicula VALUES ('103', 'FUNCIONA',NULL, 'FRZ');
INSERT INTO copia_pelicula VALUES ('104', 'ESTROPEADA','Rayado', 'FRZ');
INSERT INTO copia_pelicula VALUES ('105', 'FUNCIONA',NULL, 'MPS');
INSERT INTO copia_pelicula VALUES ('106', 'FUNCIONA',NULL, 'HBB');
INSERT INTO copia_pelicula VALUES ('107', 'FUNCIONA',NULL,'HBB');
INSERT INTO copia_pelicula VALUES ('108', 'FUNCIONA',NULL, 'BGH');
INSERT INTO copia_pelicula VALUES ('109', 'FUNCIONA',NULL, 'BGH');
INSERT INTO copia_pelicula VALUES ('110', 'FUNCIONA',NULL, 'NCH');
INSERT INTO copia_pelicula VALUES ('111', 'ESTROPEADA','Disco sucio','NCH');
INSERT INTO copia_pelicula VALUES ('112', 'FUNCIONA',NULL, 'HRL');
INSERT INTO copia_pelicula VALUES ('113', 'PERDIDA','No devuelta', 'LRF');

INSERT INTO alquiler VALUES ('113', '1001', '2014/10/09', '2014/10/10');
INSERT INTO alquiler VALUES ('112', '1001', '2014/11/29', '2014/11/30');
INSERT INTO alquiler VALUES ('108', '1001', '2014/12/01', '2014/12/03');
INSERT INTO alquiler VALUES ('101', '1001', '2014/11/28', '2014/11/29');
INSERT INTO alquiler VALUES ('103', '1002', '2014/11/29', '2014/11/30');
INSERT INTO alquiler VALUES ('106', '1002', '2014/12/07', '2014/12/10');
INSERT INTO alquiler VALUES ('107', '1003', '2014/11/28', '2014/11/29');
INSERT INTO alquiler VALUES ('109', '1003', '2014/11/15', '2014/11/16');
INSERT INTO alquiler VALUES ('104', '1004', '2014/11/29', '2014/11/30');
INSERT INTO alquiler VALUES ('109', '1004', '2014/12/28', '2014/12/29');
INSERT INTO alquiler VALUES ('107', '1005', '2014/11/28', '2014/11/29');
INSERT INTO alquiler VALUES ('113', '1006', '2014/10/16', NULL);
INSERT INTO alquiler VALUES ('110', '1006', '2014/10/01', '2014/10/04');
INSERT INTO alquiler VALUES ('112', '1006', '2014/10/01', '2014/10/04');
INSERT INTO alquiler VALUES ('102', '1005', '2014/11/24', '2014/11/25');
INSERT INTO alquiler VALUES ('107', '1005', '2014/12/05', '2014/12/06');
INSERT INTO alquiler VALUES ('111', '1005', '2014/11/13', '2014/11/14');
INSERT INTO alquiler VALUES ('104', '1005', '2014/12/01', '2014/12/02');
