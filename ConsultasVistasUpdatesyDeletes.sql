/*1 Todos los salones*/

SELECT *
FROM salones;


/*2 Salones que no estan en Jaen*/
SELECT *
FROM salones 
WHERE localidad !='Jaén';



/*3 Salones agrupados por la fecha de inicio*/
SELECT fecha_ini
FROM salones
GROUP BY fecha_ini;

/*4 Edicios con mas de 50 personas de aforo*/
SELECT nombre_edif,aforo
FROM edificio
WHERE aforo > 50;

/*5 Edificios cuyo codigo es 2222*/
SELECT nombre_edif
FROM edificio
WHERE cod_edificio = '2222';

/*6 Edificio en el que se hace el salon*/
SELECT s.nombre_salon,e.nombre_edif
FROM salones s, edificio e
WHERE s.cod_edificio=e.cod_edificio;

/*7 Salones cuyo aforo del efificio es mayor a 45*/
SELECT s.nombre_salon,e.nombre_edif,e.aforo
FROM salones s, edificio e
WHERE s.cod_edificio=e.cod_edificio AND e.aforo > 45;

/*8 Salones y edificios ordenados por su codigo*/
SELECT s.nombre_salon,e.cod_edificio, e.aforo
FROM salones s, edificio e
WHERE s.cod_edificio=e.cod_edificio;
ORDER BY 1;

/*9 Zonas de cada salon*/
SELECT s.nombre_salon, z.id_zona
FROM salones s,zona z
WHERE s.cod_edificio=z.cod_edificio;

/*10 Zonas donde la planta es mayor a la primera y su codigo es 2222*/
SELECT cod_edificio, planta
FROM zona
WHERE planta > 1 AND cod_edificio = '2222';

/*11 Salones que tienen dos o mas plantas*/
SELECT    *
FROM   salones 
WHERE cod_edificio IN (SELECT cod_edificio
          FROM edificio 
            WHERE  plantas >1);
/*12 Numero de asistentes a Jaen Go*/
SELECT COUNT (DNI)"Nº asistentes"
FROM visitas
WHERE cod_salon='0001';



/*13 Todos los edificios ordenados por aforo*/
SELECT *
FROM edificio
ORDER BY aforo;

/*14 Listado de merch agrupad por género cuya suma precio es  mayor de 30*/
SELECT genero,SUM(precio)
FROM merch
HAVING SUM(precio)>30
GROUP BY genero;


/*15 Listado de organizador que no pertenecen a la zona 1230A*/
 SELECT * 
 FROM organizador
 WHERE id_zona IN((SELECT id_zona FROM organizador)MINUS(SELECT id_zona FROM organizador WHERE id_zona='1230A'));

/*16 Zonas ordenadas por planta*/
SELECT id_zona"Zona",planta"Planta"
FROM zona
ORDER BY 2 ASC;

/*17 Seleccionar tiendas de comida que venden comida dulce*/
SELECT *
FROM tienda_comida
WHERE cod_t_com IN (SELECT cod_t_com 
                        FROM tienda_comida 
                           WHERE TIPO='DULCE');

/*18 Listado de salones y sus respectivos edificios odenados por su fecha de inicio y cuyo codigo postal es mayor de 20000 */
SELECT TO_CHAR (fecha_ini,'dd-mon-yyyy'),localidad,especialidad,e.nombre_edif
FROM salones s,edificio e
WHERE cod_post>20000 AND s.cod_edificio=e.cod_edificio
ORDER BY fecha_ini;


/*19 Lista de merch de cada estudio ordenado por id_merch*/
SELECT id_merch"Producto",estudio"Estudio"
FROM merch
ORDER BY id_merch;

/*20 Listado total de mandos y videojuegosque tiene cada consola odenado por modelo de consola */
SELECT modelo,SUM(num_mandos)"Total de Mandos",SUM(videojuegos)"Total de videojuegos"
FROM consola
GROUP BY modelo
ORDER BY modelo;

/*21 Mostrar todo el merch de Netflix que hay en la base de datos junto a su código de stand*/
SELECT  m.*,p.cod_stand
FROM merch m,productos_vendidos p
WHERE m.Estudio='Netflix' AND m.id_merch=p.id_merch;



/*Vista que recoge los datos de todos los asistentes que llevan disfraz*/
CREATE OR REPLACE VIEW asistentes_cosplay AS
SELECT *
FROM asistente
WHERE disfraz = 'V'
WITH CHECK OPTION;


/* Vista que muestra el producto más caro de cada franquicia, así como su precio*/
CREATE OR REPLACE VIEW merch_mas_caro_por_franquicia AS
SELECT p.id_merch, precio, nombre
FROM productos_vendidos p, merch m
WHERE p.id_merch = m.id_merch
AND precio =
  (SELECT MAX(precio)
  FROM merch
  );
  
/* Vista que ofrece las zonas con un número de tiendas de comida por zona mayor o igual que su media*/
CREATE OR REPLACE VIEW tiendas_comida_por_zona AS
SELECT tc.id_zona, COUNT(cod_t_com) "Puestos"
FROM zona, tienda_comida tc
HAVING COUNT(cod_t_com) >= (SELECT AVG(cod_t_com) FROM tienda_comida)
GROUP BY tc.id_zona;

/*Vista que contiene los eventos que se desarrollan en las zonas situadas en la planta 2 de sus respectivos edificios.*/

CREATE OR REPLACE VIEW eventos_en_planta_2 AS
SELECT evento.*
FROM evento, zona
WHERE evento.id_zona = zona.id_zona
AND planta = 2;

/*UPDATES*/
UPDATE consola
SET modelo='PS2'
WHERE modelo='PS4';

UPDATE edificio
SET aforo=(SELECT aforo*2 FROM edificio)
WHERE aforo<50;

UPDATE merch
SET genero='Comedia'
WHERE id_merch IN(SELECT id_merch FROM merch WHERE genero='Accion');

/*DELETES*/
DELETE FROM salones s WHERE cod_edificio IN(SELECT cod_edificio FROM edificio e WHERE plantas >2 AND s.cod_edificio=e.cod_edificio);

DELETE FROM tienda_comida
WHERE tipo='DULCE';

DELETE FROM tienda_comida
WHERE tipo='SALADO' AND procedencia='USA';

