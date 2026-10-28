-- Este script es parte de la migración de SIU-Wichi 6.4.0 a 6.5.0


----------------------------- 
--     Diaguita  
----------------------------- 
-- Function: diaguita_dsa.podar_area()

DROP FUNCTION diaguita_dsa.podar_area();

CREATE OR REPLACE FUNCTION diaguita_dsa.podar_area()
  RETURNS text AS
$BODY$
  declare
    n integer;
    m integer;
    id text;
    noUsados integer := 0;
    noUsados1 integer;
    unicosEnNivel integer := 0;
    ascensos integer := 0;
  begin
    
    TRUNCATE diaguita_dsa.w_areas_referenciadas;
    INSERT INTO diaguita_dsa.w_areas_referenciadas (codigo)
    SELECT DISTINCT id_area_responsable FROM diaguita_tmp.ft_patrimonio
    WHERE id_area_responsable IS NOT NULL AND id_area_responsable NOT IN (SELECT codigo FROM diaguita_dsa.w_areas_referenciadas);
    INSERT INTO diaguita_dsa.w_areas_referenciadas (codigo)
    SELECT DISTINCT id_area_solicitud FROM diaguita_tmp.ft_compras
    WHERE id_area_solicitud IS NOT NULL AND id_area_solicitud NOT IN (SELECT codigo FROM diaguita_dsa.w_areas_referenciadas);
    INSERT INTO diaguita_dsa.w_areas_referenciadas (codigo)
    SELECT DISTINCT id_area_item_solicitado FROM diaguita_tmp.ft_compras
    WHERE id_area_item_solicitado IS NOT NULL AND id_area_item_solicitado NOT IN (SELECT codigo FROM diaguita_dsa.w_areas_referenciadas);
    INSERT INTO diaguita_dsa.w_areas_referenciadas (codigo)
    SELECT DISTINCT id_area_oc FROM diaguita_tmp.ft_compras
    WHERE id_area_oc IS NOT NULL AND id_area_oc NOT IN (SELECT codigo FROM diaguita_dsa.w_areas_referenciadas);
    INSERT INTO diaguita_dsa.w_areas_referenciadas (codigo)
    SELECT DISTINCT id_area_re FROM diaguita_tmp.ft_compras
    WHERE id_area_re IS NOT NULL AND id_area_re NOT IN (SELECT codigo FROM diaguita_dsa.w_areas_referenciadas);

    truncate table diaguita_dsa.w_area;
    insert into diaguita_dsa.w_area
      (codigo, codigo_padre, codigo_asignado, nombre, id_oficina_patrimonio, codigos_ya_asignados)
      select id_area, id_area_padre, id_area, nombre, id_oficina_patrimonio, '*' || trim(id_area) || '*'
        from diaguita_tmp.d_area;
    loop
      select count(*) into noUsados1
        from diaguita_dsa.w_area a
        where not exists (
          select ah.codigo
            from diaguita_dsa.w_area ah
            where ah.codigo_padre = a.codigo
        ) and not exists (
          select f.codigo
            from diaguita_dsa.w_areas_referenciadas f
            where f.codigo = a.codigo
        );
      if noUsados1 = 0 then
        exit;
      end if;
      delete from diaguita_dsa.w_area a
        where not exists (
          select ah.codigo
            from diaguita_dsa.w_area ah
            where ah.codigo_padre = a.codigo
        ) and not exists (
          select f.codigo
            from diaguita_dsa.w_areas_referenciadas f
            where f.codigo = a.codigo
        );
      noUsados := noUsados + noUsados1;
    end loop;
    loop
      select count(*) into n
        from diaguita_dsa.w_area
        where codigo_padre is null;
      if n = 0 then
        raise 'Error en la estructura de áreas';
        return 'ERROR';
      elsif n > 1 then
        exit;
      end if;
      select codigo into id
        from diaguita_dsa.w_area
        where codigo_padre is null;
      update diaguita_dsa.w_area
        set codigo_padre = null
        where codigo_padre = id;
      delete from diaguita_dsa.w_area
        where codigo = id;
      unicosEnNivel := unicosEnNivel + 1;
    end loop;
    loop
      select count(*) into m
        from diaguita_dsa.w_area ah
        left join diaguita_dsa.w_area aa on aa.codigo = ah.codigo_asignado
        left join diaguita_dsa.w_area ap on ap.codigo = aa.codigo_padre
        where ah.codigo_padre is not null
          and aa.codigo_padre is not null
          and ap.codigo_padre is not null
          and strpos(ah.codigos_ya_asignados, '*' || trim(aa.codigo_padre) || '*')=0;
      if m = 0 then
        exit;
      end if;
      update diaguita_dsa.w_area ah
        set codigo_asignado = aa.codigo_padre,
        codigos_ya_asignados = ah.codigos_ya_asignados || trim(aa.codigo_padre) || '*'
        from diaguita_dsa.w_area aa
        left join diaguita_dsa.w_area ap on ap.codigo = aa.codigo_padre
        where ah.codigo_padre is not null
          and aa.codigo_padre is not null
          and ap.codigo_padre is not null
          and aa.codigo = ah.codigo_asignado
          and strpos(ah.codigos_ya_asignados, '*' || trim(aa.codigo_padre) || '*')=0;
      ascensos := ascensos + 1;
    end loop;
    select count(*) into m
      from diaguita_dsa.w_area
      where codigo_padre is not null and codigo_padre!=codigo_asignado;
    return noUsados || '|' || unicosEnNivel || '|' || n || '|' || ascensos || '|' || m;
  end;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;



----------------------------- 
--     Guarani 3  
----------------------------- 

--Esquema tmp

ALTER TABLE guarani3_tmp.ft_cursado
  ADD COLUMN horas_trabajadas_id character varying;

ALTER TABLE guarani3_tmp.ft_equivalencia
  ADD COLUMN horas_trabajadas_id character varying;

ALTER TABLE guarani3_tmp.ft_examen
  ADD COLUMN horas_trabajadas_id character varying;

ALTER TABLE guarani3_tmp.ft_cursado
  ADD COLUMN estado_civil_id integer;

ALTER TABLE guarani3_tmp.ft_equivalencia
  ADD COLUMN estado_civil_id integer;

ALTER TABLE guarani3_tmp.ft_examen
  ADD COLUMN estado_civil_id integer;

ALTER TABLE guarani3_tmp.ft_cursado
  ADD COLUMN localidad_periodo_lectivo_id integer;

ALTER TABLE guarani3_tmp.ft_equivalencia
  ADD COLUMN localidad_periodo_lectivo_id integer;

ALTER TABLE guarani3_tmp.ft_examen
  ADD COLUMN localidad_periodo_lectivo_id integer;

ALTER TABLE guarani3_tmp.ft_cursado
  ADD COLUMN localidad_procedencia_id integer;

ALTER TABLE guarani3_tmp.ft_equivalencia
  ADD COLUMN localidad_procedencia_id integer;

ALTER TABLE guarani3_tmp.ft_examen
  ADD COLUMN localidad_procedencia_id integer;

ALTER TABLE guarani3_tmp.ft_alumnos
  ADD COLUMN estado_civil_id integer;

ALTER TABLE guarani3_tmp.ft_alumnos
  ADD COLUMN localidad_periodo_lectivo_id integer;

ALTER TABLE guarani3_tmp.ft_alumnos
  ADD COLUMN localidad_procedencia_id integer;

ALTER TABLE guarani3_tmp.ft_alumnos
   ADD COLUMN costeo_estudios_id character varying;

ALTER TABLE guarani3_tmp.ft_alumnos
   ADD COLUMN beca character(1);

ALTER TABLE guarani3_tmp.ft_cursado
   ADD COLUMN costeo_estudios_id  character varying;

ALTER TABLE guarani3_tmp.ft_cursado
   ADD COLUMN beca character(1);

ALTER TABLE guarani3_tmp.ft_equivalencia
   ADD COLUMN costeo_estudios_id  character varying;

ALTER TABLE guarani3_tmp.ft_equivalencia
   ADD COLUMN beca character(1);

ALTER TABLE guarani3_tmp.ft_examen
   ADD COLUMN costeo_estudios_id  character varying;

ALTER TABLE guarani3_tmp.ft_examen
   ADD COLUMN beca character(1);

ALTER TABLE guarani3_tmp.ft_alumnos
  ADD COLUMN tecno_internet_id character varying(60);

ALTER TABLE guarani3_tmp.ft_alumnos
  ADD COLUMN tecno_pc_id character varying(60);

ALTER TABLE guarani3_tmp.ft_alumnos
  ADD COLUMN idioma_id character varying(60);

ALTER TABLE guarani3_tmp.ft_cursado
  ADD COLUMN tecno_internet_id character varying(60);

ALTER TABLE guarani3_tmp.ft_cursado
  ADD COLUMN tecno_pc_id character varying(60);

ALTER TABLE guarani3_tmp.ft_cursado
  ADD COLUMN idioma_id character varying(60);

ALTER TABLE guarani3_tmp.ft_equivalencia
  ADD COLUMN tecno_internet_id character varying(60);

ALTER TABLE guarani3_tmp.ft_equivalencia
  ADD COLUMN tecno_pc_id character varying(60);

ALTER TABLE guarani3_tmp.ft_equivalencia
  ADD COLUMN idioma_id character varying(60);

ALTER TABLE guarani3_tmp.ft_examen
  ADD COLUMN tecno_internet_id character varying(60);

ALTER TABLE guarani3_tmp.ft_examen
  ADD COLUMN tecno_pc_id character varying(60);

ALTER TABLE guarani3_tmp.ft_examen
  ADD COLUMN idioma_id character varying(60);

CREATE TABLE guarani3_tmp.d_estado_civil
(
  estado_civil_id integer,
  estado_civil_desc character varying
);

CREATE TABLE guarani3_tmp.d_costeo_estudios
(
  costeo_estudios_id character varying,
  costeo_estudios_desc character varying
);

CREATE TABLE guarani3_tmp.d_tecno_internet
(
  tecno_internet_id character varying,
  tecno_internet_desc character varying
);
CREATE TABLE guarani3_tmp.d_tecno_pc
(
  tecno_pc_id character varying,
  tecno_pc_desc character varying
);
CREATE TABLE guarani3_tmp.d_idioma
(
  idioma_id character varying,
  idioma_desc character varying
);
--Esquema dsa

ALTER TABLE guarani3_dsa.ft_cursado
  ADD COLUMN horas_trabajadas_id integer;

ALTER TABLE guarani3_dsa.ft_equivalencia
  ADD COLUMN horas_trabajadas_id integer;

ALTER TABLE guarani3_dsa.ft_examen
  ADD COLUMN horas_trabajadas_id integer;

ALTER TABLE guarani3_dsa.ft_cursado
  ADD COLUMN estado_civil_id integer ;

ALTER TABLE guarani3_dsa.ft_equivalencia
  ADD COLUMN estado_civil_id integer ;

ALTER TABLE guarani3_dsa.ft_examen
  ADD COLUMN estado_civil_id integer ;

ALTER TABLE guarani3_dsa.ft_cursado
  ADD COLUMN localidad_periodo_lectivo_id integer ;

ALTER TABLE guarani3_dsa.ft_equivalencia
  ADD COLUMN localidad_periodo_lectivo_id integer ;

ALTER TABLE guarani3_dsa.ft_examen
  ADD COLUMN localidad_periodo_lectivo_id integer ;

ALTER TABLE guarani3_dsa.ft_cursado
  ADD COLUMN localidad_procedencia_id integer ;

ALTER TABLE guarani3_dsa.ft_equivalencia
  ADD COLUMN localidad_procedencia_id integer ;

ALTER TABLE guarani3_dsa.ft_examen
  ADD COLUMN localidad_procedencia_id integer ;

ALTER TABLE guarani3_dsa.ft_alumnos
  ADD COLUMN estado_civil_id integer ;

ALTER TABLE guarani3_dsa.ft_alumnos
  ADD COLUMN localidad_periodo_lectivo_id integer ;

ALTER TABLE guarani3_dsa.ft_alumnos
  ADD COLUMN localidad_procedencia_id integer ;

ALTER TABLE guarani3_dsa.ft_alumnos
   ADD COLUMN costeo_estudios_id integer;

ALTER TABLE guarani3_dsa.ft_alumnos
   ADD COLUMN beca character(10);

ALTER TABLE guarani3_dsa.ft_cursado
   ADD COLUMN costeo_estudios_id integer;

ALTER TABLE guarani3_dsa.ft_cursado
   ADD COLUMN beca character(10);

ALTER TABLE guarani3_dsa.ft_equivalencia
   ADD COLUMN costeo_estudios_id integer;

ALTER TABLE guarani3_dsa.ft_equivalencia
   ADD COLUMN beca character(10);

ALTER TABLE guarani3_dsa.ft_examen
   ADD COLUMN costeo_estudios_id integer;

ALTER TABLE guarani3_dsa.ft_examen
   ADD COLUMN beca character(10);

ALTER TABLE guarani3_dsa.ft_alumnos
  ADD COLUMN tecno_internet_id integer;

ALTER TABLE guarani3_dsa.ft_alumnos
  ADD COLUMN tecno_pc_id integer;

ALTER TABLE guarani3_dsa.ft_alumnos
  ADD COLUMN idioma_id integer;

ALTER TABLE guarani3_dsa.ft_cursado
  ADD COLUMN tecno_internet_id integer;

ALTER TABLE guarani3_dsa.ft_cursado
  ADD COLUMN tecno_pc_id integer;

ALTER TABLE guarani3_dsa.ft_cursado
  ADD COLUMN idioma_id integer;

ALTER TABLE guarani3_dsa.ft_equivalencia
  ADD COLUMN tecno_internet_id integer;

ALTER TABLE guarani3_dsa.ft_equivalencia
  ADD COLUMN tecno_pc_id integer;

ALTER TABLE guarani3_dsa.ft_equivalencia
  ADD COLUMN idioma_id integer;

ALTER TABLE guarani3_dsa.ft_examen
  ADD COLUMN tecno_internet_id integer;

ALTER TABLE guarani3_dsa.ft_examen
  ADD COLUMN tecno_pc_id integer;

ALTER TABLE guarani3_dsa.ft_examen
  ADD COLUMN idioma_id integer;

CREATE TABLE guarani3_dsa.d_estado_civil
(
  estado_civil_id integer NOT NULL,
  estado_civil_codigo integer,
  estado_civil_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_estado_civil_pk PRIMARY KEY (estado_civil_id)
);

CREATE TABLE guarani3_dsa.d_localidad
(
  localidad_id integer NOT NULL,
  localidad_codigo integer,
  localidad_desc character varying,
  provincia_codigo integer,
  provincia_desc character varying,
  pais_codigo integer,
  pais_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_localidad_pk PRIMARY KEY (localidad_id)
);

CREATE TABLE guarani3_dsa.d_costeo_estudios
(
  costeo_estudios_id integer NOT NULL,
  costeo_estudios_codigo integer,
  costeo_estudios_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_costeo_estudios_pk PRIMARY KEY (costeo_estudios_id)
);

CREATE TABLE guarani3_dsa.d_tecno_internet
(
  tecno_internet_id integer NOT NULL,
  tecno_internet_codigo integer,
  tecno_internet_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_tecno_internet_pk PRIMARY KEY (tecno_internet_id)
);

CREATE TABLE guarani3_dsa.d_tecno_pc
(
  tecno_pc_id integer NOT NULL,
  tecno_pc_codigo integer,
  tecno_pc_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_tecno_pc_pk PRIMARY KEY (tecno_pc_id)
);

CREATE TABLE guarani3_dsa.d_idioma
(
  idioma_id integer NOT NULL,
  idioma_codigo integer,
  idioma_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_idioma_pk PRIMARY KEY (idioma_id)
);


--Esquema guarani3
ALTER TABLE guarani3.ft_rendimiento
  ADD COLUMN horas_trabajadas_id integer ;

ALTER TABLE guarani3.ft_rendimiento
  ADD COLUMN estado_civil_id integer ;

ALTER TABLE guarani3.ft_rendimiento
  ADD COLUMN localidad_periodo_lectivo_id integer ;

ALTER TABLE guarani3.ft_rendimiento
  ADD COLUMN localidad_procedencia_id integer ;

ALTER TABLE guarani3.ft_alumnos
  ADD COLUMN estado_civil_id integer ;

ALTER TABLE guarani3.ft_alumnos
  ADD COLUMN localidad_periodo_lectivo_id integer ;

ALTER TABLE guarani3.ft_alumnos
  ADD COLUMN localidad_procedencia_id integer ;

ALTER TABLE guarani3.ft_alumnos
   ADD COLUMN costeo_estudios_id integer;

ALTER TABLE guarani3.ft_alumnos
   ADD COLUMN beca character(10);

ALTER TABLE guarani3.ft_rendimiento
   ADD COLUMN costeo_estudios_id integer;

ALTER TABLE guarani3.ft_rendimiento
   ADD COLUMN beca character(10);

ALTER TABLE guarani3.ft_alumnos
  ADD COLUMN tecno_internet_id integer;

ALTER TABLE guarani3.ft_alumnos
  ADD COLUMN tecno_pc_id integer;

ALTER TABLE guarani3.ft_alumnos
  ADD COLUMN idioma_id integer;

ALTER TABLE guarani3.ft_rendimiento
  ADD COLUMN tecno_internet_id integer;

ALTER TABLE guarani3.ft_rendimiento
  ADD COLUMN tecno_pc_id integer;

ALTER TABLE guarani3.ft_rendimiento
  ADD COLUMN idioma_id integer;

CREATE TABLE guarani3.d_estado_civil
(
  estado_civil_id integer NOT NULL,
  estado_civil_codigo integer,
  estado_civil_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_estado_civil_pk PRIMARY KEY (estado_civil_id)
);

CREATE TABLE guarani3.d_localidad
(
  localidad_id integer NOT NULL,
  localidad_codigo integer,
  localidad_desc character varying,
  provincia_codigo integer,
  provincia_desc character varying,
  pais_codigo integer,
  pais_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_localidad_pk PRIMARY KEY (localidad_id)
);

CREATE TABLE guarani3.d_costeo_estudios
(
  costeo_estudios_id integer NOT NULL,
  costeo_estudios_codigo integer,
  costeo_estudios_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_costeo_estudios_pk PRIMARY KEY (costeo_estudios_id)
);

CREATE TABLE guarani3.d_tecno_internet
(
  tecno_internet_id integer NOT NULL,
  tecno_internet_codigo integer,
  tecno_internet_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_tecno_internet_pk PRIMARY KEY (tecno_internet_id)
);

CREATE TABLE guarani3.d_tecno_pc
(
  tecno_pc_id integer NOT NULL,
  tecno_pc_codigo integer,
  tecno_pc_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_tecno_pc_pk PRIMARY KEY (tecno_pc_id)
);

CREATE TABLE guarani3.d_idioma
(
  idioma_id integer NOT NULL,
  idioma_codigo integer,
  idioma_desc character varying,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone,
  CONSTRAINT d_idioma_pk PRIMARY KEY (idioma_id)
);


---------------------------------------------------------------------------
------ NUEVOS CUADROS ARAUCANO
---------------------------------------------------------------------------

--Esquema tmp

ALTER TABLE araucano_tmp.ft_totaldetalless_max
  ADD COLUMN idprocedencia character varying;

CREATE TABLE araucano_tmp.d_actividades
(
  idactividad character varying,
  nombre_actividad character varying
);

CREATE TABLE araucano_tmp.d_procedencias
(
  idProcedencia character varying,
  Nombre_Procedencia character varying
);


CREATE TABLE araucano_tmp.ft_totaldetallef_niinst
(
  idfacultad character varying,
  idtitulo character varying,
  anioinformado character varying,
  idtipotitulo character varying,
  genero character varying,
  parentesco character varying,
  idserie_c15 character varying,
  idsubserie_c15 character varying,
  idsubserieopcion_c15 character varying,
  cantidad_c15 character varying
);


CREATE TABLE araucano_tmp.ft_totaldetalles_nipc
(
  idfacultad character varying,
  idtitulo character varying,
  anioinformado character varying,
  idtipotitulo character varying,
  genero character varying,
  idserie_c19 character varying,
  idsubserie_c19 character varying,
  idsubserieopcion_c19 character varying,
  cantidad_c19 character varying
);
  

CREATE TABLE araucano_tmp.ft_totaldetalles_nipm
(
  idfacultad character varying,
  idtitulo character varying,
  anioinformado character varying,
  idtipotitulo character varying,
  genero character varying,
  idserie_c18 character varying,
  idsubserie_c18 character varying,
  idsubserieopcion_c18 character varying,
  cantidad_c18 character varying
);


CREATE TABLE araucano_tmp.ft_totaldetalles_nitra
(
  idfacultad character varying,
  idtitulo character varying,
  anioinformado character varying,
  idtipotitulo character varying,
  genero character varying,
  idserie_c14 character varying,
  idsubserie_c14 character varying,
  idsubserieopcion_c14 character varying,
  cantidad_c14 character varying
);


CREATE TABLE araucano_tmp.ft_totaldetalles_pc
(
  idfacultad character varying,
  idtitulo character varying,
  anioinformado character varying,
  idtipotitulo character varying,
  genero character varying,
  idserie_c17 character varying,
  idsubserie_c17 character varying,
  idsubserieopcion_c17 character varying,
  cantidad_c17 character varying
);


CREATE TABLE araucano_tmp.ft_totaldetalles_pm
(
  idfacultad character varying,
  idtitulo character varying,
  anioinformado character varying,
  idtipotitulo character varying,
  genero character varying,
  idserie_c16 character varying,
  idsubserie_c16 character varying,
  idsubserieopcion_c16 character varying,
  cantidad_c16 character varying
);


CREATE TABLE araucano_tmp.ft_totaldetalless_act_max
(
  idfacultad character varying,
  idactividad character varying,
  anioinformado character varying,
  genero character varying,
  idserie_edad character varying,
  idsubserie_edad character varying,
  idprocedencia character varying,
  idpais character varying,
  cantidad_c13 character varying
);

--Esquema dsa

ALTER TABLE araucano_dsa.academica_ft_cuadro12
  ADD COLUMN idprocedencia smallint;

CREATE TABLE araucano_dsa.academica_d_actividades 
(
  idactividad serial NOT NULL,
  idactividad_ona integer NOT NULL,
  nombre_actividad character varying(255),
  fechaact timestamp without time zone,
  CONSTRAINT academica_dsa_d_actividades_pkey PRIMARY KEY (idactividad)
);

CREATE TABLE araucano_dsa.academica_d_parentesco
(
  idparentesco serial NOT NULL,
  parentesco character(2) NOT NULL,
  parentescodescripcion character varying(50),
  fechaact timestamp without time zone,
  CONSTRAINT academica_dsa_d_parentesco_pkey PRIMARY KEY (idparentesco)
);

CREATE TABLE araucano_dsa.academica_d_procedencias
(
  idprocedencia serial NOT NULL,
  idprocedencia_ona integer NOT NULL,
  nombre_procedencia character varying(255),
  fechaact timestamp without time zone,
  CONSTRAINT academica_dsa_d_procedencias_pkey PRIMARY KEY (idprocedencia)
);

CREATE TABLE araucano_dsa.academica_ft_cuadro13
(
  idcuadro13 serial NOT NULL,
  idanioinformado smallint NOT NULL,
  idfacultad smallint NOT NULL,
  idactividad smallint NOT NULL,
  idgenero smallint NOT NULL,
  idpais smallint NOT NULL,
  idprocedencia smallint NOT NULL,
  idserie smallint NOT NULL,
  cantidad double precision,
  fechacarga timestamp without time zone NOT NULL,
  CONSTRAINT academica_dsa_ft_cuadro13_pkey PRIMARY KEY (idcuadro13)
);


CREATE TABLE araucano_dsa.academica_ft_cuadro14
(
  idcuadro14 serial NOT NULL,
  idanioinformado smallint NOT NULL,
  idfacultad smallint NOT NULL,
  idtipotitulo smallint NOT NULL,
  idrda smallint NOT NULL,
  idtitulo smallint NOT NULL,
  idgenero smallint NOT NULL,
  idsubserieopcion smallint NOT NULL,
  cantidad double precision,
  fechacarga timestamp without time zone NOT NULL,
  CONSTRAINT academica_dsa_ft_cuadro14_pkey PRIMARY KEY (idcuadro14)
);

CREATE TABLE araucano_dsa.academica_ft_cuadro15
(
  idcuadro15 serial NOT NULL,
  idanioinformado smallint NOT NULL,
  idfacultad smallint NOT NULL,
  idtipotitulo smallint NOT NULL,
  idrda smallint NOT NULL,
  idtitulo smallint NOT NULL,
  idgenero smallint NOT NULL,
  idparentesco smallint NOT NULL,
  idsubserieopcion smallint NOT NULL,
  cantidad double precision,
  fechacarga timestamp without time zone NOT NULL,
  CONSTRAINT academica_dsa_ft_cuadro15_pkey PRIMARY KEY (idcuadro15)
);

  
CREATE TABLE araucano_dsa.academica_ft_cuadro16
(
  idcuadro16 serial NOT NULL,
  idanioinformado smallint NOT NULL,
  idfacultad smallint NOT NULL,
  idtipotitulo smallint NOT NULL,
  idrda smallint NOT NULL,
  idtitulo smallint NOT NULL,
  idgenero smallint NOT NULL,
  idsubserieopcion smallint NOT NULL,
  cantidad double precision,
  fechacarga timestamp without time zone NOT NULL,
  CONSTRAINT academica_dsa_ft_cuadro16_pkey PRIMARY KEY (idcuadro16)
);

CREATE TABLE araucano_dsa.academica_ft_cuadro17
(
  idcuadro17 serial NOT NULL,
  idanioinformado smallint NOT NULL,
  idfacultad smallint NOT NULL,
  idtipotitulo smallint NOT NULL,
  idrda smallint NOT NULL,
  idtitulo smallint NOT NULL,
  idgenero smallint NOT NULL,
  idsubserieopcion smallint NOT NULL,
  cantidad double precision,
  fechacarga timestamp without time zone NOT NULL,
  CONSTRAINT academica_dsa_ft_cuadro17_pkey PRIMARY KEY (idcuadro17)
);

CREATE TABLE araucano_dsa.academica_ft_cuadro18
(
  idcuadro18 serial NOT NULL,
  idanioinformado smallint NOT NULL,
  idfacultad smallint NOT NULL,
  idtipotitulo smallint NOT NULL,
  idrda smallint NOT NULL,
  idtitulo smallint NOT NULL,
  idgenero smallint NOT NULL,
  idsubserieopcion smallint NOT NULL,
  cantidad double precision,
  fechacarga timestamp without time zone NOT NULL,
  CONSTRAINT academica_dsa_ft_cuadro18_pkey PRIMARY KEY (idcuadro18)
);

CREATE TABLE araucano_dsa.academica_ft_cuadro19
(
  idcuadro19 serial NOT NULL,
  idanioinformado smallint NOT NULL,
  idfacultad smallint NOT NULL,
  idtipotitulo smallint NOT NULL,
  idrda smallint NOT NULL,
  idtitulo smallint NOT NULL,
  idgenero smallint NOT NULL,
  idsubserieopcion smallint NOT NULL,
  cantidad double precision,
  fechacarga timestamp without time zone NOT NULL,
  CONSTRAINT academica_dsa_ft_cuadro19_pkey PRIMARY KEY (idcuadro19)
);

-- dw

ALTER TABLE araucano.academica_ft_cuadro12
  ADD COLUMN idprocedencia smallint;

CREATE TABLE araucano.academica_d_actividades 
(
  idactividad serial NOT NULL,
  idactividad_ona integer NOT NULL,
  nombre_actividad character varying(255),
  fechaact timestamp without time zone,
  CONSTRAINT academica_d_actividades_pkey PRIMARY KEY (idactividad)
);

CREATE TABLE araucano.academica_d_parentesco
(
  idparentesco serial NOT NULL,
  parentesco character(2) NOT NULL,
  parentescodescripcion character varying(50),
  fechaact timestamp without time zone,
  CONSTRAINT academica_d_parentesco_pkey PRIMARY KEY (idparentesco)
);

CREATE TABLE araucano.academica_d_procedencias
(
  idprocedencia serial NOT NULL,
  idprocedencia_ona integer NOT NULL,
  nombre_procedencia character varying(255),
  fechaact timestamp without time zone,
  CONSTRAINT academica_d_procedencias_pkey PRIMARY KEY (idprocedencia)
);

CREATE TABLE araucano.academica_ft_cuadro13
(
  idcuadro13 serial NOT NULL,
  idanioinformado smallint NOT NULL,
  idfacultad smallint NOT NULL,
  idactividad smallint NOT NULL,
  idgenero smallint NOT NULL,
  idpais smallint NOT NULL,
  idprocedencia smallint NOT NULL,
  idserie smallint NOT NULL,
  cantidad double precision,
  unidad_generica_id integer DEFAULT 0,
  importacion_id integer,
  CONSTRAINT academica_ft_cuadro13_pkey PRIMARY KEY (idcuadro13)
);


CREATE TABLE araucano.academica_ft_cuadro14
(
  idcuadro14 serial NOT NULL,
  idanioinformado smallint NOT NULL,
  idfacultad smallint NOT NULL,
  idtipotitulo smallint NOT NULL,
  idrda smallint NOT NULL,
  idtitulo smallint NOT NULL,
  idgenero smallint NOT NULL,
  idsubserieopcion smallint NOT NULL,
  cantidad double precision,
  unidad_generica_id integer DEFAULT 0,
  importacion_id integer,
  CONSTRAINT academica_ft_cuadro14_pkey PRIMARY KEY (idcuadro14)
);

CREATE TABLE araucano.academica_ft_cuadro15
(
  idcuadro15 serial NOT NULL,
  idanioinformado smallint NOT NULL,
  idfacultad smallint NOT NULL,
  idtipotitulo smallint NOT NULL,
  idrda smallint NOT NULL,
  idtitulo smallint NOT NULL,
  idgenero smallint NOT NULL,
  idparentesco smallint NOT NULL,
  idsubserieopcion smallint NOT NULL,
  cantidad double precision,
  unidad_generica_id integer DEFAULT 0,
  importacion_id integer,
  CONSTRAINT academica_ft_cuadro15_pkey PRIMARY KEY (idcuadro15)
);

  
CREATE TABLE araucano.academica_ft_cuadro16
(
  idcuadro16 serial NOT NULL,
  idanioinformado smallint NOT NULL,
  idfacultad smallint NOT NULL,
  idtipotitulo smallint NOT NULL,
  idrda smallint NOT NULL,
  idtitulo smallint NOT NULL,
  idgenero smallint NOT NULL,
  idsubserieopcion smallint NOT NULL,
  cantidad double precision,
  unidad_generica_id integer DEFAULT 0,
  importacion_id integer,
  CONSTRAINT academica_ft_cuadro16_pkey PRIMARY KEY (idcuadro16)
);

CREATE TABLE araucano.academica_ft_cuadro17
(
  idcuadro17 serial NOT NULL,
  idanioinformado smallint NOT NULL,
  idfacultad smallint NOT NULL,
  idtipotitulo smallint NOT NULL,
  idrda smallint NOT NULL,
  idtitulo smallint NOT NULL,
  idgenero smallint NOT NULL,
  idsubserieopcion smallint NOT NULL,
  cantidad double precision,
  unidad_generica_id integer DEFAULT 0,
  importacion_id integer,
  CONSTRAINT academica_ft_cuadro17_pkey PRIMARY KEY (idcuadro17)
);

CREATE TABLE araucano.academica_ft_cuadro18
(
  idcuadro18 serial NOT NULL,
  idanioinformado smallint NOT NULL,
  idfacultad smallint NOT NULL,
  idtipotitulo smallint NOT NULL,
  idrda smallint NOT NULL,
  idtitulo smallint NOT NULL,
  idgenero smallint NOT NULL,
  idsubserieopcion smallint NOT NULL,
  cantidad double precision,
  unidad_generica_id integer DEFAULT 0,
  importacion_id integer,
  CONSTRAINT academica_ft_cuadro18_pkey PRIMARY KEY (idcuadro18)
);

CREATE TABLE araucano.academica_ft_cuadro19
(
  idcuadro19 serial NOT NULL,
  idanioinformado smallint NOT NULL,
  idfacultad smallint NOT NULL,
  idtipotitulo smallint NOT NULL,
  idrda smallint NOT NULL,
  idtitulo smallint NOT NULL,
  idgenero smallint NOT NULL,
  idsubserieopcion smallint NOT NULL,
  cantidad double precision,
  unidad_generica_id integer DEFAULT 0,
  importacion_id integer,
  CONSTRAINT academica_ft_cuadro19_pkey PRIMARY KEY (idcuadro19)
);


----------------------------- 
--     Mapuche
----------------------------- 
--Creacion de indices

CREATE INDEX idx_ft_liq_concepto
  ON mapuche.map_dw_ft_liqconceptosxcargos
  USING btree
  (concepto_id);

CREATE INDEX idx_ft_liq_personacargo_periodo
  ON mapuche.map_dw_ft_liqconceptosxcargos
  USING btree
  (personacargo_id, periodoinfo);

CREATE INDEX idx_ft_liq_liquidacion
  ON mapuche.map_dw_ft_liqconceptosxcargos
  USING btree
  (liquidacion_id);

CREATE INDEX idx_ft_cargos_personacargo_periodo
  ON mapuche.map_dw_ft_lt_cargos
  USING btree
  (personacargo_id, periodoinfo);

CREATE INDEX idx_ft_cargos_categoria_escalafon
  ON mapuche.map_dw_ft_lt_cargos
  USING btree
  (categoria_id);

CREATE INDEX idx_ft_cargos_caract_desig
  ON mapuche.map_dw_ft_lt_cargos
  USING btree
  (plantacarac_id);

CREATE INDEX idx_ft_cargos_dedicacion
  ON mapuche.map_dw_ft_lt_cargos
  USING btree
  (hsdedicacion_id);

CREATE INDEX idx_ft_legajos_personacargo_periodo
  ON mapuche.map_dw_ft_lt_legajos
  USING btree
  (periodoinfo, persona_id);

VACUUM FULL ANALYSE mapuche.map_dw_ft_lt_legajos;
VACUUM FULL ANALYSE mapuche.map_dw_ft_liqconceptosxcargos;
VACUUM FULL ANALYSE mapuche.map_dw_ft_lt_cargos;


