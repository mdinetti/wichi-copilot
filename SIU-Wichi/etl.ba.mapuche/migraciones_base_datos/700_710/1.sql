-- Este script es parte de la migración de SIU-Wichi 7.0.0 a 7.1.0

-- **************************************************************************
-- Para mostrar los nuevos inscriptos EN ACTIVIDAD en Transparencia para UNNE
-- **************************************************************************
----------------------------------------------------------------------------
-- Agrega campo cant_ni_en_actividad en portal_transparencia_dsa
----------------------------------------------------------------------------
ALTER TABLE IF EXISTS portal_transparencia_dsa.ft_academica
    ADD COLUMN cant_ni_en_actividad integer;
COMMENT ON COLUMN portal_transparencia_dsa.ft_academica.cant_ni_en_actividad
    IS 'Nuevos Inscriptos en Actividad tomados del cuadro 18.';
----------------------------------------------------------------------------
-- Agrega campo cant_nuevos_inscriptos_en_actividad en portal_transparencia
----------------------------------------------------------------------------
ALTER TABLE IF EXISTS portal_transparencia.ft_academica
    ADD COLUMN cant_nuevos_inscriptos_en_actividad integer;
COMMENT ON COLUMN portal_transparencia.ft_academica.cant_nuevos_inscriptos_en_actividad
    IS 'Se toma de Cuadro 18: Nuevos Inscriptos con 1 o más materias aprobadas por Facultad. Excluir no dispone información';
-- **************************************************************************
-- **************************************************************************

-----------------------------
--Public
----------------------------- 
-- Agregar campo con_subfuente

ALTER TABLE IF EXISTS public.d_fuente_dato
    ADD COLUMN con_subfuente boolean DEFAULT false;

-- Crear tabla para las subfuentes
CREATE TABLE IF NOT EXISTS public.d_subfuente
(
    subfuente_id serial,
    fuente_dato_id integer,
    subfuente_desc character varying,
    habilitada boolean,
    CONSTRAINT pk_d_subfuente PRIMARY KEY (subfuente_id),
    CONSTRAINT d_subfuente_fuente_dato_id_fkey FOREIGN KEY (fuente_dato_id)
        REFERENCES public.d_fuente_dato (fuente_dato_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

INSERT INTO public.d_subfuente(
	subfuente_id, fuente_dato_id, subfuente_desc, habilitada)
	VALUES (0, 0, 'Sin Subfuente', false);
		
--Agregar la subfuente a la instalación		
ALTER TABLE IF EXISTS public.d_instalacion
    ADD COLUMN subfuente_id integer DEFAULT 0;	

--Crear tabla de configuración de parámetros de la fuente
CREATE TABLE public.parametros_fuente_dato (
    fuente_dato_id INTEGER,
    esquema character varying,
    clave character varying, 
    valor character varying,  
    CONSTRAINT parametros_fuente_dato_pk PRIMARY KEY (fuente_dato_id, clave)
);

--Seteo las dimensiones de mapuche 
INSERT INTO public.parametros_fuente_dato(fuente_dato_id, esquema, clave, valor) VALUES (2, 'mapuche', 'd_agrupamiento', 'Comun');
INSERT INTO public.parametros_fuente_dato(fuente_dato_id, esquema, clave, valor) VALUES (2, 'mapuche', 'd_carrera', 'Comun');
INSERT INTO public.parametros_fuente_dato(fuente_dato_id, esquema, clave, valor) VALUES (2, 'mapuche', 'd_categoriascargo', 'Comun');
INSERT INTO public.parametros_fuente_dato(fuente_dato_id, esquema, clave, valor) VALUES (2, 'mapuche', 'd_clasificacion_cargo', 'Comun');
INSERT INTO public.parametros_fuente_dato(fuente_dato_id, esquema, clave, valor) VALUES (2, 'mapuche', 'd_concepto', 'Comun');
INSERT INTO public.parametros_fuente_dato(fuente_dato_id, esquema, clave, valor) VALUES (2, 'mapuche', 'd_dependenciadesemp', 'Comun');
INSERT INTO public.parametros_fuente_dato(fuente_dato_id, esquema, clave, valor) VALUES (2, 'mapuche', 'd_dependenciadesig', 'Comun');
INSERT INTO public.parametros_fuente_dato(fuente_dato_id, esquema, clave, valor) VALUES (2, 'mapuche', 'd_estadocivil', 'Comun');
INSERT INTO public.parametros_fuente_dato(fuente_dato_id, esquema, clave, valor) VALUES (2, 'mapuche', 'd_finalidad_funcion', 'Comun');
INSERT INTO public.parametros_fuente_dato(fuente_dato_id, esquema, clave, valor) VALUES (2, 'mapuche', 'd_grupo_presupuestario', 'Comun');
INSERT INTO public.parametros_fuente_dato(fuente_dato_id, esquema, clave, valor) VALUES (2, 'mapuche', 'd_identidad_genero', 'Comun');
INSERT INTO public.parametros_fuente_dato(fuente_dato_id, esquema, clave, valor) VALUES (2, 'mapuche', 'd_licencia', 'Comun');
INSERT INTO public.parametros_fuente_dato(fuente_dato_id, esquema, clave, valor) VALUES (2, 'mapuche', 'd_liquidacion', 'Comun');
INSERT INTO public.parametros_fuente_dato(fuente_dato_id, esquema, clave, valor) VALUES (2, 'mapuche', 'd_nivelestudio', 'Comun');
INSERT INTO public.parametros_fuente_dato(fuente_dato_id, esquema, clave, valor) VALUES (2, 'mapuche', 'd_nivel_funcion', 'Comun');
INSERT INTO public.parametros_fuente_dato(fuente_dato_id, esquema, clave, valor) VALUES (2, 'mapuche', 'd_obra_social', 'Comun');
INSERT INTO public.parametros_fuente_dato(fuente_dato_id, esquema, clave, valor) VALUES (2, 'mapuche', 'd_objetodelgasto', 'Comun');
INSERT INTO public.parametros_fuente_dato(fuente_dato_id, esquema, clave, valor) VALUES (2, 'mapuche', 'd_persona', 'Comun');
INSERT INTO public.parametros_fuente_dato(fuente_dato_id, esquema, clave, valor) VALUES (2, 'mapuche', 'd_redprogramatica', 'Comun');
INSERT INTO public.parametros_fuente_dato(fuente_dato_id, esquema, clave, valor) VALUES (2, 'mapuche', 'd_regional', 'Comun');
INSERT INTO public.parametros_fuente_dato(fuente_dato_id, esquema, clave, valor) VALUES (2, 'mapuche', 'd_tarea', 'Comun');
INSERT INTO public.parametros_fuente_dato(fuente_dato_id, esquema, clave, valor) VALUES (2, 'mapuche', 'd_tipo_documento', 'Comun');
INSERT INTO public.parametros_fuente_dato(fuente_dato_id, esquema, clave, valor) VALUES (2, 'mapuche', 'd_tipoplantacaracter', 'Comun');
INSERT INTO public.parametros_fuente_dato(fuente_dato_id, esquema, clave, valor) VALUES (2, 'mapuche', 'd_titulo', 'Comun');
INSERT INTO public.parametros_fuente_dato(fuente_dato_id, esquema, clave, valor) VALUES (2, 'mapuche', 'd_unidad_presupuestaria', 'Comun');

--Configuro CARGA LEGAJOS PASIVOS
INSERT INTO public.parametros_fuente_dato(fuente_dato_id, esquema, clave, valor) VALUES (2, 'mapuche', 'carga_legajos_pasivos', 'No');

-----------------------------
--Mapuche
-----------------------------
--Agregar la subfuente a todas las dimensiones de mapuche
--DSA

ALTER TABLE IF EXISTS mapuche_dsa.d_grupo_presupuestario
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS mapuche_dsa.d_finalidad_funcion
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche_dsa.d_redprogramatica
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche_dsa.d_objetodelgasto
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche_dsa.d_liquidacion
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche_dsa.d_unidad_presupuestaria
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche_dsa.d_concepto
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche_dsa.d_dependenciadesemp
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche_dsa.d_regional
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche_dsa.d_agrupamiento
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche_dsa.d_tipoplantacaracter
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche_dsa.d_categoriascargo
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche_dsa.d_dependenciadesig
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche_dsa.d_persona
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche_dsa.d_titulo
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche_dsa.d_licencia
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche_dsa.d_nivelestudio
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche_dsa.d_estadocivil
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche_dsa.d_tarea
ADD COLUMN subfuente_id integer DEFAULT 0;  

ALTER TABLE IF EXISTS mapuche_dsa.ft_cargos
    ADD COLUMN subfuente_id integer DEFAULT 0;
    
ALTER TABLE IF EXISTS mapuche_dsa.ft_legajos
    ADD COLUMN subfuente_id integer DEFAULT 0;    

ALTER TABLE IF EXISTS mapuche_dsa.ft_liqconceptosxcargos
    ADD COLUMN subfuente_id integer DEFAULT 0;
    
--DW

ALTER TABLE IF EXISTS mapuche.d_grupo_presupuestario
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS mapuche.d_finalidad_funcion
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche.d_redprogramatica
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche.d_objetodelgasto
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche.d_liquidacion
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche.d_unidad_presupuestaria
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche.d_concepto
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche.d_dependenciadesemp
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche.d_regional
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche.d_agrupamiento
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche.d_tipoplantacaracter
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche.d_categoriascargo
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche.d_dependenciadesig
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche.d_persona
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche.d_titulo
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche.d_licencia
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche.d_nivelestudio
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche.d_estadocivil
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS  mapuche.d_tarea
ADD COLUMN subfuente_id integer DEFAULT 0;

ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN subfuente_id integer DEFAULT 0;

-- Agregar nuevos atributos y dimensiones
--TMP
ALTER TABLE IF EXISTS mapuche_tmp.ft_legajos
    ADD COLUMN nro_ficha integer;
ALTER TABLE IF EXISTS mapuche_tmp.ft_legajos
    ADD COLUMN tipo_docum character varying;
ALTER TABLE IF EXISTS mapuche_tmp.ft_legajos
    ADD COLUMN nro_docum character varying;
ALTER TABLE IF EXISTS mapuche_tmp.ft_legajos
    ADD COLUMN anioalta integer;
ALTER TABLE IF EXISTS mapuche_tmp.ft_legajos
    ADD COLUMN mesalta integer;
ALTER TABLE IF EXISTS mapuche_tmp.ft_legajos
    ADD COLUMN anioactualizacion integer;
ALTER TABLE IF EXISTS mapuche_tmp.ft_legajos
    ADD COLUMN mesactualizacion integer;
ALTER TABLE IF EXISTS mapuche_tmp.ft_legajos
    ADD COLUMN identidad_genero character varying;
ALTER TABLE IF EXISTS mapuche_tmp.ft_legajos
    ADD COLUMN depdesemp_cabecera character varying;
ALTER TABLE IF EXISTS mapuche_tmp.ft_legajos
    ADD COLUMN codc_obsoc character varying;
ALTER TABLE IF EXISTS mapuche_tmp.ft_legajos
    ADD COLUMN fec_ingreso date;
ALTER TABLE IF EXISTS mapuche_tmp.ft_legajos
    ADD COLUMN fecha_recibo date;
ALTER TABLE IF EXISTS mapuche_tmp.ft_legajos
    ADD COLUMN codigosituacion character varying;
ALTER TABLE IF EXISTS mapuche_tmp.ft_legajos
    ADD COLUMN codigocondicion character varying;
ALTER TABLE IF EXISTS mapuche_tmp.ft_legajos
    ADD COLUMN codigoactividad character varying;
ALTER TABLE IF EXISTS mapuche_tmp.ft_legajos
    ADD COLUMN codigozona character varying;
ALTER TABLE IF EXISTS mapuche_tmp.ft_legajos
    ADD COLUMN porcaporteadicss character varying;
ALTER TABLE IF EXISTS mapuche_tmp.ft_legajos
    ADD COLUMN provincialocalidad character varying;
ALTER TABLE IF EXISTS mapuche_tmp.ft_legajos
    ADD COLUMN nro_afili character varying;    
ALTER TABLE IF EXISTS mapuche_tmp.ft_legajos
    ADD COLUMN titulo_liq character varying;
ALTER TABLE IF EXISTS mapuche_tmp.ft_legajos
    ADD COLUMN cbu character varying;    
    
ALTER TABLE IF EXISTS mapuche_tmp.ft_cargos
    ADD COLUMN porc_aplic character varying;
ALTER TABLE IF EXISTS mapuche_tmp.ft_cargos
    ADD COLUMN nro_cargo_ant character varying;
ALTER TABLE IF EXISTS mapuche_tmp.ft_cargos
    ADD COLUMN clasif_cargo_cod character varying;
ALTER TABLE IF EXISTS mapuche_tmp.ft_cargos
    ADD COLUMN carrera_cod character varying;    
ALTER TABLE IF EXISTS mapuche_tmp.ft_cargos
    ADD COLUMN nivel_funcion character varying;
ALTER TABLE IF EXISTS mapuche_tmp.ft_cargos
    ADD COLUMN imp_basico_cat numeric(10,2);
ALTER TABLE IF EXISTS mapuche_tmp.ft_cargos
    ADD COLUMN hs_dedic_cargo numeric(11,2);    
    
ALTER TABLE IF EXISTS mapuche_tmp.ft_liqconceptosxcargos
    ADD COLUMN novedad_1 numeric(11,2);
ALTER TABLE IF EXISTS mapuche_tmp.ft_liqconceptosxcargos
    ADD COLUMN novedad_2 numeric(11,2);
    
CREATE TABLE mapuche_tmp.d_carrera (
    carrera_codigo VARCHAR,
    carrera_desc VARCHAR
);

CREATE TABLE mapuche_tmp.d_clasificacion_cargo (
    clasificacion_cargo_codigo VARCHAR,
    clasificacion_cargo_desc VARCHAR
);    

CREATE TABLE mapuche_tmp.d_identidad_genero (
    identidad_genero_codigo VARCHAR,
    identidad_genero_desc VARCHAR
);

CREATE TABLE mapuche_tmp.d_nivel_funcion (
    nivel_funcion_codigo VARCHAR,
    nivel_funcion_desc VARCHAR
);  

CREATE TABLE mapuche_tmp.d_obra_social (
    obra_social_codigo VARCHAR,
    obra_social_desc VARCHAR
);

CREATE TABLE mapuche_tmp.d_tipo_documento (
    tipo_documento_codigo VARCHAR,
    tipo_documento_desc VARCHAR
);

--DSA
CREATE TABLE mapuche_dsa.d_carrera (
	carrera_id SMALLINT NOT NULL,
   	carrera_codigo character varying,
   	carrera_desc character varying,
   	subfuente_id integer,
	fecha_desde date,
	fecha_hasta date,
	version integer,
	vigente character varying,
	fecha_actualizacion timestamp without time zone,
	CONSTRAINT d_carrera_pk PRIMARY KEY (carrera_id)
);

CREATE TABLE mapuche_dsa.d_clasificacion_cargo (
	clasificacion_cargo_id SMALLINT NOT NULL,
    	clasificacion_cargo_codigo character varying,
    	clasificacion_cargo_desc character varying,
    	subfuente_id integer,
	fecha_desde date,
	fecha_hasta date,
	version integer,
	vigente character varying,
	fecha_actualizacion timestamp without time zone,
	CONSTRAINT d_clasificacion_cargo_pk PRIMARY KEY (clasificacion_cargo_id)
);

CREATE TABLE mapuche_dsa.d_identidad_genero (
	identidad_genero_id SMALLINT NOT NULL,
    	identidad_genero_codigo character varying,
    	identidad_genero_desc character varying,
    	subfuente_id integer,
	fecha_desde date,
	fecha_hasta date,
	version integer,
	vigente character varying,
	fecha_actualizacion timestamp without time zone,
	CONSTRAINT d_identidad_genero_pk PRIMARY KEY (identidad_genero_id)
);

CREATE TABLE mapuche_dsa.d_nivel_funcion (
	nivel_funcion_id SMALLINT NOT NULL,
    	nivel_funcion_codigo character varying,
    	nivel_funcion_desc character varying,
    	subfuente_id integer,
	fecha_desde date,
	fecha_hasta date,
	version integer,
	vigente character varying,
	fecha_actualizacion timestamp without time zone,
	CONSTRAINT d_nivel_funcion_pk PRIMARY KEY (nivel_funcion_id)
);

CREATE TABLE mapuche_dsa.d_obra_social (
	obra_social_id SMALLINT NOT NULL,
    	obra_social_codigo character varying,
    	obra_social_desc character varying,
    	subfuente_id integer,
	fecha_desde date,
	fecha_hasta date,
	version integer,
	vigente character varying,
	fecha_actualizacion timestamp without time zone,
	CONSTRAINT d_obra_social_pk PRIMARY KEY (obra_social_id)
);

CREATE TABLE mapuche_dsa.d_tipo_documento (
	tipo_documento_id SMALLINT NOT NULL,
    	tipo_documento_codigo character varying,
    	tipo_documento_desc character varying,
    	subfuente_id integer,
	fecha_desde date,
	fecha_hasta date,
	version integer,
	vigente character varying,
	fecha_actualizacion timestamp without time zone,
	CONSTRAINT d_tipo_documento_pk PRIMARY KEY (tipo_documento_id)
); 

CREATE TABLE mapuche_dsa.d_persona_anexos
(
    persona_anexos_id integer NOT NULL,
    subfuente_id integer,
    legajo_codigo character varying,
    anioactualizacion_id integer,
    mesactualizacion_id integer,
    nro_afili character varying,
    codigosituacion integer,
    codigocondicion integer,
    codigoactividad integer,
    codigozona character varying,
    porcaporteadicss numeric(15,2),
    provincialocalidad character varying,
    cbu character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone,
    CONSTRAINT d_persona_anexos_pk PRIMARY KEY (persona_anexos_id)
);

ALTER TABLE IF EXISTS mapuche_dsa.d_persona
    ADD COLUMN nro_ficha INTEGER;
ALTER TABLE IF EXISTS mapuche_dsa.d_persona
    ADD COLUMN nro_documento INTEGER;
ALTER TABLE IF EXISTS mapuche_dsa.d_persona
    ADD COLUMN anioalta_id integer;
ALTER TABLE IF EXISTS mapuche_dsa.d_persona
    ADD COLUMN mesalta_id integer;
ALTER TABLE IF EXISTS mapuche_dsa.d_persona
    ADD COLUMN fecha_ingreso date;
ALTER TABLE IF EXISTS mapuche_dsa.d_persona
    ADD COLUMN fecha_recibo date;

    
ALTER TABLE IF EXISTS mapuche_dsa.ft_cargos
    ADD COLUMN porc_aplic character varying;
ALTER TABLE IF EXISTS mapuche_dsa.ft_cargos
    ADD COLUMN nro_cargo_ant INTEGER;
ALTER TABLE IF EXISTS mapuche_dsa.ft_cargos
    ADD COLUMN clasificacion_cargo_id SMALLINT;
ALTER TABLE IF EXISTS mapuche_dsa.ft_cargos
    ADD COLUMN carrera_id SMALLINT;    
ALTER TABLE IF EXISTS mapuche_dsa.ft_cargos
    ADD COLUMN nivel_funcion_id SMALLINT;
ALTER TABLE IF EXISTS mapuche_dsa.ft_cargos
    ADD COLUMN imp_basico_cat numeric(10,2);
ALTER TABLE IF EXISTS mapuche_dsa.ft_cargos
    ADD COLUMN hsdedicacioncargo_id SMALLINT;    
    
    
ALTER TABLE IF EXISTS mapuche_dsa.ft_legajos
    ADD COLUMN tipo_documento_id SMALLINT;
ALTER TABLE IF EXISTS mapuche_dsa.ft_legajos
    ADD COLUMN identidad_genero_id SMALLINT;
ALTER TABLE IF EXISTS mapuche_dsa.ft_legajos
    ADD COLUMN depdesemp_cabecera_id SMALLINT;
ALTER TABLE IF EXISTS mapuche_dsa.ft_legajos
    ADD COLUMN obra_social_id SMALLINT;
ALTER TABLE IF EXISTS mapuche_dsa.ft_legajos
    ADD COLUMN titulo_liq_id SMALLINT;
ALTER TABLE IF EXISTS mapuche_dsa.ft_legajos
    ADD COLUMN persona_anexos_id INTEGER;      
    
ALTER TABLE IF EXISTS mapuche_dsa.ft_liqconceptosxcargos
    ADD COLUMN novedad_1 numeric(11,2);
ALTER TABLE IF EXISTS mapuche_dsa.ft_liqconceptosxcargos
    ADD COLUMN novedad_2 numeric(11,2);
ALTER TABLE IF EXISTS mapuche_dsa.ft_liqconceptosxcargos
    ADD COLUMN centro_costos character varying;    
    
--DW
CREATE TABLE mapuche.d_carrera (
	carrera_id SMALLINT NOT NULL,
   	carrera_codigo character varying,
   	carrera_desc character varying,
   	subfuente_id integer,
	fecha_desde date,
	fecha_hasta date,
	version integer,
	vigente character varying,
	fecha_actualizacion timestamp without time zone,
	CONSTRAINT d_carrera_pk PRIMARY KEY (carrera_id)
);

INSERT INTO mapuche.d_carrera(
	carrera_id, carrera_codigo, carrera_desc, subfuente_id, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
	VALUES (-1,'-1','VALOR ERRONEO',0,'1900-01-01','2199-12-31',1,'Y',current_date);

INSERT INTO mapuche.d_carrera(
	carrera_id, carrera_codigo, carrera_desc, subfuente_id, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
	VALUES (0,'0','VACIO/NULO',0,'1900-01-01','2199-12-31',1,'Y',current_date);
	
CREATE TABLE mapuche.d_clasificacion_cargo (
	clasificacion_cargo_id SMALLINT NOT NULL,
    	clasificacion_cargo_codigo character varying,
    	clasificacion_cargo_desc character varying,
    	subfuente_id integer,
	fecha_desde date,
	fecha_hasta date,
	version integer,
	vigente character varying,
	fecha_actualizacion timestamp without time zone,
	CONSTRAINT d_clasificacion_cargo_pk PRIMARY KEY (clasificacion_cargo_id)
);

INSERT INTO mapuche.d_clasificacion_cargo(
	clasificacion_cargo_id, clasificacion_cargo_codigo, clasificacion_cargo_desc, subfuente_id, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
	VALUES (-1,'-1','VALOR ERRONEO',0,'1900-01-01','2199-12-31',1,'Y',current_date);

INSERT INTO mapuche.d_clasificacion_cargo(
	clasificacion_cargo_id, clasificacion_cargo_codigo, clasificacion_cargo_desc, subfuente_id, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
	VALUES (0,'0','VACIO/NULO',0,'1900-01-01','2199-12-31',1,'Y',current_date);
	
CREATE TABLE mapuche.d_identidad_genero (
	identidad_genero_id SMALLINT NOT NULL,
    	identidad_genero_codigo character varying,
    	identidad_genero_desc character varying,
    	subfuente_id integer,
	fecha_desde date,
	fecha_hasta date,
	version integer,
	vigente character varying,
	fecha_actualizacion timestamp without time zone,
	CONSTRAINT d_identidad_genero_pk PRIMARY KEY (identidad_genero_id)
);

INSERT INTO mapuche.d_identidad_genero(
	identidad_genero_id, identidad_genero_codigo, identidad_genero_desc, subfuente_id, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
	VALUES (-1,'-1','VALOR ERRONEO',0,'1900-01-01','2199-12-31',1,'Y',current_date);

INSERT INTO mapuche.d_identidad_genero(
	identidad_genero_id, identidad_genero_codigo, identidad_genero_desc, subfuente_id, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
	VALUES (0,'0','VACIO/NULO',0,'1900-01-01','2199-12-31',1,'Y',current_date);
	
CREATE TABLE mapuche.d_nivel_funcion (
	nivel_funcion_id SMALLINT NOT NULL,
    	nivel_funcion_codigo character varying,
    	nivel_funcion_desc character varying,
    	subfuente_id integer,
	fecha_desde date,
	fecha_hasta date,
	version integer,
	vigente character varying,
	fecha_actualizacion timestamp without time zone,
	CONSTRAINT d_nivel_funcion_pk PRIMARY KEY (nivel_funcion_id)
);

INSERT INTO mapuche.d_nivel_funcion(
	nivel_funcion_id, nivel_funcion_codigo, nivel_funcion_desc, subfuente_id, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
	 VALUES (-1,'-1','VALOR ERRONEO',0,'1900-01-01','2199-12-31',1,'Y',current_date);

INSERT INTO mapuche.d_nivel_funcion(
	nivel_funcion_id, nivel_funcion_codigo, nivel_funcion_desc, subfuente_id, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
	 VALUES (0,'0','VACIO/NULO',0,'1900-01-01','2199-12-31',1,'Y',current_date);
	 
CREATE TABLE mapuche.d_obra_social (
	obra_social_id SMALLINT NOT NULL,
    	obra_social_codigo character varying,
    	obra_social_desc character varying,
    	subfuente_id integer,
	fecha_desde date,
	fecha_hasta date,
	version integer,
	vigente character varying,
	fecha_actualizacion timestamp without time zone,
	CONSTRAINT d_obra_social_pk PRIMARY KEY (obra_social_id)
);

INSERT INTO mapuche.d_obra_social(
	obra_social_id, obra_social_codigo, obra_social_desc, subfuente_id, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
	 VALUES (-1,'-1','VALOR ERRONEO',0,'1900-01-01','2199-12-31',1,'Y',current_date);

INSERT INTO mapuche.d_obra_social(
	obra_social_id, obra_social_codigo, obra_social_desc, subfuente_id, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
	 VALUES (0,'0','VACIO/NULO',0,'1900-01-01','2199-12-31',1,'Y',current_date);
	 
CREATE TABLE mapuche.d_tipo_documento (
	tipo_documento_id SMALLINT NOT NULL,
    	tipo_documento_codigo character varying,
    	tipo_documento_desc character varying,
    	subfuente_id integer,
	fecha_desde date,
	fecha_hasta date,
	version integer,
	vigente character varying,
	fecha_actualizacion timestamp without time zone,
	CONSTRAINT d_tipo_documento_pk PRIMARY KEY (tipo_documento_id)
);

INSERT INTO mapuche.d_tipo_documento(
	tipo_documento_id, tipo_documento_codigo, tipo_documento_desc, subfuente_id, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
	 VALUES (-1,'-1','VALOR ERRONEO',0,'1900-01-01','2199-12-31',1,'Y',current_date);

INSERT INTO mapuche.d_tipo_documento(
	tipo_documento_id, tipo_documento_codigo, tipo_documento_desc, subfuente_id, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
	 VALUES (0,'0','VACIO/NULO',0,'1900-01-01','2199-12-31',1,'Y',current_date);
	 
CREATE TABLE mapuche.d_persona_anexos
(
    persona_anexos_id integer NOT NULL,
    subfuente_id integer NOT NULL,
    legajo_codigo character varying NOT NULL,
    anioactualizacion_id integer,
    mesactualizacion_id integer,
    nro_afili character varying,
    codigosituacion integer,
    codigocondicion integer,
    codigoactividad integer,
    codigozona character varying,
    porcaporteadicss numeric(15,2),
    provincialocalidad character varying,
    cbu character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone,
    CONSTRAINT d_persona_anexos_pk PRIMARY KEY (persona_anexos_id)
);

INSERT INTO mapuche.d_persona_anexos(
	persona_anexos_id, subfuente_id, legajo_codigo, anioactualizacion_id, mesactualizacion_id, nro_afili, codigosituacion, codigocondicion, codigoactividad, codigozona, porcaporteadicss, provincialocalidad, cbu, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
	VALUES (-1,0,'VALOR ERRONEO',0,0,'VALOR ERRONEO',0,0,0,'VALOR ERRONEO',0,'VALOR ERRONEO','VALOR ERRONEO','1900-01-01','2199-12-31',1,'Y',current_date);

INSERT INTO mapuche.d_persona_anexos(
	persona_anexos_id, subfuente_id, legajo_codigo, anioactualizacion_id, mesactualizacion_id, nro_afili, codigosituacion, codigocondicion, codigoactividad, codigozona, porcaporteadicss, provincialocalidad, cbu, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
	VALUES (0,0,'VACIO/NULO',0,0,'VACIO/NULO',0,0,0,'VACIO/NULO',0,'VACIO/NULO','VACIO/NULO','1900-01-01','2199-12-31',1,'Y',current_date);

ALTER TABLE IF EXISTS mapuche.d_persona
    ADD COLUMN nro_ficha INTEGER DEFAULT 0;
ALTER TABLE IF EXISTS mapuche.d_persona
    ADD COLUMN nro_documento INTEGER DEFAULT 0;
ALTER TABLE IF EXISTS mapuche.d_persona
    ADD COLUMN anioalta_id integer DEFAULT 0;
ALTER TABLE IF EXISTS mapuche.d_persona
    ADD COLUMN mesalta_id integer DEFAULT 0;
ALTER TABLE IF EXISTS mapuche.d_persona
    ADD COLUMN fecha_ingreso date;
ALTER TABLE IF EXISTS mapuche.d_persona
    ADD COLUMN fecha_recibo date;  

ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN porc_aplic character varying DEFAULT 0;
ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN nro_cargo_ant INTEGER DEFAULT 0;
ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN clasificacion_cargo_id SMALLINT DEFAULT 0;
ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN carrera_id SMALLINT DEFAULT 0;    
ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN nivel_funcion_id SMALLINT DEFAULT 0;   
ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN tipo_documento_id SMALLINT DEFAULT 0;
ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN identidad_genero_id SMALLINT DEFAULT 0;
ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN depdesemp_cabecera_id SMALLINT DEFAULT 0;
ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN obra_social_id SMALLINT DEFAULT 0;
ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN titulo_liq_id SMALLINT DEFAULT 0;
ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN novedad_1 numeric(11,2) DEFAULT 0;
ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN novedad_2 numeric(11,2) DEFAULT 0;
ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN imp_basico_cat numeric(10,2) DEFAULT 0;    
ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN centro_costos character varying DEFAULT 'VACIO/NULO';
ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN persona_anexos_id INTEGER DEFAULT 0;
ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN hsdedicacioncargo_id SMALLINT DEFAULT 0;    
    
    
--Actualizar vistas mapuche

CREATE OR REPLACE VIEW mapuche.ft_personal_cerrada  
    AS SELECT * FROM mapuche.ft_personal WHERE liquidacion_id IN (SELECT liquidacion_id FROM mapuche.d_liquidacion WHERE es_cerrada IN('Cerrada','VACIO/NULO'));

CREATE OR REPLACE VIEW mapuche.ft_personal_abierta  
    AS SELECT * FROM mapuche.ft_personal WHERE liquidacion_id IN (SELECT liquidacion_id FROM mapuche.d_liquidacion WHERE es_cerrada = 'Abierta');


-- *******************************************************************************************
-- FUNCTION: public.cambios_dimensiones_comunes(integer, integer)
-- DROP FUNCTION IF EXISTS public.cambios_dimensiones_comunes(integer, integer);
CREATE OR REPLACE FUNCTION public.cambios_dimensiones_comunes(
	param_instalacion_id integer DEFAULT 0,
	param_importacion_id integer DEFAULT 0)
    RETURNS TABLE(cantidad integer, resultado text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
    var_tabla_nombre TEXT;
    var_tabla_esquema TEXT;
    var_consulta_altas TEXT;
    var_consulta_modificaciones TEXT;
    var_fecha_inicio TIMESTAMP;
    var_fecha_fin TIMESTAMP;
    var_tipo TEXT;
    var_fila RECORD;
    var_instalacion_desc TEXT;
    var_fuente_dato_id INTEGER;
    var_fuente_dato_desc TEXT;
	var_cantidad_total INTEGER;
    var_cantidad_altas INTEGER;
    var_cantidad_modificaciones INTEGER;
    respuesta JSONB := '[]'::JSONB;
BEGIN
    IF param_importacion_id = 0 THEN -- Si no viene la importacion tomo la ultima de la instalacion
        SELECT importacion_id INTO param_importacion_id
        FROM public.importacion
        WHERE instalacion_id = param_instalacion_id 
        ORDER by importacion_id DESC LIMIT 1;
    END IF;
    
    -- Obtengo las fechas de la tabla importacion para la importacion_id correspondiente
    SELECT fecha_inicio, fecha_fin, tipo, instalacion_id INTO var_fecha_inicio, var_fecha_fin, var_tipo, param_instalacion_id
    FROM public.importacion
    WHERE importacion_id = param_importacion_id;

    -- Obtengo descripcion de instalacion e informacion de la fuente de datos.
    SELECT d_instalacion.instalacion_desc, d_fuente_dato.fuente_dato_id, d_fuente_dato.fuente_dato_desc INTO var_instalacion_desc, var_fuente_dato_id, var_fuente_dato_desc
    FROM public.d_instalacion, public.d_fuente_dato
    WHERE d_instalacion.fuente_dato_id=d_fuente_dato.fuente_dato_id AND d_instalacion.instalacion_id = param_instalacion_id;

    -- IMPRIMO LOS DATOS DE LA IMPORTACION INCLUYENDO SUS FECHAS (si hasta es null significa que no termino la importacion correctamente)
    respuesta := respuesta || jsonb_build_object('instalacion', param_instalacion_id, 'importacion', param_importacion_id,
                                                 'tipo', var_tipo, 
                                                 'desde', var_fecha_inicio, 'hasta', var_fecha_fin,
                                                 'fuente_id', var_fuente_dato_id, 'fuente_desc', var_fuente_dato_desc,
                                                 'instalacion_desc', var_instalacion_desc);

    var_cantidad_total := 0; -- Da la cantidad de cambios que hubieron en las dimensiones Comunes

    -- Itero sobre las tablas con valor 'Comun'
    FOR var_tabla_nombre, var_tabla_esquema IN
        SELECT clave, esquema
        FROM public.parametros_fuente_dato
        WHERE fuente_dato_id = var_fuente_dato_id AND valor = 'Comun'
    LOOP
        -- Construyo la consulta de ALTAS para la tabla var_tabla_nombre
        var_consulta_altas := format(
            'WITH fechas AS (
                SELECT %L::TIMESTAMP AS var_fecha_inicio, %L::TIMESTAMP AS var_fecha_fin
            )
            SELECT row_to_json(dimension.*)::jsonb AS resultado
            FROM %I.%I dimension, fechas
            WHERE dimension.version = 1 AND dimension.fecha_actualizacion BETWEEN var_fecha_inicio AND var_fecha_fin
            ORDER BY fecha_actualizacion;',
            var_fecha_inicio, var_fecha_fin, var_tabla_esquema, var_tabla_nombre
        );
        -- Construyo la consulta de MODIFICACIONES para la tabla var_tabla_nombre
        var_consulta_modificaciones := format(
            'WITH fechas AS (
                SELECT %L::TIMESTAMP AS var_fecha_inicio, %L::TIMESTAMP AS var_fecha_fin
            )
            SELECT row_to_json(dimension.*)::jsonb AS resultado
            FROM %I.%I dimension, fechas
            WHERE dimension.version > 1 AND dimension.fecha_actualizacion BETWEEN var_fecha_inicio AND var_fecha_fin
            ORDER BY fecha_actualizacion;',
            var_fecha_inicio, var_fecha_fin, var_tabla_esquema, var_tabla_nombre
        );
	
        EXECUTE var_consulta_altas;
        GET DIAGNOSTICS var_cantidad_altas = ROW_COUNT;        
        EXECUTE var_consulta_modificaciones;
        GET DIAGNOSTICS var_cantidad_modificaciones = ROW_COUNT;        
        IF var_cantidad_altas+var_cantidad_modificaciones > 0 THEN  -- Si hubieron altas o modificaciones muestro la tabla
            respuesta := respuesta || jsonb_build_object('tabla', var_tabla_nombre, 'esquema', var_tabla_esquema);
            var_cantidad_total := var_cantidad_total + var_cantidad_altas + var_cantidad_modificaciones;
        END IF;
        IF var_cantidad_altas > 0 THEN -- Si hubieron altas muestro el titulo de operacion -> ALTAS
            respuesta := respuesta || jsonb_build_object('operacion', 'ALTAS');
        END IF;
        FOR var_fila IN EXECUTE var_consulta_altas LOOP -- Muestro todos los registros datos de alta (vigencia = 1)
            respuesta := respuesta || jsonb_build_array(var_fila.resultado);
        END LOOP;
        IF var_cantidad_modificaciones > 0 THEN -- Si hubieron modificaciones muestro el titulo de operacion -> MODIFICACIONES
            respuesta := respuesta || jsonb_build_object('operacion', 'MODIFICACIONES');
        END IF;
        FOR var_fila IN EXECUTE var_consulta_modificaciones LOOP -- Muestro todos los registros que deshabilite y los creados (vigencia > 1)
            respuesta := respuesta || jsonb_build_array(var_fila.resultado);
        END LOOP;
    END LOOP;

    RETURN QUERY SELECT var_cantidad_total, replace(jsonb_pretty(respuesta),'"',''); -- Retorno cantidad total de cambios (para ver si hubo alto) y detalle de cambios.
END;
$BODY$;

ALTER FUNCTION public.cambios_dimensiones_comunes(integer, integer)
    OWNER TO postgres;
-- *******************************************************************************************

-----------------------------
--Pilaga
-----------------------------
--TMP
ALTER TABLE pilaga_tmp.d_comprobante
    ALTER COLUMN importe TYPE numeric(22, 2);    
    
--DSA
ALTER TABLE pilaga_dsa.d_comprobante
    ALTER COLUMN importe TYPE numeric(22, 2);
    
ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN credito_original TYPE numeric(22, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN credito_modificatorio TYPE numeric(22, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN credito TYPE numeric(22, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN preventivo TYPE numeric(22, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN compromiso TYPE numeric(22, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN devengado TYPE numeric(22, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN pagado TYPE numeric(22, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN devengado_ex TYPE numeric(22, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN pagado_ex TYPE numeric(22, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN retenciones TYPE numeric(22, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN disponibilidades TYPE numeric(22, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN previsto_de_ingreso TYPE numeric(22, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN estimado_de_ingreso TYPE numeric(22, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN devengado_de_ingreso TYPE numeric(22, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_gastos
    ALTER COLUMN cobrado TYPE numeric(22, 2);
    
ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
    ALTER COLUMN credito_original TYPE numeric(22, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
    ALTER COLUMN credito_modificatorio TYPE numeric(22, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
    ALTER COLUMN credito TYPE numeric(22, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
    ALTER COLUMN preventivo TYPE numeric(22, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
    ALTER COLUMN compromiso TYPE numeric(22, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
    ALTER COLUMN devengado TYPE numeric(22, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
    ALTER COLUMN pagado TYPE numeric(22, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
    ALTER COLUMN retenciones TYPE numeric(22, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
    ALTER COLUMN disponibilidades TYPE numeric(22, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
    ALTER COLUMN previsto_de_ingreso TYPE numeric(22, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
    ALTER COLUMN estimado_de_ingreso TYPE numeric(22, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
    ALTER COLUMN devengado_de_ingreso TYPE numeric(22, 2);

ALTER TABLE pilaga_dsa.ft_movimientos_ingresos
    ALTER COLUMN cobrado TYPE numeric(22, 2);
    
ALTER TABLE pilaga_dsa.ft_servicios_publicos
    ALTER COLUMN importe TYPE numeric(22, 2);

ALTER TABLE pilaga_dsa.ft_servicios_publicos
    ALTER COLUMN consumo TYPE numeric(22, 2);
    
ALTER TABLE pilaga_dsa.ft_tesorerias
    ALTER COLUMN debito TYPE numeric(22, 2);

ALTER TABLE pilaga_dsa.ft_tesorerias
    ALTER COLUMN credito TYPE numeric(22, 2);     
    
--DW
ALTER TABLE pilaga.d_comprobante
    ALTER COLUMN importe TYPE numeric(22, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN credito_original TYPE numeric(22, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN credito_modificatorio TYPE numeric(22, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN credito TYPE numeric(22, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN preventivo TYPE numeric(22, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN compromiso TYPE numeric(22, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN devengado TYPE numeric(22, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN pagado TYPE numeric(22, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN devengado_ex TYPE numeric(22, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN pagado_ex TYPE numeric(22, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN retenciones TYPE numeric(22, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN disponibilidades TYPE numeric(22, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN previsto_de_ingreso TYPE numeric(22, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN estimado_de_ingreso TYPE numeric(22, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN devengado_de_ingreso TYPE numeric(22, 2);

ALTER TABLE pilaga.ft_movimientos
    ALTER COLUMN cobrado TYPE numeric(22, 2);      
    
ALTER TABLE pilaga.ft_servicios_publicos
    ALTER COLUMN importe TYPE numeric(22, 2);

ALTER TABLE pilaga.ft_servicios_publicos
    ALTER COLUMN consumo TYPE numeric(22, 2);
    
ALTER TABLE pilaga.ft_tesorerias
    ALTER COLUMN debito TYPE numeric(22, 2);

ALTER TABLE pilaga.ft_tesorerias
    ALTER COLUMN credito TYPE numeric(22, 2);   
    
---------------------------------------------------------------
---- Preinscripciones
---------------------------------------------------------------

ALTER TABLE IF EXISTS guarani3_tmp.ft_preinscripciones
    ADD COLUMN edad integer; 
    
ALTER TABLE IF EXISTS guarani3_dsa.ft_preinscripciones
    ADD COLUMN edad_id integer;

ALTER TABLE IF EXISTS guarani3.ft_preinscripciones
    ADD COLUMN edad_id integer DEFAULT 0;
    
-----------------------------------------------------------
--------- Portal Transparencia
-----------------------------------------------------------
ALTER TABLE portal_transparencia_dsa.ft_presupuesto
    ALTER COLUMN credito TYPE numeric(22, 2);

ALTER TABLE portal_transparencia_dsa.ft_presupuesto
    ALTER COLUMN devengado TYPE numeric(22, 2);
    
ALTER TABLE portal_transparencia.ft_presupuesto
    ALTER COLUMN credito TYPE numeric(22, 2);

ALTER TABLE portal_transparencia.ft_presupuesto
    ALTER COLUMN devengado TYPE numeric(22, 2);
    
ALTER TABLE portal_transparencia_dsa.ft_patrimonio
    ALTER COLUMN total_valor_bienes TYPE numeric(15, 2);

ALTER TABLE portal_transparencia_dsa.ft_patrimonio
    ALTER COLUMN total_valor_residual_bienes TYPE numeric(15, 2);
    
ALTER TABLE portal_transparencia.ft_patrimonio
    ALTER COLUMN total_valor_bienes TYPE numeric(15, 2);

ALTER TABLE portal_transparencia.ft_patrimonio
    ALTER COLUMN total_valor_residual_bienes TYPE numeric(15, 2);    
    
-----------------------------------------------------------
--------- Tablero Integrado
-------------------------------------------------------------    
ALTER TABLE integrado.ft_integrado
    ALTER COLUMN pilaga_credito_uno TYPE numeric(22, 2);

ALTER TABLE integrado.ft_integrado
    ALTER COLUMN pilaga_credito_no_uno TYPE numeric(22, 2);

ALTER TABLE integrado.ft_integrado
    ALTER COLUMN pilaga_devengado_uno TYPE numeric(22, 2);

ALTER TABLE integrado.ft_integrado
    ALTER COLUMN pilaga_devengado_no_uno TYPE numeric(22, 2);

ALTER TABLE integrado.ft_integrado
    ALTER COLUMN pilaga_devengado_de_ingreso TYPE numeric(22, 2);

ALTER TABLE integrado.ft_integrado
    ALTER COLUMN pilaga_cobrado TYPE numeric(22, 2);


CREATE OR REPLACE FUNCTION integrado.carga_integrado(
	)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE fecha_hora_inicio timestamp without time zone ;
BEGIN
   fecha_hora_inicio := clock_timestamp();

TRUNCATE integrado.ft_integrado;

INSERT INTO integrado.ft_integrado (anio_id, unidad_generica_id) 
SELECT anio_id, unidad_generica_id FROM
(
SELECT DISTINCT idanioinformado AS anio_id FROM araucano.academica_ft_cuadros1y2
UNION
SELECT DISTINCT anio_id FROM pilaga.ft_movimientos
UNION 
SELECT DISTINCT anio_id FROM mapuche.ft_personal
ORDER BY 1
) as anio_id,
(SELECT DISTINCT unidad_generica_id FROM public.d_unidad_generica ORDER BY 1) as unidad_generica_id;

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

EXECUTE 'CREATE TEMP TABLE temp_cargos_escalafones_dsa ON COMMIT DROP AS 
WITH cargos AS (SELECT DISTINCT
	anio_id
	, mes_id
	, unidad_generica_id
	, cat.escalafon_codigo AS escalafon
	, es_migrado
	, count(distinct nro_cargo) AS cant_cargos
	, count(distinct nro_cargo_base) AS cant_cargos_base	  
FROM mapuche.ft_personal ft
	INNER JOIN mapuche.d_categoriascargo cat ON ft.categoria_id = cat.categoria_id
WHERE condicion_id = 1
GROUP BY 1,2,3,4,5)
SELECT 	anio_id
	, mes_id
	, unidad_generica_id
	, escalafon
	, CASE 
	     WHEN es_migrado = ''SI'' THEN cant_cargos
	     ELSE cant_cargos_base 
	  END AS cantidad
FROM cargos;';
EXECUTE 'CREATE TEMP TABLE temp_cargos_escalafones ON COMMIT DROP AS
	SELECT
	anio_id,
	unidad_generica_id,
	escalafon,
	SUM(cantidad) AS cantidad
FROM temp_cargos_escalafones_dsa c
	INNER JOIN (SELECT anio_id AS anio, MAX(mes_id) AS mes FROM temp_cargos_escalafones_dsa GROUP BY 1) p
		ON p.anio = c.anio_id
			AND c.mes_id = p.mes
GROUP BY 1, 2, 3;';
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

insert into public.importacion (instalacion_id, fecha_inicio, fecha_fin, tipo, parametros, observaciones, estado)
values (0, fecha_hora_inicio, clock_timestamp(), 'actualizacion', ' ', 'Actualizacion ft_integrado', 'finalizada');

RETURN (SELECT count(*) FROM integrado.ft_integrado);
END
$BODY$;

SELECT integrado.carga_integrado();

-- **************************************************************************
-- Creacion de VISTAS para eliminar los JOIN del SIU-Wichi.xml
-- **************************************************************************
-- guarani
-- SELECT * FROM guarani.v_gua_dw_lt_materias_x_gua_dw_lt_unidadesacademicas;
CREATE OR REPLACE VIEW guarani.v_gua_dw_lt_materias_x_gua_dw_lt_unidadesacademicas AS
SELECT 
    primera.materia_id,
    segunda.unidadacademica_id,
	segunda.unidadacademica_desc,
    primera.materia_desc
FROM 
    guarani.gua_dw_lt_materias primera
JOIN 
    guarani.gua_dw_lt_unidadesacademicas segunda
ON 
    primera.unidadacademica_id = segunda.unidadacademica_id;

-- SELECT * FROM guarani.v_gua_dw_lt_periodosanioacad_x_gua_dw_lt_tiposperiodo;
CREATE OR REPLACE VIEW guarani.v_gua_dw_lt_periodosanioacad_x_gua_dw_lt_tiposperiodo AS
SELECT 
    primera.periodo_id,
    segunda.tipoperiodo_id,
	segunda.tipoperiodo_desc,
    primera.periodo_desc,
	primera.anioacademico
FROM 
    guarani.gua_dw_lt_periodosanioacad primera
JOIN 
    guarani.gua_dw_lt_tiposperiodo segunda
ON 
    primera.tipoperiodo_id = segunda.tipoperiodo_id;

-- SELECT * FROM guarani.v_gua_dw_lt_unidadesacademicas_x_gua_dw_lt_planes;
CREATE OR REPLACE VIEW guarani.v_gua_dw_lt_unidadesacademicas_x_gua_dw_lt_planes AS
SELECT 
    segunda.plan_id,
    primera.unidadacademica_id,
	primera.unidadacademica_desc,
	segunda.carrera_id,
    segunda.carrera_desc,
	segunda.plan_desc
FROM 
    guarani.gua_dw_lt_unidadesacademicas primera
JOIN 
    guarani.gua_dw_lt_planes segunda
ON 
    primera.unidadacademica_id = segunda.unidadacademica_id;

-- SELECT * FROM guarani.v_gua_dw_lt_notas_x_gua_dw_lt_resultados;
CREATE OR REPLACE VIEW guarani.v_gua_dw_lt_notas_x_gua_dw_lt_resultados AS
SELECT 
    primera.nota_id,
    segunda.resultado_id,
	segunda.resultado_desc,
    primera.nota_desc
FROM 
    guarani.gua_dw_lt_notas primera
JOIN 
    guarani.gua_dw_lt_resultados segunda
ON 
    primera.resultado_id = segunda.resultado_id;

-- SELECT * FROM guarani.v_gua_dw_lt_intentos_x_gua_dw_lt_totalintentos;
CREATE OR REPLACE VIEW guarani.v_gua_dw_lt_intentos_x_gua_dw_lt_totalintentos AS
SELECT 
    primera.intento_id,
	primera.primeravez,
    segunda.totalintento_id,
	segunda.totalintento_desc,
    primera.nrointento_id
FROM 
    guarani.gua_dw_lt_intentos primera
JOIN 
    guarani.gua_dw_lt_totalintentos segunda
ON 
    primera.totalintento_id = segunda.totalintento_id;

-- SELECT * FROM guarani.v_gua_dw_lt_carreras_x_gua_dw_lt_unidadesacademicas;
CREATE OR REPLACE VIEW guarani.v_gua_dw_lt_carreras_x_gua_dw_lt_unidadesacademicas AS
SELECT 
    primera.carrera_id,
    segunda.unidadacademica_id,
	segunda.unidadacademica_desc,
    primera.carrera_desc
FROM 
    guarani.gua_dw_lt_carreras primera
JOIN 
    guarani.gua_dw_lt_unidadesacademicas segunda
ON 
    primera.unidadacademica_id = segunda.unidadacademica_id;

-- SELECT * FROM guarani.v_gua_dw_lt_titulosaraucano_x_gua_dw_lt_unidadesacademicas;
CREATE OR REPLACE VIEW guarani.v_gua_dw_lt_titulosaraucano_x_gua_dw_lt_unidadesacademicas AS
SELECT 
    primera.tituloaraucano_id,
    segunda.unidadacademica_id,
	segunda.unidadacademica_desc,
    primera.tituloaraucano_desc
FROM 
    guarani.gua_dw_lt_titulosaraucano primera
JOIN 
    guarani.gua_dw_lt_unidadesacademicas segunda
ON 
    primera.unidadacademica_id = segunda.unidadacademica_id;

-- SELECT * FROM guarani.v_gua_dw_lt_carreras_dto_x_gua_dw_lt_unidadesacademicas;
CREATE OR REPLACE VIEW guarani.v_gua_dw_lt_carreras_dto_x_gua_dw_lt_unidadesacademicas AS
SELECT 
    primera.carrera_id,
    segunda.unidadacademica_id,
	segunda.unidadacademica_desc,
    primera.departamento_desc
FROM 
    guarani.gua_dw_lt_carreras primera
JOIN 
    guarani.gua_dw_lt_unidadesacademicas segunda
ON 
    primera.unidadacademica_id = segunda.unidadacademica_id;

-- **************************************************************************
-- guarani3
--select * from  guarani3.v_periodo_anio_academico_x_tipo_periodo 
CREATE OR REPLACE VIEW guarani3.v_periodo_anio_academico_x_tipo_periodo AS
SELECT 
    primera.tipo_periodo_id,
    segunda.tipo_periodo_desc,
    primera.periodo_id,
    primera.periodo_desc,
    primera.anio_academico
FROM 
    guarani3.d_periodo_anio_academico primera
JOIN 
    guarani3.d_tipo_periodo segunda
ON 
    primera.tipo_periodo_id = segunda.tipo_periodo_id;

--select * from  guarani3.v_d_nota_x_d_resultado_x_d_concepto 
CREATE OR REPLACE VIEW guarani3.v_d_nota_x_d_resultado_x_d_concepto AS
SELECT 
    primera.nota_id,
    primera.nota_desc,
    segunda.resultado_desc,
    tercera.concepto_id,
    tercera.concepto_desc
FROM 
    guarani3.d_nota primera
JOIN 
    guarani3.d_resultado segunda
ON 
    primera.resultado_id = segunda.resultado_id
JOIN
	guarani3.d_concepto tercera
ON
	segunda.concepto_id = tercera.concepto_id;

--select * from  guarani3.v_d_intento_x_d_total_intento 
CREATE OR REPLACE VIEW guarani3.v_d_intento_x_d_total_intento AS
SELECT 
    primera.intento_id,
	primera.primera_vez,
    segunda.total_intento_id,
    segunda.total_intento_desc,
    primera.nro_intento_id
FROM 
    guarani3.d_intento primera
JOIN 
    guarani3.d_total_intento segunda
ON 
    primera.total_intento_id = segunda.total_intento_id;

-- ***************************************************************************
-- mapuche
--select * from  mapuche.v_d_persona_x_d_domicilio 
CREATE OR REPLACE VIEW mapuche.v_d_persona_x_d_domicilio AS
SELECT 
    primera.persona_id,
    segunda.pais_desc,
    segunda.provincia_desc,
    segunda.codigo_postal_desc,
    segunda.localidad_desc
FROM 
    mapuche.d_persona primera
JOIN 
    mapuche.d_domicilio segunda
ON 
    primera.domicilio_codigo = segunda.domicilio_codigo;
-- **************************************************************************
-- **************************************************************************



