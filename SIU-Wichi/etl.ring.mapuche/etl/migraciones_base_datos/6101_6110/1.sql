-- Este script es parte de la migración de SIU-Wichi 6.10.1 a 6.11.0

-----------------------------
--Guarani 3
-----------------------------

ALTER TABLE guarani3_tmp.d_persona
  ADD COLUMN apyno_elegido character varying;
  
ALTER TABLE guarani3_dsa.d_persona
  ADD COLUMN apyno_elegido character varying;
  
ALTER TABLE guarani3.d_persona
  ADD COLUMN apyno_elegido character varying;
  
ALTER TABLE guarani3_tmp.d_persona
  ADD COLUMN pueblo_originario character varying;
  
ALTER TABLE guarani3_dsa.d_persona
  ADD COLUMN pueblo_originario character varying;
  
ALTER TABLE guarani3.d_persona
  ADD COLUMN pueblo_originario character varying;
  
ALTER TABLE guarani3_tmp.d_persona
  ADD COLUMN identidad_genero character varying;
  
ALTER TABLE guarani3_dsa.d_persona
  ADD COLUMN identidad_genero character varying;
  
ALTER TABLE guarani3.d_persona
  ADD COLUMN identidad_genero character varying;
  
ALTER TABLE guarani3_tmp.ft_alumnos
  ADD COLUMN discapacidad_id character varying(60);
  
ALTER TABLE guarani3_tmp.ft_cursado
  ADD COLUMN discapacidad_id character varying(60);

ALTER TABLE guarani3_tmp.ft_equivalencia
  ADD COLUMN discapacidad_id character varying(60);

ALTER TABLE guarani3_tmp.ft_examen
  ADD COLUMN discapacidad_id character varying(60); 
  
CREATE TABLE guarani3_tmp.d_discapacidad
(
  discapacidad_id character varying,
  discapacidad_desc character varying
);   
  
ALTER TABLE guarani3_dsa.ft_alumnos
  ADD COLUMN discapacidad_id integer;
    
ALTER TABLE guarani3_dsa.ft_cursado
  ADD COLUMN discapacidad_id integer;

ALTER TABLE guarani3_dsa.ft_equivalencia
  ADD COLUMN discapacidad_id integer;

ALTER TABLE guarani3_dsa.ft_examen
  ADD COLUMN discapacidad_id integer;  
  
CREATE TABLE guarani3_dsa.d_discapacidad
(
  discapacidad_id integer NOT NULL,
  discapacidad_codigo integer,
  discapacidad_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_discapacidad_pk PRIMARY KEY (discapacidad_id)
);  

ALTER TABLE guarani3.ft_alumnos
  ADD COLUMN discapacidad_sino character varying(2);

ALTER TABLE guarani3.ft_rendimiento
  ADD COLUMN discapacidad_sino character varying(2);

ALTER TABLE guarani3.ft_alumnos
  ADD COLUMN discapacidad_id integer;

ALTER TABLE guarani3.ft_rendimiento
  ADD COLUMN discapacidad_id integer;
    
CREATE TABLE guarani3.d_discapacidad
(
  discapacidad_id integer NOT NULL,
  discapacidad_codigo integer,
  discapacidad_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_discapacidad_pk PRIMARY KEY (discapacidad_id)
); 


-----------------------------
--Araucano
-----------------------------  
--TMP
ALTER TABLE araucano_tmp.ft_totaldetallea
    RENAME cantidad_c3 TO cantidadm_c3;
    
ALTER TABLE araucano_tmp.ft_totaldetalled_aye
    RENAME cantidad_c5 TO cantidadm_c5;
    
ALTER TABLE araucano_tmp.ft_totaldetalled_aym
    RENAME cantidad_c4 TO cantidadm_c4;
    
ALTER TABLE araucano_tmp.ft_totaldetallef_niinst
    RENAME cantidad_c15 TO cantidadm_c15;
    
ALTER TABLE araucano_tmp.ft_totaldetalles_ae
    RENAME cantidad_c8 TO cantidadm_c8;
    
ALTER TABLE araucano_tmp.ft_totaldetalles_ni
    RENAME cantidad_c9y10 TO cantidadm_c9y10;
    
ALTER TABLE araucano_tmp.ft_totaldetalles_nipc
    RENAME cantidad_c19 TO cantidadm_c19;
    
ALTER TABLE araucano_tmp.ft_totaldetalles_nipm
    RENAME cantidad_c18 TO cantidadm_c18;
    
ALTER TABLE araucano_tmp.ft_totaldetalles_nitra
    RENAME cantidad_c14 TO cantidadm_c14;
    
ALTER TABLE araucano_tmp.ft_totaldetalles_pc
    RENAME cantidad_c17 TO cantidadm_c17;
    
ALTER TABLE araucano_tmp.ft_totaldetalles_pm
    RENAME cantidad_c16 TO cantidadm_c16;
    
ALTER TABLE araucano_tmp.ft_totaldetalles_pma
    RENAME cantidad_c7 TO cantidadm_c7;                                

ALTER TABLE araucano_tmp.ft_totaldetalles_tra
    RENAME cantidad_c6 TO cantidadm_c6;
    
ALTER TABLE araucano_tmp.ft_totaldetalless_act_max
    RENAME cantidad_c13 TO cantidadm_c13;
    
ALTER TABLE araucano_tmp.ft_totaldetalless_max
    RENAME cantidad_c12 TO cantidadm_c12;  
    
ALTER TABLE araucano_tmp.ft_totaldetallea
    ADD COLUMN cantidadn_c3 character varying;
    
ALTER TABLE araucano_tmp.ft_totaldetalled_aye
    ADD COLUMN cantidadn_c5 character varying;
    
ALTER TABLE araucano_tmp.ft_totaldetalled_aym
    ADD COLUMN cantidadn_c4 character varying;
    
ALTER TABLE araucano_tmp.ft_totaldetallef_niinst
    ADD COLUMN cantidadn_c15 character varying;
    
ALTER TABLE araucano_tmp.ft_totaldetalles_ae
    ADD COLUMN cantidadn_c8 character varying;
    
ALTER TABLE araucano_tmp.ft_totaldetalles_ni
    ADD COLUMN cantidadn_c9y10 character varying;
    
ALTER TABLE araucano_tmp.ft_totaldetalles_nipc
    ADD COLUMN cantidadn_c19 character varying;
    
ALTER TABLE araucano_tmp.ft_totaldetalles_nipm
    ADD COLUMN cantidadn_c18 character varying;
    
ALTER TABLE araucano_tmp.ft_totaldetalles_nitra
    ADD COLUMN cantidadn_c14 character varying;
    
ALTER TABLE araucano_tmp.ft_totaldetalles_pc
    ADD COLUMN cantidadn_c17 character varying;
    
ALTER TABLE araucano_tmp.ft_totaldetalles_pm
    ADD COLUMN cantidadn_c16 character varying;
    
ALTER TABLE araucano_tmp.ft_totaldetalles_pma
    ADD COLUMN cantidadn_c7 character varying;                                

ALTER TABLE araucano_tmp.ft_totaldetalles_tra
    ADD COLUMN cantidadn_c6 character varying;
    
ALTER TABLE araucano_tmp.ft_totaldetalless_act_max
    ADD COLUMN cantidadn_c13 character varying;
    
ALTER TABLE araucano_tmp.ft_totaldetalless_max
    ADD COLUMN cantidadn_c12 character varying;          

ALTER TABLE araucano_tmp.ft_totaldetallea
    ADD COLUMN cantidads_c3 character varying;
    
ALTER TABLE araucano_tmp.ft_totaldetallef_niinst
    ADD COLUMN cantidads_c15 character varying;
    
ALTER TABLE araucano_tmp.ft_totaldetalles_ae
    ADD COLUMN cantidads_c8 character varying;
    
ALTER TABLE araucano_tmp.ft_totaldetalles_ni
    ADD COLUMN cantidads_c9y10 character varying;
    
ALTER TABLE araucano_tmp.ft_totaldetalles_nipc
    ADD COLUMN cantidads_c19 character varying;
    
ALTER TABLE araucano_tmp.ft_totaldetalles_nipm
    ADD COLUMN cantidads_c18 character varying;
    
ALTER TABLE araucano_tmp.ft_totaldetalles_nitra
    ADD COLUMN cantidads_c14 character varying;
    
ALTER TABLE araucano_tmp.ft_totaldetalles_pc
    ADD COLUMN cantidads_c17 character varying;
    
ALTER TABLE araucano_tmp.ft_totaldetalles_pm
    ADD COLUMN cantidads_c16 character varying;
    
ALTER TABLE araucano_tmp.ft_totaldetalles_pma
    ADD COLUMN cantidads_c7 character varying;                                

ALTER TABLE araucano_tmp.ft_totaldetalles_tra
    ADD COLUMN cantidads_c6 character varying;
    
ALTER TABLE araucano_tmp.ft_totaldetalless_act_max
    ADD COLUMN cantidads_c13 character varying;
    
ALTER TABLE araucano_tmp.ft_totaldetalless_max
    ADD COLUMN cantidads_c12 character varying;                     
    
--DSA
ALTER TABLE araucano_dsa.academica_ft_cuadro3
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro3
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro3
    ADD COLUMN cantidads double precision;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro4
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro4
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro5
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro5
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro6
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro6
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro6
    ADD COLUMN cantidads double precision;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro7
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro7
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro7
    ADD COLUMN cantidads double precision;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro8
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro8
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro8
    ADD COLUMN cantidads double precision;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro12
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro12
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro12
    ADD COLUMN cantidads double precision;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro13
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro13
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro13
    ADD COLUMN cantidads double precision;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro14
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro14
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro14
    ADD COLUMN cantidads double precision;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro15
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro15
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro15
    ADD COLUMN cantidads double precision;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro16
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro16
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro16
    ADD COLUMN cantidads double precision;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro17
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro17
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro17
    ADD COLUMN cantidads double precision;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro18
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro18
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro18
    ADD COLUMN cantidads double precision;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro19
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro19
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano_dsa.academica_ft_cuadro19
    ADD COLUMN cantidads double precision;
    
ALTER TABLE araucano_dsa.academica_ft_cuadros1y2
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano_dsa.academica_ft_cuadros1y2
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano_dsa.academica_ft_cuadros1y2
    ADD COLUMN cantidads double precision;
    
ALTER TABLE araucano_dsa.academica_ft_cuadros9y10
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano_dsa.academica_ft_cuadros9y10
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano_dsa.academica_ft_cuadros9y10
    ADD COLUMN cantidads double precision;                                                            
    
--DW
ALTER TABLE araucano.academica_ft_cuadro3
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano.academica_ft_cuadro3
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano.academica_ft_cuadro3
    ADD COLUMN cantidads double precision;
    
ALTER TABLE araucano.academica_ft_cuadro4
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano.academica_ft_cuadro4
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano.academica_ft_cuadro5
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano.academica_ft_cuadro5
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano.academica_ft_cuadro6
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano.academica_ft_cuadro6
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano.academica_ft_cuadro6
    ADD COLUMN cantidads double precision;
    
ALTER TABLE araucano.academica_ft_cuadro7
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano.academica_ft_cuadro7
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano.academica_ft_cuadro7
    ADD COLUMN cantidads double precision;
    
ALTER TABLE araucano.academica_ft_cuadro8
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano.academica_ft_cuadro8
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano.academica_ft_cuadro8
    ADD COLUMN cantidads double precision;
    
ALTER TABLE araucano.academica_ft_cuadro12
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano.academica_ft_cuadro12
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano.academica_ft_cuadro12
    ADD COLUMN cantidads double precision;
    
ALTER TABLE araucano.academica_ft_cuadro13
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano.academica_ft_cuadro13
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano.academica_ft_cuadro13
    ADD COLUMN cantidads double precision;
    
ALTER TABLE araucano.academica_ft_cuadro14
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano.academica_ft_cuadro14
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano.academica_ft_cuadro14
    ADD COLUMN cantidads double precision;
    
ALTER TABLE araucano.academica_ft_cuadro15
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano.academica_ft_cuadro15
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano.academica_ft_cuadro15
    ADD COLUMN cantidads double precision;
    
ALTER TABLE araucano.academica_ft_cuadro16
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano.academica_ft_cuadro16
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano.academica_ft_cuadro16
    ADD COLUMN cantidads double precision;
    
ALTER TABLE araucano.academica_ft_cuadro17
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano.academica_ft_cuadro17
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano.academica_ft_cuadro17
    ADD COLUMN cantidads double precision;
    
ALTER TABLE araucano.academica_ft_cuadro18
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano.academica_ft_cuadro18
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano.academica_ft_cuadro18
    ADD COLUMN cantidads double precision;
    
ALTER TABLE araucano.academica_ft_cuadro19
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano.academica_ft_cuadro19
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano.academica_ft_cuadro19
    ADD COLUMN cantidads double precision;
    
ALTER TABLE araucano.academica_ft_cuadros1y2
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano.academica_ft_cuadros1y2
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano.academica_ft_cuadros1y2
    ADD COLUMN cantidads double precision;
    
ALTER TABLE araucano.academica_ft_cuadros9y10
    RENAME cantidad TO cantidadm;
    
ALTER TABLE araucano.academica_ft_cuadros9y10
    ADD COLUMN cantidadn double precision;
    
ALTER TABLE araucano.academica_ft_cuadros9y10
    ADD COLUMN cantidads double precision;                                                            

CREATE TABLE araucano_tmp.ft_totaldetalless_ni_max
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
  idprocedencia character varying,
  idpais character varying,
  cantidadm_c20 character varying,
  cantidadn_c20 character varying,
  cantidads_c20 character varying
);

CREATE TABLE araucano_tmp.ft_totaldetalless_r_max
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
  idprocedencia character varying,
  idpais character varying,
  cantidadm_c21 character varying,
  cantidadn_c21 character varying,
  cantidads_c21 character varying
);

CREATE TABLE araucano_tmp.ft_totaldetalless_e_max
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
  idprocedencia character varying,
  idpais character varying,
  cantidadm_c22 character varying,
  cantidadn_c22 character varying,
  cantidads_c22 character varying
);

CREATE TABLE araucano_dsa.academica_ft_cuadro20
(
  idcuadro20 serial NOT NULL,
  idanioinformado smallint NOT NULL,
  idfacultad smallint NOT NULL,
  idfacultadingreso smallint NOT NULL,
  idtipotitulo smallint NOT NULL,
  idrda smallint NOT NULL,
  idtitulo smallint NOT NULL,
  idgenero smallint NOT NULL,
  idprocedencia smallint NOT NULL,
  idpais smallint NOT NULL,
  idsubserieopcion smallint NOT NULL,
  cantidadm double precision,
  cantidadn double precision,
  cantidads double precision,
  fechacarga timestamp NOT NULL, --(fecha y hora en que se cargó la información)
  CONSTRAINT academica_dsa_ft_cuadro20_pkey PRIMARY KEY (idcuadro20)
);

CREATE TABLE araucano_dsa.academica_ft_cuadro21
(
  idcuadro21 serial NOT NULL,
  idanioinformado smallint NOT NULL,
  idfacultad smallint NOT NULL,
  idfacultadingreso smallint NOT NULL,
  idtipotitulo smallint NOT NULL,
  idrda smallint NOT NULL,
  idtitulo smallint NOT NULL,
  idgenero smallint NOT NULL,
  idprocedencia smallint NOT NULL,
  idpais smallint NOT NULL,
  idsubserieopcion smallint NOT NULL,
  cantidadm double precision,
  cantidadn double precision,
  cantidads double precision,
  fechacarga timestamp NOT NULL, --(fecha y hora en que se cargó la información)
  CONSTRAINT academica_dsa_ft_cuadro21_pkey PRIMARY KEY (idcuadro21)
);

CREATE TABLE araucano_dsa.academica_ft_cuadro22
(
  idcuadro22 serial NOT NULL,
  idanioinformado smallint NOT NULL,
  idfacultad smallint NOT NULL,
  idfacultadingreso smallint NOT NULL,
  idtipotitulo smallint NOT NULL,
  idrda smallint NOT NULL,
  idtitulo smallint NOT NULL,
  idgenero smallint NOT NULL,
  idprocedencia smallint NOT NULL,
  idpais smallint NOT NULL,
  idsubserieopcion smallint NOT NULL,
  cantidadm double precision,
  cantidadn double precision,
  cantidads double precision,
  fechacarga timestamp NOT NULL, --(fecha y hora en que se cargó la información)
  CONSTRAINT academica_dsa_ft_cuadro22_pkey PRIMARY KEY (idcuadro22)
);

CREATE TABLE araucano.academica_ft_cuadro20
(
  idcuadro20 serial NOT NULL,
  idanioinformado smallint NOT NULL,
  idfacultad smallint NOT NULL,
  idfacultadingreso smallint NOT NULL,
  idtipotitulo smallint NOT NULL,
  idrda smallint NOT NULL,
  idtitulo smallint NOT NULL,
  idgenero smallint NOT NULL,
  idprocedencia smallint NOT NULL,
  idpais smallint NOT NULL,
  idsubserieopcion smallint NOT NULL,
  cantidadm double precision,
  cantidadn double precision,
  cantidads double precision,
  unidad_generica_id integer DEFAULT 0,
  importacion_id integer,
  CONSTRAINT academica_ft_cuadro20_pkey PRIMARY KEY (idcuadro20)
);

CREATE TABLE araucano.academica_ft_cuadro21
(
  idcuadro21 serial NOT NULL,
  idanioinformado smallint NOT NULL,
  idfacultad smallint NOT NULL,
  idfacultadingreso smallint NOT NULL,
  idtipotitulo smallint NOT NULL,
  idrda smallint NOT NULL,
  idtitulo smallint NOT NULL,
  idgenero smallint NOT NULL,
  idprocedencia smallint NOT NULL,
  idpais smallint NOT NULL,
  idsubserieopcion smallint NOT NULL,
  cantidadm double precision,
  cantidadn double precision,
  cantidads double precision,
  unidad_generica_id integer DEFAULT 0,
  importacion_id integer,
  CONSTRAINT academica_ft_cuadro21_pkey PRIMARY KEY (idcuadro21)
);

CREATE TABLE araucano.academica_ft_cuadro22
(
  idcuadro22 serial NOT NULL,
  idanioinformado smallint NOT NULL,
  idfacultad smallint NOT NULL,
  idfacultadingreso smallint NOT NULL,
  idtipotitulo smallint NOT NULL,
  idrda smallint NOT NULL,
  idtitulo smallint NOT NULL,
  idgenero smallint NOT NULL,
  idprocedencia smallint NOT NULL,
  idpais smallint NOT NULL,
  idsubserieopcion smallint NOT NULL,
  cantidadm double precision,
  cantidadn double precision,
  cantidads double precision,
  unidad_generica_id integer DEFAULT 0,
  importacion_id integer,
  CONSTRAINT academica_ft_cuadro22_pkey PRIMARY KEY (idcuadro22)
);

DROP TABLE araucano_tmp.ft_cuadros1y2;

CREATE TABLE araucano_tmp.ft_cuadros1y2
(
    idfacultad character varying,
    idtitulo character varying,
    anioinformado character varying,
    idtipotitulo character varying,
    idfacultadingreso character varying,
    genero character varying,
    idserie character varying,
    cantidadm_c1y2 character varying,
    cantidadn_c1y2 character varying,
    cantidads_c1y2 character varying
);

------------------------------------------------
--Tablero Integrado
------------------------------------------------

CREATE OR REPLACE FUNCTION integrado.carga_integrado(
	)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
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
(SELECT coalesce(sum(case when cantidadm > 0 then cantidadm else cantidadn end),0)
 FROM araucano.academica_ft_cuadros1y2 c, araucano.academica_d_series s
 WHERE i.anio_id=c.idanioinformado AND i.unidad_generica_id=c.unidad_generica_id AND c.idserie=s.idserie AND s.serie='MA'), 
araucano_nuevos_inscriptos =
(SELECT coalesce(sum(case when cantidadm > 0 then cantidadm else cantidadn end),0)
 FROM araucano.academica_ft_cuadros1y2 c, araucano.academica_d_series s
 WHERE i.anio_id=c.idanioinformado AND i.unidad_generica_id=c.unidad_generica_id AND c.idserie=s.idserie AND s.serie IN ('NI', 'NIP', 'NIQ')),
araucano_reinscriptos =
(SELECT coalesce(sum(case when cantidadm > 0 then cantidadm else cantidadn end),0)
 FROM araucano.academica_ft_cuadros1y2 c, araucano.academica_d_series s
 WHERE i.anio_id=c.idanioinformado AND i.unidad_generica_id=c.unidad_generica_id AND c.idserie=s.idserie AND s.serie='R'),
 araucano_egresados =
(SELECT coalesce(sum(case when cantidadm > 0 then cantidadm else cantidadn end),0)
 FROM araucano.academica_ft_cuadros1y2 c, araucano.academica_d_series s
 WHERE i.anio_id=c.idanioinformado AND i.unidad_generica_id=c.unidad_generica_id AND c.idserie=s.idserie AND s.serie='E');
 
EXECUTE 'CREATE TEMP TABLE temp_cargos_escalafones ON COMMIT DROP AS 
SELECT DISTINCT anio_id, unidad_generica_id, 
cat.escalafon_codigo as escalafon, 
coalesce(count(nro_cargo) / count(DISTINCT mes_id),0) as cantidad
FROM mapuche.ft_personal c, mapuche.d_categoriascargo cat, mapuche.d_estadodelcargo e
WHERE c.categoria_id=cat.categoria_id AND c.estadodelcargo_id = e.estadodelcargo_id
AND condicion_id = 1 AND estadodelcargo_codigo=''1''
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
insert into public.importacion (instalacion_id, fecha_inicio, fecha_fin, tipo, parametros, observaciones, estado)
values (0, fecha_hora_inicio, clock_timestamp(), 'actualizacion', ' ', 'Actualizacion ft_integrado', 'finalizada');
RETURN (SELECT count(*) FROM integrado.ft_integrado);
END
$BODY$;

ALTER FUNCTION integrado.carga_integrado()
    OWNER TO postgres;
    
    
-------------------------------------
--Portal Transparencia
-------------------------------------
ALTER TABLE portal_transparencia_dsa.ft_academica
    ADD COLUMN cant_ni integer;
