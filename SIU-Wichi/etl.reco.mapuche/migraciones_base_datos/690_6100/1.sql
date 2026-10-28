-- Este script es parte de la migración de SIU-Wichi 6.9.0 a 6.10.0

-----------------------------
--Guarani 3
-----------------------------

ALTER TABLE guarani3_tmp.d_titulo_araucano
  ADD COLUMN titulo_araucano_nivel character varying;
  
ALTER TABLE guarani3_dsa.d_titulo_araucano
  ADD COLUMN titulo_araucano_nivel character varying;
  
ALTER TABLE guarani3.d_titulo_araucano
  ADD COLUMN titulo_araucano_nivel character varying;
  
  
-----------------------------
--Mapuche
-----------------------------

ALTER TABLE mapuche_tmp.ft_legajos
  ADD COLUMN domicilio_codigo character varying;
  
ALTER TABLE mapuche_tmp.ft_legajos
  ADD COLUMN direccion character varying;
  
CREATE TABLE mapuche_tmp.d_domicilio (
    	domicilio_codigo VARCHAR,
    	pais_desc VARCHAR,
	provincia_desc VARCHAR,
	codigo_postal_desc VARCHAR,
	localidad_desc VARCHAR
);

ALTER TABLE mapuche_dsa.d_persona
  ADD direccion character varying;

ALTER TABLE mapuche_dsa.d_persona
  ADD domicilio_codigo character varying;
  
CREATE TABLE mapuche_dsa.d_domicilio (
                domicilio_id SMALLINT NOT NULL,
                domicilio_codigo VARCHAR,
                pais_desc VARCHAR,
		provincia_desc VARCHAR,
		codigo_postal_desc VARCHAR,
		localidad_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_domicilio_pk PRIMARY KEY (domicilio_id)
);  
 
ALTER TABLE mapuche.d_persona
  ADD direccion character varying;
ALTER TABLE mapuche.d_persona
  ADD domicilio_codigo character varying;
  
CREATE TABLE mapuche.d_domicilio (
                domicilio_id SMALLINT NOT NULL,
                domicilio_codigo VARCHAR,
                pais_desc VARCHAR,
		provincia_desc VARCHAR,
		codigo_postal_desc VARCHAR,
		localidad_desc VARCHAR,
                fecha_desde DATE,
                fecha_hasta DATE,
                version INT,
                vigente VARCHAR,
                fecha_actualizacion timestamp without time zone,
                CONSTRAINT d_domicilio_pk PRIMARY KEY (domicilio_id)
);  

-----------------------------
--Kolla
-----------------------------

CREATE INDEX d_pregunta_respuesta_busqueda
  ON kolla_dsa.d_pregunta_respuesta
  USING btree
  (instalacion_id, pregunta_codigo, 
  "left"(pregunta_desc::text, 30) COLLATE pg_catalog."default",
  respuesta_codigo,
  "left"(respuesta_desc::text, 30) COLLATE pg_catalog."default",
  "left"(respuesta_codigo_combinado::text, 30) COLLATE pg_catalog."default");

CREATE INDEX d_pregunta_respuesta_instalacion_id_pregunta_codigo
  ON kolla_tmp.d_pregunta_respuesta
  USING btree
  (instalacion_id COLLATE pg_catalog."default", pregunta_codigo COLLATE pg_catalog."default");

CREATE INDEX dsa_ft_entrevista_instalacion_encuestado
  ON kolla_dsa.ft_entrevista
  USING btree
  (instalacion_id, encuestado_id);

  ---------------------------------------
  --Araucano
  ---------------------------------------
  --cuadro13
  ALTER TABLE araucano_tmp.ft_totaldetalless_act_MAX
  ADD COLUMN IdSubSerieOpcion_Edad character varying;  
  
  ALTER TABLE araucano_dsa.academica_ft_cuadro13
    RENAME idserie TO idsubserieopcion;
    
  ALTER TABLE araucano.academica_ft_cuadro13
    RENAME idserie TO idsubserieopcion;
    
  --cuadro 1y 2  
  ALTER TABLE araucano_tmp.ft_cuadros1y2
  ADD COLUMN IdFacultadIngreso character varying; 
  
  ALTER TABLE araucano_dsa.academica_ft_cuadros1y2
  ADD COLUMN IdFacultadIngreso smallint NOT NULL default 0; 
  
  ALTER TABLE araucano.academica_ft_cuadros1y2
  ADD COLUMN IdFacultadIngreso smallint NOT NULL default 0;  
  
  ALTER TABLE araucano.academica_ft_cuadros1y2
    ALTER COLUMN IdFacultadIngreso DROP DEFAULT;
 
 ALTER TABLE araucano_dsa.academica_ft_cuadros1y2
    ALTER COLUMN IdFacultadIngreso DROP DEFAULT;

-- ft_totaldetalles_AE --> cuadro 8
ALTER TABLE araucano_tmp.ft_totaldetalles_AE
  ADD COLUMN IdFacultadIngreso character varying; 
  
  ALTER TABLE araucano_dsa.academica_ft_cuadro8
  ADD COLUMN IdFacultadIngreso smallint NOT NULL default 0; 
  
  ALTER TABLE araucano.academica_ft_cuadro8
  ADD COLUMN IdFacultadIngreso smallint NOT NULL default 0;  
  
  ALTER TABLE araucano.academica_ft_cuadro8
    ALTER COLUMN IdFacultadIngreso DROP DEFAULT;
 
 ALTER TABLE araucano_dsa.academica_ft_cuadro8
    ALTER COLUMN IdFacultadIngreso DROP DEFAULT;
    
-- ft_totaldetallea --> cuadro 3
ALTER TABLE araucano_tmp.ft_totaldetallea
  ADD COLUMN IdFacultadIngreso character varying; 
  
  ALTER TABLE araucano_dsa.academica_ft_cuadro3
  ADD COLUMN IdFacultadIngreso smallint NOT NULL default 0; 
  
  ALTER TABLE araucano.academica_ft_cuadro3
  ADD COLUMN IdFacultadIngreso smallint NOT NULL default 0;  
  
  ALTER TABLE araucano.academica_ft_cuadro3
    ALTER COLUMN IdFacultadIngreso DROP DEFAULT;
 
 ALTER TABLE araucano_dsa.academica_ft_cuadro3
    ALTER COLUMN IdFacultadIngreso DROP DEFAULT;
    
-- ft_totaldetalles_NI -->cuadros 9 y 10
ALTER TABLE araucano_tmp.ft_totaldetalles_NI
  ADD COLUMN IdFacultadIngreso character varying; 
  
  ALTER TABLE araucano_dsa.academica_ft_cuadros9y10
  ADD COLUMN IdFacultadIngreso smallint NOT NULL default 0; 
  
  ALTER TABLE araucano.academica_ft_cuadros9y10
  ADD COLUMN IdFacultadIngreso smallint NOT NULL default 0;  
  
  ALTER TABLE araucano.academica_ft_cuadros9y10
    ALTER COLUMN IdFacultadIngreso DROP DEFAULT;
 
 ALTER TABLE araucano_dsa.academica_ft_cuadros9y10
    ALTER COLUMN IdFacultadIngreso DROP DEFAULT;
    
-- ft_totaldetalles_PMA -->cuadro 7
ALTER TABLE araucano_tmp.ft_totaldetalles_PMA
  ADD COLUMN IdFacultadIngreso character varying; 
  
  ALTER TABLE araucano_dsa.academica_ft_cuadro7
  ADD COLUMN IdFacultadIngreso smallint NOT NULL default 0; 
  
  ALTER TABLE araucano.academica_ft_cuadro7
  ADD COLUMN IdFacultadIngreso smallint NOT NULL default 0;  
  
  ALTER TABLE araucano.academica_ft_cuadro7
    ALTER COLUMN IdFacultadIngreso DROP DEFAULT;
 
 ALTER TABLE araucano_dsa.academica_ft_cuadro7
    ALTER COLUMN IdFacultadIngreso DROP DEFAULT;
    
-- ft_totaldetalless_MAX --> cuadro 12
ALTER TABLE araucano_tmp.ft_totaldetalless_MAX
  ADD COLUMN IdFacultadIngreso character varying; 
  
  ALTER TABLE araucano_dsa.academica_ft_cuadro12
  ADD COLUMN IdFacultadIngreso smallint NOT NULL default 0; 
  
  ALTER TABLE araucano.academica_ft_cuadro12
  ADD COLUMN IdFacultadIngreso smallint NOT NULL default 0;  
  
  ALTER TABLE araucano.academica_ft_cuadro12
    ALTER COLUMN IdFacultadIngreso DROP DEFAULT;
 
 ALTER TABLE araucano_dsa.academica_ft_cuadro12
    ALTER COLUMN IdFacultadIngreso DROP DEFAULT;

-- ft_totaldetalles_TRA --> cuadro 6
ALTER TABLE araucano_tmp.ft_totaldetalles_TRA
  ADD COLUMN IdFacultadIngreso character varying; 
  
  ALTER TABLE araucano_dsa.academica_ft_cuadro6
  ADD COLUMN IdFacultadIngreso smallint NOT NULL default 0; 
  
  ALTER TABLE araucano.academica_ft_cuadro6
  ADD COLUMN IdFacultadIngreso smallint NOT NULL default 0;  
  
  ALTER TABLE araucano.academica_ft_cuadro6
    ALTER COLUMN IdFacultadIngreso DROP DEFAULT;
 
 ALTER TABLE araucano_dsa.academica_ft_cuadro6
    ALTER COLUMN IdFacultadIngreso DROP DEFAULT;
    
-- ft_totaldetallef_NIINST --> cuadro 15
ALTER TABLE araucano_tmp.ft_totaldetallef_NIINST
  ADD COLUMN IdFacultadIngreso character varying; 
  
  ALTER TABLE araucano_dsa.academica_ft_cuadro15
  ADD COLUMN IdFacultadIngreso smallint NOT NULL default 0; 
  
  ALTER TABLE araucano.academica_ft_cuadro15
  ADD COLUMN IdFacultadIngreso smallint NOT NULL default 0;  
  
  ALTER TABLE araucano.academica_ft_cuadro15
    ALTER COLUMN IdFacultadIngreso DROP DEFAULT;
 
 ALTER TABLE araucano_dsa.academica_ft_cuadro15
    ALTER COLUMN IdFacultadIngreso DROP DEFAULT;
    
-- ft_totaldetalles_NIPC cuadro 19
ALTER TABLE araucano_tmp.ft_totaldetalles_NIPC
  ADD COLUMN IdFacultadIngreso character varying; 
  
  ALTER TABLE araucano_dsa.academica_ft_cuadro19
  ADD COLUMN IdFacultadIngreso smallint NOT NULL default 0; 
  
  ALTER TABLE araucano.academica_ft_cuadro19
  ADD COLUMN IdFacultadIngreso smallint NOT NULL default 0;  
  
  ALTER TABLE araucano.academica_ft_cuadro19
    ALTER COLUMN IdFacultadIngreso DROP DEFAULT;
 
 ALTER TABLE araucano_dsa.academica_ft_cuadro19
    ALTER COLUMN IdFacultadIngreso DROP DEFAULT;

-- ft_totaldetalles_NIPM --> cuadro 18
ALTER TABLE araucano_tmp.ft_totaldetalles_NIPM
  ADD COLUMN IdFacultadIngreso character varying; 
  
  ALTER TABLE araucano_dsa.academica_ft_cuadro18
  ADD COLUMN IdFacultadIngreso smallint NOT NULL default 0; 
  
  ALTER TABLE araucano.academica_ft_cuadro18
  ADD COLUMN IdFacultadIngreso smallint NOT NULL default 0;  
  
  ALTER TABLE araucano.academica_ft_cuadro18
    ALTER COLUMN IdFacultadIngreso DROP DEFAULT;
 
 ALTER TABLE araucano_dsa.academica_ft_cuadro18
    ALTER COLUMN IdFacultadIngreso DROP DEFAULT;

-- ft_totaldetalles_NITRA --> cuadro 14
ALTER TABLE araucano_tmp.ft_totaldetalles_NITRA
  ADD COLUMN IdFacultadIngreso character varying; 
  
  ALTER TABLE araucano_dsa.academica_ft_cuadro14
  ADD COLUMN IdFacultadIngreso smallint NOT NULL default 0; 
  
  ALTER TABLE araucano.academica_ft_cuadro14
  ADD COLUMN IdFacultadIngreso smallint NOT NULL default 0;  
  
  ALTER TABLE araucano.academica_ft_cuadro14
    ALTER COLUMN IdFacultadIngreso DROP DEFAULT;
 
 ALTER TABLE araucano_dsa.academica_ft_cuadro14
    ALTER COLUMN IdFacultadIngreso DROP DEFAULT;

-- ft_totaldetalles_PC --> cuadro 17
ALTER TABLE araucano_tmp.ft_totaldetalles_PC
  ADD COLUMN IdFacultadIngreso character varying; 
  
  ALTER TABLE araucano_dsa.academica_ft_cuadro17
  ADD COLUMN IdFacultadIngreso smallint NOT NULL default 0; 
  
  ALTER TABLE araucano.academica_ft_cuadro17
  ADD COLUMN IdFacultadIngreso smallint NOT NULL default 0;  
  
  ALTER TABLE araucano.academica_ft_cuadro17
    ALTER COLUMN IdFacultadIngreso DROP DEFAULT;
 
 ALTER TABLE araucano_dsa.academica_ft_cuadro17
    ALTER COLUMN IdFacultadIngreso DROP DEFAULT;

-- ft_totaldetalles_PM --> cuadro 16
ALTER TABLE araucano_tmp.ft_totaldetalles_PM
  ADD COLUMN IdFacultadIngreso character varying; 
  
  ALTER TABLE araucano_dsa.academica_ft_cuadro16
  ADD COLUMN IdFacultadIngreso smallint NOT NULL default 0; 
  
  ALTER TABLE araucano.academica_ft_cuadro16
  ADD COLUMN IdFacultadIngreso smallint NOT NULL default 0;  
  
  ALTER TABLE araucano.academica_ft_cuadro16
    ALTER COLUMN IdFacultadIngreso DROP DEFAULT;
 
 ALTER TABLE araucano_dsa.academica_ft_cuadro16
    ALTER COLUMN IdFacultadIngreso DROP DEFAULT;

--------------------------------
-- Agrega fuente de dato Sudocu
--------------------------------

INSERT INTO public.d_fuente_dato(fuente_dato_id, fuente_dato_desc) VALUES (14, 'Sudocu');

-------------------------------------
-- Agrega esquemas y tablas de Sudocu
-------------------------------------

CREATE SCHEMA sudocu_tmp;
CREATE SCHEMA sudocu_dsa;
CREATE SCHEMA sudocu;

-- ***************************************************************************
-- sudocu_tmp
-- ***************************************************************************

CREATE TABLE sudocu_tmp.d_area
(
  area_uuid text,
  area_sigla text,
  area_desc text,
  fecha_desde text,
  fecha_hasta text,
  version text,
  vigente text,
  fecha_actualizacion text
);

CREATE TABLE sudocu_tmp.d_usuario
(
  usuario_uuid text, -- text
  usuario_nro_documento text, -- dni
  apyno text, -- apellido, nombre
  email text,
  username text,
  estado text, -- eliminado
  fecha_desde text,
  fecha_hasta text,
  version text,
  vigente text,
  fecha_actualizacion text
);
CREATE TABLE sudocu_tmp.d_estado -- estados de los documentos
(
  estado_id text,
  tipo_documento_id text,
  estado_orden text, -- orden
  estado_desc text, -- nombre del estado
  fecha_desde text,
  fecha_hasta text,
  version text,
  vigente text,
  fecha_actualizacion text
);
CREATE TABLE sudocu_tmp.d_tipo_documento
(
  tipo_documento_id text,
  tipo_documento_sigla text, -- nombre_abrev
  tipo_documento_desc text, -- nombre del tipo de documento
  tipo_documento_visibilidad text, -- visibilidad
  tipo_documento_esencia text, -- esencia
  tipo_documento_tipo_leido text, -- tipo_leido
  tipo_documento_nivel_firma text, -- nivel_firma
  fecha_desde text,
  fecha_hasta text,
  version text,
  vigente text,
  fecha_actualizacion text
);
CREATE TABLE sudocu_tmp.d_documento
(
  documento_numero_asignado text, 
  documento_uuid text, --id
  documento_tipo_documento_id text, -- id_tipo
  documento_titulo text, -- titulo
  documento_fecha text, -- fecha
  documento_estado text, -- estado
  documento_estado_desc text, -- de d_estado
  documento_version text, -- version
  documento_visibilidad text, -- visibilidad
  documento_nro text -- nro
);  

CREATE TABLE sudocu_tmp.d_tipo_evento
(
  tipo_evento_id text, -- id
  tipo_evento_nombre  text, -- nombre
  tipo_evento_nombre_plural  text, -- nombre_plural
  tipo_evento_desc  text, -- descripcion
  fecha_desde text,
  fecha_hasta text,
  version text,
  vigente text,
  fecha_actualizacion text
);
CREATE TABLE sudocu_tmp.d_documento_version
(
  documento_version_uuid text,
  documento_uuid text, --id_original
  documento_version_titulo text, -- titulo
  documento_version_fecha text, -- fecha
  documento_version_nro text, -- nro
  estado text,
  estado_desc text, -- de d_estado
  activo text, --activo
  visibilidad text, -- visibilidad
  fecha_desde text,
  fecha_hasta text,
  version text,
  vigente text,
  fecha_actualizacion text
);  
CREATE TABLE sudocu_tmp.ft_evento
(
  evento_id text,
  documento_uuid text,
  documento_version_uuid text,
  tipo_evento_id text,
  circuito_id text,
  area_origen_id text,
  usuario_origen_id text,
  area_destino_id text,
  usuario_destino_id text,
  autorizacion_nivel text,
  autorizacion_estado text,
  accion text,
  usuario_uuid text,
  fecha_id text,
  anio_id text,
  mes_id text,
  hora_id text,
  fecha text,
  resultado text
);

-- ***************************************************************************
-- sudocu_dsa
-- ***************************************************************************

CREATE TABLE sudocu_dsa.d_area
(
  area_id serial NOT NULL,
  area_uuid uuid,
  area_sigla character varying,
  area_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT pk_dsa_d_area PRIMARY KEY (area_id)
);

CREATE TABLE sudocu_dsa.d_usuario
(
  usuario_id serial,
  usuario_uuid uuid, -- uuid
  usuario_nro_documento character varying, -- dni
  apyno character varying, -- apellido, nombre
  email character varying,
  username character varying,
  estado character varying, -- eliminado
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT pk_d_usuario PRIMARY KEY (usuario_id)
);
CREATE TABLE sudocu_dsa.d_estado -- estados de los documentos
(
  estado_id integer NOT NULL,
  tipo_documento_id integer,
  estado_orden integer, -- orden
  estado_desc character varying, -- nombre del estado
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT pk_d_estado PRIMARY KEY (estado_id)
);
CREATE TABLE sudocu_dsa.d_tipo_documento
(
  tipo_documento_id integer NOT NULL,
  tipo_documento_sigla character varying, -- nombre_abrev
  tipo_documento_desc character varying, -- nombre del tipo de documento
  tipo_documento_visibilidad character varying, -- visibilidad
  tipo_documento_esencia character varying, -- esencia
  tipo_documento_tipo_leido character varying, -- tipo_leido
  tipo_documento_nivel_firma character varying, -- nivel_firma
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT pk_tipo_documento PRIMARY KEY (tipo_documento_id)
);
CREATE TABLE sudocu_dsa.d_documento
(
  documento_id serial NOT NULL,
  documento_numero_asignado character varying, 
  documento_uuid uuid, --id
  documento_tipo_documento_id integer, -- id_tipo
  documento_titulo character varying, -- titulo
  documento_fecha date, -- fecha
  documento_estado integer, -- estado
  documento_estado_desc character varying, -- de d_estado
  documento_version character varying, -- version
  documento_visibilidad character varying, -- visibilidad
  documento_nro json, -- nro
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT pk_d_documento PRIMARY KEY (documento_id)
);  
CREATE TABLE sudocu_dsa.d_tipo_evento
(
  tipo_evento_id integer, -- id
  tipo_evento_nombre  character varying, -- nombre
  tipo_evento_nombre_plural  character varying, -- nombre_plural
  tipo_evento_desc  character varying, -- descripcion
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT pk_d_tipo_evento PRIMARY KEY (tipo_evento_id)
);
CREATE TABLE sudocu_dsa.d_documento_version
(
  documento_version_id serial NOT NULL,
  documento_version_uuid uuid,
  documento_uuid uuid, --id_original
  documento_version_titulo character varying, -- titulo
  documento_version_fecha date, -- fecha
  documento_version_nro json, -- nro
  estado integer,
  estado_desc character varying, -- de d_estado
  activo character varying, --activo
  visibilidad character varying, -- visibilidad
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT pk_d_documento_version PRIMARY KEY (documento_version_id)
);  
CREATE TABLE sudocu_dsa.ft_evento
(
  evento_id integer NOT NULL,
  documento_id integer,
  documento_version_id integer,
  tipo_documento_id integer,
  tipo_evento_id integer,
  circuito_id integer,
  area_origen_id integer,
  usuario_origen_id integer,
  area_destino_id integer,
  usuario_destino_id integer,
  autorizacion_nivel character varying,
  autorizacion_estado character varying,
  accion integer,
  usuario_uuid uuid,
  fecha_id date,
  anio_id integer,
  mes_id integer,
  hora_id character varying,
  fecha timestamp without time zone,
  resultado character varying,
  CONSTRAINT pk_ft_evento PRIMARY KEY (evento_id)
);
-- ************************************************************************************
-- CREACION DE INDICES PARA MEJORAR LA VELOCIDAD
-- ************************************************************************************
CREATE INDEX sudocu_dsa_d_area_area_uuid
  ON sudocu_dsa.d_area
  USING btree
  (area_uuid);
CREATE INDEX sudocu_dsa_d_usuario_usuario_uuid
  ON sudocu_dsa.d_usuario
  USING btree
  (usuario_uuid);
CREATE INDEX sudocu_dsa_d_documento_documento_uuid
  ON sudocu_dsa.d_documento
  USING btree
  (documento_uuid NULLS FIRST);
CREATE INDEX sudocu_dsa_d_documento_version_documento_version_uuid
  ON sudocu_dsa.d_documento_version
  USING btree
  (documento_version_uuid NULLS FIRST);

-- ***************************************************************************
-- sudocu
-- ***************************************************************************

CREATE TABLE sudocu.d_area
(
  area_id integer NOT NULL,
  area_uuid uuid,
  area_sigla character varying,
  area_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT pk_dsa_d_area PRIMARY KEY (area_id)
);

CREATE TABLE sudocu.d_usuario
(
  usuario_id integer NOT NULL,
  usuario_uuid uuid, -- uuid
  usuario_nro_documento character varying, -- dni
  apyno character varying, -- apellido, nombre
  email character varying,
  username character varying,
  estado character varying, -- eliminado
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT pk_d_usuario PRIMARY KEY (usuario_id)
);
CREATE TABLE sudocu.d_estado -- estados de los documentos
(
  estado_id integer NOT NULL,
  tipo_documento_id integer,
  estado_orden integer, -- orden
  estado_desc character varying, -- nombre del estado
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT pk_d_estado PRIMARY KEY (estado_id)
);
CREATE TABLE sudocu.d_tipo_documento
(
  tipo_documento_id integer NOT NULL,
  tipo_documento_sigla character varying, -- nombre_abrev
  tipo_documento_desc character varying, -- nombre del tipo de documento
  tipo_documento_visibilidad character varying, -- visibilidad
  tipo_documento_esencia character varying, -- esencia
  tipo_documento_tipo_leido character varying, -- tipo_leido
  tipo_documento_nivel_firma character varying, -- nivel_firma
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT pk_tipo_documento PRIMARY KEY (tipo_documento_id)
);
CREATE TABLE sudocu.d_documento
(
  documento_id integer NOT NULL,
  documento_numero_asignado character varying, 
  documento_uuid uuid, --id
  documento_tipo_documento_id integer, -- id_tipo
  documento_titulo character varying, -- titulo
  documento_fecha date, -- fecha
  documento_estado integer, -- estado
  documento_estado_desc character varying, -- de d_estado
  documento_version character varying, -- version
  documento_visibilidad character varying, -- visibilidad
  documento_nro json, -- nro
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT pk_d_documento PRIMARY KEY (documento_id)
);  
CREATE TABLE sudocu.d_tipo_evento
(
  tipo_evento_id integer, -- id
  tipo_evento_nombre  character varying, -- nombre
  tipo_evento_nombre_plural  character varying, -- nombre_plural
  tipo_evento_desc  character varying, -- descripcion
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT pk_d_tipo_evento PRIMARY KEY (tipo_evento_id)
);
CREATE TABLE sudocu.d_documento_version
(
  documento_version_id integer NOT NULL,
  documento_version_uuid uuid,
  documento_uuid uuid, --id_original
  documento_version_titulo character varying, -- titulo
  documento_version_fecha date, -- fecha
  documento_version_nro json, -- nro
  estado integer,
  estado_desc character varying, -- de d_estado
  activo character varying, --activo
  visibilidad character varying, -- visibilidad
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT pk_d_documento_version PRIMARY KEY (documento_version_id)
);  
CREATE TABLE sudocu.ft_evento
(
  evento_id integer NOT NULL,
  documento_id integer,
  documento_version_id integer,
  tipo_documento_id integer,
  tipo_evento_id integer,
  circuito_id integer,
  area_origen_id integer,
  usuario_origen_id integer,
  area_destino_id integer,
  usuario_destino_id integer,
  autorizacion_nivel character varying,
  autorizacion_estado character varying,
  accion integer,
  usuario_uuid uuid,
  fecha_id date,
  anio_id integer,
  mes_id integer,
  hora_id character varying,
  fecha timestamp without time zone,
  resultado character varying,
  CONSTRAINT pk_ft_evento PRIMARY KEY (evento_id)
);

-- ***************************************************************************
-- ***************************************************************************



