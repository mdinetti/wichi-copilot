-- Este script es parte de la migración de SIU-Wichi 6.0.0 a 6.1.0.


-- ----------------------------------
-- Diaguita
-- ----------------------------------
--Se crea la tabla de proveedores (esquema diaguita_tmp)

CREATE TABLE diaguita_tmp.d_persona 
(
  persona_codigo text,
  persona_tipo_documento text,
  persona_nro_documento text,
  fisica_o_juridica text,
  razon_social_apyno text,
  nombre_fantasia text,
  sexo text,
  nacionalidad text,
  email text,
  cbu text,
  persona_detalle text,
  estado character varying
);


--Se agrega numero de alta y proveedor en el cubo de Patrimonio (esquema diaguita_tmp)
ALTER TABLE diaguita_tmp.ft_patrimonio ADD COLUMN id_alta text;
ALTER TABLE diaguita_tmp.ft_patrimonio ADD COLUMN persona text;

--Se crea la tabla de proveedores (esquema diaguita_dsa)

CREATE TABLE diaguita_dsa.d_persona
(
  persona_id serial,
  persona_codigo integer,
  persona_tipo_documento character varying,
  persona_nro_documento character varying,
  fisica_o_juridica character varying,
  razon_social_apyno character varying,
  nombre_fantasia character varying,
  genero_id character varying,
  nacionalidad character varying,
  email character varying,
  cbu character varying,
  persona_detalle character varying,
  estado character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone
);


--Se agrega numero de alta y proveedor en el cubo de Patrimonio (esquema diaguita_dsa)

ALTER TABLE diaguita_dsa.ft_patrimonio ADD COLUMN numero_alta_id integer;
ALTER TABLE diaguita_dsa.ft_patrimonio ADD COLUMN persona_id integer;


--Se crea la tabla de proveedores (esquema diaguita)

CREATE TABLE diaguita.d_persona
(
  persona_id serial NOT NULL,
  persona_codigo integer,
  persona_tipo_documento character varying,
  persona_nro_documento character varying,
  fisica_o_juridica character varying,
  razon_social_apyno character varying,
  nombre_fantasia character varying,
  genero_id character varying,
  nacionalidad character varying,
  email character varying,
  cbu character varying,
  persona_detalle character varying,
  estado character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT pk_d_persona PRIMARY KEY (persona_id)
);


--Se agrega numero de alta y proveedor en el cubo de Patrimonio (esquema diaguita)
  
ALTER TABLE diaguita.ft_patrimonio ADD COLUMN numero_alta_id integer;
ALTER TABLE diaguita.ft_patrimonio ADD COLUMN persona_id integer;

-- ----------------------------------
-- integrado
-- ----------------------------------
--Se crea el esquema integrado (para manejar el tablero integrado), las tablas y la funcion de actualizacion

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.9
-- Dumped by pg_dump version 9.4.10
-- Started on 2016-12-07 15:21:39 ART

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 36 (class 2615 OID 1334025929)
-- Name: integrado; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA integrado;


ALTER SCHEMA integrado OWNER TO postgres;

SET search_path = integrado, pg_catalog;

--
-- TOC entry 982 (class 1255 OID 1334025930)
-- Name: carga_integrado(); Type: FUNCTION; Schema: integrado; Owner: postgres
--

CREATE FUNCTION carga_integrado() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE fecha_hora_inicio timestamp without time zone ;
BEGIN
   fecha_hora_inicio := clock_timestamp();
-- ELIMINA TODOS LOS REGISTROS EXISTENTES
TRUNCATE integrado.ft_integrado;
-- INSERTA TODOS LOS REGISTROS CON COMBINACION DE ANIO-UA
INSERT INTO integrado.ft_integrado (anio_id, unidad_generica_id) 
SELECT anio_id, unidad_generica_id FROM
(
SELECT DISTINCT idanioinformado AS anio_id FROM araucano.academica_ft_cuadros1y2
UNION
SELECT DISTINCT anio_id FROM pilaga.ft_movimientos
UNION 
SELECT DISTINCT EXTRACT(YEAR FROM periodoinfo) AS anio_id FROM mapuche.map_dw_ft_lt_cargos
ORDER BY 1
) as anio_id,
(SELECT DISTINCT unidad_generica_id FROM public.d_unidad_generica ORDER BY 1) as unidad_generica_id;


-- ACTUALIZA DATOS DE PILAGA 
EXECUTE 'CREATE TEMP TABLE temp_pilaga_integrado ON COMMIT DROP AS
SELECT DISTINCT mov.anio_id, mov.unidad_generica_id,
 coalesce(sum(CASE WHEN o.resumen_desc=''1 - Sueldos'' THEN credito ELSE 0 END),0) AS pilaga_credito_uno,
 coalesce(sum(CASE WHEN o.resumen_desc<>''1 - Sueldos'' THEN credito ELSE 0 END),0) AS pilaga_credito_no_uno,
 coalesce(sum(CASE WHEN o.resumen_desc=''1 - Sueldos'' THEN devengado ELSE 0 END),0) AS pilaga_devengado_uno,
 coalesce(sum(CASE WHEN o.resumen_desc<>''1 - Sueldos'' THEN devengado ELSE 0 END),0) AS pilaga_devengado_no_uno,
 coalesce(sum(devengado_de_ingreso),0) AS pilaga_devengado_de_ingreso,
 coalesce(sum(cobrado),0) AS pilaga_cobrado
 FROM pilaga.ft_movimientos mov, pilaga.d_objeto_del_gasto o
 WHERE mov.objeto_del_gasto_id=o.objeto_del_gasto_id --AND o.resumen_desc=''1 - Sueldos''
 GROUP BY 1,2;';
UPDATE integrado.ft_integrado i 
  SET pilaga_credito_uno = coalesce(mov.pilaga_credito_uno,0),
      pilaga_credito_no_uno = coalesce(mov.pilaga_credito_no_uno,0),
      pilaga_devengado_uno = coalesce(mov.pilaga_devengado_uno,0), 
      pilaga_devengado_no_uno = coalesce(mov.pilaga_devengado_no_uno,0), 
      pilaga_devengado_de_ingreso = coalesce(mov.pilaga_devengado_de_ingreso,0), 
      pilaga_cobrado = coalesce(mov.pilaga_cobrado,0) 
 FROM temp_pilaga_integrado mov
WHERE i.anio_id = mov.anio_id AND i.unidad_generica_id = mov.unidad_generica_id;

-- ACTUALIZA DATOS DE ARAUCANO
UPDATE integrado.ft_integrado i
SET araucano_alumnos =
(SELECT coalesce(sum(cantidad),0)
 FROM araucano.academica_ft_cuadros1y2 c, araucano.academica_d_series s
 WHERE i.anio_id=c.idanioinformado AND i.unidad_generica_id=c.unidad_generica_id AND c.idserie=s.idserie AND s.serie='MA'), 
araucano_nuevos_inscriptos =
(SELECT coalesce(sum(cantidad),0)
 FROM araucano.academica_ft_cuadros1y2 c, araucano.academica_d_series s
 WHERE i.anio_id=c.idanioinformado AND i.unidad_generica_id=c.unidad_generica_id AND c.idserie=s.idserie AND s.serie IN ('NI', 'NIP', 'NIQ')),
araucano_reinscriptos =
(SELECT coalesce(sum(cantidad),0)
 FROM araucano.academica_ft_cuadros1y2 c, araucano.academica_d_series s
 WHERE i.anio_id=c.idanioinformado AND i.unidad_generica_id=c.unidad_generica_id AND c.idserie=s.idserie AND s.serie='R'),
 araucano_egresados =
(SELECT coalesce(sum(cantidad),0)
 FROM araucano.academica_ft_cuadros1y2 c, araucano.academica_d_series s
 WHERE i.anio_id=c.idanioinformado AND i.unidad_generica_id=c.unidad_generica_id AND c.idserie=s.idserie AND s.serie='E');

 -- ACTUALIZA DATOS DE MAPUCHE
EXECUTE 'CREATE TEMP TABLE temp_cargos_escalafones ON COMMIT DROP AS 
SELECT DISTINCT EXTRACT(YEAR FROM c.periodoinfo) as anio_id, unidad_generica_id, 
cat.escalafon_id_map as escalafon, 
coalesce(sum(cantcargosactivos) / count(DISTINCT EXTRACT(MONTH FROM periodoinfo)),0) as cantidad
FROM mapuche.map_dw_ft_lt_cargos c, mapuche.map_dw_lt_categoriascargo cat
WHERE c.categoria_id=cat.categoria_id
GROUP BY 1,2,3;';
UPDATE integrado.ft_integrado i
SET mapuche_cargos_docentes =
(SELECT coalesce(sum(cantidad),0)
FROM temp_cargos_escalafones tempo
WHERE tempo.escalafon='D' AND 
i.anio_id=tempo.anio_id AND i.unidad_generica_id=tempo.unidad_generica_id),
mapuche_cargos_no_docentes =
(SELECT coalesce(sum(cantidad),0)
FROM temp_cargos_escalafones tempo
WHERE tempo.escalafon='N' AND 
i.anio_id=tempo.anio_id AND i.unidad_generica_id=tempo.unidad_generica_id),
mapuche_cargos_superiores =
(SELECT coalesce(sum(cantidad),0)
FROM temp_cargos_escalafones tempo
WHERE tempo.escalafon='S' AND 
i.anio_id=tempo.anio_id AND i.unidad_generica_id=tempo.unidad_generica_id);

-- Agrega registro informando la actualizacion, luego se usa para saber si esta actualizada ft_integrado.
insert into public.importacion (instalacion_id, fecha_inicio, fecha_fin, tipo, parametros, observaciones, estado)
values (0, fecha_hora_inicio, clock_timestamp(), 'actualizacion', ' ', 'Actualizacion ft_integrado', 'finalizada');

RETURN (SELECT count(*) FROM integrado.ft_integrado);
END
$$;


ALTER FUNCTION integrado.carga_integrado() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 961 (class 1259 OID 1334025931)
-- Name: ft_integrado; Type: TABLE; Schema: integrado; Owner: postgres; Tablespace: 
--

CREATE TABLE ft_integrado (
    id integer NOT NULL,
    anio_id integer,
    unidad_generica_id integer,
    araucano_alumnos numeric(13,2),
    araucano_nuevos_inscriptos numeric(13,2),
    araucano_reinscriptos numeric(13,2),
    araucano_egresados numeric(13,2),
    pilaga_credito_uno numeric(13,2),
    pilaga_credito_no_uno numeric(13,2),
    pilaga_devengado_uno numeric(13,2),
    pilaga_devengado_no_uno numeric(13,2),
    pilaga_devengado_de_ingreso numeric(13,2),
    pilaga_cobrado numeric(13,2),
    mapuche_cargos_docentes numeric(13,2),
    mapuche_cargos_no_docentes numeric(13,2),
    mapuche_cargos_superiores numeric(13,2)
);


ALTER TABLE ft_integrado OWNER TO postgres;

--
-- TOC entry 962 (class 1259 OID 1334025934)
-- Name: ft_integrado_id_seq; Type: SEQUENCE; Schema: integrado; Owner: postgres
--

CREATE SEQUENCE ft_integrado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ft_integrado_id_seq OWNER TO postgres;

--
-- TOC entry 4681 (class 0 OID 0)
-- Dependencies: 962
-- Name: ft_integrado_id_seq; Type: SEQUENCE OWNED BY; Schema: integrado; Owner: postgres
--

ALTER SEQUENCE ft_integrado_id_seq OWNED BY ft_integrado.id;


--
-- TOC entry 963 (class 1259 OID 1334025936)
-- Name: metas; Type: TABLE; Schema: integrado; Owner: postgres; Tablespace: 
--

CREATE TABLE metas (
    id integer NOT NULL,
    descripcion character varying
);


ALTER TABLE metas OWNER TO postgres;

--
-- TOC entry 964 (class 1259 OID 1334025942)
-- Name: metas_estados; Type: TABLE; Schema: integrado; Owner: postgres; Tablespace: 
--

CREATE TABLE metas_estados (
    id integer NOT NULL,
    color character varying,
    descripcion character varying,
    rgb character varying
);


ALTER TABLE metas_estados OWNER TO postgres;

--
-- TOC entry 965 (class 1259 OID 1334025948)
-- Name: metas_estados_id_seq; Type: SEQUENCE; Schema: integrado; Owner: postgres
--

CREATE SEQUENCE metas_estados_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE metas_estados_id_seq OWNER TO postgres;

--
-- TOC entry 4682 (class 0 OID 0)
-- Dependencies: 965
-- Name: metas_estados_id_seq; Type: SEQUENCE OWNED BY; Schema: integrado; Owner: postgres
--

ALTER SEQUENCE metas_estados_id_seq OWNED BY metas_estados.id;


--
-- TOC entry 966 (class 1259 OID 1334025950)
-- Name: metas_id_seq; Type: SEQUENCE; Schema: integrado; Owner: postgres
--

CREATE SEQUENCE metas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE metas_id_seq OWNER TO postgres;

--
-- TOC entry 4683 (class 0 OID 0)
-- Dependencies: 966
-- Name: metas_id_seq; Type: SEQUENCE OWNED BY; Schema: integrado; Owner: postgres
--

ALTER SEQUENCE metas_id_seq OWNED BY metas.id;


--
-- TOC entry 967 (class 1259 OID 1334025952)
-- Name: metas_rangos; Type: TABLE; Schema: integrado; Owner: postgres; Tablespace: 
--

CREATE TABLE metas_rangos (
    id integer NOT NULL,
    metas_id integer,
    metas_estados_id integer,
    valor_inicio real,
    valor_fin real
);


ALTER TABLE metas_rangos OWNER TO postgres;

--
-- TOC entry 968 (class 1259 OID 1334025955)
-- Name: metas_rangos_id_seq; Type: SEQUENCE; Schema: integrado; Owner: postgres
--

CREATE SEQUENCE metas_rangos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE metas_rangos_id_seq OWNER TO postgres;

--
-- TOC entry 4684 (class 0 OID 0)
-- Dependencies: 968
-- Name: metas_rangos_id_seq; Type: SEQUENCE OWNED BY; Schema: integrado; Owner: postgres
--

ALTER SEQUENCE metas_rangos_id_seq OWNED BY metas_rangos.id;


--
-- TOC entry 4539 (class 2604 OID 1334025957)
-- Name: id; Type: DEFAULT; Schema: integrado; Owner: postgres
--

ALTER TABLE ONLY ft_integrado ALTER COLUMN id SET DEFAULT nextval('ft_integrado_id_seq'::regclass);


--
-- TOC entry 4540 (class 2604 OID 1334025958)
-- Name: id; Type: DEFAULT; Schema: integrado; Owner: postgres
--

ALTER TABLE ONLY metas ALTER COLUMN id SET DEFAULT nextval('metas_id_seq'::regclass);


--
-- TOC entry 4541 (class 2604 OID 1334025959)
-- Name: id; Type: DEFAULT; Schema: integrado; Owner: postgres
--

ALTER TABLE ONLY metas_estados ALTER COLUMN id SET DEFAULT nextval('metas_estados_id_seq'::regclass);


--
-- TOC entry 4542 (class 2604 OID 1334025960)
-- Name: id; Type: DEFAULT; Schema: integrado; Owner: postgres
--

ALTER TABLE ONLY metas_rangos ALTER COLUMN id SET DEFAULT nextval('metas_rangos_id_seq'::regclass);


--
-- TOC entry 4669 (class 0 OID 1334025931)
-- Dependencies: 961
-- Data for Name: ft_integrado; Type: TABLE DATA; Schema: integrado; Owner: postgres
--



--
-- TOC entry 4685 (class 0 OID 0)
-- Dependencies: 962
-- Name: ft_integrado_id_seq; Type: SEQUENCE SET; Schema: integrado; Owner: postgres
--

SELECT pg_catalog.setval('ft_integrado_id_seq', 24156, true);


--
-- TOC entry 4671 (class 0 OID 1334025936)
-- Dependencies: 963
-- Data for Name: metas; Type: TABLE DATA; Schema: integrado; Owner: postgres
--

INSERT INTO metas VALUES (1, 'Porcentaje del devengado correspondiente al inciso 1 sobre el total.');
INSERT INTO metas VALUES (2, 'Porcentaje de Cargos Docentes sobre el total.');
INSERT INTO metas VALUES (3, 'Cantidad de Egresados cada 100 Alumnos.');
INSERT INTO metas VALUES (4, 'Porcentaje de Alumnos sobre Porcentaje de Devengado con relación al total de la Universidad.');


--
-- TOC entry 4672 (class 0 OID 1334025942)
-- Dependencies: 964
-- Data for Name: metas_estados; Type: TABLE DATA; Schema: integrado; Owner: postgres
--

INSERT INTO metas_estados VALUES (1, 'verde', 'El valor se encuentra dentro del rango de valores deseados.', 'rgb(82, 240, 55)');
INSERT INTO metas_estados VALUES (2, 'amarillo', 'El valor se encuentra fuera del rango deseado pero a poca distancia.', 'rgb(255, 255, 0)');
INSERT INTO metas_estados VALUES (3, 'rojo', 'El valor se encuentra fuera del rango de valores deseados.', 'rgb(255, 0, 0)');


--
-- TOC entry 4686 (class 0 OID 0)
-- Dependencies: 965
-- Name: metas_estados_id_seq; Type: SEQUENCE SET; Schema: integrado; Owner: postgres
--

SELECT pg_catalog.setval('metas_estados_id_seq', 1, false);


--
-- TOC entry 4687 (class 0 OID 0)
-- Dependencies: 966
-- Name: metas_id_seq; Type: SEQUENCE SET; Schema: integrado; Owner: postgres
--

SELECT pg_catalog.setval('metas_id_seq', 1, false);


--
-- TOC entry 4675 (class 0 OID 1334025952)
-- Dependencies: 967
-- Data for Name: metas_rangos; Type: TABLE DATA; Schema: integrado; Owner: postgres
--

INSERT INTO metas_rangos VALUES (1, 1, 1, 0, 80);
INSERT INTO metas_rangos VALUES (2, 1, 2, 80, 94);
INSERT INTO metas_rangos VALUES (3, 1, 3, 94, 100);
INSERT INTO metas_rangos VALUES (4, 2, 3, 0, 60);
INSERT INTO metas_rangos VALUES (5, 2, 2, 60, 80);
INSERT INTO metas_rangos VALUES (6, 2, 1, 80, 100);
INSERT INTO metas_rangos VALUES (7, 3, 3, 0, 5);
INSERT INTO metas_rangos VALUES (8, 3, 2, 5, 10);
INSERT INTO metas_rangos VALUES (9, 3, 1, 10, 1000000);
INSERT INTO metas_rangos VALUES (10, 4, 3, 0, 25);
INSERT INTO metas_rangos VALUES (11, 4, 2, 25, 50);
INSERT INTO metas_rangos VALUES (12, 4, 1, 50, 100);


--
-- TOC entry 4688 (class 0 OID 0)
-- Dependencies: 968
-- Name: metas_rangos_id_seq; Type: SEQUENCE SET; Schema: integrado; Owner: postgres
--

SELECT pg_catalog.setval('metas_rangos_id_seq', 1, false);


--
-- TOC entry 4544 (class 2606 OID 1334025962)
-- Name: ft_integrado_pkey; Type: CONSTRAINT; Schema: integrado; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ft_integrado
    ADD CONSTRAINT ft_integrado_pkey PRIMARY KEY (id);


--
-- TOC entry 4546 (class 2606 OID 1334025964)
-- Name: pk_metas; Type: CONSTRAINT; Schema: integrado; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY metas
    ADD CONSTRAINT pk_metas PRIMARY KEY (id);


--
-- TOC entry 4548 (class 2606 OID 1334025966)
-- Name: pk_metas_estados; Type: CONSTRAINT; Schema: integrado; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY metas_estados
    ADD CONSTRAINT pk_metas_estados PRIMARY KEY (id);


--
-- TOC entry 4550 (class 2606 OID 1334025968)
-- Name: pk_metas_rangos; Type: CONSTRAINT; Schema: integrado; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY metas_rangos
    ADD CONSTRAINT pk_metas_rangos PRIMARY KEY (id);


--
-- TOC entry 4551 (class 2606 OID 1334025969)
-- Name: fk_metas_rangos_metas; Type: FK CONSTRAINT; Schema: integrado; Owner: postgres
--

ALTER TABLE ONLY metas_rangos
    ADD CONSTRAINT fk_metas_rangos_metas FOREIGN KEY (metas_id) REFERENCES metas(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4552 (class 2606 OID 1334025974)
-- Name: fk_metas_rangos_metas_estados; Type: FK CONSTRAINT; Schema: integrado; Owner: postgres
--

ALTER TABLE ONLY metas_rangos
    ADD CONSTRAINT fk_metas_rangos_metas_estados FOREIGN KEY (metas_estados_id) REFERENCES metas_estados(id) ON UPDATE CASCADE ON DELETE RESTRICT;


-- Completed on 2016-12-07 15:21:39 ART

--
-- PostgreSQL database dump complete
--

-- Agrega registros de VACIO / NULO que faltaban para poder agregar los registros de importacion con d_instalacion VACIO.
INSERT INTO public.d_fuente_dato (fuente_dato_id, fuente_dato_desc) VALUES (0,'VACIO / NULO');
INSERT INTO public.d_instalacion (instalacion_id, instalacion_desc, instalacion_codigo, fuente_dato_id) VALUES (0,'VACIO / NULO','V/N',0);


  
