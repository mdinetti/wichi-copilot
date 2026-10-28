-- Este script es parte de la migración de SIU-Wichi 6.1.0 a 6.2.0.


-- Agrega extension de encriptacion

create extension pgcrypto; 

-- Actualizo las claves de la tabla parametro_instalacion

update parametro_instalacion set valor  = encrypt(valor::bytea,'wichikey'::bytea,'3des'::text) where nombre = 'clave';


-- ----------------------------------
-- Querandies
-- ----------------------------------
SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 30 (class 2615 OID 1569248975)
-- Name: querandies; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA querandies;

ALTER SCHEMA querandies OWNER TO postgres;
SET search_path = querandies, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;

--
-- TOC entry 857 (class 1259 OID 1581162407)
-- Name: d_anio; Type: TABLE; Schema: querandies; Owner: postgres; Tablespace: 
--

CREATE TABLE d_anio (
    anio_id integer NOT NULL
);


ALTER TABLE d_anio OWNER TO postgres;

--
-- TOC entry 842 (class 1259 OID 1569248976)
-- Name: d_construcciones; Type: TABLE; Schema: querandies; Owner: postgres; Tablespace: 
--

CREATE TABLE d_construcciones (
    construccion_id integer NOT NULL,
    construccion_codigo character varying(30),
    construccion_desc character varying(255),
    anio_id integer,
    telefono character varying(30),
    fecha_alta date,
    calle_nombre_numero character varying(255),
    anio_ejecucion smallint,
    anio_intervencion smallint,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


ALTER TABLE d_construcciones OWNER TO postgres;

--
-- TOC entry 843 (class 1259 OID 1569248982)
-- Name: d_cumplimiento; Type: TABLE; Schema: querandies; Owner: postgres; Tablespace: 
--

CREATE TABLE d_cumplimiento (
    cumplimiento_id integer NOT NULL,
    cumplimiento_codigo character varying(30),
    cumplimiento_desc character varying(30),
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


ALTER TABLE d_cumplimiento OWNER TO postgres;

--
-- TOC entry 844 (class 1259 OID 1569248988)
-- Name: d_estado_conservacion; Type: TABLE; Schema: querandies; Owner: postgres; Tablespace: 
--

CREATE TABLE d_estado_conservacion (
    estado_conservacion_id integer NOT NULL,
    estado_conservacion_codigo character varying(30),
    estado_conservacion_desc character varying(80),
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


ALTER TABLE d_estado_conservacion OWNER TO postgres;

--
-- TOC entry 845 (class 1259 OID 1569248994)
-- Name: d_estado_construccion; Type: TABLE; Schema: querandies; Owner: postgres; Tablespace: 
--

CREATE TABLE d_estado_construccion (
    estado_construccion_id integer NOT NULL,
    estado_construccion_codigo character varying(30),
    estado_construccion_desc character varying(80),
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


ALTER TABLE d_estado_construccion OWNER TO postgres;

--
-- TOC entry 846 (class 1259 OID 1569249000)
-- Name: d_inmuebles; Type: TABLE; Schema: querandies; Owner: postgres; Tablespace: 
--

CREATE TABLE d_inmuebles (
    inmueble_id integer NOT NULL,
    inmueble_codigo character varying(30),
    inmueble_desc character varying(255),
    anio_id integer,
    calle_nombre_numero character varying(255),
    unidad_economica character(10),
    fot_normativo numeric(3,2),
    fot_real numeric(3,2),
    fos_normativo numeric(3,2),
    fos_real numeric(3,2),
    fecha_alta date,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone,
    fotfos character varying
);


ALTER TABLE d_inmuebles OWNER TO postgres;

--
-- TOC entry 858 (class 1259 OID 1581162410)
-- Name: d_localidad; Type: TABLE; Schema: querandies; Owner: postgres; Tablespace: 
--

CREATE TABLE d_localidad (
    localidad_id integer NOT NULL,
    localidad_codigo character varying,
    localidad_desc character varying,
    partido_codigo character varying,
    partido_desc character varying,
    provincia_codigo character varying,
    provincia_desc character varying,
    pais_codigo character varying,
    pais_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


ALTER TABLE d_localidad OWNER TO postgres;

--
-- TOC entry 859 (class 1259 OID 1581162416)
-- Name: d_periodo; Type: TABLE; Schema: querandies; Owner: postgres; Tablespace: 
--

CREATE TABLE d_periodo (
    periodo_id integer NOT NULL,
    periodo_desc character varying NOT NULL,
    anio_id text
);


ALTER TABLE d_periodo OWNER TO postgres;

--
-- TOC entry 860 (class 1259 OID 1581162422)
-- Name: d_sino; Type: TABLE; Schema: querandies; Owner: postgres; Tablespace: 
--

CREATE TABLE d_sino (
    sino_id integer NOT NULL,
    sino_desc character varying(10)
);


ALTER TABLE d_sino OWNER TO postgres;

--
-- TOC entry 847 (class 1259 OID 1569249006)
-- Name: d_situacion_dominio; Type: TABLE; Schema: querandies; Owner: postgres; Tablespace: 
--

CREATE TABLE d_situacion_dominio (
    situacion_dominio_id integer NOT NULL,
    situacion_dominio_codigo character varying(30),
    situacion_dominio_desc character varying(255),
    propio smallint,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


ALTER TABLE d_situacion_dominio OWNER TO postgres;

--
-- TOC entry 848 (class 1259 OID 1569249012)
-- Name: d_sub_tipo_uso; Type: TABLE; Schema: querandies; Owner: postgres; Tablespace: 
--

CREATE TABLE d_sub_tipo_uso (
    sub_tipo_uso_id integer NOT NULL,
    sub_tipo_uso_codigo character varying(80),
    sub_tipo_uso_desc character varying(255),
    tipo_uso_codigo character varying(80),
    tipo_uso_desc character varying(255),
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


ALTER TABLE d_sub_tipo_uso OWNER TO postgres;

--
-- TOC entry 849 (class 1259 OID 1569249018)
-- Name: d_tipo_construccion; Type: TABLE; Schema: querandies; Owner: postgres; Tablespace: 
--

CREATE TABLE d_tipo_construccion (
    tipo_construccion_id integer NOT NULL,
    tipo_construccion_codigo character varying(30),
    tipo_construccion_desc character varying(80),
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


ALTER TABLE d_tipo_construccion OWNER TO postgres;

--
-- TOC entry 850 (class 1259 OID 1569249024)
-- Name: d_tipo_planta; Type: TABLE; Schema: querandies; Owner: postgres; Tablespace: 
--

CREATE TABLE d_tipo_planta (
    tipo_planta_id integer NOT NULL,
    tipo_planta_codigo character varying(30),
    tipo_planta_desc character varying(80),
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


ALTER TABLE d_tipo_planta OWNER TO postgres;

--
-- TOC entry 851 (class 1259 OID 1569249030)
-- Name: d_tipo_uso; Type: TABLE; Schema: querandies; Owner: postgres; Tablespace: 
--

CREATE TABLE d_tipo_uso (
    tipo_uso_id integer NOT NULL,
    tipo_uso_codigo character varying(30),
    tipo_uso_desc character varying(255),
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


ALTER TABLE d_tipo_uso OWNER TO postgres;

--
-- TOC entry 852 (class 1259 OID 1569249036)
-- Name: d_ubicacion; Type: TABLE; Schema: querandies; Owner: postgres; Tablespace: 
--

CREATE TABLE d_ubicacion (
    ubicacion_id integer NOT NULL,
    ubicacion_codigo character varying(30),
    ubicacion_desc character varying(255),
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


ALTER TABLE d_ubicacion OWNER TO postgres;

--
-- TOC entry 861 (class 1259 OID 1581162425)
-- Name: d_unidad_academica; Type: TABLE; Schema: querandies; Owner: postgres; Tablespace: 
--

CREATE TABLE d_unidad_academica (
    unidad_academica_id integer NOT NULL,
    institucion_codigo character varying,
    institucion_desc character varying,
    unidad_academica_codigo character varying,
    unidad_academica_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


ALTER TABLE d_unidad_academica OWNER TO postgres;

--
-- TOC entry 853 (class 1259 OID 1569249042)
-- Name: d_uso; Type: TABLE; Schema: querandies; Owner: postgres; Tablespace: 
--

CREATE TABLE d_uso (
    uso_id integer NOT NULL,
    uso_codigo character varying(30),
    uso_desc character varying(255),
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


ALTER TABLE d_uso OWNER TO postgres;

--
-- TOC entry 854 (class 1259 OID 1569249048)
-- Name: ft_construcciones_plantas; Type: TABLE; Schema: querandies; Owner: postgres; Tablespace: 
--

CREATE TABLE ft_construcciones_plantas (
    ft_construccion_plantas_id integer,
    periodo_id integer,
    institucion_id integer,
    localidad_id integer,
    inmueble_id integer,
    anio_id integer,
    construccion_id integer,
    estado_conservacion_id smallint,
    patrimonio_historico smallint,
    tipo_construccion_id smallint,
    estado_construccion_id smallint,
    acceso_circulacion_senderos smallint,
    iluminacion_artificial smallint,
    solados_antideslizantes smallint,
    estacionamiento_designado smallint,
    senializacion_vision_reducida smallint,
    acceso_desnivel_salvado smallint,
    sanitarios_accesibles smallint,
    acceso_pisos_superiores smallint,
    accesos_a_nivel smallint,
    entradas_aulas_sin_escalones smallint,
    puertas_accesibles smallint,
    mostradores_accesibles smallint,
    adecuacion_comunicacion_reducida smallint,
    tipo_planta_id smallint,
    numero_planta smallint,
    cant_plantas smallint,
    superficie_construida_cubierta numeric(10,0),
    superficie_construida_semicubierta numeric(10,0),
    superficie_no_construida numeric(10,0),
    superficie_total_construccion numeric(10,0),
    anio_querandies_id integer
);


ALTER TABLE ft_construcciones_plantas OWNER TO postgres;

--
-- TOC entry 855 (class 1259 OID 1569249051)
-- Name: ft_construcciones_tipo_de_uso; Type: TABLE; Schema: querandies; Owner: postgres; Tablespace: 
--

CREATE TABLE ft_construcciones_tipo_de_uso (
    ft_construcciones_tipo_de_uso_id integer,
    periodo_id integer,
    institucion_id integer,
    localidad_id integer,
    inmueble_id integer,
    anio_id integer,
    construccion_id integer,
    patrimonio_historico smallint,
    estado_conservacion_id smallint,
    tipo_construccion_id smallint,
    estado_construccion_id smallint,
    unidad_academica_id integer,
    uso_id smallint,
    sub_tipo_uso_id integer,
    acceso_circulacion_senderos smallint,
    iluminacion_artificial smallint,
    solados_antideslizantes smallint,
    estacionamiento_designado smallint,
    senializacion_vision_reducida smallint,
    acceso_desnivel_salvado smallint,
    sanitarios_accesibles smallint,
    acceso_pisos_superiores smallint,
    accesos_a_nivel smallint,
    entradas_aulas_sin_escalones smallint,
    puertas_accesibles smallint,
    mostradores_accesibles smallint,
    adecuacion_comunicacion_reducida smallint,
    superficie_uso numeric(10,0),
    anio_querandies_id integer,
    unidad_generica_id integer
);


ALTER TABLE ft_construcciones_tipo_de_uso OWNER TO postgres;

--
-- TOC entry 856 (class 1259 OID 1569249054)
-- Name: ft_inmuebles; Type: TABLE; Schema: querandies; Owner: postgres; Tablespace: 
--

CREATE TABLE ft_inmuebles (
    ft_inmueble_id integer,
    periodo_id integer,
    institucion_id integer,
    localidad_id integer,
    inmueble_id integer,
    anio_id integer,
    situacion_dominio_id integer,
    ubicacion_id integer,
    agua_corriente smallint,
    gas_natural smallint,
    energia smallint,
    cloacas smallint,
    telecomun_e_informatica smallint,
    superficie_terreno numeric(10,0),
    valuacion_tecnica_contable numeric(12,0),
    superficie_construida_planta_baja numeric(10,0),
    superficie_construida_cubierta numeric(10,0),
    superficie_construida_semicubierta numeric(10,0),
    superficie_no_construida numeric(10,0),
    superficie_total_construida numeric(10,0),
    cantidad_construcciones smallint,
    cantidad_solares smallint,
    cantidad_total_construcciones smallint,
    anio_querandies_id integer
);


ALTER TABLE ft_inmuebles OWNER TO postgres;

--
-- TOC entry 4330 (class 2606 OID 1581162432)
-- Name: d_anio_pkey; Type: CONSTRAINT; Schema: querandies; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY d_anio
    ADD CONSTRAINT d_anio_pkey PRIMARY KEY (anio_id);


--
-- TOC entry 4308 (class 2606 OID 1569253054)
-- Name: d_cumplimiento_pkey; Type: CONSTRAINT; Schema: querandies; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY d_cumplimiento
    ADD CONSTRAINT d_cumplimiento_pkey PRIMARY KEY (cumplimiento_id);


--
-- TOC entry 4334 (class 2606 OID 1581162434)
-- Name: d_periodo_pkey; Type: CONSTRAINT; Schema: querandies; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY d_periodo
    ADD CONSTRAINT d_periodo_pkey PRIMARY KEY (periodo_id);


--
-- TOC entry 4332 (class 2606 OID 1581162436)
-- Name: idxp_d_localidad; Type: CONSTRAINT; Schema: querandies; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY d_localidad
    ADD CONSTRAINT idxp_d_localidad PRIMARY KEY (localidad_id);


--
-- TOC entry 4338 (class 2606 OID 1581162438)
-- Name: idxp_d_unidad_academica; Type: CONSTRAINT; Schema: querandies; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY d_unidad_academica
    ADD CONSTRAINT idxp_d_unidad_academica PRIMARY KEY (unidad_academica_id);


--
-- TOC entry 4306 (class 2606 OID 1773492033)
-- Name: pk_d_construcciones; Type: CONSTRAINT; Schema: querandies; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY d_construcciones
    ADD CONSTRAINT pk_d_construcciones PRIMARY KEY (construccion_id);


--
-- TOC entry 4310 (class 2606 OID 1773492035)
-- Name: pk_d_estado_conservacion; Type: CONSTRAINT; Schema: querandies; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY d_estado_conservacion
    ADD CONSTRAINT pk_d_estado_conservacion PRIMARY KEY (estado_conservacion_id);


--
-- TOC entry 4314 (class 2606 OID 1773492039)
-- Name: pk_d_inmuebles; Type: CONSTRAINT; Schema: querandies; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY d_inmuebles
    ADD CONSTRAINT pk_d_inmuebles PRIMARY KEY (inmueble_id);


--
-- TOC entry 4336 (class 2606 OID 1773492042)
-- Name: pk_d_sino; Type: CONSTRAINT; Schema: querandies; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY d_sino
    ADD CONSTRAINT pk_d_sino PRIMARY KEY (sino_id);


--
-- TOC entry 4316 (class 2606 OID 1773492044)
-- Name: pk_d_situacion_dominio; Type: CONSTRAINT; Schema: querandies; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY d_situacion_dominio
    ADD CONSTRAINT pk_d_situacion_dominio PRIMARY KEY (situacion_dominio_id);


--
-- TOC entry 4318 (class 2606 OID 1773492050)
-- Name: pk_d_sub_tipo_uso; Type: CONSTRAINT; Schema: querandies; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY d_sub_tipo_uso
    ADD CONSTRAINT pk_d_sub_tipo_uso PRIMARY KEY (sub_tipo_uso_id);


--
-- TOC entry 4320 (class 2606 OID 1773498991)
-- Name: pk_d_tipo_construccion; Type: CONSTRAINT; Schema: querandies; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY d_tipo_construccion
    ADD CONSTRAINT pk_d_tipo_construccion PRIMARY KEY (tipo_construccion_id);


--
-- TOC entry 4322 (class 2606 OID 1773498997)
-- Name: pk_d_tipo_planta; Type: CONSTRAINT; Schema: querandies; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY d_tipo_planta
    ADD CONSTRAINT pk_d_tipo_planta PRIMARY KEY (tipo_planta_id);


--
-- TOC entry 4324 (class 2606 OID 1773498999)
-- Name: pk_d_tipo_uso; Type: CONSTRAINT; Schema: querandies; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY d_tipo_uso
    ADD CONSTRAINT pk_d_tipo_uso PRIMARY KEY (tipo_uso_id);


--
-- TOC entry 4326 (class 2606 OID 1773499001)
-- Name: pk_d_ubicacion; Type: CONSTRAINT; Schema: querandies; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY d_ubicacion
    ADD CONSTRAINT pk_d_ubicacion PRIMARY KEY (ubicacion_id);


--
-- TOC entry 4328 (class 2606 OID 1773499018)
-- Name: pk_d_uso; Type: CONSTRAINT; Schema: querandies; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY d_uso
    ADD CONSTRAINT pk_d_uso PRIMARY KEY (uso_id);


--
-- TOC entry 4312 (class 2606 OID 1773492037)
-- Name: pk_estado_construccion; Type: CONSTRAINT; Schema: querandies; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY d_estado_construccion
    ADD CONSTRAINT pk_estado_construccion PRIMARY KEY (estado_construccion_id);


-- Completed on 2017-02-13 15:07:27 ART

--
-- PostgreSQL database dump complete
--
