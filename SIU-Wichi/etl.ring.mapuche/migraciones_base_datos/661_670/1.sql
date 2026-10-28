-- Este script es parte de la migración de SIU-Wichi 6.6.1 a 6.7.0

--------------------------------
-- Agrega fuente de dato Moodle
--------------------------------

INSERT INTO public.d_fuente_dato(fuente_dato_id, fuente_dato_desc) VALUES (13, 'Moodle');

----------------------------------------
-- Agrega campo activa a la instalacion
----------------------------------------
ALTER TABLE public.d_instalacion
  ADD COLUMN activa character(1) DEFAULT 'S';

----------------------------------------
-- Agrega campo quincena a la fecha
----------------------------------------
ALTER TABLE public.d_fecha
  ADD COLUMN quincena integer;

ALTER TABLE public.d_fecha
  ADD COLUMN quincena_desc character varying;

UPDATE public.d_fecha SET quincena = Case WHEN dia <= 15 THEN 1 ELSE 2 END;
UPDATE public.d_fecha SET quincena_desc = Case WHEN dia <= 15 THEN '1er Quincena' ELSE '2da Quincena' END;

-----------------------------
-- Guarani 3
-----------------------------
ALTER TABLE guarani3_tmp.ft_alumnos
  ADD COLUMN situacion_aspirante_id integer;

ALTER TABLE guarani3_dsa.ft_alumnos
  ADD COLUMN situacion_aspirante_id integer;

ALTER TABLE guarani3.ft_alumnos
  ADD COLUMN situacion_aspirante_id integer;

SET search_path = guarani3_tmp, pg_catalog;

--Tablas para integracion Moodle

CREATE TABLE int_pv_cursos(
  curso integer,
  id_curso_externo character varying(50),
  nombre character varying(150),
  plataforma integer
);

CREATE TABLE int_pv_cursos_comisiones
(
  curso integer,
  comision integer
);

CREATE TABLE int_pv_plataformas
(
  plataforma integer,
  nombre character varying(100),
  url character varying(200),
  host character varying(200),
  token character varying,
  rol_alumno integer,
  rol_alumno_curso integer,
  categoria_curso_default integer,
  activa boolean
);

CREATE TABLE int_pv_plataformas_ra
(
  plataforma integer,
  responsable_academica integer
);

CREATE TABLE int_pv_roles_docentes
(
  plataforma integer,
  responsabilidad integer,
  rol_externo integer
);

CREATE TABLE int_pv_usuarios
(
  plataforma integer,
  persona integer,
  id_usuario_externo character varying(50)
);

CREATE TABLE comisiones_completas(
	comision integer,
	materia character varying,
	propuesta integer,
	plan integer,
	responsable_academica integer
);
CREATE TABLE inscripciones_personas_comisiones(
	comision integer,
	alumno integer,
	actividad integer,
	curso integer,
	legajo character varying,
	persona integer,
	propuesta integer,
	plan_version integer,
	ubicacion integer,
	plataforma integer,
	id_usuario_externo integer
);

CREATE TABLE inscripciones_comision(
	comision integer,
	curso integer,
	cantidad_inscripciones integer,
	cantidad_bajas integer,
	total integer
);
-----------------------------
-- Moodle
-----------------------------
--Crea el esquema moodle
CREATE SCHEMA moodle;
SET search_path = moodle, pg_catalog;

CREATE TABLE moodle.d_usuario(
  usuario_id integer NOT NULL,
  usuario_codigo character varying,
  apyno character varying,
  plataforma_g3 integer,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_usuario_pkey PRIMARY KEY (usuario_id)
);

CREATE TABLE moodle.d_curso(
  curso_id integer NOT NULL,
  curso_codigo character varying,
  curso_descripcion_corta character varying,
  curso_descripcion_larga character varying,
  plataforma_g3 integer,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_curso_pkey PRIMARY KEY (curso_id)
);

CREATE TABLE moodle.d_rol(
  rol_id integer NOT NULL,
  rol_codigo character varying,
  rol_descripcion character varying,
  plataforma_g3 integer,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_rol_pkey PRIMARY KEY (rol_id)
);

CREATE TABLE moodle.ft_actividades(
  id integer,
  fecha_id date,
  usuario_codigo character varying,
  curso_codigo character varying,
  usuario_id integer,
  curso_id integer,
  rol_id integer,
  persona_id integer,
  alumno_id integer,
  actividad_id integer,
  comision_id integer,
  propuesta_formativa_id integer,
  plan_version_id integer,
  cantidad_inscriptos integer,
  cantidad_bajas integer,
  total_inscriptos integer,
  cantidad integer,
  plataforma_g3 integer,
  CONSTRAINT d_actividades_pkey PRIMARY KEY (id)
);

--Crea el esquema dsa de moodle
CREATE SCHEMA moodle_dsa;
SET search_path = moodle_dsa, pg_catalog;

CREATE TABLE moodle_dsa.d_usuario(
  usuario_id integer NOT NULL,
  usuario_codigo character varying,
  apyno character varying,
  plataforma_g3 integer,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_usuario_pkey PRIMARY KEY (usuario_id)
);

CREATE TABLE moodle_dsa.d_curso(
  curso_id integer NOT NULL,
  curso_codigo character varying,
  curso_descripcion_corta character varying,
  curso_descripcion_larga character varying,
  plataforma_g3 integer,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_curso_pkey PRIMARY KEY (curso_id)
);

CREATE TABLE moodle_dsa.d_rol(
  rol_id integer NOT NULL,
  rol_codigo character varying,
  rol_descripcion character varying,
  plataforma_g3 integer,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_rol_pkey PRIMARY KEY (rol_id)
);

CREATE TABLE moodle_dsa.ft_actividades(
  id serial,
  usuario_codigo character varying,
  curso_codigo character varying,
  usuario_id integer NOT NULL,
  curso_id integer NOT NULL,
  rol_id integer,
  plataforma_g3 integer,
  fecha_id date,
  cantidad integer,
  CONSTRAINT d_actividades_pkey PRIMARY KEY (id)
);
--Esquema moodle_tmp

--Crea el esquema temporal de moodle
CREATE SCHEMA moodle_tmp;
SET search_path = moodle_tmp, pg_catalog;

CREATE TABLE moodle_tmp.d_usuario(
  usuario_codigo text,
  apyno text,
  plataforma_g3 text
);

CREATE TABLE moodle_tmp.d_curso(
  curso_codigo text,
  curso_descripcion_corta text,
  curso_descripcion_larga text,
  plataforma_g3 text
);

CREATE TABLE moodle_tmp.d_rol(
  rol_codigo text,
  rol_descripcion text,
  plataforma_g3 text
);

CREATE TABLE moodle_tmp.d_rol_usuario(
  curso_codigo text,
  usuario_codigo text,
  rol_codigo text,
  plataforma_g3 text
);

CREATE TABLE moodle_tmp.ft_actividades(
  usuario_codigo text,
  curso_codigo text,
  fecha integer,
  cantidad integer,
  plataforma_g3 text
);
-----------------------------
-- Diaguita
-----------------------------
CREATE TABLE diaguita_tmp.d_usuario(
  usuario_codigo text,
  apyno text
);

CREATE TABLE diaguita_dsa.d_usuario(
  id_usuario integer NOT NULL,
  apyno character varying,
  CONSTRAINT d_usuario_pkey PRIMARY KEY (id_usuario)
);

CREATE TABLE diaguita.d_usuario(
  id_usuario integer NOT NULL,
  apyno character varying,
  CONSTRAINT d_usuario_pkey PRIMARY KEY (id_usuario)
);

ALTER TABLE diaguita.ft_compras
  ADD COLUMN numero_mcc character varying;

ALTER TABLE diaguita_dsa.ft_compras
  ADD COLUMN numero_mcc character varying;

ALTER TABLE diaguita_tmp.ft_compras
  ADD COLUMN numero_mcc character varying;


ALTER TABLE diaguita.ft_compras
  ADD COLUMN expediente_ejercicio_conv integer;

ALTER TABLE diaguita_dsa.ft_compras
  ADD COLUMN expediente_ejercicio_conv integer;

ALTER TABLE diaguita_tmp.ft_compras
  ADD COLUMN expediente_ejercicio_conv character varying;

ALTER TABLE diaguita_tmp.ft_compras
  ADD COLUMN usuario_autorizante_conv character varying;
ALTER TABLE diaguita_tmp.ft_compras
  ADD COLUMN fecha_autorizacion_conv character varying;

ALTER TABLE diaguita_dsa.ft_compras
  ADD COLUMN usuario_autorizante_conv integer;
ALTER TABLE diaguita_dsa.ft_compras
  ADD COLUMN fecha_autorizacion_conv date;

ALTER TABLE diaguita.ft_compras
  ADD COLUMN usuario_autorizante_conv integer;
ALTER TABLE diaguita.ft_compras
  ADD COLUMN fecha_autorizacion_conv date;

-----------------------------
-- Portal transparencia
-----------------------------
-- Se agrega el atributo Nivel (de Tipo de Titulo)

DROP TABLE portal_transparencia_dsa.ft_academica;
CREATE TABLE portal_transparencia_dsa.ft_academica -- Informacion de Araucano
(
  id serial NOT NULL,
  anio_id integer,
  unidad_generica_id integer,
  anio_ingreso_id character varying,
  genero_id integer NOT NULL,
  titulo_id integer NOT NULL,
  nivel character varying,
  cant_nip integer, -- Nuevos Inscriptos por Primera vez
  cant_nie integer, -- Nuevos Inscriptos por Equivalencia
  cant_r integer, -- Reinscriptos
  cant_ep integer, -- Egresados que entraron por Primera vez
  cant_ee integer -- Egresados que entraron por Equivalencia
) WITH (
  OIDS=FALSE
);

DROP TABLE portal_transparencia.ft_academica;
CREATE TABLE portal_transparencia.ft_academica
(
	id serial NOT NULL
	, anio integer
	, unidad_generica_desc character varying
	, genero_desc character varying
	, titulo character varying
	, nivel character varying
	, cant_nuevos_inscriptos integer
	, cant_alumnos integer
	, cant_egresados integer
	, CONSTRAINT pk_ft_academica PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);

