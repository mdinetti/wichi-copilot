-- Este script es parte de la migración de SIU-Wichi 6.2.0 a 6.3.0.

----------------------------- 
--     Public  
----------------------------- 
-- Agrega diez registros a la tabla de años 

INSERT INTO d_anio(anio_id) VALUES (1970);
INSERT INTO d_anio(anio_id) VALUES (1971);
INSERT INTO d_anio(anio_id) VALUES (1972);
INSERT INTO d_anio(anio_id) VALUES (1973);
INSERT INTO d_anio(anio_id) VALUES (1974);
INSERT INTO d_anio(anio_id) VALUES (1975);
INSERT INTO d_anio(anio_id) VALUES (1976);
INSERT INTO d_anio(anio_id) VALUES (1977);
INSERT INTO d_anio(anio_id) VALUES (1978);
INSERT INTO d_anio(anio_id) VALUES (1979);

----------------------------- 
--     Pilaga  
----------------------------- 
-- Cambia el tipo de la columna estado a text, falto en migracion 5.4.0 a 5.5.0 
ALTER TABLE pilaga_tmp.d_persona ALTER COLUMN estado TYPE text; 

----------------------------- 
--     Diaguita  
----------------------------- 
--Agrega el expediente de baja del bien patrimonial
ALTER TABLE diaguita_tmp.ft_patrimonio ADD COLUMN expediente_baja text;
ALTER TABLE diaguita_dsa.ft_patrimonio ADD COLUMN expediente_baja_id integer;
ALTER TABLE diaguita.ft_patrimonio ADD COLUMN expediente_baja_id integer;  

-----------------------------
--     Guarani 3 
-----------------------------

--Crea el esquema temporal de guarani3

CREATE SCHEMA guarani3_tmp;

SET search_path = guarani3_tmp, pg_catalog;
CREATE TABLE d_actividad (
    estado_actividad_desc character varying,
    tipo_actividad_desc character varying,
    actividad_id character varying,
    actividad_desc character varying
);


CREATE TABLE d_alcance_equivalencia (
    alcance_equivalencia_id character varying NOT NULL,
    alcance_equivalencia_desc character varying
);


CREATE TABLE d_alumno (
    alumno_id integer NOT NULL,
    legajo_id character varying,
    persona_id integer
);


CREATE TABLE d_calidad_alumno (
    calidad_alumno_id character varying NOT NULL,
    calidad_alumno_desc character varying
);


CREATE TABLE d_catedra (
    catedra_id character varying NOT NULL,
    catedra_desc character varying
);


CREATE TABLE d_colegio (
    colegio_id integer,
    colegio_desc character varying,
    ambito_desc character varying,
    sector_desc character varying,
    localidad_id integer
);


CREATE TABLE d_comision (
    comision_id character varying NOT NULL,
    comision_desc character varying
);

CREATE TABLE d_comision_docentes
(
  comision_id character varying NOT NULL,
  responsabilidad_docentes_codigo character varying,
  responsabilidad_docentes_desc character varying
);

CREATE TABLE d_concepto (
    concepto_id character varying NOT NULL,
    concepto_desc character varying
);


CREATE TABLE d_condicion_examen (
    condicion_examen_id character varying NOT NULL,
    condicion_examen_desc character varying
);


CREATE TABLE d_condicion_regularidad (
    condicion_regularidad_id character varying NOT NULL,
    condicion_regularidad_desc character varying
);


CREATE TABLE d_estado_acta (
    estado_acta_id character varying NOT NULL,
    estado_acta_desc character varying
);


CREATE TABLE d_estado_tramite (
    estado_tramite_id character varying NOT NULL,
    estado_tramite_desc character varying
);


CREATE TABLE d_estudio_padres (
    estudio_padres_id integer NOT NULL,
    estudio_padres_desc character varying
);


CREATE TABLE d_horas_trabajadas (
    horas_trabajadas_id character varying NOT NULL,
    horas_trabajadas_desc character varying
);


CREATE TABLE d_localidad (
    localidad_id integer,
    localidad_desc character varying,
    provincia_id integer
);


CREATE TABLE d_actividad_comun (
    actividad_comun_id character varying,
    actividad_comun_desc character varying
);

CREATE TABLE d_mesa_docentes
(
  mesa_id character varying NOT NULL,
  tribunal_docentes_codigo character varying,
  tribunal_docentes_desc character varying
);

CREATE TABLE d_nacionalidad (
    nacionalidad_id integer NOT NULL,
    nacionalidad_desc character varying
);


CREATE TABLE d_origen_equivalencia (
    origen_equivalencia_id character varying,
    origen_equivalencia_desc character varying
);


CREATE TABLE d_pais (
    pais_id integer,
    pais_desc character varying
);


CREATE TABLE d_persona (
    persona_id integer,
    apellido_nombres character varying,
    fecha_nacimiento date,
    tipo_nro_documento character varying
);


CREATE TABLE d_plan_version (
    plan_version_id character varying,
    plan_version_desc character varying,
    plan_version_estado character varying,
    plan character varying,
    plan_version character varying
);


CREATE TABLE d_propuesta_formativa (
    tipo_propuesta_formativa_id character varying,
    tipo_propuesta_formativa_desc character varying,
    propuesta_formativa_id character varying,
    propuesta_formativa_desc character varying,
    responsables_academicas_codigo character varying
);


CREATE TABLE d_provincia (
    provincia_id integer,
    provincia_desc character varying,
    pais_id integer
);


CREATE TABLE d_rama_disciplinar (
    rama_disciplinar_id integer,
    rama_id integer,
    rama_desc character varying,
    disciplina_id character varying,
    disciplina_desc character varying,
    area_id integer,
    area_desc character varying
);


CREATE TABLE d_responsable_academica (
    propuesta character varying,
    tipo_reponsable_academica_desc character varying,
    responsable_academica_id character varying,
    responsable_academica_desc character varying
);


CREATE TABLE d_resultado (
    resultado_id character varying NOT NULL,
    resultado_desc character varying
);


CREATE TABLE d_resultado_aspirante (
    resultado_aspirante_id character varying NOT NULL,
    resultado_aspirante_desc character varying
);


CREATE TABLE d_sexo (
    sexo_id integer,
    sexo_desc character varying
);


CREATE TABLE d_situacion_aspirante (
    situacion_aspirante_id integer NOT NULL,
    situacion_aspirante_desc character varying,
    resultado_aspirante_id character varying
);


CREATE TABLE d_situacion_laboral_padres (
    situacion_laboral_padres_id integer NOT NULL,
    situacion_laboral_padres_desc character varying
);


CREATE TABLE d_tipo_ingreso (
    tipo_ingreso_id character varying NOT NULL,
    tipo_ingreso_desc character varying
);


CREATE TABLE d_tipo_ingreso_aspirante (
    tipo_ingreso_aspirante_id integer NOT NULL,
    tipo_ingreso_aspirante_desc character varying
);


CREATE TABLE d_tipo_periodo (
    tipo_periodo_id character varying NOT NULL,
    tipo_periodo_desc character varying
);


CREATE TABLE d_titulo_araucano (
    titulo_araucano_id character varying NOT NULL,
    titulo_araucano_desc character varying
);


CREATE TABLE d_ubicacion (
    tipo_ubicacion_id character varying,
    tipo_ubicacion_desc character varying,
    ubicacion_id character varying,
    ubicacion_desc character varying
);


CREATE TABLE ft_alumnos (
    anio_academico integer NOT NULL,
    plan_version_id character varying,
    propuesta_formativa_id character varying,
    ubicacion_id character varying,
    titulo_araucano_id character varying,
    sexo_id integer,
    anio_ingreso_propuesta integer,
    colegio_secundario_id integer,
    actividades_rendidas_anio_anterior_id integer,
    actividades_aprobadas_anio_anterior_id integer,
    total_actividades_rendidas_id integer,
    total_actividades_aprobadas_id integer,
    horas_trabajadas_id character varying,
    tipo_ingreso_id character varying,
    edad integer,
    alumno_id integer,
    nacionalidad_id integer,
    calidad_alumno_id character varying,
    rama_disciplinar_id integer,
    max_trabajo_padres integer,
    max_estudio_padres integer,
    persona_id integer,
    nuevosinscriptos integer,
    reinscriptos integer,
    egresados integer
);


CREATE TABLE ft_cursado (
    ubicacion_id character varying,
    anio_academico character varying,
    tipo_periodo_id character varying,
    periodo_lectivo_desc character varying,
    orden_periodo_en_anio character varying,
    alumno_id character varying,
    edad_id integer,
    sexo_id character varying,
    nacionalidad_id character varying,
    colegio_secundario_id integer,
    propuesta_formativa_id character varying,
    plan_version_id character varying,
    actividad_id character varying,
    catedra_id character varying,
    comision_id character varying,
    condicion_regularidad_id character varying,
    resultado_id character varying,
    nota character varying,
    concepto character varying,
    porcentaje_asistencia character varying,
    tipo_actividad_id character varying,
    acta character varying,
    estado_acta_id character varying,
    total_intentos_cursada character varying,
    nro_intento_cursada character varying,
    cantidad_registros_cursada character varying,
    anio_ingreso_institucion character varying,
    anio_ingreso_pf character varying,
    periodo_inscripcion_pf_desc character varying,
    persona_id integer
);


CREATE TABLE ft_equivalencia (
    ubicacion_id character varying,
    anio_academico character varying,
    fecha_equivalencia character varying,
    alumno_id character varying,
    edad_id integer,
    sexo_id character varying,
    nacionalidad_id character varying,
    colegio_secundario_id integer,
    propuesta_formativa_id character varying,
    plan_version_id character varying,
    actividad_id character varying,
    alcance_equivalencia_id character varying,
    resultado_id character varying,
    nota character varying,
    concepto character varying,
    origen_equivalencia_id character varying,
    equivalencia_guarani_id character varying,
    tipo_actividad_id character varying,
    estado_tramite_id character varying,
    condicion_alumno_id character varying,
    cantidad_registros_examen character varying,
    anio_ingreso_institucion character varying,
    anio_ingreso_pf character varying,
    periodo_inscripcion_pf_desc character varying,
    tramite character varying,
    persona_id integer
);


CREATE TABLE ft_examen (
    ubicacion_id character varying,
    anio_academico character varying,
    tipo_periodo_id character varying,
    turno_examen_desc character varying,
    mesa_examen_desc character varying,
    fecha_examen character varying,
    mesa_id character varying,
    alumno_id character varying,
    edad_id integer,
    sexo_id character varying,
    nacionalidad_id character varying,
    colegio_secundario_id integer,
    propuesta_formativa_id character varying,
    plan_version_id character varying,
    actividad_id character varying,
    catedra_id character varying,
    resultado_id character varying,
    nota character varying,
    concepto character varying,
    acta character varying,
    estado_acta_id character varying,
    condicion_alumno_id character varying,
    total_intentos_rendir character varying,
    nro_intento_rendir character varying,
    cantidad_registros_examen character varying,
    anio_ingreso_institucion character varying,
    anio_ingreso_pf character varying,
    periodo_inscripcion_pf_desc character varying,
    tipo_actividad_id character varying,
    persona_id integer
);


CREATE TABLE ft_procedencia_aspirantes (
    ubicacion_id character varying,
    periodo_inscripcion_id character varying,
    propuesta_formativa_id character varying,
    plan_version_id character varying,
    tipo_ingreso_aspirante_id integer,
    colegio_id integer,
    situacion_aspirante_id integer,
    sexo_id integer,
    persona_id integer,
    edad_id integer,
    estudio_padres_id integer,
    situacion_padres_id integer,
    nacionalidad_id integer,
    cantidad integer,
    anio_academico integer
);

--Crea el esquema dsa de guarani3

CREATE SCHEMA guarani3_dsa;
SET search_path = guarani3_dsa, pg_catalog;

CREATE TABLE d_acta (
    acta_id integer NOT NULL,
  acta_codigo character varying,
  acta_desc character varying,
  estado_acta_id character varying,
  estado_acta_desc character varying,
  instalacion_id integer,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_actividad (
    actividad_id integer NOT NULL,
    actividad_codigo character varying,
    tipo_actividad_desc character varying,
    actividad_desc character varying,
    estado_actividad_desc character varying,
    instalacion_id integer,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_actividad_rango (
    actividad_rango_id integer NOT NULL,
    cantidad_actividades integer,
    rango_aprob_anio_ant_desc character varying,
    rango_aprob_total_desc character varying,
    rango_rend_anio_ant_desc character varying,
    rango_rend_total_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_alcance_equivalencia (
    alcance_equivalencia_id integer NOT NULL,
    alcance_equivalencia_codigo character varying,
    alcance_equivalencia_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_alumno (
    alumno_id integer NOT NULL,
    alumno_codigo integer,
    alumno_codigo_legajo character varying,
    instalacion_id integer,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_calidad_alumno (
    calidad_alumno_id integer NOT NULL,
    calidad_alumno_codigo character varying,
    calidad_alumno_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_catedra (
    catedra_id integer NOT NULL,
    catedra_codigo character varying,
    catedra_desc character varying,
    instalacion_id integer,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_comision (
    comision_id integer NOT NULL,
    comision_desc character varying,
    comision_codigo character varying,
    instalacion_id integer,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_concepto (
    concepto_id integer NOT NULL,
    concepto_codigo character varying,
    concepto_desc character varying,
    instalacion_id integer,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_condicion (
    condicion_id integer NOT NULL,
    condicion_codigo character varying,
    condicion_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_docente (
    docente_id integer NOT NULL,
    docente_codigo character varying,
    docente_desc character varying,
    instalacion_id integer,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_edad (
    edad_id integer NOT NULL,
    edad integer,
    rango_edad_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_estudio_padres (
    estudio_padres_id integer NOT NULL,
    estudio_padres_codigo integer,
    estudio_padres_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_horas_trabajadas (
    horas_trabajadas_id integer NOT NULL,
    horas_trabajadas_codigo character varying,
    horas_trabajadas_desc character varying,
    horas_trabajadas_grupo_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_intento (
    intento_id integer NOT NULL,
    nro_intento_id character varying,
    total_intento_id integer,
    primera_vez character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_actividad_comun (
    actividad_comun_id integer NOT NULL,
    actividad_comun_codigo character varying,
    actividad_comun_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_nacionalidad (
    nacionalidad_id integer NOT NULL,
    nacionalidad_codigo integer,
    nacionalidad_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_nota (
    nota_id integer NOT NULL,
    nota_codigo character varying,
    nota_desc character varying,
    resultado_id integer,
    instalacion_id integer,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_origen_equivalencia (
    origen_equivalencia_id integer NOT NULL,
    origen_equivalencia_codigo character varying,
    origen_equivalencia_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_periodo_anio_academico (
    periodo_id integer NOT NULL,
    periodo_desc character varying,
    periodo_orden_anio character varying,
    tipo_periodo_id integer,
    anio_academico character varying,
    instalacion_id integer,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_periodo_inscripcion (
    periodo_inscripcion_id integer NOT NULL,
    periodo_inscripcion_codigo character varying,
    periodo_inscripcion_desc character varying,
    anio_academico character varying,
    instalacion_id integer,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_persona (
    persona_id integer NOT NULL,
    persona_codigo integer,
    persona_desc character varying,
    instalacion_id integer,
    fecha_nacimiento date,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_plan_version (
    plan_version_id integer NOT NULL,
    plan_version_codigo character varying,
    plan_version_desc character varying,
    plan_version_estado character varying,
    plan character varying,
    plan_version character varying,
    instalacion_id integer,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_procedencia (
    procedencia_id integer NOT NULL,
    colegio_id integer,
    colegio_desc character varying,
    ambito_desc character varying,
    sector_desc character varying,
    localidad_id integer,
    localidad_desc character varying,
    provincia_id integer,
    provincia_desc character varying,
    pais_id integer,
    pais_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_propuesta_formativa (
    propuesta_formativa_id integer NOT NULL,
    propuesta_formativa_codigo character varying,
    tipo_propuesta_formativa_desc character varying,
    propuesta_formativa_desc character varying,
    instalacion_id integer,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_rama_disciplinar (
    rama_disciplinar_id integer NOT NULL,
    rama_disciplinar_codigo integer,
    rama_id integer,
    rama_desc character varying,
    disciplina_id character varying,
    disciplina_desc character varying,
    area_id integer,
    area_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_responsable_academica (
    responsable_academica_id integer NOT NULL,
    responsable_academica_codigo character varying,
    tipo_responsable_academica_desc character varying,
    responsable_academica_desc character varying,
    instalacion_id integer,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_resultado (
    resultado_id integer NOT NULL,
    resultado_codigo character varying,
    resultado_desc character varying,
    concepto_id integer,
    instalacion_id integer,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_sexo (
    sexo_id integer NOT NULL,
    sexo_codigo integer,
    sexo_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_situacion_aspirante (
    situacion_aspirante_id integer NOT NULL,
    situacion_aspirante_codigo integer,
    situacion_aspirante_desc character varying,
    resultado_aspirante_codigo character varying,
    resultado_aspirante_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_situacion_laboral_padres (
    situacion_laboral_padres_id integer NOT NULL,
    situacion_laboral_padres_codigo integer,
    situacion_laboral_padres_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_tipo_ingreso (
    tipo_ingreso_id integer NOT NULL,
    tipo_ingreso_codigo character varying,
    tipo_ingreso_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_tipo_ingreso_aspirante (
    tipo_ingreso_aspirante_id integer NOT NULL,
    tipo_ingreso_aspirante_codigo integer,
    tipo_ingreso_aspirante_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_tipo_periodo (
    tipo_periodo_id integer NOT NULL,
    tipo_periodo_codigo character varying,
    tipo_periodo_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_titulo_araucano (
    titulo_araucano_id integer NOT NULL,
    titulo_araucano_codigo character varying,
    titulo_araucano_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_total_intento (
    total_intento_id integer NOT NULL,
    total_intento_codigo character varying,
    total_intento_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_tramite (
   tramite_id integer NOT NULL,
  tramite_codigo character varying,
  tramite_desc character varying,
  estado_tramite_id character varying,
  estado_tramite_desc character varying,
  instalacion_id integer,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_ubicacion (
    ubicacion_id integer NOT NULL,
    ubicacion_codigo character varying,
    tipo_ubicacion_desc character varying,
    ubicacion_desc character varying,
    instalacion_id integer,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE ft_alumnos (
    instalacion_id integer,
    anio_academico integer NOT NULL,
    plan_version_id integer NOT NULL,
    responsable_academica_id integer NOT NULL,
    propuesta_formativa_id integer NOT NULL,
    ubicacion_id integer NOT NULL,
    titulo_araucano_id integer NOT NULL,
    sexo_id integer NOT NULL,
    anio_ingreso_propuesta integer NOT NULL,
    procedencia_id integer NOT NULL,
    actividades_rendidas_anio_anterior_id integer NOT NULL,
    actividades_aprobadas_anio_anterior_id integer NOT NULL,
    total_actividades_rendidas_id integer NOT NULL,
    total_actividades_aprobadas_id integer NOT NULL,
    horas_trabajadas_id integer NOT NULL,
    tipo_ingreso_id integer NOT NULL,
    edad_id integer NOT NULL,
    alumno_id integer NOT NULL,
    nacionalidad_id integer NOT NULL,
    calidad_alumno_id integer NOT NULL,
    rama_disciplinar_id integer DEFAULT (-1) NOT NULL,
    estudio_padres_id integer,
    situacion_laboral_padres_id integer,
    persona_id integer,
    nuevos_inscriptos integer,
    reinscriptos integer,
    egresados integer,
    total_alumnos integer
);


CREATE TABLE ft_cursado (
    instalacion_id integer,
    responsable_academica_id integer NOT NULL,
    ubicacion_id integer NOT NULL,
    anio_academico integer NOT NULL,
    tipo_periodo_id integer NOT NULL,
    periodo_lectivo_id integer NOT NULL,
    orden_periodo_en_anio integer NOT NULL,
    alumno_id integer NOT NULL,
    edad_id integer NOT NULL,
    sexo_id integer NOT NULL,
    nacionalidad_id integer NOT NULL,
    procedencia_id integer NOT NULL,
    docente_id integer NOT NULL,
    propuesta_formativa_id integer NOT NULL,
    plan_version_id integer NOT NULL,
    actividad_id integer NOT NULL,
    catedra_id integer NOT NULL,
    comision_id integer NOT NULL,
    condicion_regularidad_id integer NOT NULL,
    nota_id integer NOT NULL,
    porcentaje_asistencia numeric(5,2) NOT NULL,
    tipo_actividad_id integer NOT NULL,
    acta_id integer NOT NULL,
    total_intentos_cursada integer NOT NULL,
    nro_intento_cursada integer NOT NULL,
    cantidad_registros_cursada integer NOT NULL,
    anio_ingreso_institucion integer NOT NULL,
    periodo_inscripcion_pf_id integer,
    persona_id integer
);


CREATE TABLE ft_equivalencia (
    instalacion_id integer,
    responsable_academica_id integer NOT NULL,
    ubicacion_id integer NOT NULL,
    anio_academico integer NOT NULL,
    fecha_equivalencia date NOT NULL,
    alumno_id integer NOT NULL,
    edad_id integer NOT NULL,
    sexo_id integer NOT NULL,
    nacionalidad_id integer NOT NULL,
    procedencia_id integer NOT NULL,
    propuesta_formativa_id integer NOT NULL,
    plan_version_id integer NOT NULL,
    actividad_id integer NOT NULL,
    alcance_equivalencia_id integer NOT NULL,
    nota_id integer NOT NULL,
    origen_equivalencia_id integer NOT NULL,
    equivalencia_guarani_id character varying NOT NULL,
    tipo_actividad_id integer NOT NULL,
    tramite_id integer NOT NULL,
    condicion_alumno_id integer NOT NULL,
    cantidad_registros_examen integer NOT NULL,
    anio_ingreso_institucion integer NOT NULL,
    periodo_inscripcion_pf_id integer,
    persona_id integer
);


CREATE TABLE ft_examen (
    instalacion_id integer,
    responsable_academica_id integer NOT NULL,
    ubicacion_id integer NOT NULL,
    anio_academico integer NOT NULL,
    tipo_periodo_id integer NOT NULL,
    turno_examen_id integer NOT NULL,
    mesa_examen_desc character varying NOT NULL,
    fecha_examen date NOT NULL,
    alumno_id integer NOT NULL,
    edad_id integer NOT NULL,
    sexo_id integer NOT NULL,
    nacionalidad_id integer NOT NULL,
    procedencia_id integer NOT NULL,
    docente_id integer NOT NULL,
    propuesta_formativa_id integer NOT NULL,
    plan_version_id integer NOT NULL,
    actividad_id integer NOT NULL,
    catedra_id integer NOT NULL,
    nota_id integer NOT NULL,
    tipo_actividad_id integer NOT NULL,
    acta_id integer NOT NULL,
    condicion_alumno_id integer NOT NULL,
    total_intentos_rendir integer NOT NULL,
    nro_intento_rendir integer NOT NULL,
    cantidad_registros_examen integer NOT NULL,
    anio_ingreso_institucion integer NOT NULL,
    periodo_inscripcion_pf_id integer,
    persona_id integer
);


CREATE TABLE ft_procedencia_aspirantes (
    instalacion_id integer,
    ubicacion_id integer NOT NULL,
    responsable_academica_id integer NOT NULL,
    periodo_inscripcion_id integer NOT NULL,
    propuesta_formativa_id integer NOT NULL,
    plan_version_id integer NOT NULL,
    tipo_ingreso_aspirante_id integer NOT NULL,
    procedencia_id integer NOT NULL,
    situacion_aspirante_id integer NOT NULL,
    sexo_id integer NOT NULL,
    edad_id integer NOT NULL,
    estudio_padres_id integer,
    situacion_laboral_padres_id integer,
    nacionalidad_id integer NOT NULL,
    cantidad integer NOT NULL,
    anio_academico integer,
    persona_id integer
);

ALTER TABLE ONLY d_acta
    ADD CONSTRAINT d_acta_pk PRIMARY KEY (acta_id);

ALTER TABLE ONLY d_actividad
    ADD CONSTRAINT d_actividad_pk PRIMARY KEY (actividad_id);

ALTER TABLE ONLY d_actividad_rango
    ADD CONSTRAINT d_actividad_rango_pk PRIMARY KEY (actividad_rango_id);

ALTER TABLE ONLY d_alcance_equivalencia
    ADD CONSTRAINT d_alcance_equivalencia_pk PRIMARY KEY (alcance_equivalencia_id);

ALTER TABLE ONLY d_alumno
    ADD CONSTRAINT d_alumno_pk PRIMARY KEY (alumno_id);

ALTER TABLE ONLY d_calidad_alumno
    ADD CONSTRAINT d_calidad_alumno_pk PRIMARY KEY (calidad_alumno_id);

ALTER TABLE ONLY d_catedra
    ADD CONSTRAINT d_catedra_pk PRIMARY KEY (catedra_id);

ALTER TABLE ONLY d_comision
    ADD CONSTRAINT d_comision_pk PRIMARY KEY (comision_id);

ALTER TABLE ONLY d_concepto
    ADD CONSTRAINT d_concepto_pk PRIMARY KEY (concepto_id);

ALTER TABLE ONLY d_condicion
    ADD CONSTRAINT d_condicion_pk PRIMARY KEY (condicion_id);

ALTER TABLE ONLY d_docente
    ADD CONSTRAINT d_docente_pk PRIMARY KEY (docente_id);

ALTER TABLE ONLY d_edad
    ADD CONSTRAINT d_edades_pk PRIMARY KEY (edad_id);

ALTER TABLE ONLY d_estudio_padres
    ADD CONSTRAINT d_estudio_padres_pk PRIMARY KEY (estudio_padres_id);

ALTER TABLE ONLY d_horas_trabajadas
    ADD CONSTRAINT d_horas_trabajadas_pk PRIMARY KEY (horas_trabajadas_id);

ALTER TABLE ONLY d_intento
    ADD CONSTRAINT d_intento_pk PRIMARY KEY (intento_id);

ALTER TABLE ONLY d_nacionalidad
    ADD CONSTRAINT d_nacionalidad_pk PRIMARY KEY (nacionalidad_id);

ALTER TABLE ONLY d_nota
    ADD CONSTRAINT d_nota_pk PRIMARY KEY (nota_id);

ALTER TABLE ONLY d_origen_equivalencia
    ADD CONSTRAINT d_origen_equivalencia_pk PRIMARY KEY (origen_equivalencia_id);

ALTER TABLE ONLY d_periodo_anio_academico
    ADD CONSTRAINT d_periodo_anio_acad_pk PRIMARY KEY (periodo_id);

ALTER TABLE ONLY d_periodo_inscripcion
    ADD CONSTRAINT d_periodosinscripcion_pk PRIMARY KEY (periodo_inscripcion_id);

ALTER TABLE ONLY d_persona
    ADD CONSTRAINT d_persona_pk PRIMARY KEY (persona_id);

ALTER TABLE ONLY d_plan_version
    ADD CONSTRAINT d_planes_pk PRIMARY KEY (plan_version_id);

ALTER TABLE ONLY d_procedencia
    ADD CONSTRAINT d_procedencia_pk PRIMARY KEY (procedencia_id);

ALTER TABLE ONLY d_propuesta_formativa
    ADD CONSTRAINT d_propuesta_formativa_pk PRIMARY KEY (propuesta_formativa_id);

ALTER TABLE ONLY d_rama_disciplinar
    ADD CONSTRAINT d_rama_disciplinar_pk PRIMARY KEY (rama_disciplinar_id);

ALTER TABLE ONLY d_responsable_academica
    ADD CONSTRAINT d_responsable_academica_pk PRIMARY KEY (responsable_academica_id);

ALTER TABLE ONLY d_resultado
    ADD CONSTRAINT d_resultado_pk PRIMARY KEY (resultado_id);

ALTER TABLE ONLY d_sexo
    ADD CONSTRAINT d_sexo_pk PRIMARY KEY (sexo_id);

ALTER TABLE ONLY d_situacion_aspirante
    ADD CONSTRAINT d_situacion_aspirante_pk PRIMARY KEY (situacion_aspirante_id);

ALTER TABLE ONLY d_situacion_laboral_padres
    ADD CONSTRAINT d_situacion_laboral_padres_pk PRIMARY KEY (situacion_laboral_padres_id);

ALTER TABLE ONLY d_tipo_ingreso_aspirante
    ADD CONSTRAINT d_tipo_ingreso_aspirante_pk PRIMARY KEY (tipo_ingreso_aspirante_id);

ALTER TABLE ONLY d_tipo_ingreso
    ADD CONSTRAINT d_tipo_ingreso_pk PRIMARY KEY (tipo_ingreso_id);

ALTER TABLE ONLY d_tipo_periodo
    ADD CONSTRAINT d_tipo_periodo_pk PRIMARY KEY (tipo_periodo_id);

ALTER TABLE ONLY d_titulo_araucano
    ADD CONSTRAINT d_titulos_araucano_pk PRIMARY KEY (titulo_araucano_id);

ALTER TABLE ONLY d_total_intento
    ADD CONSTRAINT d_total_intento_pk PRIMARY KEY (total_intento_id);

ALTER TABLE ONLY d_tramite
    ADD CONSTRAINT d_tramite_pk PRIMARY KEY (tramite_id);

ALTER TABLE ONLY d_ubicacion
    ADD CONSTRAINT d_ubicacion_pk PRIMARY KEY (ubicacion_id);

ALTER TABLE ONLY d_actividad_comun
    ADD CONSTRAINT d_actividad_comun_pk PRIMARY KEY (actividad_comun_id);



--Crea el esquema guarani3
CREATE SCHEMA guarani3;
SET search_path = guarani3, pg_catalog;

CREATE TABLE d_acta (
    acta_id integer NOT NULL,
  acta_codigo character varying,
  acta_desc character varying,
  estado_acta_id character varying,
  estado_acta_desc character varying,
  instalacion_id integer,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_actividad (
    actividad_id integer NOT NULL,
    actividad_codigo character varying,
    tipo_actividad_desc character varying,
    actividad_desc character varying,
    estado_actividad_desc character varying,
    instalacion_id integer,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_actividad_rango (
    actividad_rango_id integer NOT NULL,
    cantidad_actividades integer,
    rango_aprob_anio_ant_desc character varying,
    rango_aprob_total_desc character varying,
    rango_rend_anio_ant_desc character varying,
    rango_rend_total_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_alcance_equivalencia (
    alcance_equivalencia_id integer NOT NULL,
    alcance_equivalencia_codigo character varying,
    alcance_equivalencia_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_alumno (
   alumno_id integer NOT NULL,
   alumno_codigo integer,
   alumno_codigo_legajo character varying,
    instalacion_id integer,
   fecha_desde date,
   fecha_hasta date,
   version integer,
   vigente character varying,
   fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_calidad_alumno (
    calidad_alumno_id integer NOT NULL,
    calidad_alumno_codigo character varying,
    calidad_alumno_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_catedra (
    catedra_id integer NOT NULL,
    catedra_codigo character varying,
    catedra_desc character varying,
    instalacion_id integer,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_comision (
    comision_id integer NOT NULL,
    comision_desc character varying,
    comision_codigo character varying,
    instalacion_id integer,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_concepto (
    concepto_id integer NOT NULL,
    concepto_codigo character varying,
    concepto_desc character varying,
    instalacion_id integer,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_condicion (
    condicion_id integer NOT NULL,
    condicion_codigo character varying,
    condicion_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_docente (
    docente_id integer NOT NULL,
    docente_codigo character varying,
    docente_desc character varying,
    instalacion_id integer,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_edad (
    edad_id integer NOT NULL,
    edad integer,
    rango_edad_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_estudio_padres (
    estudio_padres_id integer NOT NULL,
    estudio_padres_codigo integer,
    estudio_padres_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_horas_trabajadas (
    horas_trabajadas_id integer NOT NULL,
    horas_trabajadas_codigo character varying,
    horas_trabajadas_desc character varying,
    horas_trabajadas_grupo_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_intento (
    intento_id integer NOT NULL,
    nro_intento_id character varying,
    total_intento_id integer,
    primera_vez character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

COMMENT ON COLUMN d_intento.total_intento_id IS 'PK de la dimensión lt_total_intento';
COMMENT ON COLUMN d_intento.primera_vez IS 'Valores posibles: SI / NO';

CREATE TABLE d_actividad_comun (
    actividad_comun_id integer NOT NULL,
    actividad_comun_codigo character varying,
    actividad_comun_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_nacionalidad (
    nacionalidad_id integer NOT NULL,
    nacionalidad_codigo integer,
    nacionalidad_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_nota (
    nota_id integer NOT NULL,
    nota_codigo character varying,
    nota_desc character varying,
    resultado_id integer,
    instalacion_id integer,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

COMMENT ON COLUMN d_nota.resultado_id IS 'PK a la dimensión d_resultado';

CREATE TABLE d_origen_equivalencia (
    origen_equivalencia_id integer NOT NULL,
    origen_equivalencia_codigo character varying,
    origen_equivalencia_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_periodo_anio_academico (
    periodo_id integer NOT NULL,
    periodo_desc character varying,
    periodo_orden_anio character varying,
    tipo_periodo_id integer,
    anio_academico character varying,
    instalacion_id integer,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

COMMENT ON COLUMN d_periodo_anio_academico.tipo_periodo_id IS 'PK de la dimensión lt_tipo_periodo';

CREATE TABLE d_periodo_inscripcion (
    periodo_inscripcion_id integer NOT NULL,
    periodo_inscripcion_codigo character varying,
    periodo_inscripcion_desc character varying,
    anio_academico character varying,
    instalacion_id integer,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_persona (
    persona_id integer NOT NULL,
    persona_codigo integer,
    persona_desc character varying,
    instalacion_id integer,
    fecha_nacimiento date,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_plan_version (
    plan_version_id integer NOT NULL,
    plan_version_codigo character varying,
    plan_version_desc character varying,
    plan_version_estado character varying,
    plan character varying,
    plan_version character varying,
    instalacion_id integer,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_procedencia (
    procedencia_id integer NOT NULL,
    colegio_id integer,
    colegio_desc character varying,
    ambito_desc character varying,
    sector_desc character varying,
    localidad_id integer,
    localidad_desc character varying,
    provincia_id integer,
    provincia_desc character varying,
    pais_id integer,
    pais_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_propuesta_formativa (
    propuesta_formativa_id integer NOT NULL,
    propuesta_formativa_codigo character varying,
    tipo_propuesta_formativa_desc character varying,
    propuesta_formativa_desc character varying,
    instalacion_id integer,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_rama_disciplinar (
    rama_disciplinar_id integer NOT NULL,
    rama_disciplinar_codigo integer,
    rama_id integer,
    rama_desc character varying,
    disciplina_id character varying,
    disciplina_desc character varying,
    area_id integer,
    area_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_responsable_academica (
    responsable_academica_id integer NOT NULL,
    responsable_academica_codigo character varying,
    tipo_responsable_academica_desc character varying,
    responsable_academica_desc character varying,
    instalacion_id integer,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_resultado (
    resultado_id integer NOT NULL,
    resultado_codigo character varying,
    resultado_desc character varying,
    concepto_id integer,
    instalacion_id integer,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_sexo (
    sexo_id integer NOT NULL,
    sexo_codigo integer,
    sexo_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_situacion_aspirante (
    situacion_aspirante_id integer NOT NULL,
    situacion_aspirante_codigo integer,
    situacion_aspirante_desc character varying,
    resultado_aspirante_codigo character varying,
    resultado_aspirante_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_situacion_laboral_padres (
    situacion_laboral_padres_id integer NOT NULL,
    situacion_laboral_padres_codigo integer,
    situacion_laboral_padres_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_tipo_ingreso (
    tipo_ingreso_id integer NOT NULL,
    tipo_ingreso_codigo character varying,
    tipo_ingreso_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_tipo_ingreso_aspirante (
    tipo_ingreso_aspirante_id integer NOT NULL,
    tipo_ingreso_aspirante_codigo integer,
    tipo_ingreso_aspirante_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_tipo_periodo (
    tipo_periodo_id integer NOT NULL,
    tipo_periodo_codigo character varying,
    tipo_periodo_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_titulo_araucano (
    titulo_araucano_id integer NOT NULL,
    titulo_araucano_codigo character varying,
    titulo_araucano_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);


CREATE TABLE d_total_intento (
    total_intento_id integer NOT NULL,
    total_intento_codigo character varying,
    total_intento_desc character varying,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_tramite (
   tramite_id integer NOT NULL,
  tramite_codigo character varying,
  tramite_desc character varying,
  estado_tramite_id character varying,
  estado_tramite_desc character varying,
  instalacion_id integer,
  fecha_desde date,
  fecha_hasta date,
  version integer,
  vigente character varying,
  fecha_actualizacion timestamp without time zone
);

CREATE TABLE d_ubicacion (
    ubicacion_id integer NOT NULL,
    ubicacion_codigo character varying,
    tipo_ubicacion_desc character varying,
    ubicacion_desc character varying,
    instalacion_id integer,
    fecha_desde date,
    fecha_hasta date,
    version integer,
    vigente character varying,
    fecha_actualizacion timestamp without time zone
);

CREATE TABLE ft_alumnos (
    id integer NOT NULL,
    instalacion_id integer,
    importacion_id integer,
    anio_academico integer NOT NULL,
    plan_version_id integer NOT NULL,
    responsable_academica_id integer NOT NULL,
    propuesta_formativa_id integer NOT NULL,
    ubicacion_id integer NOT NULL,
    titulo_araucano_id integer NOT NULL,
    sexo_id integer NOT NULL,
    anio_ingreso_propuesta integer NOT NULL,
    procedencia_id integer NOT NULL,
    actividades_rendidas_anio_anterior_id integer NOT NULL,
    actividades_aprobadas_anio_anterior_id integer NOT NULL,
    total_actividades_rendidas_id integer NOT NULL,
    total_actividades_aprobadas_id integer NOT NULL,
    horas_trabajadas_id integer NOT NULL,
    tipo_ingreso_id integer NOT NULL,
    edad_id integer NOT NULL,
    alumno_id integer NOT NULL,
    nacionalidad_id integer NOT NULL,
    calidad_alumno_id integer NOT NULL,
    rama_disciplinar_id integer NOT NULL,
    situacion_laboral_padres_id integer,
    estudio_padres_id integer,
    persona_id integer NOT NULL,
    nuevos_inscriptos integer,
    reinscriptos integer,
    egresados integer,
    total_alumnos integer,
    unidad_generica_id integer
);

COMMENT ON COLUMN ft_alumnos.titulo_araucano_id IS 'clave subrogada que identifica al titulo araucano';
COMMENT ON COLUMN ft_alumnos.procedencia_id IS 'Reemplaza a colegio_id';
COMMENT ON COLUMN ft_alumnos.edad_id IS 'edad en el año académico considerado';
COMMENT ON COLUMN ft_alumnos.nuevos_inscriptos IS 'cantidad de nuevos inscriptos';
COMMENT ON COLUMN ft_alumnos.reinscriptos IS 'cantidad de reinscriptos';
COMMENT ON COLUMN ft_alumnos.egresados IS 'cantidad de egresados';

CREATE SEQUENCE ft_alumnos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE ft_alumnos_id_seq OWNED BY ft_alumnos.id;

CREATE TABLE ft_procedencia_aspirantes (
    id integer NOT NULL,
    instalacion_id integer,
    importacion_id integer,
    ubicacion_id integer NOT NULL,
    responsable_academica_id integer NOT NULL,
    periodo_inscripcion_id integer NOT NULL,
    propuesta_formativa_id integer NOT NULL,
    plan_version_id integer NOT NULL,
    tipo_ingreso_aspirante_id integer NOT NULL,
    procedencia_id integer NOT NULL,
    situacion_aspirante_id integer NOT NULL,
    sexo_id integer NOT NULL,
    persona_id integer NOT NULL,
    edad_id integer NOT NULL,
    estudio_padres_id integer,
    situacion_laboral_padres_id integer,
    nacionalidad_id integer NOT NULL,
    cantidad integer NOT NULL,
    unidad_generica_id integer,
    anio_academico integer
);

CREATE SEQUENCE ft_procedencia_aspirantes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE ft_procedencia_aspirantes_id_seq OWNED BY ft_procedencia_aspirantes.id;

CREATE TABLE ft_rendimiento (
    id integer NOT NULL,
    instalacion_id integer,
    importacion_id integer,
    anio_academico integer NOT NULL,
    anio_ingreso_institucion integer NOT NULL,
    responsable_academica_id integer NOT NULL,
    ubicacion_id integer NOT NULL,
    propuesta_formativa_id integer NOT NULL,
    actividad_id integer NOT NULL,
    periodo_id integer NOT NULL,
    condicion_id integer NOT NULL,
    acta_id integer NOT NULL,
    tramite_id integer NOT NULL,
    sexo_id integer NOT NULL,
    edad_id integer NOT NULL,
    alumno_id integer NOT NULL,
    nacionalidad_id integer NOT NULL,
    procedencia_id integer NOT NULL,
    plan_version_id integer NOT NULL,
    comision_id integer NOT NULL,
    catedra_id integer NOT NULL,
    total_intentos integer NOT NULL,
    fecha date NOT NULL,
    origen_equivalencia_id integer NOT NULL,
    alcance_equivalencia_id integer NOT NULL,
    docente_id integer NOT NULL,
    nota_id integer NOT NULL,
    periodo_inscripcion_pf_id integer,
    mesa_examen_desc character varying NOT NULL,
    unidad_generica_id integer,
    tipo_actividad_id integer,
    persona_id integer NOT NULL,
    cantidad_registros_examen integer,
    cantidad_registros_cursada integer,
    cantidad_registros_equivalencia integer
);

CREATE SEQUENCE ft_rendimiento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE ft_rendimiento_id_seq OWNED BY ft_rendimiento.id;

ALTER TABLE ONLY ft_alumnos ALTER COLUMN id SET DEFAULT nextval('ft_alumnos_id_seq'::regclass);

ALTER TABLE ONLY ft_procedencia_aspirantes ALTER COLUMN id SET DEFAULT nextval('ft_procedencia_aspirantes_id_seq'::regclass);

ALTER TABLE ONLY ft_rendimiento ALTER COLUMN id SET DEFAULT nextval('ft_rendimiento_id_seq'::regclass);

ALTER TABLE ONLY d_acta
    ADD CONSTRAINT d_acta_pk PRIMARY KEY (acta_id);

ALTER TABLE ONLY d_actividad
    ADD CONSTRAINT d_actividad_pk PRIMARY KEY (actividad_id);

ALTER TABLE ONLY d_actividad_rango
    ADD CONSTRAINT d_actividad_rango_pk PRIMARY KEY (actividad_rango_id);

ALTER TABLE ONLY d_alcance_equivalencia
    ADD CONSTRAINT d_alcance_equivalencia_pk PRIMARY KEY (alcance_equivalencia_id);

ALTER TABLE ONLY d_alumno
    ADD CONSTRAINT d_alumno_pk PRIMARY KEY (alumno_id);

ALTER TABLE ONLY d_calidad_alumno
    ADD CONSTRAINT d_calidad_alumno_pk PRIMARY KEY (calidad_alumno_id);

ALTER TABLE ONLY d_catedra
    ADD CONSTRAINT d_catedra_pk PRIMARY KEY (catedra_id);

ALTER TABLE ONLY d_comision
    ADD CONSTRAINT d_comision_pk PRIMARY KEY (comision_id);

ALTER TABLE ONLY d_concepto
    ADD CONSTRAINT d_concepto_pk PRIMARY KEY (concepto_id);

ALTER TABLE ONLY d_condicion
    ADD CONSTRAINT d_condicion_pk PRIMARY KEY (condicion_id);

ALTER TABLE ONLY d_docente
    ADD CONSTRAINT d_docente_pk PRIMARY KEY (docente_id);

ALTER TABLE ONLY d_edad
    ADD CONSTRAINT d_edades_pk PRIMARY KEY (edad_id);

ALTER TABLE ONLY d_estudio_padres
    ADD CONSTRAINT d_estudio_padres_pk PRIMARY KEY (estudio_padres_id);

ALTER TABLE ONLY d_horas_trabajadas
    ADD CONSTRAINT d_horas_trabajadas_pk PRIMARY KEY (horas_trabajadas_id);

ALTER TABLE ONLY d_intento
    ADD CONSTRAINT d_intento_pk PRIMARY KEY (intento_id);

ALTER TABLE ONLY d_actividad_comun
    ADD CONSTRAINT d_actividad_comun_pk PRIMARY KEY (actividad_comun_id);

ALTER TABLE ONLY d_nacionalidad
    ADD CONSTRAINT d_nacionalidad_pk PRIMARY KEY (nacionalidad_id);

ALTER TABLE ONLY d_nota
    ADD CONSTRAINT d_nota_pk PRIMARY KEY (nota_id);

ALTER TABLE ONLY d_origen_equivalencia
    ADD CONSTRAINT d_origen_equivalencia_pk PRIMARY KEY (origen_equivalencia_id);

ALTER TABLE ONLY d_periodo_anio_academico
    ADD CONSTRAINT d_periodo_anio_acad_pk PRIMARY KEY (periodo_id);

ALTER TABLE ONLY d_periodo_inscripcion
    ADD CONSTRAINT d_periodosinscripcion_pk PRIMARY KEY (periodo_inscripcion_id);

ALTER TABLE ONLY d_persona
    ADD CONSTRAINT d_persona_pk PRIMARY KEY (persona_id);

ALTER TABLE ONLY d_plan_version
    ADD CONSTRAINT d_planes_pk PRIMARY KEY (plan_version_id);

ALTER TABLE ONLY d_procedencia
    ADD CONSTRAINT d_procedencia_pk PRIMARY KEY (procedencia_id);

ALTER TABLE ONLY d_propuesta_formativa
    ADD CONSTRAINT d_propuesta_formativa_pk PRIMARY KEY (propuesta_formativa_id);

ALTER TABLE ONLY d_rama_disciplinar
    ADD CONSTRAINT d_rama_disciplinar_pk PRIMARY KEY (rama_disciplinar_id);

ALTER TABLE ONLY d_responsable_academica
    ADD CONSTRAINT d_responsable_academica_pk PRIMARY KEY (responsable_academica_id);

ALTER TABLE ONLY d_resultado
    ADD CONSTRAINT d_resultado_pk PRIMARY KEY (resultado_id);

ALTER TABLE ONLY d_sexo
    ADD CONSTRAINT d_sexo_pk PRIMARY KEY (sexo_id);

ALTER TABLE ONLY d_situacion_aspirante
    ADD CONSTRAINT d_situacion_aspirante_pk PRIMARY KEY (situacion_aspirante_id);

ALTER TABLE ONLY d_situacion_laboral_padres
    ADD CONSTRAINT d_situacion_laboral_padres_pk PRIMARY KEY (situacion_laboral_padres_id);

ALTER TABLE ONLY d_tipo_ingreso_aspirante
    ADD CONSTRAINT d_tipo_ingreso_aspirante_pk PRIMARY KEY (tipo_ingreso_aspirante_id);

ALTER TABLE ONLY d_tipo_ingreso
    ADD CONSTRAINT d_tipo_ingreso_pk PRIMARY KEY (tipo_ingreso_id);

ALTER TABLE ONLY d_tipo_periodo
    ADD CONSTRAINT d_tipo_periodo_pk PRIMARY KEY (tipo_periodo_id);

ALTER TABLE ONLY d_titulo_araucano
    ADD CONSTRAINT d_titulos_araucano_pk PRIMARY KEY (titulo_araucano_id);

ALTER TABLE ONLY d_total_intento
    ADD CONSTRAINT d_total_intento_pk PRIMARY KEY (total_intento_id);

ALTER TABLE ONLY d_tramite
    ADD CONSTRAINT d_tramite_pk PRIMARY KEY (tramite_id);

ALTER TABLE ONLY d_ubicacion
    ADD CONSTRAINT d_ubicacion_pk PRIMARY KEY (ubicacion_id);

CREATE INDEX idxp_ft_alumnos_unidadgenericaid ON ft_alumnos USING btree (unidad_generica_id);

CREATE INDEX idxp_ft_procedencia_aspirantes_unidadgenericaid ON ft_procedencia_aspirantes USING btree (unidad_generica_id);

-----------------------------
--     Diaguita Compras
-----------------------------
SET search_path = diaguita_tmp, pg_catalog;
CREATE TABLE d_lugar_entrega
(
  id_lugar_entrega character varying not null,
  nombre_lugar_entrega character varying,
  domicilio_lugar_entrega character varying,
  localidad_lugar_entrega character varying,
  codigo_postal_lugar_entrega character varying
);
CREATE TABLE d_oficina_contrataciones
(
  id_oficina character varying not null,
  nombre character varying
);

CREATE TABLE d_proveedor
(
  id_proveedor character varying not null,
  razon_social character varying,
  nombre_fantasia character varying,
  email character varying,
  cbu character varying,
  cuit character varying,
  descripcion_domicilio character varying,
  nombre_localidad character varying
);
CREATE TABLE ft_compras
(
  id_compras serial not null,
  etapa character varying,
  identificador_solicitud character varying,
  fecha_creacion_solicitud character varying,
  descripcion_solicitud character varying,
  prioridad_solicitud character varying,
  estado_solicitud character varying,
  referente_solicitud character varying,
  id_lugar_entrega_solicitud character varying,
  id_oficina_central_contratacion_solicitud character varying,
  id_area_solicitud character varying,
  descripcion_item_solicitado character varying,
  cantidad_item_solicitado character varying DEFAULT 0,
  unidad_medida_item_solicitado character varying,
  precio_estimado_item_solicitado character varying DEFAULT 0,
  id_area_item_solicitado character varying,
  identificador_convocatoria character varying,
  fecha_creacion_convocatoria character varying,
  descripcion_convocatoria character varying,
  estado_convocatoria character varying,
  prioridad_convocatoria character varying,
  id_convocatoria character varying,
  expediente_convocatoria character varying,
  tipo_procedimiento_convocatoria character varying,
  id_renglon character varying,
  descripcion_renglon character varying,
  numero_renglon character varying,
  precio_estimado_renglon character varying DEFAULT 0,
  catalogo_bien_servicio_renglon character varying,
  id_renglon_area character varying,
  cantidad_renglon character varying DEFAULT 0,
  id_item_area character varying,
  id_convocatoria_aa character varying,
  id_acto_apertura character varying,
  inicio_acto_apertura character varying,
  fin_acto_apertura character varying,
  oficina_acto_apertura character varying,
  lugar_acto_apertura character varying,
  identificador_acto_apertura character varying,
  estado_acto_apertura character varying,
  id_acto_apertura_de character varying,
  fecha_creacion_dictamen character varying,
  fecha_generacion_dictamen character varying,
  identificador_dictamen character varying,
  estado_dictamen character varying,
  -- Adjudicacion
  id_renglon_ad character varying,
  estado_adjudicacion character varying,
  identificador_adjudicacion character varying,
  id_proveedor character varying,
  cantidad_ad character varying DEFAULT 0,
  monto_unitario character varying DEFAULT 0,
  id_adjudicacion character varying, -- Clave para Orden de Compra
  -- Orden de Compra
  id_renglon_area_oc character varying,
  id_detalle_orden_compra_oc character varying,
  id_proveedor_oc character varying,
  id_area_oc character varying,
  estado_orden_compra character varying,
  identificador_orden_compra character varying,
  fecha_emision_oc character varying,
  id_lugar_entrega_oc character varying,
  cantidad_oc character varying DEFAULT 0,
  id_adjudicacion_oc character varying, -- Clave para Adjudicacion
  -- Recepciones
  id_detalle_orden_compra_re character varying,
  fecha_recepcion character varying,
  estado_recepcion character varying,
  remito character varying,
  factura_numero character varying,
  identificador_acta_provisoria_recepcion character varying,
  fecha_acta_provisoria_re character varying,
  id_area_re character varying,
  identificador_acta_definitiva_recepcion character varying,
  fecha_acta_definitiva_re character varying,
  cantidad_recibida character varying DEFAULT 0,
  cantidad_aceptada character varying DEFAULT 0,
  cantidad_rechazada character varying DEFAULT 0
);
-----------------------------
SET search_path = diaguita_dsa, pg_catalog;
CREATE TABLE d_lugar_entrega
(
  id_lugar_entrega integer not null,
  nombre_lugar_entrega character varying,
  domicilio_lugar_entrega character varying,
  localidad_lugar_entrega character varying,
  codigo_postal_lugar_entrega character varying,
  CONSTRAINT d_lugar_entrega_pkey PRIMARY KEY (id_lugar_entrega)
);
CREATE TABLE d_oficina_contrataciones
(
  id_oficina integer not null,
  nombre character varying,
  CONSTRAINT d_oficina_contratacion_pkey PRIMARY KEY (id_oficina)
);
CREATE TABLE d_proveedor
(
  id_proveedor integer not null,
  razon_social character varying,
  nombre_fantasia character varying,
  email character varying,
  cbu character varying,
  cuit character varying,
  descripcion_domicilio character varying,
  nombre_localidad character varying,
  CONSTRAINT d_proveedor_pkey PRIMARY KEY (id_proveedor)
);
CREATE TABLE ft_compras
(
  id_compras serial not null,
  etapa character varying,
  identificador_solicitud character varying,
  fecha_creacion_solicitud date,
  descripcion_solicitud character varying,
  prioridad_solicitud character varying,
  estado_solicitud character varying,
  referente_solicitud character varying,
  id_lugar_entrega_solicitud integer,
  id_oficina_central_contratacion_solicitud integer,
  id_area_solicitud integer,
  descripcion_item_solicitado character varying,
  cantidad_item_solicitado double precision DEFAULT 0,
  unidad_medida_item_solicitado character varying,
  precio_estimado_item_solicitado double precision DEFAULT 0,
  id_area_item_solicitado integer,
  identificador_convocatoria character varying,
  fecha_creacion_convocatoria date,
  descripcion_convocatoria character varying,
  estado_convocatoria character varying,
  prioridad_convocatoria character varying,
  id_convocatoria integer,
  expediente_convocatoria character varying,
  tipo_procedimiento_convocatoria character varying,
  id_renglon integer,
  descripcion_renglon character varying,
  numero_renglon character varying,
  precio_estimado_renglon double precision DEFAULT 0,
  catalogo_bien_servicio_renglon integer,
  id_renglon_area integer,
  cantidad_renglon double precision DEFAULT 0,
  id_item_area integer,
  id_convocatoria_aa integer,
  id_acto_apertura integer,
  inicio_acto_apertura timestamp without time zone,
  fin_acto_apertura timestamp without time zone,
  oficina_acto_apertura character varying,
  lugar_acto_apertura character varying,
  identificador_acto_apertura character varying,
  estado_acto_apertura character varying,
  id_acto_apertura_de integer,
  fecha_creacion_dictamen date,
  fecha_generacion_dictamen date,
  identificador_dictamen character varying,
  estado_dictamen character varying,
  -- Adjudicacion
  id_renglon_ad integer,
  estado_adjudicacion character varying,
  identificador_adjudicacion character varying,
  id_proveedor integer,
  cantidad_ad double precision DEFAULT 0,
  monto_unitario double precision DEFAULT 0,
  id_adjudicacion integer, -- Clave para Orden de Compra
  -- Orden de Compra
  id_renglon_area_oc integer,
  id_detalle_orden_compra_oc integer,
  id_proveedor_oc integer,
  id_area_oc integer,
  estado_orden_compra character varying,
  identificador_orden_compra character varying,
  fecha_emision_oc date,
  id_lugar_entrega_oc integer,
  cantidad_oc double precision DEFAULT 0,
  monto_unitario_oc double precision DEFAULT 0,
  id_adjudicacion_oc integer, -- Clave para Adjudicacion
  -- Recepciones
  id_detalle_orden_compra_re integer,
  fecha_recepcion date,
  estado_recepcion character varying,
  remito character varying,
  factura_numero character varying,
  identificador_acta_provisoria_recepcion character varying,
  fecha_acta_provisoria_re date,
  id_area_re integer,
  identificador_acta_definitiva_recepcion character varying,
  fecha_acta_definitiva_re date,
  cantidad_recibida double precision DEFAULT 0,
  cantidad_aceptada double precision DEFAULT 0,
  cantidad_rechazada double precision DEFAULT 0,
  importe_total_solicitud double precision DEFAULT 0,
  importe_total_convocatoria double precision DEFAULT 0,
  importe_total_adjudicado double precision DEFAULT 0,
  importe_total_oc double precision DEFAULT 0,
  CONSTRAINT ft_compras_pkey PRIMARY KEY (id_compras)
);
-----------------------------
SET search_path = diaguita, pg_catalog;
CREATE TABLE d_lugar_entrega
(
  id_lugar_entrega integer not null,
  nombre_lugar_entrega character varying,
  domicilio_lugar_entrega character varying,
  localidad_lugar_entrega character varying,
  codigo_postal_lugar_entrega character varying,
  CONSTRAINT d_lugar_entrega_pkey PRIMARY KEY (id_lugar_entrega)
);
CREATE TABLE d_oficina_contrataciones
(
  id_oficina integer not null,
  nombre character varying,
  CONSTRAINT d_oficina_contratacion_pkey PRIMARY KEY (id_oficina)
);
CREATE TABLE d_proveedor
(
  id_proveedor integer not null,
  razon_social character varying,
  nombre_fantasia character varying,
  email character varying,
  cbu character varying,
  cuit character varying,
  descripcion_domicilio character varying,
  nombre_localidad character varying,
  CONSTRAINT d_proveedor_pkey PRIMARY KEY (id_proveedor)
);
CREATE TABLE ft_compras
(
  id_compras serial not null,
  etapa character varying,
  identificador_solicitud character varying,
  fecha_creacion_solicitud date,
  descripcion_solicitud character varying,
  prioridad_solicitud character varying,
  estado_solicitud character varying,
  referente_solicitud character varying,
  id_lugar_entrega_solicitud integer,
  id_oficina_central_contratacion_solicitud integer,
  id_area_solicitud integer,
  descripcion_item_solicitado character varying,
  cantidad_item_solicitado double precision DEFAULT 0,
  unidad_medida_item_solicitado character varying,
  precio_estimado_item_solicitado double precision DEFAULT 0,
  id_area_item_solicitado integer,
  identificador_convocatoria character varying,
  fecha_creacion_convocatoria date,
  descripcion_convocatoria character varying,
  estado_convocatoria character varying,
  prioridad_convocatoria character varying,
  id_convocatoria integer,
  expediente_convocatoria character varying,
  tipo_procedimiento_convocatoria character varying,
  id_renglon integer,
  descripcion_renglon character varying,
  numero_renglon character varying,
  precio_estimado_renglon double precision DEFAULT 0,
  catalogo_bien_servicio_renglon integer,
  id_renglon_area integer,
  cantidad_renglon double precision DEFAULT 0,
  id_item_area integer,
  id_convocatoria_aa integer,
  id_acto_apertura integer,
  inicio_acto_apertura timestamp without time zone,
  fin_acto_apertura timestamp without time zone,
  oficina_acto_apertura character varying,
  lugar_acto_apertura character varying,
  identificador_acto_apertura character varying,
  estado_acto_apertura character varying,
  id_acto_apertura_de integer,
  fecha_creacion_dictamen date,
  fecha_generacion_dictamen date,
  identificador_dictamen character varying,
  estado_dictamen character varying,
  -- Adjudicacion
  id_renglon_ad integer,
  estado_adjudicacion character varying,
  identificador_adjudicacion character varying,
  id_proveedor integer,
  cantidad_ad double precision DEFAULT 0,
  monto_unitario double precision DEFAULT 0,
  id_adjudicacion integer, -- Clave para Orden de Compra
  -- Orden de Compra
  id_renglon_area_oc integer,
  id_detalle_orden_compra_oc integer,
  id_proveedor_oc integer,
  id_area_oc integer,
  estado_orden_compra character varying,
  identificador_orden_compra character varying,
  fecha_emision_oc date,
  id_lugar_entrega_oc integer,
  cantidad_oc double precision DEFAULT 0,
  monto_unitario_oc double precision DEFAULT 0,
  id_adjudicacion_oc integer, -- Clave para Adjudicacion
  -- Recepciones
  id_detalle_orden_compra_re integer,
  fecha_recepcion date,
  estado_recepcion character varying,
  remito character varying,
  factura_numero character varying,
  identificador_acta_provisoria_recepcion character varying,
  fecha_acta_provisoria_re date,
  id_area_re integer,
  identificador_acta_definitiva_recepcion character varying,
  fecha_acta_definitiva_re date,
  cantidad_recibida double precision DEFAULT 0,
  cantidad_aceptada double precision DEFAULT 0,
  cantidad_rechazada double precision DEFAULT 0,
  importe_total_solicitud double precision DEFAULT 0,
  importe_total_convocatoria double precision DEFAULT 0,
  importe_total_adjudicado double precision DEFAULT 0,
  importe_total_oc double precision DEFAULT 0,
  unidad_generica_id integer,
  CONSTRAINT ft_compras_pkey PRIMARY KEY (id_compras)
);
-----------------------------
-----------------------------
CREATE TABLE diaguita_dsa.w_areas_referenciadas
(
  codigo text,
  CONSTRAINT w_areas_referenciadas_pkey PRIMARY KEY (codigo)
)
WITH (
  OIDS=FALSE
);
-----------------------------
-----------------------------
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
    -- Se crea un tabla con todas las referencias a areas de las distintas tablas de hechos
    TRUNCATE diaguita_dsa.w_areas_referenciadas;
    INSERT INTO diaguita_dsa.w_areas_referenciadas (codigo)
    SELECT DISTINCT id_area_responsable FROM diaguita_tmp.ft_patrimonio
    WHERE id_area_responsable NOT IN (SELECT codigo FROM diaguita_dsa.w_areas_referenciadas);
    INSERT INTO diaguita_dsa.w_areas_referenciadas (codigo)
    SELECT DISTINCT id_area_solicitud FROM diaguita_tmp.ft_compras
    WHERE id_area_solicitud NOT IN (SELECT codigo FROM diaguita_dsa.w_areas_referenciadas);
    INSERT INTO diaguita_dsa.w_areas_referenciadas (codigo)
    SELECT DISTINCT id_area_item_solicitado FROM diaguita_tmp.ft_compras
    WHERE id_area_item_solicitado NOT IN (SELECT codigo FROM diaguita_dsa.w_areas_referenciadas);
    INSERT INTO diaguita_dsa.w_areas_referenciadas (codigo)
    SELECT DISTINCT id_area_oc FROM diaguita_tmp.ft_compras
    WHERE id_area_oc NOT IN (SELECT codigo FROM diaguita_dsa.w_areas_referenciadas);
    INSERT INTO diaguita_dsa.w_areas_referenciadas (codigo)
    SELECT DISTINCT id_area_re FROM diaguita_tmp.ft_compras
    WHERE id_area_re NOT IN (SELECT codigo FROM diaguita_dsa.w_areas_referenciadas);

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
ALTER FUNCTION diaguita_dsa.podar_area()
  OWNER TO postgres;
-----------------------------
-----------------------------
-----------------------------








