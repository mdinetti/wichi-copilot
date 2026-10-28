-- Este script es parte de la migración de SIU-Wichi 7.0.0 a 7.1.0

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
    provincialocalidad character varying ,
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
    provincialocalidad character varying ,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone,
    CONSTRAINT d_persona_anexos_pk PRIMARY KEY (persona_anexos_id)
);

ALTER TABLE IF EXISTS mapuche.d_persona
    ADD COLUMN nro_ficha INTEGER;
ALTER TABLE IF EXISTS mapuche.d_persona
    ADD COLUMN nro_documento INTEGER;
ALTER TABLE IF EXISTS mapuche.d_persona
    ADD COLUMN anioalta_id integer;
ALTER TABLE IF EXISTS mapuche.d_persona
    ADD COLUMN mesalta_id integer;
ALTER TABLE IF EXISTS mapuche.d_persona
    ADD COLUMN fecha_ingreso date;
ALTER TABLE IF EXISTS mapuche.d_persona
    ADD COLUMN fecha_recibo date;  

ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN porc_aplic character varying;
ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN nro_cargo_ant INTEGER;
ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN clasificacion_cargo_id SMALLINT;
ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN carrera_id SMALLINT;    
ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN nivel_funcion_id SMALLINT;   
ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN tipo_documento_id SMALLINT;
ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN identidad_genero_id SMALLINT;
ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN depdesemp_cabecera_id SMALLINT;
ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN obra_social_id SMALLINT;
ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN titulo_liq_id SMALLINT;
ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN novedad_1 numeric(11,2);
ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN novedad_2 numeric(11,2);
ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN imp_basico_cat numeric(10,2);    
ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN centro_costos character varying;
ALTER TABLE IF EXISTS mapuche.ft_personal
    ADD COLUMN persona_anexos_id INTEGER;     
    
    
--Actualizar vistas mapuche

CREATE OR REPLACE VIEW mapuche.ft_personal_abierta
 AS
 SELECT id,
    importacion_id,
    unidad_generica_id,
    periodo_id,
    anio_id,
    mes_id,
    condicion_id,
    liquidacion_id,
    concepto_id,
    persona_id,
    nro_cargo_base,
    nro_cargo,
    unidad_presupuestaria_id,
    tipo_ejercicio_id,
    grupo_presupuestario_id,
    finalidad_funcion_id,
    imppresupfuente_id,
    objetogasto_id,
    red_programatica_id,
    antiguedadliq_id,
    dias_trabajados,
    periodo_retroactivo_id,
    importe_liq,
    porc_imppresup,
    nro_recibo,
    nro_orimp,
    importenetocargo,
    importebrutocargo,
    importegastototalcargo,
    importedescuentoscargo,
    importeaportescargo,
    importeasigfam,
    importeremconap,
    importeremsinap,
    importeotrosrem,
    dependenciadesigncargo_id,
    categoria_id,
    nudo,
    estadodelcargo_id,
    plantacarac_id,
    agrupamiento_id,
    subrogancia_id,
    categoria_subrogada_id,
    asociado_id,
    antiguedadescalafon_id,
    hsdedicacion_id,
    porctrabajado_id,
    porcreduccionhoraria_id,
    regional_id,
    fechaalta,
    fechabaja,
    dependenciadesemp_id,
    tarea_id,
    nivelestudio_id,
    estadocivil_id,
    activo_id,
    sexo_id,
    discapacidad_id,
    edad_id,
    titulo_id,
    nivel_estudio_liq_id,
    cargahorariahs,
    categoria_incentivo_id,
    dedicacion_incentivo_id,
    regional_cabecera_id,
    dependencia_cabecera_id,
    dependenciadesign_id,
    es_migrado,
    licencia_id,
    fechacarga,
    porc_aplic,
    nro_cargo_ant,
    clasificacion_cargo_id,
    carrera_id,
    nivel_funcion_id,
    tipo_documento_id,
    identidad_genero_id,
    depdesemp_cabecera_id,
    obra_social_id,
    titulo_liq_id,
    novedad_1,
    novedad_2,
    imp_basico_cat,
    centro_costos,
    persona_anexos_id,
    subfuente_id
   FROM mapuche.ft_personal
  WHERE (liquidacion_id IN ( SELECT d_liquidacion.liquidacion_id
           FROM mapuche.d_liquidacion
          WHERE d_liquidacion.es_cerrada::text = 'Abierta'::text));


CREATE OR REPLACE VIEW mapuche.ft_personal_cerrada
 AS
 SELECT id,
    importacion_id,
    unidad_generica_id,
    periodo_id,
    anio_id,
    mes_id,
    condicion_id,
    liquidacion_id,
    concepto_id,
    persona_id,
    nro_cargo_base,
    nro_cargo,
    unidad_presupuestaria_id,
    tipo_ejercicio_id,
    grupo_presupuestario_id,
    finalidad_funcion_id,
    imppresupfuente_id,
    objetogasto_id,
    red_programatica_id,
    antiguedadliq_id,
    dias_trabajados,
    periodo_retroactivo_id,
    importe_liq,
    porc_imppresup,
    nro_recibo,
    nro_orimp,
    importenetocargo,
    importebrutocargo,
    importegastototalcargo,
    importedescuentoscargo,
    importeaportescargo,
    importeasigfam,
    importeremconap,
    importeremsinap,
    importeotrosrem,
    dependenciadesigncargo_id,
    categoria_id,
    nudo,
    estadodelcargo_id,
    plantacarac_id,
    agrupamiento_id,
    subrogancia_id,
    categoria_subrogada_id,
    asociado_id,
    antiguedadescalafon_id,
    hsdedicacion_id,
    porctrabajado_id,
    porcreduccionhoraria_id,
    regional_id,
    fechaalta,
    fechabaja,
    dependenciadesemp_id,
    tarea_id,
    nivelestudio_id,
    estadocivil_id,
    activo_id,
    sexo_id,
    discapacidad_id,
    edad_id,
    titulo_id,
    nivel_estudio_liq_id,
    cargahorariahs,
    categoria_incentivo_id,
    dedicacion_incentivo_id,
    regional_cabecera_id,
    dependencia_cabecera_id,
    dependenciadesign_id,
    es_migrado,
    licencia_id,
    fechacarga,
    porc_aplic,
    nro_cargo_ant,
    clasificacion_cargo_id,
    carrera_id,
    nivel_funcion_id,
    tipo_documento_id,
    identidad_genero_id,
    depdesemp_cabecera_id,
    obra_social_id,
    titulo_liq_id,
    novedad_1,
    novedad_2,
    imp_basico_cat,
    centro_costos,
    persona_anexos_id,
    subfuente_id
   FROM mapuche.ft_personal
  WHERE (liquidacion_id IN ( SELECT d_liquidacion.liquidacion_id
           FROM mapuche.d_liquidacion
          WHERE d_liquidacion.es_cerrada::text = ANY (ARRAY['Cerrada'::character varying, 'VACIO/NULO'::character varying]::text[])));



