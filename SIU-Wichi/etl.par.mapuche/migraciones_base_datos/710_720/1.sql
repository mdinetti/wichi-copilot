-- Este script es parte de la migración de SIU-Wichi 7.1.0 a 7.2.0

------------------------------------------------------------------------------------------
------- Araucano
------------------------------------------------------------------------------------------

--TMP

CREATE TABLE araucano_tmp.ft_preuniversitarios
(
    idfacultad character varying,
    idtitulo character varying,
    anioinformado character varying,
    idtipotitulo character varying,
    idfacultadingreso character varying,
    genero character varying,
    idserie character varying,
    cantidadm character varying,
    cantidadn character varying,
    cantidads character varying
);

CREATE TABLE araucano_tmp.ft_totaldetalles_epeqe
(
  idfacultad character varying,
  idtitulo character varying,
  anioinformado character varying,
  idtipotitulo character varying,
  idfacultadingreso character varying,
  genero character varying,
  idserie_edad character varying,
  idsubserie_edad character varying,
  idsubserieopcion_edad character varying,
  cantidadm_c23y24 character varying,
  cantidadn_c23y24 character varying,
  cantidads_c23y24 character varying
);

CREATE TABLE araucano_tmp.ft_totaldetalles_mapm
(
  idfacultad character varying,
  idtitulo character varying,
  anioinformado character varying,
  idtipotitulo character varying,
  idfacultadingreso character varying,
  genero character varying,
  idserie_c25 character varying,
  idsubserie_c25 character varying,
  idsubserieopcion_c25 character varying,
  cantidadm_c25 character varying,
  cantidadn_c25 character varying,
  cantidads_c25 character varying
);

CREATE TABLE araucano_tmp.ft_totaldetalles_mapc
(
  idfacultad character varying,
  idtitulo character varying,
  anioinformado character varying,
  idtipotitulo character varying,
  idfacultadingreso character varying,
  genero character varying,
  idserie_c26 character varying,
  idsubserie_c26 character varying,
  idsubserieopcion_c26 character varying,
  cantidadm_c26 character varying,
  cantidadn_c26 character varying,
  cantidads_c26 character varying
);

--DSA

CREATE TABLE araucano_dsa.academica_ft_preuniversitarios
(
  idpreuniversitarios serial NOT NULL,
  idanioinformado smallint NOT NULL,
  idfacultad smallint NOT NULL,
  idfacultadingreso smallint NOT NULL,
  idtipotitulo smallint NOT NULL,
  idrda smallint NOT NULL,
  idtitulo smallint NOT NULL,
  idgenero smallint NOT NULL,
  idserie smallint NOT NULL,
  cantidadm double precision,
  cantidadn double precision,
  cantidads double precision,
  cantidad double precision,
  fechacarga timestamp NOT NULL, --(fecha y hora en que se cargó la información)
  CONSTRAINT academica_dsa_ft_preuniversitarios_pkey PRIMARY KEY (idpreuniversitarios)
);

CREATE TABLE araucano_dsa.academica_ft_cuadros23y24
(
  idcuadros23y24 serial NOT NULL,
  idanioinformado smallint NOT NULL,
  idfacultad smallint NOT NULL,
  idfacultadingreso smallint NOT NULL,
  idtipotitulo smallint NOT NULL,
  idrda smallint NOT NULL,
  idtitulo smallint NOT NULL,
  idgenero smallint NOT NULL,
  idsubserieopcion smallint NOT NULL,
  cantidadm double precision,
  cantidadn double precision,
  cantidads double precision,
  cantidad double precision,
  fechacarga timestamp without time zone NOT NULL,
  CONSTRAINT academica_dsa_ft_cuadros23y24_pkey PRIMARY KEY (idcuadros23y24)
);

CREATE TABLE araucano_dsa.academica_ft_cuadro25
(
  idcuadro25 serial NOT NULL,
  idanioinformado smallint NOT NULL,
  idfacultad smallint NOT NULL,
  idfacultadingreso smallint NOT NULL,
  idtipotitulo smallint NOT NULL,
  idrda smallint NOT NULL,
  idtitulo smallint NOT NULL,
  idgenero smallint NOT NULL,
  idsubserieopcion smallint NOT NULL,
  cantidadm double precision,
  cantidadn double precision,
  cantidads double precision,
  cantidad double precision,
  fechacarga timestamp without time zone NOT NULL,
  CONSTRAINT academica_dsa_ft_cuadro25_pkey PRIMARY KEY (idcuadro25)
);

CREATE TABLE araucano_dsa.academica_ft_cuadro26
(
  idcuadro26 serial NOT NULL,
  idanioinformado smallint NOT NULL,
  idfacultad smallint NOT NULL,
  idfacultadingreso smallint NOT NULL,
  idtipotitulo smallint NOT NULL,
  idrda smallint NOT NULL,
  idtitulo smallint NOT NULL,
  idgenero smallint NOT NULL,
  idsubserieopcion smallint NOT NULL,
  cantidadm double precision,
  cantidadn double precision,
  cantidads double precision,
  cantidad double precision,
  fechacarga timestamp without time zone NOT NULL,
  CONSTRAINT academica_dsa_ft_cuadro26_pkey PRIMARY KEY (idcuadro26)
);

-- DW
CREATE TABLE araucano.academica_ft_preuniversitarios
(
  idpreuniversitarios serial NOT NULL,
  idanioinformado smallint NOT NULL,
  idfacultad smallint NOT NULL,
  idfacultadingreso smallint NOT NULL,
  idtipotitulo smallint NOT NULL,
  idrda smallint NOT NULL,
  idtitulo smallint NOT NULL,
  idgenero smallint NOT NULL,
  idserie smallint NOT NULL,
  cantidadm double precision,
  cantidadn double precision,
  cantidads double precision,
  cantidad double precision, 
  unidad_generica_id integer DEFAULT 0,
  importacion_id integer,
  CONSTRAINT academica_ft_preuniversitarios_pkey PRIMARY KEY (idpreuniversitarios)
);

CREATE TABLE araucano.academica_ft_cuadros23y24
(
  idcuadros23y24 serial NOT NULL,
  idanioinformado smallint NOT NULL,
  idfacultad smallint NOT NULL,
  idfacultadingreso smallint NOT NULL,
  idtipotitulo smallint NOT NULL,
  idrda smallint NOT NULL,
  idtitulo smallint NOT NULL,
  idgenero smallint NOT NULL,
  idsubserieopcion smallint NOT NULL,
  cantidadm double precision,
  cantidadn double precision,
  cantidads double precision,
  cantidad double precision, 
  unidad_generica_id integer DEFAULT 0,
  importacion_id integer,
  CONSTRAINT academica_ft_cuadros23y24_pkey PRIMARY KEY (idcuadros23y24)
);

CREATE TABLE araucano.academica_ft_cuadro25
(
  idcuadro25 serial NOT NULL,
  idanioinformado smallint NOT NULL,
  idfacultad smallint NOT NULL,
  idfacultadingreso smallint NOT NULL,
  idtipotitulo smallint NOT NULL,
  idrda smallint NOT NULL,
  idtitulo smallint NOT NULL,
  idgenero smallint NOT NULL,
  idsubserieopcion smallint NOT NULL,
  cantidadm double precision,
  cantidadn double precision,
  cantidads double precision,
  cantidad double precision, 
  unidad_generica_id integer DEFAULT 0,
  importacion_id integer,
  CONSTRAINT academica_ft_cuadro25_pkey PRIMARY KEY (idcuadro25)
);

CREATE TABLE araucano.academica_ft_cuadro26
(
  idcuadro26 serial NOT NULL,
  idanioinformado smallint NOT NULL,
  idfacultad smallint NOT NULL,
  idfacultadingreso smallint NOT NULL,
  idtipotitulo smallint NOT NULL,
  idrda smallint NOT NULL,
  idtitulo smallint NOT NULL,
  idgenero smallint NOT NULL,
  idsubserieopcion smallint NOT NULL,
  cantidadm double precision,
  cantidadn double precision,
  cantidads double precision,
  cantidad double precision, 
  unidad_generica_id integer DEFAULT 0,
  importacion_id integer,
  CONSTRAINT academica_ft_cuadro26_pkey PRIMARY KEY (idcuadro26)
);

------------------------------------------------------------------------------------------
------- SUDOCU
------------------------------------------------------------------------------------------

--TMP

ALTER TABLE IF EXISTS sudocu_tmp.d_area
    ADD COLUMN eliminado boolean;
    
ALTER TABLE IF EXISTS sudocu_tmp.d_usuario
    ADD COLUMN nivel_firma text;
      
ALTER TABLE IF EXISTS sudocu_tmp.d_tipo_documento
    ADD COLUMN eliminado boolean;   
    
ALTER TABLE IF EXISTS sudocu_tmp.d_documento
    ADD COLUMN documento text;     
    
ALTER TABLE IF EXISTS sudocu_tmp.d_documento
    ADD COLUMN ts timestamp;    
    
ALTER TABLE IF EXISTS sudocu_tmp.d_documento
    ADD COLUMN firmas text;    
    
ALTER TABLE IF EXISTS sudocu_tmp.d_documento_version
   ADD COLUMN ts timestamp;
    
ALTER TABLE IF EXISTS sudocu_tmp.ft_evento
    ADD COLUMN atributos text; 
    
ALTER TABLE IF EXISTS sudocu_tmp.ft_evento
   ADD COLUMN ts timestamp;    

----------AGREGA TABLAS PARA INDICADORES------------
CREATE TABLE IF NOT EXISTS sudocu_tmp.archivos
(
    id character varying,
    tipo_archivo character varying(2),
    filename character varying(1000),
    ext character varying(255),
    mimetype character varying(255),
    repositorio character varying(255),
    id_repo character varying(255),
    estado integer,
    ts timestamp without time zone,
    size bigint,
    paginas integer,
    firmado boolean,
    hash character varying,
    firmas text,
    path character varying 
);

CREATE TABLE IF NOT EXISTS sudocu_tmp.config
(
    contexto character varying(255),
    clave character varying(255),
    valor text
);

CREATE TABLE IF NOT EXISTS sudocu_tmp.documentos_numeradores
(
    id integer
);

CREATE TABLE IF NOT EXISTS sudocu_tmp.documentos_templates
(
    id integer,
    fecha_creacion timestamp without time zone
);

CREATE TABLE IF NOT EXISTS sudocu_tmp.documentos_relaciones
(
    id integer,
    id_documento character varying,
    id_documento_relacionado character varying,
    id_tipo_relacion integer,
    atributos text,
    ts timestamp without time zone,
    estado integer   
);

CREATE TABLE IF NOT EXISTS sudocu_tmp.documentos_seguimientos
(
    id character varying,
    tipo character varying(20),
    ts timestamp with time zone
);
    
CREATE TABLE IF NOT EXISTS sudocu_tmp.documentos_contenedores
(
    id integer,
    publico boolean
);

CREATE TABLE IF NOT EXISTS sudocu_tmp.migrations
(
    id integer,
    name character varying(255),
    run_on timestamp without time zone
);

CREATE TABLE IF NOT EXISTS sudocu_tmp.pdf_templates
(
    id integer,
    fecha_creacion timestamp without time zone
);

CREATE TABLE IF NOT EXISTS sudocu_tmp.personas
(
    id character varying,
    tipo character varying
);

CREATE TABLE IF NOT EXISTS sudocu_tmp.ultimos_eventos
(
    id character varying,
    ts timestamp without time zone
);

CREATE TABLE IF NOT EXISTS sudocu_tmp.size_indexes_tables
(
    nombre_tabla character varying,
    valor_size integer,
    valor_indexes integer
);

------------------------------------------------------------------------------------------
------- Mapuche
------------------------------------------------------------------------------------------
--Agrega codigo en descripcion de fuente
UPDATE mapuche.d_imppresupfuente
	SET imppresupfuente_desc= imppresupfuente_codigo || ' - ' || imppresupfuente_desc
	WHERE imppresupfuente_codigo not in ('0' , '-1');

--Agranda numeric
DROP VIEW mapuche.ft_personal_abierta;
DROP VIEW mapuche.ft_personal_cerrada;

--TMP
ALTER TABLE mapuche_tmp.ft_liqconceptosxcargos
    ALTER COLUMN novedad_1 TYPE numeric(17, 2);
    
ALTER TABLE mapuche_tmp.ft_liqconceptosxcargos
    ALTER COLUMN novedad_2 TYPE numeric(17, 2);
    
--DSA
ALTER TABLE mapuche_dsa.ft_liqconceptosxcargos
    ALTER COLUMN novedad_1 TYPE numeric(17, 2);
    
ALTER TABLE mapuche_dsa.ft_liqconceptosxcargos
    ALTER COLUMN novedad_2 TYPE numeric(17, 2);
    
--DW
ALTER TABLE mapuche.ft_personal
    ALTER COLUMN novedad_1 TYPE numeric(17, 2);
    
ALTER TABLE mapuche.ft_personal
    ALTER COLUMN novedad_2 TYPE numeric(17, 2);
    
--Actualizar vistas mapuche

CREATE OR REPLACE VIEW mapuche.ft_personal_cerrada  
    AS SELECT * FROM mapuche.ft_personal WHERE liquidacion_id IN (SELECT liquidacion_id FROM mapuche.d_liquidacion WHERE es_cerrada IN('Cerrada','VACIO/NULO'));

CREATE OR REPLACE VIEW mapuche.ft_personal_abierta  
    AS SELECT * FROM mapuche.ft_personal WHERE liquidacion_id IN (SELECT liquidacion_id FROM mapuche.d_liquidacion WHERE es_cerrada = 'Abierta');
    
------------------------------------------------------------------------------------------
------- Guarani
------------------------------------------------------------------------------------------    
    
CREATE TABLE IF NOT EXISTS guarani3_tmp.d_modalidad
(
    modalidad_id character NOT NULL,
    modalidad_desc character varying
);

CREATE TABLE IF NOT EXISTS guarani3_dsa.d_modalidad
(
    modalidad_id integer NOT NULL,
    modalidad_codigo character varying,
    modalidad_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying ,
    fecha_actualizacion timestamp without time zone,
    CONSTRAINT d_modalidad_pk PRIMARY KEY (modalidad_id)
);

CREATE TABLE IF NOT EXISTS guarani3.d_modalidad
(
    modalidad_id integer NOT NULL,
    modalidad_codigo character varying,
    modalidad_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone,
    CONSTRAINT d_modalidad_pk PRIMARY KEY (modalidad_id)
);

ALTER TABLE IF EXISTS guarani3_tmp.ft_alumnos
    ADD COLUMN modalidad_id character;
    
ALTER TABLE IF EXISTS guarani3_dsa.ft_alumnos
    ADD COLUMN modalidad_id integer NOT NULL DEFAULT 0;
    
ALTER TABLE IF EXISTS guarani3.ft_alumnos
    ADD COLUMN modalidad_id integer NOT NULL DEFAULT 0;
    
ALTER TABLE IF EXISTS guarani3_tmp.ft_procedencia_aspirantes
    ADD COLUMN modalidad_id character;
    
ALTER TABLE IF EXISTS guarani3_dsa.ft_procedencia_aspirantes
    ADD COLUMN modalidad_id integer NOT NULL DEFAULT 0;
    
ALTER TABLE IF EXISTS guarani3.ft_procedencia_aspirantes
    ADD COLUMN modalidad_id integer NOT NULL DEFAULT 0;        
    
ALTER TABLE IF EXISTS guarani3_tmp.d_comision
    ADD COLUMN modalidad_desc character varying DEFAULT 'VACIO/NULO';    

ALTER TABLE IF EXISTS guarani3_dsa.d_comision
    ADD COLUMN modalidad_desc character varying DEFAULT 'VACIO/NULO';
    
ALTER TABLE IF EXISTS guarani3.d_comision
    ADD COLUMN modalidad_desc character varying DEFAULT 'VACIO/NULO';
    
ALTER TABLE IF EXISTS guarani3_tmp.ft_examen
    ADD COLUMN modalidad_id character;

ALTER TABLE IF EXISTS guarani3_tmp.ft_equivalencia
    ADD COLUMN modalidad_id character;
    
ALTER TABLE IF EXISTS guarani3_tmp.ft_cursado
    ADD COLUMN modalidad_id character;

ALTER TABLE IF EXISTS guarani3_dsa.ft_examen
    ADD COLUMN modalidad_id integer NOT NULL DEFAULT 0;

ALTER TABLE IF EXISTS guarani3_dsa.ft_equivalencia
    ADD COLUMN modalidad_id integer NOT NULL DEFAULT 0;
    
ALTER TABLE IF EXISTS guarani3_dsa.ft_cursado
    ADD COLUMN modalidad_id integer NOT NULL DEFAULT 0;
    
ALTER TABLE IF EXISTS guarani3.ft_rendimiento
    ADD COLUMN modalidad_id integer NOT NULL DEFAULT 0;
    
    
--Inscripciones a Cursadas

CREATE TABLE IF NOT EXISTS guarani3_tmp.ft_inscripciones_cursadas
(
    ubicacion_id character varying,
    anio_academico character varying,
    tipo_periodo_id character varying,
    periodo_lectivo_desc character varying,
    alumno_id character varying,
    propuesta_formativa_id character varying,
    plan_version_id character varying,
    actividad_id character varying,
    catedra_id character varying,
    tipo_actividad_id character varying,
    comision_id character varying,
    modalidad_id character,
    inscripcion character varying,
    nro_transaccion character varying,
    estado_inscripcion_id character(1),
    turno_id character varying,
    fecha_inscripcion character varying,
    instancias_desc character varying,
    sexo_id character varying,
    edad_id integer,
    nacionalidad_id character varying,
    colegio_secundario_id integer,
    anio_ingreso_institucion character varying,
    anio_ingreso_pf character varying,
    periodo_inscripcion_pf_desc character varying,
    cantidad_registros_inscripciones character varying,
    persona_id integer,
    horas_trabajadas_id character varying,
    estado_civil_id integer,
    localidad_per_lec_id integer,
    localidad_proc_id integer,
    costeo_estudios_id character varying,
    beca_id character(1),
    tecno_internet_id character varying(60),
    tecno_pc_id character varying(60),
    idioma_id character varying(60),
    discapacidad_id character varying
);

CREATE TABLE IF NOT EXISTS guarani3_dsa.ft_inscripciones_cursadas
(
    instalacion_id integer,
    ubicacion_id integer NOT NULL,
    anio_academico integer NOT NULL,
    tipo_periodo_id integer NOT NULL,
    periodo_lectivo_id integer NOT NULL,
    alumno_id integer NOT NULL,
    edad_id integer NOT NULL,
    sexo_id integer NOT NULL,
    nacionalidad_id integer NOT NULL,
    procedencia_id integer NOT NULL, 
    propuesta_formativa_id integer NOT NULL,
    responsable_academica_id integer NOT NULL,
    plan_version_id integer NOT NULL,
    actividad_id integer NOT NULL,
    catedra_id integer NOT NULL,
    comision_id integer NOT NULL,
    condicion_id integer NOT NULL,
    tipo_actividad_id integer NOT NULL,
    inscripcion integer NOT NULL,
    nro_transaccion integer NOT NULL,
    estado_inscripcion_id integer NOT NULL,
    turno_cursada_id integer NOT NULL,
    fecha_inscripcion date NOT NULL,
    anio_ingreso_institucion integer NOT NULL,
    periodo_inscripcion_pf_id integer,
    cantidad_registros_inscripciones integer NOT NULL, 
    modalidad_id integer NOT NULL,
    persona_id integer,
    horas_trabajadas_id integer NOT NULL,
    estado_civil_id integer NOT NULL,
    localidad_periodo_lectivo_id integer NOT NULL,
    localidad_procedencia_id integer NOT NULL,
    costeo_estudios_id integer,
    beca character(10) COLLATE pg_catalog."default",
    tecno_internet_id integer,
    tecno_pc_id integer,
    idioma_id integer,
    discapacidad_id integer
);

ALTER TABLE IF EXISTS guarani3.ft_rendimiento
    ADD COLUMN inscripcion integer NOT NULL DEFAULT 0;

ALTER TABLE IF EXISTS guarani3.ft_rendimiento
    ADD COLUMN nro_transaccion integer NOT NULL DEFAULT 0;
    
ALTER TABLE IF EXISTS guarani3.ft_rendimiento
    ADD COLUMN estado_inscripcion_id integer NOT NULL DEFAULT 0;
    
ALTER TABLE IF EXISTS guarani3.ft_rendimiento
    ADD COLUMN turno_cursada_id integer NOT NULL DEFAULT 0;

ALTER TABLE IF EXISTS guarani3.ft_rendimiento
    ADD COLUMN cantidad_registros_inscripciones integer;

CREATE TABLE IF NOT EXISTS guarani3_tmp.d_estado_inscripcion
(
    estado_inscripcion_id character NOT NULL,
    estado_inscripcion_desc character varying
);

CREATE TABLE IF NOT EXISTS guarani3_dsa.d_estado_inscripcion
(
    estado_inscripcion_id integer NOT NULL,
    estado_inscripcion_codigo character varying,
    estado_inscripcion_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying ,
    fecha_actualizacion timestamp without time zone,
    CONSTRAINT d_estado_inscripcion_pk PRIMARY KEY (estado_inscripcion_id)
);

CREATE TABLE IF NOT EXISTS guarani3.d_estado_inscripcion
(
    estado_inscripcion_id integer NOT NULL,
    estado_inscripcion_codigo character varying,
    estado_inscripcion_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone,
    CONSTRAINT d_estado_inscripcion_pk PRIMARY KEY (estado_inscripcion_id)
);

CREATE TABLE IF NOT EXISTS guarani3_tmp.d_turno_cursada
(
    turno_cursada_id character NOT NULL,
    turno_cursada_desc character varying
);

CREATE TABLE IF NOT EXISTS guarani3_dsa.d_turno_cursada
(
    turno_cursada_id integer NOT NULL,
    turno_cursada_codigo character varying,
    turno_cursada_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying ,
    fecha_actualizacion timestamp without time zone,
    CONSTRAINT d_turno_cursada_pk PRIMARY KEY (turno_cursada_id)
);

CREATE TABLE IF NOT EXISTS guarani3.d_turno_cursada
(
    turno_cursada_id integer NOT NULL,
    turno_cursada_codigo character varying,
    turno_cursada_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone,
    CONSTRAINT d_turno_cursada_pk PRIMARY KEY (turno_cursada_id)
);
