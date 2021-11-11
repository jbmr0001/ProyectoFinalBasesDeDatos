
DROP TABLE SALONES CASCADE CONSTRAINTS;
DROP TABLE EDIFICIO CASCADE CONSTRAINTS;
DROP TABLE ZONA CASCADE CONSTRAINTS;
DROP TABLE ARTISTA CASCADE CONSTRAINTS;
DROP TABLE ASISTENTE CASCADE CONSTRAINTS;
DROP TABLE CONSOLA CASCADE CONSTRAINTS;
DROP TABLE EVENTO CASCADE CONSTRAINTS;
DROP TABLE ORGANIZADOR CASCADE CONSTRAINTS;
DROP TABLE MERCH CASCADE CONSTRAINTS;
DROP TABLE PRODUCTOS_VENDIDOS CASCADE CONSTRAINTS;
DROP TABLE TIENDA CASCADE CONSTRAINTS;
DROP TABLE PERIODISTA CASCADE CONSTRAINTS;
DROP TABLE VENDEDOR CASCADE CONSTRAINTS;
DROP TABLE TIENDA_COMIDA CASCADE CONSTRAINTS;
DROP TABLE VISITAS CASCADE CONSTRAINTS;

CREATE TABLE edificio (
  cod_edificio VARCHAR(4) CONSTRAINT pk_edicio PRIMARY KEY,
  nombre_edif VARCHAR(18),
  dir_edif VARCHAR(25), 
  aforo NUMBER(3) CONSTRAINT ck_afo_edif CHECK (aforo > 0),
  plantas NUMBER(2) CONSTRAINT ck_plan_edif CHECK (plantas > 0)
);

CREATE TABLE zona (
id_zona VARCHAR(5) PRIMARY KEY,
planta NUMBER(2) CONSTRAINT ck_plan_zona CHECK(planta > 0),
cod_edificio VARCHAR(4) CONSTRAINT fk_edificio REFERENCES edificio);

CREATE TABLE salones (
  cod_salon VARCHAR(4) CONSTRAINT pk_salones PRIMARY KEY,
  nombre_salon VARCHAR(15),
  localidad VARCHAR(15) CONSTRAINT nn_localidad NOT NULL,
  cod_edificio VARCHAR(4) CONSTRAINT fk_nombre_edif REFERENCES edificio,
  fecha_ini DATE,
  fecha_fin DATE,
  cod_post VARCHAR(5),
  especialidad VARCHAR(11)
);

CREATE TABLE asistente (
  nombre VARCHAR(20),
  apellido VARCHAR(20),
  DNI VARCHAR(9) CONSTRAINT pk_dni PRIMARY KEY,
  disfraz VARCHAR(1) CONSTRAINT ck_disfraz_asist CHECK(disfraz = 'V' OR disfraz = 'F'),
  tipo_entrada VARCHAR(8) CONSTRAINT ck_tipo_entrada_asist CHECK(tipo_entrada='NORMAL' OR tipo_entrada='VIP' OR tipo_entrada='INVITADO')
);


CREATE TABLE consola (
  cod_stand VARCHAR(4) CONSTRAINT pk_consola PRIMARY KEY,
  id_zona VARCHAR(5) CONSTRAINT fk_zona REFERENCES zona, 
  tamano NUMBER(2) CONSTRAINT ck_tamano_consola CHECK (tamano > 0),
  modelo VARCHAR(10),
  videojuegos VARCHAR(2) CONSTRAINT ck_videojuegos_consola CHECK(videojuegos >0),
  torneo VARCHAR(1) CONSTRAINT ck_torneo_consola CHECK(torneo='V' OR torneo = 'F'),
  num_mandos NUMBER(1) CONSTRAINT ck_num_mandos_consola CHECK(num_mandos>1 AND num_mandos < 9),
  cod_consola VARCHAR(4)
);



CREATE TABLE tienda (
  cod_stand VARCHAR(6) CONSTRAINT pk_tienda PRIMARY KEY,
  id_zona VARCHAR(6) CONSTRAINT fk_zona_tienda REFERENCES zona,
  tamano NUMBER(2) CONSTRAINT ck_tamano_tienda CHECK (tamano > 0),
  V_artista VARCHAR(1) CONSTRAINT ck_v_artista_tienda CHECK(V_artista = 'V' OR V_artista = 'F'), 
  cod_tienda VARCHAR(4));

CREATE TABLE merch (
  id_merch VARCHAR(3) CONSTRAINT pk_anime PRIMARY KEY,
  precio NUMBER(2) CONSTRAINT ck_precio_anime CHECK(precio > 0),
  nombre VARCHAR(20),
  protagonista VARCHAR(20),
  estudio VARCHAR(15),
  genero VARCHAR(20),
  director VARCHAR(20),
  pais VARCHAR(10),
  tipo VARCHAR (10) CONSTRAINT ck_tipo_merch CHECK(tipo = 'SERIE' OR tipo = 'PELICULA' OR tipo = 'VIDEOJUEGO' OR tipo='ANIME')
);

CREATE TABLE productos_vendidos (
  cod_stand VARCHAR(4) CONSTRAINT ct_fk REFERENCES tienda,
  id_merch VARCHAR(3) CONSTRAINT id_fk REFERENCES merch 
);



CREATE TABLE tienda_comida (
  cod_stand VARCHAR(4) CONSTRAINT pk_tienda_comida PRIMARY KEY,
  id_zona VARCHAR(5) CONSTRAINT fk_zona_comida REFERENCES zona,
  tamano NUMBER(2) CONSTRAINT ck_tamano_tienda_comida CHECK (tamano > 0),
  cod_t_com VARCHAR(4),
  tipo VARCHAR(6) CONSTRAINT ck_tipo_tienda_comida CHECK(tipo= 'DULCE' OR tipo = 'SALADO'),
  procedencia VARCHAR(10));

CREATE TABLE evento (
  cod_stand VARCHAR(4) CONSTRAINT pk_evento PRIMARY KEY,
  id_zona VARCHAR(5) CONSTRAINT fk_zona_evento REFERENCES zona,
  tamano NUMBER(2) CONSTRAINT ck_tamano_evento CHECK (tamano > 0),
  cod_evento VARCHAR(4),
  tipo_evento VARCHAR(10),
  tiempo_ini NUMBER(4,2) CONSTRAINT ck_tiem_ini_eve CHECK(tiempo_ini > 00.00 AND tiempo_ini < 23.59 ),
  tiempo_fin NUMBER(4,2) CONSTRAINT ck_tiem_fin_eve CHECK(tiempo_fin > 00.00 AND tiempo_fin < 23.59 ),
  premio VARCHAR(1) CONSTRAINT ck_premio_evento CHECK (premio = 'V' OR premio = 'F')
);


CREATE TABLE periodista (
  nombre VARCHAR(20),
  apellido VARCHAR(20),
  DNI VARCHAR(9) CONSTRAINT pk_dni_periodista PRIMARY KEY,
  cod_periodista VARCHAR(3),
  tipo_medio VARCHAR(9) CONSTRAINT ck_tipo_medio_per CHECK( tipo_medio='YOUTUBE' OR tipo_medio='TV' OR tipo_medio='PERIODICO'OR tipo_medio = 'REVISTA') 
  );

CREATE TABLE visitas (
  cod_salon VARCHAR(4) CONSTRAINT cod_salon_fk REFERENCES salones,
  DNI VARCHAR(9) CONSTRAINT dni_fk REFERENCES asistente
);
CREATE TABLE artista (
  nombre VARCHAR(20),
  apellido VARCHAR(20),
  DNI VARCHAR(9) CONSTRAINT pk_dni_artista PRIMARY KEY,
  cod_artista VARCHAR(4),
  cod_stand VARCHAR(4) CONSTRAINT fk_tienda REFERENCES tienda
);


CREATE TABLE organizador (
  nombre VARCHAR(20),
  apellido VARCHAR(20),
  DNI VARCHAR(9) CONSTRAINT pk_dni_organizador PRIMARY KEY,
  cod_organizador VARCHAR(3),
  id_zona VARCHAR(5) CONSTRAINT fk_zona_organizador REFERENCES zona);


CREATE TABLE vendedor (
  nombre VARCHAR(20),
  apellido VARCHAR(20),
  DNI VARCHAR(9) CONSTRAINT pk_dni_vendedor PRIMARY KEY,
  cod_vendedor VARCHAR(3),
  cod_stand VARCHAR(5) CONSTRAINT fk_stand_vendedor REFERENCES tienda);
  
  


