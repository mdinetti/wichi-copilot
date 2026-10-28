-- *******************************************************************************************************************
-- Crea esquemas para el portal de transparencia, tanto el de produccion como el dsa
-- *******************************************************************************************************************
CREATE SCHEMA portal_transparencia_dsa
  AUTHORIZATION postgres;

-- CREA TABLA CON AÑOS

CREATE TABLE portal_transparencia_dsa.d_anio
(
  anio_id integer NOT NULL
)
WITH (
  OIDS=FALSE
);
ALTER TABLE portal_transparencia_dsa.d_anio
  OWNER TO postgres;

-- CREA TABLA CON MESES

CREATE TABLE portal_transparencia_dsa.d_mes
(
  mes_id integer NOT NULL,
  mes_desc character varying NOT NULL
)
WITH (
  OIDS=FALSE
);
ALTER TABLE portal_transparencia_dsa.d_mes
  OWNER TO postgres;

-- CREA TABLA CON DESCRIPCIONES DE UNIDADES GENÉRICAS

CREATE TABLE portal_transparencia_dsa.d_unidad_generica
(
  unidad_generica_id serial NOT NULL,
  institucion_id integer NOT NULL,
  unidad_generica_desc character varying NOT NULL,
  rol_desc character varying NOT NULL
)
WITH (
  OIDS=FALSE
);
ALTER TABLE portal_transparencia_dsa.d_unidad_generica
  OWNER TO postgres;

-- CREA TABLA CON DESCRIPCIONES DE GENERO

CREATE TABLE portal_transparencia_dsa.d_genero
(
  genero_id integer NOT NULL,
  genero_codigo character varying,
  genero_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone
)
WITH (
  OIDS=FALSE
);
ALTER TABLE portal_transparencia_dsa.d_genero
  OWNER TO postgres;

-- CREA TABLA CON DESCRIPCIONES DE TITULOS

CREATE TABLE portal_transparencia_dsa.academica_d_titulos
(
  idtitulo serial NOT NULL,
  idtitulo_ona integer NOT NULL,
  titulo character varying(255),
  rama character varying(255),
  disciplina character varying(255),
  area character varying(255),
  idrda integer,
  fechaact timestamp without time zone
) WITH (
  OIDS=FALSE
);
ALTER TABLE portal_transparencia_dsa.academica_d_titulos
	OWNER TO postgres;

-- CREA TABLE CON DESCRIPCIONES DE CARGOS

CREATE TABLE portal_transparencia_dsa.map_dw_lt_categoriascargo
(
  categoria_id integer NOT NULL,
  categoria_id_map character varying,
  categoria_desc character varying,
  escalafon_id_map character varying,
  escalafon_desc character varying,
  dedicacion_id_map character varying,
  dedicacion_desc character varying,
  estadolaboral_id_map character varying,
  estadolaboral_desc character varying,
  fechadesde date,
  fechahasta date,
  version integer,
  vigente character varying,
  fechaact timestamp without time zone
) WITH (
  OIDS=FALSE
);
ALTER TABLE portal_transparencia_dsa.map_dw_lt_categoriascargo
  OWNER TO postgres;

-- CREA TABLA CON DESCRIPCION DE CATALOGO PARA PATRIMONIO

CREATE TABLE portal_transparencia_dsa.d_catalogo_bien
(
  catalogo_bien_id serial NOT NULL,
  catalogo_bien_nivel1_codigo integer,
  catalogo_bien_nivel1_desc text,
  catalogo_bien_nivel2_codigo integer,
  catalogo_bien_nivel2_desc text,
  catalogo_bien_nivel3_codigo integer,
  catalogo_bien_nivel3_desc text,
  catalogo_bien_nivel4_codigo integer,
  catalogo_bien_nivel4_desc text,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone
) WITH (
  OIDS=FALSE
);
ALTER TABLE portal_transparencia_dsa.d_catalogo_bien
  OWNER TO postgres;

-- CREA TABLA CON DESCRIPCIONES DE OBJETO DEL GASTO 

CREATE TABLE portal_transparencia_dsa.d_objeto_del_gasto
(
  objeto_del_gasto_id integer NOT NULL,
  objeto_del_gasto_codigo character varying,
  resumen_desc character varying,
  inciso_desc character varying,
  partida_principal_desc character varying,
  partida_parcial_desc character varying,
  objeto_del_gasto_desc character varying,
  orden integer,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone
) WITH (
  OIDS=FALSE
);
ALTER TABLE portal_transparencia_dsa.d_objeto_del_gasto
  OWNER TO postgres;

-- CREA TABLA CON DESCRIPCIONES DE FINALIDAD Y FUNCION

CREATE TABLE portal_transparencia_dsa.d_finalidad_funcion
(
  finalidad_funcion_id integer NOT NULL,
  finalidad_codigo smallint,
  funcion_codigo smallint,
  finalidad_desc character varying,
  funcion_desc character varying,
  finalidad_funcion_combo_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone
) WITH (
  OIDS=FALSE
);
ALTER TABLE portal_transparencia_dsa.d_finalidad_funcion
  OWNER TO postgres;

--- CREA TABLA CON DESCRIPCIONES DE FUENTES DE FINANCIAMIENTO

CREATE TABLE portal_transparencia_dsa.d_fuente
(
  fuente_id integer NOT NULL,
  fuente_codigo smallint,
  fuente_desc character varying,
  fuentecompleto_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT pk_dsa_d_fuente PRIMARY KEY (fuente_id)
) WITH (
  OIDS=FALSE
);
ALTER TABLE portal_transparencia_dsa.d_fuente
  OWNER TO postgres;

--- CREA TABLA CON DESCRIPCIONES DE PROVEEDORES

CREATE TABLE portal_transparencia_dsa.d_proveedor
(
  proveedor_id integer NOT NULL,
  razon_social character varying,
  nombre_fantasia character varying,
  email character varying,
  cbu character varying,
  cuit character varying,
  descripcion_domicilio character varying,
  nombre_localidad character varying
)
WITH (
  OIDS=FALSE
);
ALTER TABLE portal_transparencia_dsa.d_proveedor
	OWNER TO postgres;

-- CREA TABLA PARA INFORMACION DE PRESUPUESTO

CREATE TABLE portal_transparencia_dsa.ft_presupuesto
(
  id serial NOT NULL,
  anio_id integer,
  mes_id integer,
  unidad_generica_id integer,
  objeto_del_gasto_id integer,
  finalidad_funcion_id integer,
  fuente_id integer,
  credito numeric(13,2),
  devengado numeric(13,2)
) WITH (
  OIDS=FALSE
);
ALTER TABLE portal_transparencia_dsa.ft_presupuesto
	OWNER TO postgres;

-- CREA TABLA PARA INFORMACION DE COMPRAS

CREATE TABLE portal_transparencia_dsa.ft_compras
(
  id serial NOT NULL,
  anio_id integer,
  mes_id integer,
  unidad_generica_id integer,
  proveedor_id integer NOT NULL,
  rubro_id integer NOT NULL,
  importe_total NUMERIC(19,2)
) WITH (
  OIDS=FALSE
);
ALTER TABLE portal_transparencia_dsa.ft_compras
	OWNER TO postgres;

-- CREA TABLA PARA INFORMACION DE PATRIMONIO

CREATE TABLE portal_transparencia_dsa.ft_patrimonio
(
  id serial NOT NULL,
  anio_id integer,
  mes_id integer,
  unidad_generica_id integer,
  catalogo_bien_id integer NOT NULL,
  cant_bienes integer
  , total_valor_bienes numeric(13,2)
  , total_valor_residual_bienes numeric(13,2)
) WITH (
  OIDS=FALSE
);
ALTER TABLE portal_transparencia_dsa.ft_patrimonio
	OWNER TO postgres;

-- CREA TABLA PARA INFORMACION DE RECURSOS HUMANOS

CREATE TABLE portal_transparencia_dsa.ft_cargos
(
  id serial NOT NULL,
  anio_id integer,
  mes_id integer,
  unidad_generica_id integer,
  genero_id integer NOT NULL,
  escalafon_id character varying,
  cant_cargos integer
) WITH (
  OIDS=FALSE
);
ALTER TABLE portal_transparencia_dsa.ft_cargos
	OWNER TO postgres;

-- CREA TABLA PARA INFORMACION ACADEMICA 

CREATE TABLE portal_transparencia_dsa.ft_academica -- Informacion de Araucano
(
  id serial NOT NULL,
  anio_id integer,
  unidad_generica_id integer,
  anio_ingreso_id character varying,
  genero_id integer NOT NULL,
  titulo_id integer NOT NULL,
  cant_nip integer, -- Nuevos Inscriptos por Primera vez
  cant_nie integer, -- Nuevos Inscriptos por Equivalencia
  cant_r integer, -- Reinscriptos
  cant_ep integer, -- Egresados que entraron por Primera vez
  cant_ee integer -- Egresados que entraron por Equivalencia
) WITH (
  OIDS=FALSE
);
ALTER TABLE portal_transparencia_dsa.ft_academica
	OWNER TO postgres;

-- Schema: portal_transparencia

-- *******************************************************************************************************************
CREATE SCHEMA portal_transparencia
  AUTHORIZATION postgres;

CREATE TABLE portal_transparencia.ft_presupuesto 
(
	id serial NOT NULL
	, anio integer
	, unidad_generica_desc character varying
	, inciso_desc character varying
	, fuente_desc character varying
        , credito numeric(13,2)
	, devengado numeric(13,2)
	, CONSTRAINT pk_ft_presupuesto PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);
ALTER TABLE portal_transparencia.ft_presupuesto 
	OWNER TO postgres;

CREATE TABLE portal_transparencia.ft_compras 
(
	id serial NOT NULL
	, anio integer
	, unidad_generica_desc character varying
	, razon_social character varying
	, rubro_desc character varying
	, importe_total numeric(19,2)
	, CONSTRAINT pk_ft_compras PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);
ALTER TABLE portal_transparencia.ft_compras 
	OWNER TO postgres;

CREATE TABLE portal_transparencia.ft_patrimonio
(
	id serial NOT NULL
	, anio integer
	, unidad_generica_desc character varying
	, inciso_desc character varying
	, partida_parcial_desc character varying
	, cant_bienes integer
	, total_valor_bienes numeric(13,2)
	, total_valor_residual_bienes numeric(13,2)
	, CONSTRAINT pk_ft_patrimonio PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);
ALTER TABLE portal_transparencia.ft_patrimonio 
	OWNER TO postgres;

CREATE TABLE portal_transparencia.ft_cargos
(
	id serial NOT NULL
	, anio integer
	, unidad_generica_desc character varying
	, genero_desc character varying
	, escalafon_desc character varying
	, cant_cargos integer
	, CONSTRAINT pk_ft_cargos PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);
ALTER TABLE portal_transparencia.ft_cargos 
	OWNER TO postgres;

CREATE TABLE portal_transparencia.ft_academica
(
	id serial NOT NULL
	, anio integer
	, unidad_generica_desc character varying
	, genero_desc character varying
	, titulo character varying
	, cant_nuevos_inscriptos integer
	, cant_alumnos integer
	, cant_egresados integer
	, CONSTRAINT pk_ft_academica PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);
ALTER TABLE portal_transparencia.ft_academica 
	OWNER TO postgres;
