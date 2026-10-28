-- Este script es parte de la migración de SIU-Wichi 6.11.0 a 6.12.0

-----------------------------
--Guarani 3
-----------------------------

ALTER TABLE guarani3_tmp.ft_procedencia_aspirantes
  ADD COLUMN localidad_procedencia_id integer;
  
ALTER TABLE guarani3_dsa.ft_procedencia_aspirantes
  ADD COLUMN localidad_procedencia_id integer;

ALTER TABLE guarani3.ft_procedencia_aspirantes
  ADD COLUMN localidad_procedencia_id integer;
  
  
-----------------------------
--Mapuche
-----------------------------

ALTER TABLE mapuche_tmp.ft_cargos
  ADD COLUMN tarea_codigo character varying;
    
ALTER TABLE mapuche_tmp.ft_legajos
  ADD COLUMN grupo_sanguineo character varying;

ALTER TABLE mapuche_tmp.ft_legajos
  ADD COLUMN telefono character varying;
  
CREATE TABLE mapuche_tmp.d_tarea (
    tarea_codigo character varying,
    tarea_desc character varying
);

ALTER TABLE mapuche_dsa.d_persona
  ADD COLUMN grupo_sanguineo character varying;

ALTER TABLE mapuche_dsa.d_persona
  ADD COLUMN telefono character varying;

ALTER TABLE mapuche_dsa.ft_cargos
  ADD COLUMN tarea_id SMALLINT;
    
CREATE TABLE mapuche_dsa.d_tarea (
	tarea_id SMALLINT NOT NULL,
        tarea_codigo character varying,
        tarea_desc character varying,
	fecha_desde date,
	fecha_hasta date,
	version integer,
	vigente character varying,
	fecha_actualizacion timestamp without time zone,
	CONSTRAINT d_tarea_pk PRIMARY KEY (tarea_id)
);

ALTER TABLE mapuche.d_persona
  ADD COLUMN grupo_sanguineo character varying;

ALTER TABLE mapuche.d_persona
  ADD COLUMN telefono character varying;

ALTER TABLE mapuche.ft_personal
  ADD COLUMN tarea_id SMALLINT;
      
CREATE TABLE mapuche.d_tarea (
        tarea_id SMALLINT NOT NULL,
        tarea_codigo character varying,
        tarea_desc character varying,
        fecha_desde date,
        fecha_hasta date,
        version integer,
        vigente character varying,
        fecha_actualizacion timestamp without time zone,
        CONSTRAINT d_tarea_pk PRIMARY KEY (tarea_id)
);


-- CREACION DE VISTAS PARA ACCESO A LAS TABLAS DE DATOS FT POR PARTE DE LOS DOS CUBOS
CREATE OR REPLACE VIEW mapuche.ft_personal_cerrada  
    AS SELECT * FROM mapuche.ft_personal WHERE liquidacion_id IN (SELECT liquidacion_id FROM mapuche.d_liquidacion WHERE es_cerrada IN('Cerrada','VACIO/NULO'));

CREATE OR REPLACE VIEW mapuche.ft_personal_abierta  
    AS SELECT * FROM mapuche.ft_personal WHERE liquidacion_id IN (SELECT liquidacion_id FROM mapuche.d_liquidacion WHERE es_cerrada = 'Abierta');



-------------------------------------------------------
--- Preinscripciones
-------------------------------------------------------

UPDATE public.d_fuente_dato
	SET fuente_dato_desc= 'SIU-Preinscripciones'
	WHERE fuente_dato_id=11;
	
--Esquema guarani3_tmp

SET search_path = guarani3_tmp, pg_catalog;

CREATE TABLE guarani3_tmp.d_cobertura_salud(
  cobertura_salud_codigo integer,
  cobertura_salud_desc text
);

CREATE TABLE guarani3_tmp.d_identidad_genero(
  identidad_genero_codigo integer,
  identidad_genero_desc text
);

CREATE TABLE guarani3_tmp.d_periodo_inscripcion_preinscripciones(
  periodo_inscripcion_codigo integer,
  periodo_inscripcion_desc text,
  anio_academico integer
);

CREATE TABLE guarani3_tmp.d_pueblos_originarios(
  pueblo_originario_codigo integer,
  pueblo_originario_desc text
);

CREATE TABLE guarani3_tmp.d_tipo_allegado(
  tipo_allegado_codigo text,
  tipo_allegado_desc text
);

CREATE TABLE guarani3_tmp.d_tipo_documento(
  tipo_documento_codigo integer,
  tipo_documento_desc text
);

CREATE TABLE guarani3_tmp.d_trabajo_ocupacion(
  trabajo_ocupacion_codigo integer,
  trabajo_ocupacion_desc text
);

CREATE TABLE guarani3_tmp.d_turno_preferido(
   turno_preferido_codigo integer,
   turno_preferido_desc text
);

CREATE TABLE guarani3_tmp.d_vive_con(
  vive_con_codigo integer,
  vive_con_desc text
);

CREATE TABLE guarani3_tmp.ft_preinscripciones(
	responsable_academica integer,
	propuesta integer,
	ubicacion integer,
	modalidad text,
	periodo_insc integer,
	fecha_preinscripcion date,
	estado_preinsc text,
	apyno text,
	tipo_documento integer,
	nro_documento text,
	sexo integer,
	fecha_nacimiento date,
	nacionalidad integer,
	loc_nacimiento integer,
	estado_civil integer,
	alu_est_civil_uh text,
	turno_preferido integer,
	colegio_secundario integer,
	titulo_secundario integer,
	anio_egreso_sec integer,
	alu_trabajo INTEGER,
	pertenece_pueblo_originario text,
	pueblo_originario integer,
	pueblo_originario_otro text,
	identidad_genero integer,
	identidad_genero_otro text,
	celular_numero text,
	e_mail text,
	apyno_elegido text,
	apyno_padre text,
	apyno_madre text,
	sit_laboral_padre integer,
	padre_trab_ocup text,
	sit_laboral_madre integer,
	madre_trab_ocup text,
	sit_actual_padre text,
	sit_actual_madre text,
	nivel_estudio_padre integer,
	nivel_estudio_madre integer,
	tipo_allegado text,
	apyno_pers_alleg text,
	costeo_estudios text,
	tiene_beca text,
	tecno_pc text,
	tecno_int text,
	idioma text,
	condicion_discapacidad text,
	tiene_cud text,
	discapacidad text,
	cant_hijos_alum integer,
	vive_actual_con integer,
	obra_social_alu text,
	loc_per_lect integer,
	loc_proc integer,
	es_celiaco text,
	adeuda_materias text
);	
	
--Esquema guarani3_dsa

SET search_path = guarani3_dsa, pg_catalog;

CREATE TABLE guarani3_dsa.d_cantidad_hijos(
   cantidad_hijos_id integer NOT NULL,
   cantidad_hijos_codigo integer,
   cantidad_hijos_desc text,
   fecha_desde date,
   fecha_hasta date,
   version integer,
   vigente character varying,
   fecha_actualizacion timestamp without time zone,
   CONSTRAINT d_cantidad_hijos_pk PRIMARY KEY (cantidad_hijos_id) 
);

CREATE TABLE guarani3_dsa.d_cobertura_salud(
   cobertura_salud_id integer NOT NULL,
   cobertura_salud_codigo integer,
   cobertura_salud_desc text,
   fecha_desde date,
   fecha_hasta date,
   version integer,
   vigente character varying,
   fecha_actualizacion timestamp without time zone,
   CONSTRAINT d_cobertura_salud_pk PRIMARY KEY (cobertura_salud_id) 
);

CREATE TABLE guarani3_dsa.d_periodo_inscripcion_preinscripciones(
   periodo_inscripcion_id integer NOT NULL,
   periodo_inscripcion_codigo integer,
   periodo_inscripcion_desc text,
   anio_academico integer,
   instalacion_id integer,
   fecha_desde date,
   fecha_hasta date,
   version integer,
   vigente character varying,
   fecha_actualizacion timestamp without time zone,
   CONSTRAINT d_periodo_inscripcion_pk PRIMARY KEY (periodo_inscripcion_id) 
);

CREATE TABLE guarani3_dsa.d_turno_preferido(
   turno_preferido_id integer NOT NULL,
   turno_preferido_codigo integer,
   turno_preferido_desc text,
   instalacion_id integer,
   fecha_desde date,
   fecha_hasta date,
   version integer,
   vigente character varying,
   fecha_actualizacion timestamp without time zone,
   CONSTRAINT d_turno_preferido_pk PRIMARY KEY (turno_preferido_id) 
);

CREATE TABLE guarani3_dsa.d_vive_con(
   vive_con_id integer NOT NULL,
   vive_con_codigo integer,
   vive_con_desc text,
   fecha_desde date,
   fecha_hasta date,
   version integer,
   vigente character varying,
   fecha_actualizacion timestamp without time zone,
   CONSTRAINT d_vive_con_pk PRIMARY KEY (vive_con_id) 
);	

CREATE TABLE IF NOT EXISTS guarani3_dsa.ft_preinscripciones
(
    instalacion_id integer,
    responsable_academica_id integer,
    propuesta_formativa_id integer,
    ubicacion_id integer,
    modalidad text,
    periodo_inscripcion_id integer,
    anio_academico integer,
    fecha_preinscripcion date,
    estado_preinsc text,
    apyno text,
    tipoynum text,
    sexo_id integer,
    fecha_nacimiento date,
    nacionalidad_id integer,
    loc_nacimiento_id integer,
    estado_civil_id integer,
    alu_est_civil_uh text,
    turno_preferido_id integer,
    colegio_secundario_id integer,
    titulo_secundario integer,
    anio_egreso_sec integer,
    horas_trabajadas_id integer,
    pueblo_originario text,
    identidad_genero text,
    celular_numero text,
    e_mail text,
    apyno_elegido text,
    apyno_padre text,
    apyno_madre text,
    padre_trab text,
    madre_trab text,
    sit_actual_padre text,
    sit_actual_madre text,
    estudio_padre_id integer,
    estudio_madre_id integer,
    allegado text,
    costeo_estudios_id integer,
    beca text,
    tecno_pc_id integer,
    tecno_internet_id integer,
    idioma_id integer,
    condicion_discapacidad text,
    tiene_cud text,
    discapacidad_id integer,
    cantidad_hijos_id integer,
    vive_con_id integer,
    cobertura_salud_id integer,
    localidad_periodo_lectivo_id integer,
    localidad_procedencia_id integer,
    es_celiaco text,
    adeuda_materias text
);

--Esquema guarani3

SET search_path = guarani3, pg_catalog;

CREATE TABLE guarani3.d_cantidad_hijos(
   cantidad_hijos_id integer NOT NULL,
   cantidad_hijos_codigo integer,
   cantidad_hijos_desc text,
   fecha_desde date,
   fecha_hasta date,
   version integer,
   vigente character varying,
   fecha_actualizacion timestamp without time zone,
   CONSTRAINT d_cantidad_hijos_pk PRIMARY KEY (cantidad_hijos_id) 
);

CREATE TABLE guarani3.d_cobertura_salud(
   cobertura_salud_id integer NOT NULL,
   cobertura_salud_codigo integer,
   cobertura_salud_desc text,
   fecha_desde date,
   fecha_hasta date,
   version integer,
   vigente character varying,
   fecha_actualizacion timestamp without time zone,
   CONSTRAINT d_cobertura_salud_pk PRIMARY KEY (cobertura_salud_id) 
);

CREATE TABLE guarani3.d_periodo_inscripcion_preinscripciones(
   periodo_inscripcion_id integer NOT NULL,
   periodo_inscripcion_codigo integer,
   periodo_inscripcion_desc text,
   anio_academico integer,
   instalacion_id integer,
   fecha_desde date,
   fecha_hasta date,
   version integer,
   vigente character varying,
   fecha_actualizacion timestamp without time zone,
   CONSTRAINT d_periodo_inscripcion_pk PRIMARY KEY (periodo_inscripcion_id) 
);

CREATE TABLE guarani3.d_turno_preferido(
   turno_preferido_id integer NOT NULL,
   turno_preferido_codigo integer,
   turno_preferido_desc text,
   instalacion_id integer,
   fecha_desde date,
   fecha_hasta date,
   version integer,
   vigente character varying,
   fecha_actualizacion timestamp without time zone,
   CONSTRAINT d_turno_preferido_pk PRIMARY KEY (turno_preferido_id) 
);

CREATE TABLE guarani3.d_vive_con(
   vive_con_id integer NOT NULL,
   vive_con_codigo integer,
   vive_con_desc text,
   fecha_desde date,
   fecha_hasta date,
   version integer,
   vigente character varying,
   fecha_actualizacion timestamp without time zone,
   CONSTRAINT d_vive_con_pk PRIMARY KEY (vive_con_id) 
);

CREATE TABLE IF NOT EXISTS guarani3.ft_preinscripciones
(
    instalacion_id integer,
    responsable_academica_id integer,
    propuesta_formativa_id integer,
    ubicacion_id integer,
    modalidad text,
    periodo_inscripcion_id integer,
    anio_academico integer,
    fecha_preinscripcion date,
    estado_preinsc text,
    apyno text,
    tipoynum text,
    sexo_id integer,
    fecha_nacimiento date,
    nacionalidad_id integer,
    loc_nacimiento_id integer,
    estado_civil_id integer,
    alu_est_civil_uh text,
    turno_preferido_id integer,
    colegio_secundario_id integer,
    titulo_secundario integer,
    anio_egreso_sec integer,
    horas_trabajadas_id integer,
    pueblo_originario text,
    identidad_genero text,
    celular_numero text,
    e_mail text,
    apyno_elegido text,
    apyno_padre text,
    apyno_madre text,
    padre_trab text,
    madre_trab text,
    sit_actual_padre text,
    sit_actual_madre text,
    estudio_padre_id integer,
    estudio_madre_id integer,
    allegado text,
    costeo_estudios_id integer,
    beca text,
    tecno_pc_id integer,
    tecno_internet_id integer,
    idioma_id integer,
    condicion_discapacidad text,
    tiene_cud text,
    discapacidad_id integer,
    cantidad_hijos_id integer,
    vive_con_id integer,
    cobertura_salud_id integer,
    localidad_periodo_lectivo_id integer,
    localidad_procedencia_id integer,
    es_celiaco text,
    adeuda_materias text,
    cantidad integer,
    importacion_id integer,
    unidad_generica_id integer
);
