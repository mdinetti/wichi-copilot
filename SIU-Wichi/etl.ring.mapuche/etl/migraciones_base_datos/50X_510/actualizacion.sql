-- Actualizacion de Wichi 5.0.0 o 5.0.1 a 5.1.0

-- ----------------------------
-- pilaga
-- ----------------------------

alter table pilaga_tmp.d_cuenta_tesoreria drop constraint pk_d_cuenta_tesoreria;
alter table pilaga_tmp.d_grupo_presupuestario drop constraint pk_d_grupo_presupuestario;
alter table pilaga_tmp.d_red_programatica drop constraint pk_d_red_programatica;
alter table pilaga_tmp.ft_comprobantes drop constraint pk_ft_comprobantes;
ALTER TABLE pilaga_tmp.d_cuenta_tesoreria
  ALTER COLUMN cuenta_tesoreria_codigo DROP NOT NULL;
ALTER TABLE pilaga_tmp.d_grupo_presupuestario
  ALTER COLUMN grupo_presupuestario_codigo DROP NOT NULL;
ALTER TABLE pilaga_tmp.d_red_programatica
  ALTER COLUMN programa_codigo DROP NOT NULL;
ALTER TABLE pilaga_tmp.ft_comprobantes
  ALTER COLUMN comprobante_codigo DROP NOT NULL;


-- ----------------------------
-- mapuche
-- ----------------------------


ALTER TABLE mapuche_tmp.map_dsa_ft_lt_legajos ADD COLUMN categoria_incentivo_codigo  character varying;
ALTER TABLE mapuche_dsa.map_dsa_ids_ft_lt_legajos ADD COLUMN categoria_incentivo_id integer;
-- Pone en vacio/nulo los errores, blancos, N, vacios, etc.
UPDATE mapuche.map_dw_ft_lt_legajos
 SET categoria_incentivo_id = 0
 WHERE categoria_incentivo_id IN (SELECT categoria_incentivo_id 
                    FROM mapuche.d_categoria_incentivo 
                    WHERE     categoria_incentivo_codigo='N' OR
                        categoria_incentivo_codigo=' ' OR
                        categoria_incentivo_codigo='-1');
-- Elimina de la tabla de categorias los codigos que no se usaran mas ‘ ‘, ‘N’, etc.
DELETE FROM mapuche.d_categoria_incentivo WHERE categoria_incentivo_codigo='N';
DELETE FROM mapuche.d_categoria_incentivo WHERE categoria_incentivo_codigo=' ';

ALTER TABLE mapuche_dsa.map_dsa_ids_ft_liqconceptosxcargos ADD COLUMN importedescuentoscargo numeric(15,2);
ALTER TABLE mapuche_dsa.map_dsa_ids_ft_liqconceptosxcargos ADD COLUMN importeaportescargo numeric(15,2);

UPDATE mapuche.map_dw_ft_liqconceptosxcargos ft 
  SET importedescuentoscargo = importe_liq
WHERE importedescuentoscargo IS NULL AND 
  ft.concepto_id IN (SELECT concepto_id FROM mapuche.map_dw_lt_conceptos WHERE conceptotipo_id_map='D');
UPDATE mapuche.map_dw_ft_liqconceptosxcargos ft 
  SET importeaportescargo = importe_liq
WHERE importeaportescargo IS NULL AND 
  ft.concepto_id IN (SELECT concepto_id FROM mapuche.map_dw_lt_conceptos WHERE conceptotipo_id_map='A');


-- ----------------------------
-- guarani - drops
-- ----------------------------

DROP VIEW guarani.gua_dw_vista_comisiones;
DROP VIEW guarani.gua_dw_vista_catedras;
DROP TABLE guarani.gua_dw_ft_alumnosarau CASCADE;
DROP TABLE guarani.gua_dw_ft_cursado CASCADE;
DROP TABLE guarani.gua_dw_ft_equivalencia CASCADE;
DROP TABLE guarani.gua_dw_ft_examen CASCADE;
DROP TABLE guarani.gua_dw_ft_procedenciaaspirantes CASCADE;
DROP TABLE guarani.gua_dw_lt_alcanceequivalencia CASCADE;
DROP TABLE guarani.gua_dw_lt_carreras CASCADE;
DROP TABLE guarani.gua_dw_lt_catedras CASCADE;
DROP TABLE guarani.gua_dw_lt_comision CASCADE;
DROP TABLE guarani.gua_dw_lt_condicion CASCADE;
DROP TABLE guarani.gua_dw_lt_edades CASCADE;
DROP TABLE guarani.gua_dw_lt_estadosacta CASCADE;
DROP TABLE guarani.gua_dw_lt_horastrabajadas CASCADE;
DROP TABLE guarani.gua_dw_lt_intentos CASCADE;
DROP TABLE guarani.gua_dw_lt_legajos CASCADE;
DROP TABLE guarani.gua_dw_lt_materiacomun CASCADE;
DROP TABLE guarani.gua_dw_lt_materias CASCADE;
DROP TABLE guarani.gua_dw_lt_materiasrangos CASCADE;
DROP TABLE guarani.gua_dw_lt_notas CASCADE;
DROP TABLE guarani.gua_dw_lt_origenequivalencia CASCADE;
DROP TABLE guarani.gua_dw_lt_periodosanioacad CASCADE;
DROP TABLE guarani.gua_dw_lt_periodosinsccarrera CASCADE;
DROP TABLE guarani.gua_dw_lt_periodosinscripcion CASCADE;
DROP TABLE guarani.gua_dw_lt_planes CASCADE;
DROP TABLE guarani.gua_dw_lt_procedencia CASCADE;
DROP TABLE guarani.gua_dw_lt_procesadook CASCADE;
DROP TABLE guarani.gua_dw_lt_resultados CASCADE;
DROP TABLE guarani.gua_dw_lt_sedes CASCADE;
DROP TABLE guarani.gua_dw_lt_sexos CASCADE;
DROP TABLE guarani.gua_dw_lt_situacionesaspirantes CASCADE;
DROP TABLE guarani.gua_dw_lt_tipoingreso CASCADE;
DROP TABLE guarani.gua_dw_lt_tiposperiodo CASCADE;
DROP TABLE guarani.gua_dw_lt_titulosaraucano CASCADE;
DROP TABLE guarani.gua_dw_lt_totalintentos CASCADE;
DROP TABLE guarani.gua_dw_lt_unidadesacademicas CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_ft_alumnosarau CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_ft_cursado CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_ft_equivalencia CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_ft_examen CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_ft_procedenciaaspirantes CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_alcanceequivalencia CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_anioacademico CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_anioingresocarrera CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_anioingresoua CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_carreras CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_catedras CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_comision CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_condicion CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_edades CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_estadosacta CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_horastrabajadas CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_intentos CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_legajos CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_materiacomun CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_materias CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_materiasrangos CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_notas CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_origenequivalencia CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_periodosanioacad CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_periodosinsccarrera CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_periodosinscripcion CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_planes CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_procedencia CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_procesadook CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_resultados CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_sedes CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_sexos CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_situacionesaspirantes CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_tipoingreso CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_tiposperiodo CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_titulosaraucano CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_totalintentos CASCADE;
DROP TABLE guarani_dsa.gua_dsa_ids_lt_unidadesacademicas CASCADE;
DROP TABLE guarani_tmp.gua_dsa_ft_alumnosarau CASCADE;
DROP TABLE guarani_tmp.gua_dsa_ft_cursado CASCADE;
DROP TABLE guarani_tmp.gua_dsa_ft_equivalencia CASCADE;
DROP TABLE guarani_tmp.gua_dsa_ft_examen CASCADE;
DROP TABLE guarani_tmp.gua_dsa_ft_procedenciaaspirantes CASCADE;
DROP TABLE guarani_tmp.gua_dsa_lt_alcanceequivalencia CASCADE;
DROP TABLE guarani_tmp.gua_dsa_lt_carreras CASCADE;
DROP TABLE guarani_tmp.gua_dsa_lt_colegios CASCADE;
DROP TABLE guarani_tmp.gua_dsa_lt_condicionexamen CASCADE;
DROP TABLE guarani_tmp.gua_dsa_lt_condicionregularidad CASCADE;
DROP TABLE guarani_tmp.gua_dsa_lt_departamentos CASCADE;
DROP TABLE guarani_tmp.gua_dsa_lt_estadosacta CASCADE;
DROP TABLE guarani_tmp.gua_dsa_lt_horastrabajadas CASCADE;
DROP TABLE guarani_tmp.gua_dsa_lt_localidades CASCADE;
DROP TABLE guarani_tmp.gua_dsa_lt_materiacomun CASCADE;
DROP TABLE guarani_tmp.gua_dsa_lt_materias CASCADE;
DROP TABLE guarani_tmp.gua_dsa_lt_origenequivalencia CASCADE;
DROP TABLE guarani_tmp.gua_dsa_lt_paises CASCADE;
DROP TABLE guarani_tmp.gua_dsa_lt_provincias CASCADE;
DROP TABLE guarani_tmp.gua_dsa_lt_resultados CASCADE;
DROP TABLE guarani_tmp.gua_dsa_lt_resultadosaspirantes CASCADE;
DROP TABLE guarani_tmp.gua_dsa_lt_sedes CASCADE;
DROP TABLE guarani_tmp.gua_dsa_lt_sexos CASCADE;
DROP TABLE guarani_tmp.gua_dsa_lt_situacionesaspirantes CASCADE;
DROP TABLE guarani_tmp.gua_dsa_lt_tipoingreso CASCADE;
DROP TABLE guarani_tmp.gua_dsa_lt_tiposperiodo CASCADE;
DROP TABLE guarani_tmp.gua_dsa_lt_titulosaraucano CASCADE;
DROP TABLE guarani_tmp.gua_dsa_lt_unidadesacademicas CASCADE;


-- ----------------------------
-- guarani - creates tmp
-- ----------------------------

--Tablas comunes
CREATE TABLE guarani_tmp.gua_dsa_lt_departamentos (
                unidadacademica_id VARCHAR,
                departamento_id VARCHAR,
				departamento_desc VARCHAR
);
CREATE TABLE guarani_tmp.gua_dsa_lt_carreras (
                unidadacademica_id VARCHAR,
                carrera_id VARCHAR,
				carrera_desc VARCHAR,
                departamento_id VARCHAR
);
-- carreras con departamento
CREATE TABLE guarani_tmp.gua_dsa_lt_unidadesacademicas(
                unidadacademica_id VARCHAR,
                unidadacademica_desc VARCHAR
);
CREATE TABLE guarani_tmp.gua_dsa_lt_colegios (
                colegio_id INTEGER,
                colegio_desc VARCHAR,
                localidad_id INTEGER
);
CREATE TABLE guarani_tmp.gua_dsa_lt_localidades (
                localidad_id INTEGER,
                localidad_desc VARCHAR,
                provincia_id INTEGER
);
CREATE TABLE guarani_tmp.gua_dsa_lt_provincias (
                provincia_id INTEGER,
                provincia_desc VARCHAR,
                pais_id INTEGER
);
CREATE TABLE guarani_tmp.gua_dsa_lt_paises (
                pais_id INTEGER,
                pais_desc VARCHAR
);
CREATE TABLE guarani_tmp.gua_dsa_lt_sexos (
                sexo_id INTEGER,
                sexo_desc VARCHAR
);
CREATE TABLE guarani_tmp.gua_dsa_ft_procedenciaaspirantes (
                unidadacademica_id VARCHAR,
                anioacademico INTEGER,
				periodoinscripcion VARCHAR,
                carrera_id VARCHAR,
                colegio_id INTEGER,
				situacionasp_id VARCHAR,
				sexo_id INTEGER,
				cantidad INTEGER
);
CREATE TABLE guarani_tmp.gua_dsa_lt_situacionesaspirantes (
                situacionasp_id VARCHAR,
                situacionasp_desc VARCHAR,
				resultadoasp_id VARCHAR
);
CREATE TABLE guarani_tmp.gua_dsa_lt_resultadosaspirantes (
                resultadoasp_id VARCHAR,
                resultadoasp_desc VARCHAR
				
);

--Tablas temporales cubo alumnos
CREATE TABLE guarani_tmp.gua_dsa_lt_titulosaraucano (
                tituloaraucano_id VARCHAR NOT NULL,
                tituloaraucano_desc VARCHAR
);
COMMENT ON TABLE guarani_tmp.gua_dsa_lt_titulosaraucano IS 'cubo 05';

CREATE TABLE guarani_tmp.gua_dsa_lt_tipoingreso (
                tipoingreso_id VARCHAR NOT NULL,
                tipoingreso_desc VARCHAR
);
COMMENT ON TABLE guarani_tmp.gua_dsa_lt_tipoingreso IS 'cubo 05';

CREATE TABLE guarani_tmp.gua_dsa_lt_horastrabajadas (
                horastrabajadas_id VARCHAR NOT NULL,
                horastrabajadas_desc VARCHAR
);
COMMENT ON TABLE guarani_tmp.gua_dsa_lt_horastrabajadas IS 'cubo 05';

CREATE TABLE guarani_tmp.gua_dsa_ft_alumnosarau (
                anioacademico INTEGER NOT NULL,
                unidadacademica_id VARCHAR,
                carrera_id VARCHAR,
                tituloaraucanocarrera_id VARCHAR,
                sexo_id INTEGER,
                anioingresocarrera INTEGER,
                colegiosecundario_id INTEGER,
                materiasrendidasanioanterior INTEGER,
                materiasaprobadasanioanterior INTEGER,
                totalmateriasrendidas INTEGER,
                totalmateriasaprobadas INTEGER,
                horastrabajadas_id VARCHAR,
                tipoingreso_id VARCHAR,
                edad INTEGER,
                procesoaraucanook VARCHAR,
                nuevosinscriptos INTEGER,
                reinscriptos INTEGER,
                egresados INTEGER
);
COMMENT ON TABLE guarani_tmp.gua_dsa_ft_alumnosarau IS 'Corresponde al cubo 05';
COMMENT ON COLUMN guarani_tmp.gua_dsa_ft_alumnosarau.edad IS 'edad en el año académico considerado';
COMMENT ON COLUMN guarani_tmp.gua_dsa_ft_alumnosarau.procesoaraucanook IS 'Indica si el proceso de generacion de datos para informar a SIU-Araucano fue exitoso para el/los registro/s considerado/s';
COMMENT ON COLUMN guarani_tmp.gua_dsa_ft_alumnosarau.nuevosinscriptos IS 'cantidad de nuevos inscriptos';
COMMENT ON COLUMN guarani_tmp.gua_dsa_ft_alumnosarau.reinscriptos IS 'cantidad de reinscriptos';
COMMENT ON COLUMN guarani_tmp.gua_dsa_ft_alumnosarau.egresados IS 'cantidad de egresados';

--Tablas temporales cubo rend. academico
CREATE TABLE guarani_tmp.gua_dsa_lt_tiposperiodo (
                tipoperiodo_id VARCHAR,
                tipoperiodo_desc VARCHAR
);
CREATE TABLE guarani_tmp.gua_dsa_lt_sedes (
                sede_id VARCHAR,
                sede_desc VARCHAR
);
CREATE TABLE guarani_tmp.gua_dsa_lt_resultados (
                resultado_id VARCHAR,
                resultado_desc VARCHAR
);
CREATE TABLE guarani_tmp.gua_dsa_lt_origenequivalencia (
                origenequivalencia_id VARCHAR,
                origenequivalencia_desc VARCHAR
);
CREATE TABLE guarani_tmp.gua_dsa_lt_materiacomun (
                materiacomun_id VARCHAR,
                materiacomun_desc VARCHAR
);
COMMENT ON TABLE guarani_tmp.gua_dsa_lt_materiacomun IS 'Corresponde a LT_Materia_Comun.';
COMMENT ON COLUMN guarani_tmp.gua_dsa_lt_materiacomun.materiacomun_id IS 'Código que indica se es una materia normal o se obtiene como materia común con otra carrera. 0 / 1';

CREATE TABLE guarani_tmp.gua_dsa_lt_estadosacta (
                estadoacta_id VARCHAR,
                estadoacta_desc VARCHAR
);
CREATE TABLE guarani_tmp.gua_dsa_lt_condicionexamen (
                condicionexamen_id VARCHAR,
                condicionexamen_desc VARCHAR
);
COMMENT ON COLUMN guarani_tmp.gua_dsa_lt_condicionexamen.condicionexamen_id IS 'Código de condición del alumno utilizado para exámenes y equivalencias (E)';
COMMENT ON COLUMN guarani_tmp.gua_dsa_lt_condicionexamen.condicionexamen_desc IS 'Descripción correspondiente a la condición del alumno para exámenes y caso de equivalencia.';

CREATE TABLE guarani_tmp.gua_dsa_lt_alcanceequivalencia (
                alcanceequivalencia_id VARCHAR,
                alcanceequivalencia_desc VARCHAR
);
CREATE TABLE guarani_tmp.gua_dsa_lt_materias (
                unidadacademica_id VARCHAR,
                materia_id VARCHAR,
                materia_desc VARCHAR
);
CREATE TABLE guarani_tmp.gua_dsa_lt_condicionregularidad (
                condicionregularidad_id VARCHAR,
                condicionregularidad_desc VARCHAR
);
CREATE TABLE guarani_tmp.gua_dsa_ft_examen (
                unidadacademica_id VARCHAR,
                sede_id VARCHAR,
                anioacademico VARCHAR,
                tipoperiodo_id VARCHAR,
                turnoexamen_desc VARCHAR,
                mesaexamen_desc VARCHAR,
                fechaexamen VARCHAR,
                legajo_id VARCHAR,
                carrera_id VARCHAR,
                plancarrera_id VARCHAR,
                versionplan_id VARCHAR,
                materia_id VARCHAR,
                catedra_desc VARCHAR,
                resultado_id VARCHAR,
                nota VARCHAR,
                tipomateria_id VARCHAR,
                tipoacta_id VARCHAR,
                acta VARCHAR,
                estadoacta_id VARCHAR,
                condicionalumno_id VARCHAR,
                totalintentosrendir VARCHAR,
                nrointentorendir VARCHAR,
                cantidadregistrosexamen VARCHAR,
                anioingresoua VARCHAR,
                cohorte VARCHAR,
                periodoinscripcioncarrera_desc VARCHAR
);
COMMENT ON COLUMN guarani_tmp.gua_dsa_ft_examen.tipomateria_id IS 'Indicación de si es una materia normal o se obtiene como materia común con otra carrera. 0/1 (Indicando normal  / materia común respectivamente)';
COMMENT ON COLUMN guarani_tmp.gua_dsa_ft_examen.totalintentosrendir IS 'Total de veces que ha intentado rendir la materia dentro de la carrera';
COMMENT ON COLUMN guarani_tmp.gua_dsa_ft_examen.nrointentorendir IS 'Número de vez que intenta rendir la materia dentro de la carrera.';
COMMENT ON COLUMN guarani_tmp.gua_dsa_ft_examen.cohorte IS 'Año de ingreso a la carrera.';

CREATE TABLE guarani_tmp.gua_dsa_ft_equivalencia (
                unidadacademica_id VARCHAR,
                anioacademico VARCHAR,
                tipoperiodo_id VARCHAR,
                periodo_desc VARCHAR,
                fechaequivalencia VARCHAR,
                legajo VARCHAR,
                carrera_id VARCHAR,
                plancarrera_id VARCHAR,
                versionplan_id VARCHAR,
                materia_id VARCHAR,
                alcanceequivalencia_id VARCHAR,
                resultado_id VARCHAR,
                nota VARCHAR,
                origenequivalencia_id VARCHAR,
                equivalenciaguarani_id VARCHAR,
                tipomateria_id VARCHAR,
                estadoacta_id VARCHAR,
                condicionalumno_id VARCHAR,
                cantidadregistrosexamen VARCHAR,
                anioingresoua VARCHAR,
                cohorte VARCHAR,
                periodoinscripcioncarrera_desc VARCHAR
);
COMMENT ON COLUMN guarani_tmp.gua_dsa_ft_equivalencia.tipoperiodo_id IS 'Es siempre NP indicando que no está asociado a ningún período.';
COMMENT ON COLUMN guarani_tmp.gua_dsa_ft_equivalencia.periodo_desc IS 'Es siempre NP indicando que no está asociado a ningún período.';
COMMENT ON COLUMN guarani_tmp.gua_dsa_ft_equivalencia.fechaequivalencia IS 'Fecha de otorgamiento de la equivalencia.';
COMMENT ON COLUMN guarani_tmp.gua_dsa_ft_equivalencia.equivalenciaguarani_id IS 'Código con que queda registrada la equivalencia en el SIU-Guaraní';
COMMENT ON COLUMN guarani_tmp.gua_dsa_ft_equivalencia.tipomateria_id IS 'Indicación de si es una materia normal o se obtiene como materia común con otra carrera. 0/1 (Indicando normal  / materia común respectivamente)';
COMMENT ON COLUMN guarani_tmp.gua_dsa_ft_equivalencia.condicionalumno_id IS 'Código de condición del alumno. Es siempre 1';
COMMENT ON COLUMN guarani_tmp.gua_dsa_ft_equivalencia.cohorte IS 'Año de ingreso a la carrera.';

CREATE TABLE guarani_tmp.gua_dsa_ft_cursado (
                unidadacademica_id VARCHAR,
                sede_id VARCHAR,
                anioacademico VARCHAR,
                tipoperiodo_id VARCHAR,
                periodolectivo_desc VARCHAR,
                ordenperiodoenanio VARCHAR,
                legajo_id VARCHAR,
                carrera_id VARCHAR,
                plancarrera_id VARCHAR,
                versionplan_id VARCHAR,
                materia_id VARCHAR,
                catedra_desc VARCHAR,
                comision_id VARCHAR,
                condicionregularidad_id VARCHAR,
                resultado_id VARCHAR,
                nota VARCHAR,
                porcentajeasistencia VARCHAR,
                tipomateria_id VARCHAR,
                acta VARCHAR,
                estadoacta_id VARCHAR,
                totalintentoscursada VARCHAR,
                nrointentocursada VARCHAR,
                cantidadregistroscursada VARCHAR,
                anioingresoua VARCHAR,
                cohorte VARCHAR,
                periodoinscripcioncarrera_desc VARCHAR
);
COMMENT ON TABLE guarani_tmp.gua_dsa_ft_cursado IS 'Cubo 02 rend acad v2';
COMMENT ON COLUMN guarani_tmp.gua_dsa_ft_cursado.tipoperiodo_id IS 'Es siempre (PL)';
COMMENT ON COLUMN guarani_tmp.gua_dsa_ft_cursado.tipomateria_id IS 'Indicación de si es una materia normal o se obtiene como materia común con otra carrera.';
COMMENT ON COLUMN guarani_tmp.gua_dsa_ft_cursado.totalintentoscursada IS 'Total de veces que ha intentado cursar la materia dentro de la carrera.';
COMMENT ON COLUMN guarani_tmp.gua_dsa_ft_cursado.nrointentocursada IS 'Número de vez que intenta cursar la materia dentro de la carrera.';
COMMENT ON COLUMN guarani_tmp.gua_dsa_ft_cursado.cantidadregistroscursada IS 'Cantidad de registros de cursada. Es siempre 1.';
COMMENT ON COLUMN guarani_tmp.gua_dsa_ft_cursado.anioingresoua IS 'Año de ingreso a la unidad académica.';
COMMENT ON COLUMN guarani_tmp.gua_dsa_ft_cursado.cohorte IS 'Año de ingreso a la carrera';
COMMENT ON COLUMN guarani_tmp.gua_dsa_ft_cursado.periodoinscripcioncarrera_desc IS 'Descripción del período de inscripción a la carrera.';


-- ----------------------------
-- guarani - creates dsa
-- ----------------------------

--Tablas cubo procedencia
CREATE TABLE guarani_dsa.gua_dsa_ids_lt_periodosinscripcion (
                periodoinscripcion_id INTEGER NOT NULL,
                periodoinscripcion_desc VARCHAR,
                anioacademico INTEGER,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP without time zone,
                CONSTRAINT gua_dsa_ids_lt_periodosinscripcion_pk PRIMARY KEY (periodoinscripcion_id)
);
CREATE TABLE guarani_dsa.gua_dsa_ids_lt_situacionesaspirantes (
                situacionaspirante_id INTEGER NOT NULL,
                situacionasp_id_gua VARCHAR,
                situacionasp_desc VARCHAR,
                resultadoasp_id_gua VARCHAR,
                resultadoasp_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP without time zone,
                CONSTRAINT gua_dsa_ids_lt_situacionesaspirantes_pk PRIMARY KEY (situacionaspirante_id)
);
CREATE TABLE guarani_dsa.gua_dsa_ids_ft_procedenciaaspirantes (
                unidadacademica_id INTEGER NOT NULL,
                periodoinscripcion_id INTEGER NOT NULL,
                carrera_id INTEGER NOT NULL,
                procedencia_id INTEGER NOT NULL,
                situacionaspirante_id INTEGER NOT NULL,
                sexo_id INTEGER NOT NULL,
                cantidad INTEGER NOT NULL
);

--Tablas cubo alumnos
CREATE TABLE guarani_dsa.gua_dsa_ids_lt_titulosaraucano (
                tituloaraucano_id INTEGER NOT NULL,
                tituloaraucano_id_gua VARCHAR ,
                tituloaraucano_desc VARCHAR,
				unidadacademica_id integer,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dsa_ids_lt_titulosaraucano_pk PRIMARY KEY (tituloaraucano_id)
);
COMMENT ON TABLE guarani_dsa.gua_dsa_ids_lt_titulosaraucano IS 'cubo 05';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_lt_titulosaraucano.tituloaraucano_id_gua IS 'clave subrogada';

CREATE TABLE guarani_dsa.gua_dsa_ids_lt_tipoingreso (
                tipoingreso_id INTEGER NOT NULL,
                tipoingreso_id_gua VARCHAR ,
                tipoingreso_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dsa_ids_lt_tipoingreso_pk PRIMARY KEY (tipoingreso_id)
);
COMMENT ON TABLE guarani_dsa.gua_dsa_ids_lt_tipoingreso IS 'cubo 05';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_lt_tipoingreso.tipoingreso_id_gua IS 'clave subrogada';

CREATE TABLE guarani_dsa.gua_dsa_ids_lt_horastrabajadas (
                horastrabajadas_id INTEGER NOT NULL,
                horastrabajadas_id_gua VARCHAR,
                horastrabajadas_desc VARCHAR,
			    horastrabajadas_grupo_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dsa_ids_lt_horastrabajadas_pk PRIMARY KEY (horastrabajadas_id)
);
COMMENT ON TABLE guarani_dsa.gua_dsa_ids_lt_horastrabajadas IS 'cubo 05';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_lt_horastrabajadas.horastrabajadas_id IS 'clave subrogada';

CREATE TABLE guarani_dsa.gua_dsa_ids_ft_alumnosarau (
                anioacademico INTEGER NOT NULL,
                unidadacademica_id INTEGER NOT NULL,
                carrera_id INTEGER NOT NULL,
                tituloaraucanocarrera_id INTEGER NOT NULL,
                sexo_id INTEGER NOT NULL,
                anioingresocarrera INTEGER NOT NULL,
                procedencia_id INTEGER NOT NULL,
                materiasrendidasanioanterior_id INTEGER NOT NULL,
                materiasaprobadasanioanterior_id INTEGER NOT NULL,
                totalmateriasrendidas_id INTEGER NOT NULL,
                totalmateriasaprobadas_id INTEGER NOT NULL,
                horastrabajadas_id INTEGER NOT NULL,
                tipoingreso_id INTEGER NOT NULL,
                edad_id INTEGER NOT NULL,
                procesoaraucanook_id INTEGER NOT NULL,
                nuevosinscriptos INTEGER NOT NULL,
                reinscriptos INTEGER NOT NULL,
                egresados INTEGER NOT NULL,
				totalalumnos integer DEFAULT 0 NOT NULL,
                legajo_id integer DEFAULT (-1) NOT NULL
);
COMMENT ON TABLE guarani_dsa.gua_dsa_ids_ft_alumnosarau IS 'Corresponde al cubo 05';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_alumnosarau.unidadacademica_id IS 'Clave subrogada que identifica a la unidad académica';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_alumnosarau.carrera_id IS 'clave subrogada para identificar a la carrera';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_alumnosarau.tituloaraucanocarrera_id IS 'clave subrogada que identifica al titulo araucano';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_alumnosarau.procedencia_id IS 'Reemplaza a colegio_id';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_alumnosarau.edad_id IS 'edad en el año académico considerado';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_alumnosarau.procesoaraucanook_id IS 'Indica si el proceso de generacion de datos para informar a SIU-Araucano fue exitoso para el/los registro/s considerado/s';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_alumnosarau.nuevosinscriptos IS 'cantidad de nuevos inscriptos';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_alumnosarau.reinscriptos IS 'cantidad de reinscriptos';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_alumnosarau.egresados IS 'cantidad de egresados';


CREATE TABLE guarani_dsa.gua_dsa_ids_lt_anioingresocarrera (
                anioingresocarrera INTEGER NOT NULL,
                CONSTRAINT gua_dsa_ids_lt_anioingresocarrera_pk PRIMARY KEY (anioingresocarrera)
);
COMMENT ON TABLE guarani_dsa.gua_dsa_ids_lt_anioingresocarrera IS 'cubo 05';

CREATE TABLE guarani_dsa.gua_dsa_ids_lt_edades (
                edad_id INTEGER NOT NULL,
                edad INTEGER,
                rangoedad_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dsa_ids_lt_edades_pk PRIMARY KEY (edad_id)
);
COMMENT ON TABLE guarani_dsa.gua_dsa_ids_lt_edades IS 'cubo 05';

CREATE TABLE guarani_dsa.gua_dsa_ids_lt_materiasrangos (
                materiasrangos_id INTEGER NOT NULL,
                cantmaterias INTEGER,
                rangoaprobanioant_desc VARCHAR,
                rangoaprobtotal_desc VARCHAR,
                rangorendanioant_desc VARCHAR,
                rangorendtotal_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua__dsa_ids_lt_materiasrangos_pk PRIMARY KEY (materiasrangos_id)
);
COMMENT ON TABLE guarani_dsa.gua_dsa_ids_lt_materiasrangos IS 'cubo 05';

CREATE TABLE guarani_dsa.gua_dsa_ids_lt_procesadook (
                procesadook_id INTEGER NOT NULL,         
                procesadook_desc VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dsa_ids_lt_procesadook_pk PRIMARY KEY (procesadook_id)
);

--Tablas cubo rend. academico
CREATE TABLE guarani_dsa.gua_dsa_ids_lt_origenequivalencia (
                origenequivalencia_id INTEGER NOT NULL,
                origenequivalencia_id_gua VARCHAR,
                origenequivalencia_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dsa_ids_lt_origenequivalencia_pk PRIMARY KEY (origenequivalencia_id)
);
CREATE TABLE guarani_dsa.gua_dsa_ids_lt_tiposperiodo (
                tipoperiodo_id INTEGER NOT NULL,
                tipoperiodo_id_gua VARCHAR ,
                tipoperiodo_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dsa_ids_lt_tiposperiodo_pk PRIMARY KEY (tipoperiodo_id)
);
CREATE TABLE guarani_dsa.gua_dsa_ids_lt_sedes (
                sede_id INTEGER NOT NULL,
                sede_id_gua VARCHAR,
                sede_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dsa_ids_lt_sedes_pk PRIMARY KEY (sede_id)
);
CREATE TABLE guarani_dsa.gua_dsa_ids_lt_resultados (
                resultado_id INTEGER NOT NULL,
                resultado_id_gua VARCHAR,
                resultado_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dsa_ids_lt_resultados_pk PRIMARY KEY (resultado_id)
);
CREATE TABLE guarani_dsa.gua_dsa_ids_lt_materiacomun (
                materiacomun_id INTEGER NOT NULL,
                materiacomun_id_gua VARCHAR,
                materiacomun_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dsa_ids_lt_materiacomun_pk PRIMARY KEY (materiacomun_id)
);
COMMENT ON TABLE guarani_dsa.gua_dsa_ids_lt_materiacomun IS 'Corresponde a LT_Materia_Comun.';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_lt_materiacomun.materiacomun_id IS 'Código que indica se es una materia normal o se obtiene como materia común con otra carrera. 0 / 1';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_lt_materiacomun.materiacomun_id_gua IS 'Código que indica se es una materia normal o se obtiene como materia común con otra carrera. 0 / 1';

CREATE TABLE guarani_dsa.gua_dsa_ids_lt_condicion (
                condicion_id INTEGER NOT NULL,
                condicion_id_gua VARCHAR,
                condicion_desc VARCHAR,
                tipocondicion_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dsa_ids_lt_condicion_pk PRIMARY KEY (condicion_id)
);

CREATE TABLE guarani_dsa.gua_dsa_ids_lt_alcanceequivalencia (
                alcanceequivalencia_id INTEGER NOT NULL,
                alcanceequivalencia_id_gua VARCHAR,
                alcanceequivalencia_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dsa_ids_lt_alcanceequivalencia_pk PRIMARY KEY (alcanceequivalencia_id)
);

CREATE TABLE guarani_dsa.gua_dsa_ids_lt_estadosacta (
                estadoacta_id INTEGER NOT NULL,
                estadoacta_id_gua VARCHAR,
                estadoacta_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dsa_ids_lt_estadosacta_pk PRIMARY KEY (estadoacta_id)
);

CREATE TABLE guarani_dsa.gua_dsa_ids_lt_materias (
                materia_id INTEGER NOT NULL,
                materia_id_gua VARCHAR,
                materia_desc VARCHAR,
                unidadacademica_id_gua VARCHAR,
				unidadacademica_id integer,
				descripcion_completa text,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dsa_ids_lt_materias_pk PRIMARY KEY (materia_id)
);

CREATE TABLE guarani_dsa.gua_dsa_ids_ft_cursado (
                unidadacademica_id INTEGER NOT NULL,
                sede_id INTEGER NOT NULL,
                anioacademico INTEGER NOT NULL,
                tipoperiodo_id INTEGER NOT NULL,
                periodolectivo_id INTEGER NOT NULL,
                ordenperiodoenanio INTEGER NOT NULL,
                legajo_id INTEGER NOT NULL,
                carrera_id INTEGER NOT NULL,
                plancarrera_id INTEGER NOT NULL,
                versionplan_id VARCHAR NOT NULL,
                materia_id INTEGER NOT NULL,
                comision_id VARCHAR NOT NULL,
                condicionregularidad_id INTEGER NOT NULL,
                resultado_id INTEGER NOT NULL,
                nota INTEGER NOT NULL,
                porcentajeasistencia NUMERIC(5,2) NOT NULL,
                materiacomun_id INTEGER NOT NULL,
                acta VARCHAR NOT NULL,
                estadoacta_id INTEGER NOT NULL,
                totalintentoscursada INTEGER NOT NULL,
                nrointentocursada INTEGER NOT NULL,
                cantidadregistroscursada INTEGER NOT NULL,
                anioingresoua INTEGER NOT NULL,
                cohorte INTEGER NOT NULL,
                periodoinsccarrera_id INTEGER,
                periodoinscripcioncarrera_desc VARCHAR NOT NULL,
				catedra_id integer DEFAULT 0 NOT NULL
);
COMMENT ON TABLE guarani_dsa.gua_dsa_ids_ft_cursado IS 'Cubo 02 rend acad v2';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_cursado.tipoperiodo_id IS 'Es siempre (PL)';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_cursado.periodolectivo_id IS 'PK de la dimensión lt_periodosanioacad';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_cursado.materiacomun_id IS 'Indicación de si es una materia normal o se obtiene como materia común con otra carrera.';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_cursado.totalintentoscursada IS 'Total de veces que ha intentado cursar la materia dentro de la carrera.';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_cursado.nrointentocursada IS 'Número de vez que intenta cursar la materia dentro de la carrera.';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_cursado.cantidadregistroscursada IS 'Cantidad de registros de cursada. Es siempre 1.';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_cursado.anioingresoua IS 'Año de ingreso a la unidad académica.';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_cursado.cohorte IS 'Año de ingreso a la carrera';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_cursado.periodoinsccarrera_id IS 'clave de la dimensión lt_periodoinsccarrera';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_cursado.periodoinscripcioncarrera_desc IS 'Descripción del período de inscripción a la carrera.';

CREATE TABLE guarani_dsa.gua_dsa_ids_ft_equivalencia (
                unidadacademica_id INTEGER NOT NULL,
                anioacademico INTEGER NOT NULL,
                tipoperiodo_id INTEGER NOT NULL,
                fechaequivalencia DATE NOT NULL,
                legajo_id INTEGER NOT NULL,
                carrera_id INTEGER NOT NULL,
                plancarrera_id INTEGER NOT NULL,
                versionplan_id VARCHAR NOT NULL,
                materia_id INTEGER NOT NULL,
                alcanceequivalencia_id INTEGER NOT NULL,
                resultado_id INTEGER NOT NULL,
                nota INTEGER NOT NULL,
                origenequivalencia_id INTEGER NOT NULL,
                equivalenciaguarani_id VARCHAR NOT NULL,
                tipomateria_id INTEGER NOT NULL,
                estadoacta_id INTEGER NOT NULL,
                condicionalumno_id INTEGER NOT NULL,
                cantidadregistrosexamen INTEGER NOT NULL,
                anioingresoua INTEGER NOT NULL,
                cohorte INTEGER NOT NULL,
                periodoinscripcioncarrera_desc VARCHAR NOT NULL,
				periodoinsccarrera_id INTEGER,
				periodo_id integer DEFAULT 0 NOT NULL
);
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_equivalencia.tipoperiodo_id IS 'Es siempre NP indicando que no está asociado a ningún período.';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_equivalencia.fechaequivalencia IS 'Fecha de otorgamiento de la equivalencia.';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_equivalencia.equivalenciaguarani_id IS 'Código con que queda registrada la equivalencia en el SIU-Guaraní';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_equivalencia.tipomateria_id IS 'Indicación de si es una materia normal o se obtiene como materia común con otra carrera. 0/1 (Indicando normal  / materia común respectivamente)';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_equivalencia.condicionalumno_id IS 'Código de condición del alumno. Es siempre E';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_equivalencia.cantidadregistrosexamen IS 'Es siempre 1';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_equivalencia.cohorte IS 'Año de ingreso a la carrera.';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_equivalencia.periodoinsccarrera_id IS 'clave de la dimensión lt_periodoinsccarrera';

CREATE TABLE guarani_dsa.gua_dsa_ids_ft_examen (
                unidadacademica_id INTEGER NOT NULL,
                sede_id INTEGER NOT NULL,
                anioacademico INTEGER NOT NULL,
                tipoperiodo_id INTEGER NOT NULL,
                turnoexamen_id INTEGER NOT NULL,
                mesaexamen_desc VARCHAR NOT NULL,
                fechaexamen DATE NOT NULL,
                legajo_id INTEGER NOT NULL,
                carrera_id INTEGER NOT NULL,
                plancarrera_id INTEGER NOT NULL,
                versionplan_id INTEGER NOT NULL,
                materia_id INTEGER NOT NULL,
                catedra_id INTEGER NOT NULL,
                resultado_id INTEGER NOT NULL,
                nota INTEGER NOT NULL,
                tipomateria_id INTEGER NOT NULL,
                tipoacta_id VARCHAR NOT NULL,
                acta VARCHAR NOT NULL,
                estadoacta_id INTEGER NOT NULL,
                condicionalumno_id INTEGER NOT NULL,
                totalintentosrendir INTEGER NOT NULL,
                nrointentorendir INTEGER NOT NULL,
                cantidadregistrosexamen INTEGER NOT NULL,
                anioingresoua INTEGER NOT NULL,
                cohorte INTEGER NOT NULL,
                periodoinscripcioncarrera_desc VARCHAR NOT NULL,
                periodoinsccarrera_id INTEGER
);
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_examen.turnoexamen_id IS 'PK de la dimension lt_periodosanioacad';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_examen.tipomateria_id IS 'Indicación de si es una materia normal o se obtiene como materia común con otra carrera. 0/1 (Indicando normal  / materia común respectivamente)';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_examen.totalintentosrendir IS 'Total de veces que ha intentado rendir la materia dentro de la carrera';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_examen.nrointentorendir IS 'Número de vez que intenta rendir la materia dentro de la carrera.';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_examen.cohorte IS 'Año de ingreso a la carrera.';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_ft_examen.periodoinsccarrera_id IS 'clave de la dimensión lt_periodoinsccarrera';

CREATE TABLE guarani_dsa.gua_dsa_ids_lt_planes (
                plan_id INTEGER NOT NULL,
                carrera_id_gua VARCHAR,
                plan_id_gua VARCHAR,
                plan_desc VARCHAR,
                planversion_id VARCHAR,
				unidadacademica_id_gua VARCHAR,
     		    carrera_id INTEGER ,
				carrera_desc VARCHAR,
				unidadacademica_id INTEGER,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dsa_ids_lt_planes_pk PRIMARY KEY (plan_id)
);
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_lt_planes.plan_desc IS 'Se copia el valor de plan_id ya que en las tablas de guaraní 2 no tiene un campo descripción para el plan.';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_lt_planes.carrera_id IS 'No se usa. Creado para permitir copia de dw a dsa';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_lt_planes.carrera_desc IS 'No se usa. Creado para permitir copia de dw a dsa';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_lt_planes.unidadacademica_id IS 'No se usa. Creado para permitir copia de dw a dsa';

CREATE TABLE guarani_dsa.gua_dsa_ids_lt_notas (
                nota_id INTEGER NOT NULL,
                nota_id_gua VARCHAR,
                nota_desc VARCHAR,
                resultado_id INTEGER,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dsa_ids_lt_notas_pk PRIMARY KEY (nota_id)
);
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_lt_notas.resultado_id IS 'PK a la dimensión lt_resultados';

CREATE TABLE guarani_dsa.gua_dsa_ids_lt_legajos (
                legajo_id INTEGER NOT NULL,
                legajo_id_gua VARCHAR,
                legajo_desc VARCHAR,
				agrupamiento_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dsa_ids_lt_legajos_pk PRIMARY KEY (legajo_id)
);

CREATE TABLE guarani_dsa.gua_dsa_ids_lt_comision (
                comision_id INTEGER NOT NULL,
                comision_desc VARCHAR,
                comision_id_gua VARCHAR,
                unidadacademica_id_gua VARCHAR,
                catedra_id INTEGER,
                materia_id INTEGER,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dsa_ids_lt_comision_pk PRIMARY KEY (comision_id)
);
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_lt_comision.materia_id IS 'id correspondiente a la dimension lt_materias';

CREATE TABLE guarani_dsa.gua_dsa_ids_lt_periodosinsccarrera (
                periodoinsccarrera_id INTEGER NOT NULL,
                anioingresocarrera_id_gua VARCHAR,
                periodoinsccarrera_id_gua VARCHAR,
                periodoinsccarrera_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dsa_ids_lt_periodosinsccarrera_pk PRIMARY KEY (periodoinsccarrera_id)
);
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_lt_periodosinsccarrera.anioingresocarrera_id_gua IS 'Corresponde a la cohorte';

CREATE TABLE guarani_dsa.gua_dsa_ids_lt_catedras (
                catedra_id INTEGER NOT NULL,
                catedra_id_gua VARCHAR,
                catedra_desc VARCHAR,
                materia_id integer,
                materia_id_gua VARCHAR,
                unidadacademica_id_gua VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dsa_ids_lt_catedras_pk PRIMARY KEY (catedra_id)
);
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_lt_catedras.materia_id IS 'id correspondiente a la dimension lt_materias';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_lt_catedras.materia_id_gua IS 'id correspondiente a la dimension lt_materias';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_lt_catedras.unidadacademica_id_gua IS 'id correspondiente a la dimension lt_materias';

CREATE TABLE guarani_dsa.gua_dsa_ids_lt_anioingresoua (
                anioingresoua_id INTEGER NOT NULL,
                anioingresoua_desc VARCHAR,
                CONSTRAINT gua_dsa_ids_lt_anioingresoua_pk PRIMARY KEY (anioingresoua_id)
);
COMMENT ON TABLE guarani_dsa.gua_dsa_ids_lt_anioingresoua IS 'cubo 02 v2';

CREATE TABLE guarani_dsa.gua_dsa_ids_lt_periodosanioacad (
                periodo_id INTEGER NOT NULL,
                periodo_desc VARCHAR,
                periodoordenanio VARCHAR,
                tipoperiodo_id INTEGER,
                anioacademico VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dsa_ids_lt_periodosanioacad_pk PRIMARY KEY (periodo_id)
);
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_lt_periodosanioacad.tipoperiodo_id IS 'PK de la dimensión lt_tiposperiodo';

CREATE TABLE guarani_dsa.gua_dsa_ids_lt_intentos (
                intento_id INTEGER NOT NULL,
                nrointento_id VARCHAR,
                totalintento_id INTEGER,
                primeravez VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dsa_ids_lt_intentos_pk PRIMARY KEY (intento_id)
);
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_lt_intentos.totalintento_id IS 'PK de la dimensión lt_totalintentos';
COMMENT ON COLUMN guarani_dsa.gua_dsa_ids_lt_intentos.primeravez IS 'Valores posibles: SI / NO';

CREATE TABLE guarani_dsa.gua_dsa_ids_lt_totalintentos (
                totalintento_id INTEGER NOT NULL,
                totalintento_id_gua VARCHAR,
                totalintento_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dsa_ids_lt_totalintentos_pk PRIMARY KEY (totalintento_id)
);

--tablas compartidas guarani
CREATE TABLE guarani_dsa.gua_dsa_ids_lt_unidadesacademicas (
                unidadacademica_id INTEGER NOT NULL,
                unidadacademica_id_gua VARCHAR,
                unidadacademica_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP without time zone,
                CONSTRAINT gua_dsa_ids_lt_unidadesacademicas_pk PRIMARY KEY (unidadacademica_id)
);
CREATE TABLE guarani_dsa.gua_dsa_ids_lt_carreras (
                carrera_id INTEGER NOT NULL,
                carrera_id_gua VARCHAR,
                carrera_desc VARCHAR,
                unidadacademica_id INTEGER,
                departamento_id_gua VARCHAR,
                departamento_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP without time zone,
                CONSTRAINT gua_dsa_ids_lt_carreras_pk PRIMARY KEY (carrera_id)
);
CREATE TABLE guarani_dsa.gua_dsa_ids_lt_sexos (
                sexo_id INTEGER NOT NULL,
                sexo_id_gua INTEGER,
                sexo_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP without time zone,
                CONSTRAINT gua_dsa_ids_lt_sexos_pk PRIMARY KEY (sexo_id)
);
CREATE TABLE guarani_dsa.gua_dsa_ids_lt_procedencia (
                procedencia_id INTEGER NOT NULL,
                colegio_id_gua INTEGER,
                colegio_desc VARCHAR,
                localidad_id_gua INTEGER,
                localidad_desc VARCHAR,
                provincia_id_gua INTEGER,
                provincia_desc VARCHAR,
                pais_id_gua INTEGER,
                pais_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP without time zone,
                CONSTRAINT gua_dsa_ids_lt_procedencia_pk PRIMARY KEY (procedencia_id)
);
CREATE TABLE guarani_dsa.gua_dsa_ids_lt_anioacademico (
                anioacademico INTEGER NOT NULL,
                CONSTRAINT gua_dsa_ids_lt_anioacademico_pk PRIMARY KEY (anioacademico)
);


-- ----------------------------
-- guarani - creates dw
-- ----------------------------

--Tablas cubo procedencia
CREATE TABLE guarani.gua_dw_lt_periodosinscripcion (
                periodoinscripcion_id INTEGER NOT NULL,
                periodoinscripcion_desc VARCHAR,
                anioacademico INTEGER,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP without time zone,
                CONSTRAINT gua_dw_lt_periodosinscripcion_pk PRIMARY KEY (periodoinscripcion_id)
);
CREATE TABLE guarani.gua_dw_lt_situacionesaspirantes (
                situacionaspirante_id INTEGER NOT NULL,
                situacionasp_id_gua VARCHAR,
                situacionasp_desc VARCHAR,
                resultadoasp_id_gua VARCHAR,
                resultadoasp_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP without time zone,
                CONSTRAINT gua_dw_lt_situacionesaspirantes_pk PRIMARY KEY (situacionaspirante_id)
);
CREATE TABLE guarani.gua_dw_ft_procedenciaaspirantes (
				id serial NOT NULL,
				importacion_id integer,
                unidadacademica_id INTEGER NOT NULL,
                periodoinscripcion_id INTEGER NOT NULL,
                carrera_id INTEGER NOT NULL,
                procedencia_id INTEGER NOT NULL,
                situacionaspirante_id INTEGER NOT NULL,
                sexo_id INTEGER NOT NULL,
                cantidad INTEGER NOT NULL,
                unidad_generica_id integer
);
CREATE INDEX idxp_ft_procedenciaaspirantes_unidadgenericaid ON guarani.gua_dw_ft_procedenciaaspirantes USING btree (unidad_generica_id);

--Tablas cubo alumnos
CREATE TABLE guarani.gua_dw_ft_alumnosarau (
				id serial NOT NULL,
				importacion_id integer,
                unidadacademica_id INTEGER NOT NULL,
                anioacademico INTEGER NOT NULL,
                carrera_id INTEGER NOT NULL,
                tituloaraucanocarrera_id INTEGER NOT NULL,
                sexo_id INTEGER NOT NULL,
                anioingresocarrera INTEGER NOT NULL,
                procedencia_id INTEGER NOT NULL,
                materiasrendidasanioanterior_id INTEGER NOT NULL,
                materiasaprobadasanioanterior_id INTEGER NOT NULL,
                totalmateriasrendidas_id INTEGER NOT NULL,
                totalmateriasaprobadas_id INTEGER NOT NULL,
                horastrabajadas_id INTEGER NOT NULL,
                tipoingreso_id INTEGER NOT NULL,
                edad_id INTEGER NOT NULL,
                procesoaraucanook_id INTEGER NOT NULL,
                nuevosinscriptos INTEGER NOT NULL,
                reinscriptos INTEGER NOT NULL,
                egresados INTEGER NOT NULL,
                unidad_generica_id integer,
				totalalumnos integer DEFAULT 0 NOT NULL,
	            legajo_id integer NOT NULL
);
COMMENT ON TABLE guarani.gua_dw_ft_alumnosarau IS 'Corresponde al cubo 05';
COMMENT ON COLUMN guarani.gua_dw_ft_alumnosarau.unidadacademica_id IS 'Clave subrogada que identifica a la unidad académica';
COMMENT ON COLUMN guarani.gua_dw_ft_alumnosarau.carrera_id IS 'clave subrogada para identificar a la carrera';
COMMENT ON COLUMN guarani.gua_dw_ft_alumnosarau.tituloaraucanocarrera_id IS 'clave subrogada que identifica al titulo araucano';
COMMENT ON COLUMN guarani.gua_dw_ft_alumnosarau.procedencia_id IS 'Reemplaza a colegio_id';
COMMENT ON COLUMN guarani.gua_dw_ft_alumnosarau.edad_id IS 'edad en el año académico considerado';
COMMENT ON COLUMN guarani.gua_dw_ft_alumnosarau.procesoaraucanook_id IS 'Indica si el proceso de generacion de datos para informar a SIU-Araucano fue exitoso para el/los registro/s considerado/s';
COMMENT ON COLUMN guarani.gua_dw_ft_alumnosarau.nuevosinscriptos IS 'cantidad de nuevos inscriptos';
COMMENT ON COLUMN guarani.gua_dw_ft_alumnosarau.reinscriptos IS 'cantidad de reinscriptos';
COMMENT ON COLUMN guarani.gua_dw_ft_alumnosarau.egresados IS 'cantidad de egresados';
CREATE INDEX idxp_ft_alumnosarau_unidadgenericaid ON guarani.gua_dw_ft_alumnosarau USING btree (unidad_generica_id);

CREATE TABLE guarani.gua_dw_lt_titulosaraucano (
                tituloaraucano_id INTEGER NOT NULL,
                tituloaraucano_id_gua VARCHAR ,
                tituloaraucano_desc VARCHAR,
				unidadacademica_id integer,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dw_lt_titulosaraucano_pk PRIMARY KEY (tituloaraucano_id)
);
COMMENT ON TABLE guarani.gua_dw_lt_titulosaraucano IS 'cubo 05';
COMMENT ON COLUMN guarani.gua_dw_lt_titulosaraucano.tituloaraucano_id_gua IS 'clave subrogada';

CREATE TABLE guarani.gua_dw_lt_tipoingreso (
                tipoingreso_id INTEGER NOT NULL,
                tipoingreso_id_gua VARCHAR ,
                tipoingreso_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dw_lt_tipoingreso_pk PRIMARY KEY (tipoingreso_id)
);
COMMENT ON TABLE guarani.gua_dw_lt_tipoingreso IS 'cubo 05';
COMMENT ON COLUMN guarani.gua_dw_lt_tipoingreso.tipoingreso_id_gua IS 'clave subrogada';

CREATE TABLE guarani.gua_dw_lt_horastrabajadas (
                horastrabajadas_id INTEGER NOT NULL,
                horastrabajadas_id_gua VARCHAR,
                horastrabajadas_desc VARCHAR,
			    horastrabajadas_grupo_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dw_lt_horastrabajadas_pk PRIMARY KEY (horastrabajadas_id)
);
COMMENT ON TABLE guarani.gua_dw_lt_horastrabajadas IS 'cubo 05';
COMMENT ON COLUMN guarani.gua_dw_lt_horastrabajadas.horastrabajadas_id IS 'clave subrogada';

CREATE TABLE guarani.gua_dw_lt_materiasrangos (
                materiasrangos_id INTEGER NOT NULL,
                cantmaterias INTEGER,
                rangoaprobanioant_desc VARCHAR,
                rangoaprobtotal_desc VARCHAR,
                rangorendanioant_desc VARCHAR,
                rangorendtotal_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dw_lt_materiasrangos_pk PRIMARY KEY (materiasrangos_id)
);
COMMENT ON TABLE guarani.gua_dw_lt_materiasrangos IS 'cubo 05';

CREATE TABLE guarani.gua_dw_lt_edades (
                edad_id INTEGER NOT NULL,
                edad INTEGER,
                rangoedad_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dw_lt_edades_pk PRIMARY KEY (edad_id)
);
COMMENT ON TABLE guarani.gua_dw_lt_edades IS 'cubo 05';

CREATE TABLE guarani.gua_dw_lt_procesadook (
                procesadook_id INTEGER NOT NULL,
                procesadook_desc VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dw_lt_procesadook_pk PRIMARY KEY (procesadook_id)
);

--Tablas cubo rend.academico
CREATE TABLE guarani.gua_dw_lt_condicion (
                condicion_id INTEGER NOT NULL,
                condicion_id_gua VARCHAR,
                condicion_desc VARCHAR,
                tipocondicion_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dw_lt_condicion_pk PRIMARY KEY (condicion_id)
);
COMMENT ON COLUMN guarani.gua_dw_lt_condicion.condicion_id_gua IS 'Código de condición del alumno utilizado para exámenes y equivalencias (E)';
COMMENT ON COLUMN guarani.gua_dw_lt_condicion.condicion_desc IS 'Descripción correspondiente a la condición del alumno para exámenes y caso de equivalencia.';

CREATE TABLE guarani.gua_dw_lt_tiposperiodo (
                tipoperiodo_id INTEGER NOT NULL,
                tipoperiodo_id_gua VARCHAR,
                tipoperiodo_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dw_lt_tiposperiodo_pk PRIMARY KEY (tipoperiodo_id)
);

CREATE TABLE guarani.gua_dw_lt_planes (
                plan_id INTEGER NOT NULL,
                carrera_id_gua VARCHAR,
                plan_id_gua VARCHAR,
                plan_desc VARCHAR,
                planversion_id VARCHAR,
                carrera_id INTEGER ,
				carrera_desc VARCHAR,
				unidadacademica_id INTEGER,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dw_lt_planes_pk PRIMARY KEY (plan_id)
);
COMMENT ON COLUMN guarani.gua_dw_lt_planes.plan_desc IS 'Se copia el valor de plan_id ya que en las tablas de guaraní 2 no tiene un campo descripción para el plan.';

CREATE TABLE guarani.gua_dw_lt_intentos (
                intento_id INTEGER NOT NULL,
                nrointento_id VARCHAR,
                totalintento_id INTEGER,
                primeravez VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dw_lt_intentos_pk PRIMARY KEY (intento_id)
);
COMMENT ON COLUMN guarani.gua_dw_lt_intentos.totalintento_id IS 'PK de la dimensión lt_totalintentos';
COMMENT ON COLUMN guarani.gua_dw_lt_intentos.primeravez IS 'Valores posibles: SI / NO';

CREATE TABLE guarani.gua_dw_lt_totalintentos (
                totalintento_id INTEGER NOT NULL,
                totalintento_id_gua VARCHAR,
                totalintento_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dw_lt_totalintentos_pk PRIMARY KEY (totalintento_id)
);
CREATE TABLE guarani.gua_dw_lt_notas (
                nota_id INTEGER NOT NULL,
                nota_id_gua VARCHAR,
                nota_desc VARCHAR,
                resultado_id INTEGER,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dw_lt_notas_pk PRIMARY KEY (nota_id)
);
COMMENT ON COLUMN guarani.gua_dw_lt_notas.resultado_id IS 'PK a la dimensión lt_notas';

CREATE TABLE guarani.gua_dw_ft_equivalencia (
				id serial NOT NULL,
				importacion_id integer,
                unidadacademica_id INTEGER NOT NULL,
                anioacademico INTEGER NOT NULL,
                tipoperiodo_id INTEGER NOT NULL,
                fechaequivalencia DATE NOT NULL,
                legajo_id INTEGER NOT NULL,
                carrera_id INTEGER NOT NULL,
                plancarrera_id INTEGER NOT NULL,
                versionplan_id VARCHAR NOT NULL,
                materia_id INTEGER NOT NULL,
                alcanceequivalencia_id INTEGER NOT NULL,
                resultado_id INTEGER NOT NULL,
                nota INTEGER NOT NULL,
                origenequivalencia_id INTEGER NOT NULL,
                equivalenciaguarani_id VARCHAR NOT NULL,
                tipomateria_id INTEGER NOT NULL,
                estadoacta_id INTEGER NOT NULL,
                condicionalumno_id INTEGER NOT NULL,
                cantidadregistrosexamen INTEGER NOT NULL,
                anioingresoua INTEGER NOT NULL,
                cohorte INTEGER NOT NULL,
                periodoinscripcioncarrera_desc VARCHAR NOT NULL,
                periodoinsccarrera_id INTEGER,
				periodo_id integer NOT NULL,
                unidad_generica_id integer
);
COMMENT ON COLUMN guarani.gua_dw_ft_equivalencia.tipoperiodo_id IS 'Es siempre NP indicando que no está asociado a ningún período.';
COMMENT ON COLUMN guarani.gua_dw_ft_equivalencia.fechaequivalencia IS 'Fecha de otorgamiento de la equivalencia.';
COMMENT ON COLUMN guarani.gua_dw_ft_equivalencia.equivalenciaguarani_id IS 'Código con que queda registrada la equivalencia en el SIU-Guaraní';
COMMENT ON COLUMN guarani.gua_dw_ft_equivalencia.tipomateria_id IS 'Indicación de si es una materia normal o se obtiene como materia común con otra carrera. 0/1 (Indicando normal  / materia común respectivamente)';
COMMENT ON COLUMN guarani.gua_dw_ft_equivalencia.condicionalumno_id IS 'Código de condición del alumno. Es siempre E';
COMMENT ON COLUMN guarani.gua_dw_ft_equivalencia.cantidadregistrosexamen IS 'Es siempre 1';
COMMENT ON COLUMN guarani.gua_dw_ft_equivalencia.cohorte IS 'Año de ingreso a la carrera.';
COMMENT ON COLUMN guarani.gua_dw_ft_equivalencia.periodoinsccarrera_id IS 'clave de la dimensión lt_periodoinsccarrera';
CREATE INDEX idxp_ft_equivalencia_unidadgenericaid ON guarani.gua_dw_ft_equivalencia USING btree (unidad_generica_id);

CREATE TABLE guarani.gua_dw_lt_legajos (
                legajo_id INTEGER NOT NULL,
                legajo_id_gua VARCHAR,
                legajo_desc VARCHAR,
				agrupamiento_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dw_lt_legajos_pk PRIMARY KEY (legajo_id)
);
CREATE TABLE guarani.gua_dw_lt_periodosanioacad (
                periodo_id INTEGER NOT NULL,
                periodo_desc VARCHAR,
                periodoordenanio VARCHAR,
                tipoperiodo_id INTEGER,
                anioacademico VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dw_lt_periodosanioacad_pk PRIMARY KEY (periodo_id)
);
COMMENT ON COLUMN guarani.gua_dw_lt_periodosanioacad.tipoperiodo_id IS 'PK de la dimensión lt_tiposperiodo';

CREATE TABLE guarani.gua_dw_lt_estadosacta (
                estadoacta_id INTEGER NOT NULL,
                estadoacta_id_gua VARCHAR ,
                estadoacta_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dw_lt_estadosacta_pk PRIMARY KEY (estadoacta_id)
);
CREATE TABLE guarani.gua_dw_lt_alcanceequivalencia (
                alcanceequivalencia_id INTEGER NOT NULL,
                alcanceequivalencia_id_gua VARCHAR ,
                alcanceequivalencia_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dw_lt_alcanceequivalencia_pk PRIMARY KEY (alcanceequivalencia_id)
);
CREATE TABLE guarani.gua_dw_ft_cursado (
				id serial NOT NULL,
				importacion_id integer,
                unidadacademica_id INTEGER NOT NULL,
                sede_id INTEGER NOT NULL,
                anioacademico INTEGER NOT NULL,
                tipoperiodo_id INTEGER NOT NULL,
                periodolectivo_id INTEGER NOT NULL,
                ordenperiodoenanio INTEGER NOT NULL,
                legajo_id INTEGER NOT NULL,
                carrera_id INTEGER NOT NULL,
                plancarrera_id INTEGER NOT NULL,
                versionplan_id VARCHAR NOT NULL,
                materia_id INTEGER NOT NULL,
                comision_id VARCHAR NOT NULL,
                condicionregularidad_id INTEGER NOT NULL,
                resultado_id INTEGER NOT NULL,
                nota INTEGER NOT NULL,
                porcentajeasistencia NUMERIC(5,2) NOT NULL,
                materiacomun_id INTEGER NOT NULL,
                acta VARCHAR NOT NULL,
                estadoacta_id INTEGER NOT NULL,
                totalintentoscursada INTEGER NOT NULL,
                nrointentocursada INTEGER NOT NULL,
                cantidadregistroscursada INTEGER NOT NULL,
                anioingresoua INTEGER NOT NULL,
                cohorte INTEGER NOT NULL,
                periodoinsccarrera_id INTEGER,
                periodoinscripcioncarrera_desc VARCHAR NOT NULL,
				catedra_id integer NOT NULL,
                unidad_generica_id integer
);
COMMENT ON TABLE guarani.gua_dw_ft_cursado IS 'Cubo 02 rend acad v2';
COMMENT ON COLUMN guarani.gua_dw_ft_cursado.tipoperiodo_id IS 'Es siempre (PL)';
COMMENT ON COLUMN guarani.gua_dw_ft_cursado.periodolectivo_id IS 'PK dimension lt_periodosanioacad';
COMMENT ON COLUMN guarani.gua_dw_ft_cursado.materiacomun_id IS 'Indicación de si es una materia normal o se obtiene como materia común con otra carrera.';
COMMENT ON COLUMN guarani.gua_dw_ft_cursado.totalintentoscursada IS 'Total de veces que ha intentado cursar la materia dentro de la carrera.';
COMMENT ON COLUMN guarani.gua_dw_ft_cursado.nrointentocursada IS 'Número de vez que intenta cursar la materia dentro de la carrera.';
COMMENT ON COLUMN guarani.gua_dw_ft_cursado.cantidadregistroscursada IS 'Cantidad de registros de cursada. Es siempre 1.';
COMMENT ON COLUMN guarani.gua_dw_ft_cursado.anioingresoua IS 'Año de ingreso a la unidad académica.';
COMMENT ON COLUMN guarani.gua_dw_ft_cursado.cohorte IS 'Año de ingreso a la carrera';
COMMENT ON COLUMN guarani.gua_dw_ft_cursado.periodoinsccarrera_id IS 'clave de la dimensión lt_periodoinsccarrera';
COMMENT ON COLUMN guarani.gua_dw_ft_cursado.periodoinscripcioncarrera_desc IS 'Descripción del período de inscripción a la carrera.';
CREATE INDEX idxp_ft_cursado_unidadgenericaid ON guarani.gua_dw_ft_cursado USING btree (unidad_generica_id);

CREATE TABLE guarani.gua_dw_lt_origenequivalencia (
                origenequivalencia_id INTEGER NOT NULL,
                origenequivalencia_id_gua VARCHAR ,
                origenequivalencia_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dw_lt_origenequivalencia_pk PRIMARY KEY (origenequivalencia_id)
);
CREATE TABLE guarani.gua_dw_lt_periodosinsccarrera (
                periodoinsccarrera_id INTEGER NOT NULL,
                anioingresocarrera_id_gua VARCHAR,
                periodoinsccarrera_id_gua VARCHAR,
                periodoinsccarrera_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dw_lt_periodosinsccarrera_pk PRIMARY KEY (periodoinsccarrera_id)
);
COMMENT ON COLUMN guarani.gua_dw_lt_periodosinsccarrera.anioingresocarrera_id_gua IS 'Corresponde a la cohorte';

CREATE TABLE guarani.gua_dw_lt_materiacomun (
                materiacomun_id INTEGER NOT NULL,
                materiacomun_id_gua VARCHAR,
                materiacomun_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dw_lt_materiacomun_pk PRIMARY KEY (materiacomun_id)
);
COMMENT ON TABLE guarani.gua_dw_lt_materiacomun IS 'Corresponde a LT_Materia_Comun.';
COMMENT ON COLUMN guarani.gua_dw_lt_materiacomun.materiacomun_id IS 'Código que indica se es una materia normal o se obtiene como materia común con otra carrera. 0 / 1';
COMMENT ON COLUMN guarani.gua_dw_lt_materiacomun.materiacomun_id_gua IS 'Código que indica se es una materia normal o se obtiene como materia común con otra carrera. 0 / 1';

CREATE TABLE guarani.gua_dw_lt_catedras (
                catedra_id INTEGER NOT NULL,
                catedra_id_gua VARCHAR,
                catedra_desc VARCHAR,
                materia_id INTEGER ,
                materia_id_gua VARCHAR,
                unidadacademica_id_gua VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dw_lt_catedras_pk PRIMARY KEY (catedra_id)
);
COMMENT ON COLUMN guarani.gua_dw_lt_catedras.materia_id IS 'id correspondiente a la dimension lt_materias';
COMMENT ON COLUMN guarani.gua_dw_lt_catedras.materia_id_gua IS 'id correspondiente a la dimension lt_materias';
COMMENT ON COLUMN guarani.gua_dw_lt_catedras.unidadacademica_id_gua IS 'id correspondiente a la dimension lt_materias';

CREATE TABLE guarani.gua_dw_lt_materias (
                materia_id INTEGER NOT NULL,
                materia_id_gua VARCHAR ,
                materia_desc VARCHAR,
                unidadacademica_id_gua VARCHAR ,
				unidadacademica_id integer,
				descripcion_completa text,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dw_lt_materias_pk PRIMARY KEY (materia_id)
);
CREATE TABLE guarani.gua_dw_lt_sedes (
                sede_id INTEGER NOT NULL,
                sede_id_gua VARCHAR,
                sede_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dw_lt_sedes_pk PRIMARY KEY (sede_id)
);
CREATE TABLE guarani.gua_dw_lt_resultados (
                resultado_id INTEGER NOT NULL,
                resultado_id_gua VARCHAR ,
                resultado_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dw_lt_resultados_pk PRIMARY KEY (resultado_id)
);
CREATE TABLE guarani.gua_dw_lt_comision (
                comision_id INTEGER NOT NULL,
                comision_desc VARCHAR,
                comision_id_gua VARCHAR,
                unidadacademica_id_gua VARCHAR,
                catedra_id INTEGER,
                materia_id INTEGER,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dw_lt_comision_pk PRIMARY KEY (comision_id)
);
COMMENT ON COLUMN guarani.gua_dw_lt_comision.materia_id IS 'id correspondiente a la dimension lt_materias';

CREATE TABLE guarani.gua_dw_ft_examen (
				id serial NOT NULL,
				importacion_id integer,
                unidadacademica_id INTEGER NOT NULL,
                sede_id INTEGER NOT NULL,
                anioacademico INTEGER NOT NULL,
                tipoperiodo_id INTEGER NOT NULL,
                turnoexamen_id INTEGER NOT NULL,
                mesaexamen_desc VARCHAR NOT NULL,
                fechaexamen DATE NOT NULL,
                legajo_id INTEGER NOT NULL,
                carrera_id INTEGER NOT NULL,
                plancarrera_id INTEGER NOT NULL,
                versionplan_id INTEGER NOT NULL,
                materia_id INTEGER NOT NULL,
                catedra_id INTEGER NOT NULL,
                resultado_id INTEGER NOT NULL,
                nota INTEGER NOT NULL,
                tipomateria_id INTEGER NOT NULL,
                tipoacta_id VARCHAR NOT NULL,
                acta VARCHAR NOT NULL,
                estadoacta_id INTEGER NOT NULL,
                condicionalumno_id INTEGER NOT NULL,
                totalintentosrendir INTEGER NOT NULL,
                nrointentorendir INTEGER NOT NULL,
                cantidadregistrosexamen INTEGER NOT NULL,
                anioingresoua INTEGER NOT NULL,
                cohorte INTEGER NOT NULL,
                periodoinscripcioncarrera_desc VARCHAR NOT NULL,
                periodoinsccarrera_id INTEGER,
                unidad_generica_id integer
);
COMMENT ON COLUMN guarani.gua_dw_ft_examen.turnoexamen_id IS 'FT dimension lt_periodosanioacad';
COMMENT ON COLUMN guarani.gua_dw_ft_examen.tipomateria_id IS 'Indicación de si es una materia normal o se obtiene como materia común con otra carrera. 0/1 (Indicando normal  / materia común respectivamente)';
COMMENT ON COLUMN guarani.gua_dw_ft_examen.totalintentosrendir IS 'Total de veces que ha intentado rendir la materia dentro de la carrera';
COMMENT ON COLUMN guarani.gua_dw_ft_examen.nrointentorendir IS 'Número de vez que intenta rendir la materia dentro de la carrera.';
COMMENT ON COLUMN guarani.gua_dw_ft_examen.cohorte IS 'Año de ingreso a la carrera.';
COMMENT ON COLUMN guarani.gua_dw_ft_examen.periodoinsccarrera_id IS 'clave de la dimensión lt_periodoinsccarrera';
CREATE INDEX idxp_ft_examen_unidadgenericaid ON guarani.gua_dw_ft_examen USING btree (unidad_generica_id);

--Tablas comunes guarani
CREATE TABLE guarani.gua_dw_lt_procedencia (
                procedencia_id INTEGER NOT NULL,
                colegio_id_gua INTEGER,
                colegio_desc VARCHAR,
                localidad_id_gua INTEGER,
                localidad_desc VARCHAR,
                provincia_id_gua INTEGER,
                provincia_desc VARCHAR,
                pais_id_gua INTEGER,
                pais_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dw_lt_procedencia_pk PRIMARY KEY (procedencia_id)
);
CREATE TABLE guarani.gua_dw_lt_unidadesacademicas (
                unidadacademica_id INTEGER NOT NULL,
                unidadacademica_id_gua VARCHAR,
                unidadacademica_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dw_lt_unidadesacademicas_pk PRIMARY KEY (unidadacademica_id)
);
CREATE TABLE guarani.gua_dw_lt_carreras (
                carrera_id INTEGER NOT NULL,
                carrera_id_gua VARCHAR,
                carrera_desc VARCHAR,
                unidadacademica_id INTEGER,
                departamento_id_gua VARCHAR,
                departamento_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dw_lt_carreras_pk PRIMARY KEY (carrera_id)
);
CREATE TABLE guarani.gua_dw_lt_sexos (
                sexo_id INTEGER NOT NULL,
                sexo_id_gua INTEGER,
                sexo_desc VARCHAR,
                fechadesde DATE,
                fechahasta DATE,
                version INTEGER,
                vigente VARCHAR,
                fechaact TIMESTAMP,
                CONSTRAINT gua_dw_lt_sexos_pk PRIMARY KEY (sexo_id)
);

CREATE VIEW guarani.gua_dw_vista_comisiones AS
	SELECT COALESCE((ltco.comision_id)::character varying, '-1'::character varying) AS comision_id
	, COALESCE(ltco.comision_desc, 'N/A'::character varying) AS comision_desc
	, COALESCE(ltca.catedra_id, (-1)) AS catedra_id
	, COALESCE(ltca.catedra_desc, 'Sin cátedra asociada'::character varying) AS catedra_desc
	, ltma.materia_id, ltma.descripcion_completa AS materia_desc
	, ltma.unidadacademica_id 
	, uni.unidadacademica_desc
	FROM ((guarani.gua_dw_lt_comision ltco 
		LEFT JOIN guarani.gua_dw_lt_catedras ltca ON ((((ltco.catedra_id = ltca.catedra_id) AND ((ltco.unidadacademica_id_gua)::text = (ltca.unidadacademica_id_gua)::text)) AND (ltco.materia_id = ltca.materia_id)))) 
		LEFT JOIN guarani.gua_dw_lt_materias ltma ON (((ltco.materia_id = ltma.materia_id) AND ((ltco.unidadacademica_id_gua)::text = (ltma.unidadacademica_id_gua)::text)))) 
		LEFT JOIN guarani.gua_dw_lt_unidadesacademicas uni ON uni.unidadacademica_id = ltma.unidadacademica_id
	WHERE (ltma.materia_id <> 0);

COMMENT ON VIEW guarani.gua_dw_vista_comisiones IS 'Comisión -> Materia -> Cátedra';

CREATE VIEW guarani.gua_dw_vista_catedra AS
	SELECT COALESCE(ltca.catedra_id, (-1)) AS catedra_id
	, COALESCE(ltca.catedra_desc, 'Sin cátedra asociada'::character varying) AS catedra_desc
	, ltma.materia_id, ltma.descripcion_completa AS materia_desc
	, ltua.unidadacademica_id
	, ltua.unidadacademica_desc 
	FROM ((guarani.gua_dw_lt_catedras ltca 
		LEFT JOIN guarani.gua_dw_lt_materias ltma ON ((((ltca.materia_id_gua)::text = (ltma.materia_id_gua)::text) AND ((ltca.unidadacademica_id_gua)::text = (ltma.unidadacademica_id_gua)::text)))) 
		LEFT JOIN guarani.gua_dw_lt_unidadesacademicas ltua ON (((ltca.unidadacademica_id_gua)::text = (ltua.unidadacademica_id_gua)::text))) 
	WHERE ((ltma.materia_id <> 0) AND (ltma.descripcion_completa <> '(-1) Sin Materia Asociada'::text)) 
	ORDER BY ltca.catedra_id;


-- ----------------------------
-- limpieza de temporales
-- ----------------------------

TRUNCATE TABLE araucano_dsa.academica_d_facultades;
TRUNCATE TABLE araucano_dsa.academica_d_generos;
TRUNCATE TABLE araucano_dsa.academica_d_mug_paises;
TRUNCATE TABLE araucano_dsa.academica_d_rda;
TRUNCATE TABLE araucano_dsa.academica_d_series;
TRUNCATE TABLE araucano_dsa.academica_d_subseriesopcion;
TRUNCATE TABLE araucano_dsa.academica_d_tipostitulos;
TRUNCATE TABLE araucano_dsa.academica_d_titulos;
TRUNCATE TABLE araucano_dsa.academica_ft_cuadro12;
TRUNCATE TABLE araucano_dsa.academica_ft_cuadro3;
TRUNCATE TABLE araucano_dsa.academica_ft_cuadro4;
TRUNCATE TABLE araucano_dsa.academica_ft_cuadro5;
TRUNCATE TABLE araucano_dsa.academica_ft_cuadro6;
TRUNCATE TABLE araucano_dsa.academica_ft_cuadro7;
TRUNCATE TABLE araucano_dsa.academica_ft_cuadro8;
TRUNCATE TABLE araucano_dsa.academica_ft_cuadros1y2;
TRUNCATE TABLE araucano_dsa.academica_ft_cuadros9y10;
TRUNCATE TABLE araucano_tmp.d_facultad;
TRUNCATE TABLE araucano_tmp.d_mug_paises;
TRUNCATE TABLE araucano_tmp.d_subserie;
TRUNCATE TABLE araucano_tmp.d_tipotitulo;
TRUNCATE TABLE araucano_tmp.d_titulo;
TRUNCATE TABLE araucano_tmp.ft_cuadros1y2;
TRUNCATE TABLE araucano_tmp.ft_totaldetallea;
TRUNCATE TABLE araucano_tmp.ft_totaldetalled_aye;
TRUNCATE TABLE araucano_tmp.ft_totaldetalled_aym;
TRUNCATE TABLE araucano_tmp.ft_totaldetalles_ae;
TRUNCATE TABLE araucano_tmp.ft_totaldetalles_ni;
TRUNCATE TABLE araucano_tmp.ft_totaldetalles_pma;
TRUNCATE TABLE araucano_tmp.ft_totaldetalles_tra;
TRUNCATE TABLE araucano_tmp.ft_totaldetalless_max;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_ft_liqconceptosxcargos;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_ft_lt_cargos;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_ft_lt_legajos;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_lt_activo;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_lt_agrupamiento;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_lt_antiguedad;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_lt_asociado;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_lt_categoriascargo;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_lt_conceptos;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_lt_dependenciadesemp;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_lt_dependenciadesig;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_lt_discapacidad;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_lt_estadocivil;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_lt_estadodelcargo;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_lt_hsdedicacion;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_lt_imppresupfuentes;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_lt_imppresupsubdependencia;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_lt_liquidaciones;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_lt_nivelestudios;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_lt_objetodelgasto;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_lt_persona;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_lt_personacargo;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_lt_porcreduchoraria;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_lt_porctrabajado;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_lt_rangoedades;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_lt_redprogramatica;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_lt_sede;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_lt_sexo;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_lt_sistprev;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_lt_subrogancia;
TRUNCATE TABLE mapuche_dsa.map_dsa_ids_lt_tipoplantacaracter;
TRUNCATE TABLE mapuche_tmp.map_dsa_ft_liqconceptosxcargos;
TRUNCATE TABLE mapuche_tmp.map_dsa_ft_lt_cargos;
TRUNCATE TABLE mapuche_tmp.map_dsa_ft_lt_legajos;
TRUNCATE TABLE mapuche_tmp.map_dsa_lt_activo;
TRUNCATE TABLE mapuche_tmp.map_dsa_lt_agrupamiento;
TRUNCATE TABLE mapuche_tmp.map_dsa_lt_asociado;
TRUNCATE TABLE mapuche_tmp.map_dsa_lt_caracter;
TRUNCATE TABLE mapuche_tmp.map_dsa_lt_categoriascargo;
TRUNCATE TABLE mapuche_tmp.map_dsa_lt_conceptos;
TRUNCATE TABLE mapuche_tmp.map_dsa_lt_conceptotipo;
TRUNCATE TABLE mapuche_tmp.map_dsa_lt_dedicacion;
TRUNCATE TABLE mapuche_tmp.map_dsa_lt_dependenciadesemp;
TRUNCATE TABLE mapuche_tmp.map_dsa_lt_dependenciadesig;
TRUNCATE TABLE mapuche_tmp.map_dsa_lt_discapacidad;
TRUNCATE TABLE mapuche_tmp.map_dsa_lt_escalafones;
TRUNCATE TABLE mapuche_tmp.map_dsa_lt_estadocivil;
TRUNCATE TABLE mapuche_tmp.map_dsa_lt_estadodelcargo;
TRUNCATE TABLE mapuche_tmp.map_dsa_lt_estadolaboral;
TRUNCATE TABLE mapuche_tmp.map_dsa_lt_imppresupdependencias;
TRUNCATE TABLE mapuche_tmp.map_dsa_lt_imppresupfuentes;
TRUNCATE TABLE mapuche_tmp.map_dsa_lt_imppresupsubdep;
TRUNCATE TABLE mapuche_tmp.map_dsa_lt_liquidaciones;
TRUNCATE TABLE mapuche_tmp.map_dsa_lt_nivelestudio;
TRUNCATE TABLE mapuche_tmp.map_dsa_lt_objgasto;
TRUNCATE TABLE mapuche_tmp.map_dsa_lt_redprogramatica;
TRUNCATE TABLE mapuche_tmp.map_dsa_lt_sedes;
TRUNCATE TABLE mapuche_tmp.map_dsa_lt_sexo;
TRUNCATE TABLE mapuche_tmp.map_dsa_lt_sistprev;
TRUNCATE TABLE mapuche_tmp.map_dsa_lt_subrogancia;
TRUNCATE TABLE mapuche_tmp.map_dsa_lt_tipoplanta;
TRUNCATE TABLE pilaga_dsa.d_banco_sucursal;
TRUNCATE TABLE pilaga_dsa.d_circuito_gestion;
TRUNCATE TABLE pilaga_dsa.d_codigo_economico;
TRUNCATE TABLE pilaga_dsa.d_comprobante;
TRUNCATE TABLE pilaga_dsa.d_concepto;
TRUNCATE TABLE pilaga_dsa.d_concepto_ingreso;
TRUNCATE TABLE pilaga_dsa.d_cuenta_bancaria;
TRUNCATE TABLE pilaga_dsa.d_cuenta_tesoreria;
TRUNCATE TABLE pilaga_dsa.d_documento_principal;
TRUNCATE TABLE pilaga_dsa.d_ejercicio;
TRUNCATE TABLE pilaga_dsa.d_estado_liquidacion;
TRUNCATE TABLE pilaga_dsa.d_etapa_presupuestaria;
TRUNCATE TABLE pilaga_dsa.d_expediente;
TRUNCATE TABLE pilaga_dsa.d_finalidad_funcion;
TRUNCATE TABLE pilaga_dsa.d_fondo;
TRUNCATE TABLE pilaga_dsa.d_fuente;
TRUNCATE TABLE pilaga_dsa.d_grupo_presupuestario;
TRUNCATE TABLE pilaga_dsa.d_medio_pago;
TRUNCATE TABLE pilaga_dsa.d_moneda;
TRUNCATE TABLE pilaga_dsa.d_objeto_del_gasto;
TRUNCATE TABLE pilaga_dsa.d_persona;
TRUNCATE TABLE pilaga_dsa.d_red_programatica;
TRUNCATE TABLE pilaga_dsa.d_rubro_ingreso;
TRUNCATE TABLE pilaga_dsa.d_tipo_comprobante;
TRUNCATE TABLE pilaga_dsa.d_tipo_documento;
TRUNCATE TABLE pilaga_dsa.d_tipo_operacion;
TRUNCATE TABLE pilaga_dsa.d_tipo_persona;
TRUNCATE TABLE pilaga_dsa.d_unidad_gestion;
TRUNCATE TABLE pilaga_dsa.d_unidad_presupuestaria;
TRUNCATE TABLE pilaga_dsa.ft_comprobantes;
TRUNCATE TABLE pilaga_dsa.ft_movimientos_gastos;
TRUNCATE TABLE pilaga_dsa.ft_movimientos_ingresos;
TRUNCATE TABLE pilaga_dsa.ft_tesorerias;
TRUNCATE TABLE pilaga_tmp.d_banco_sucursal;
TRUNCATE TABLE pilaga_tmp.d_circuito_gestion;
TRUNCATE TABLE pilaga_tmp.d_codigo_economico;
TRUNCATE TABLE pilaga_tmp.d_comprobante;
TRUNCATE TABLE pilaga_tmp.d_concepto;
TRUNCATE TABLE pilaga_tmp.d_concepto_ingreso;
TRUNCATE TABLE pilaga_tmp.d_cuenta_bancaria;
TRUNCATE TABLE pilaga_tmp.d_cuenta_tesoreria;
TRUNCATE TABLE pilaga_tmp.d_documento_principal;
TRUNCATE TABLE pilaga_tmp.d_ejercicio;
TRUNCATE TABLE pilaga_tmp.d_estado_liquidacion;
TRUNCATE TABLE pilaga_tmp.d_etapa_presupuestaria;
TRUNCATE TABLE pilaga_tmp.d_expediente;
TRUNCATE TABLE pilaga_tmp.d_finalidad_funcion;
TRUNCATE TABLE pilaga_tmp.d_fondo;
TRUNCATE TABLE pilaga_tmp.d_fuente;
TRUNCATE TABLE pilaga_tmp.d_grupo_presupuestario;
TRUNCATE TABLE pilaga_tmp.d_medio_pago;
TRUNCATE TABLE pilaga_tmp.d_moneda;
TRUNCATE TABLE pilaga_tmp.d_objeto_del_gasto;
TRUNCATE TABLE pilaga_tmp.d_persona;
TRUNCATE TABLE pilaga_tmp.d_red_programatica;
TRUNCATE TABLE pilaga_tmp.d_rubro_ingreso;
TRUNCATE TABLE pilaga_tmp.d_tipo_comprobante;
TRUNCATE TABLE pilaga_tmp.d_tipo_documento;
TRUNCATE TABLE pilaga_tmp.d_tipo_operacion;
TRUNCATE TABLE pilaga_tmp.d_tipo_persona;
TRUNCATE TABLE pilaga_tmp.d_unidad_gestion;
TRUNCATE TABLE pilaga_tmp.d_unidad_presupuestaria;
TRUNCATE TABLE pilaga_tmp.ft_comprobantes;
TRUNCATE TABLE pilaga_tmp.ft_movimientos_gastos;
TRUNCATE TABLE pilaga_tmp.ft_movimientos_ingresos;
TRUNCATE TABLE pilaga_tmp.ft_tesorerias;
TRUNCATE TABLE rhun_dsa.d_agrupamiento_no_docente;
TRUNCATE TABLE rhun_dsa.d_anios_de_antiguedad;
TRUNCATE TABLE rhun_dsa.d_antiguedad_docente;
TRUNCATE TABLE rhun_dsa.d_cargo_por_persona;
TRUNCATE TABLE rhun_dsa.d_categoria_conicet;
TRUNCATE TABLE rhun_dsa.d_categoria_incentivo;
TRUNCATE TABLE rhun_dsa.d_categoria_universidad;
TRUNCATE TABLE rhun_dsa.d_concepto;
TRUNCATE TABLE rhun_dsa.d_edad;
TRUNCATE TABLE rhun_dsa.d_equivalencia_cargo;
TRUNCATE TABLE rhun_dsa.d_escalafon;
TRUNCATE TABLE rhun_dsa.d_estado_cargo;
TRUNCATE TABLE rhun_dsa.d_estado_civil;
TRUNCATE TABLE rhun_dsa.d_estado_laboral;
TRUNCATE TABLE rhun_dsa.d_fuente_financiamiento;
TRUNCATE TABLE rhun_dsa.d_hora_dedicacion;
TRUNCATE TABLE rhun_dsa.d_nacionalidad;
TRUNCATE TABLE rhun_dsa.d_nivel_educacion;
TRUNCATE TABLE rhun_dsa.d_nivel_ensenianza;
TRUNCATE TABLE rhun_dsa.d_objeto_del_gasto;
TRUNCATE TABLE rhun_dsa.d_ona_jerarquia;
TRUNCATE TABLE rhun_dsa.d_ona_tipo_titulo;
TRUNCATE TABLE rhun_dsa.d_periodo_retroactivo;
TRUNCATE TABLE rhun_dsa.d_persona;
TRUNCATE TABLE rhun_dsa.d_sistema_previsional;
TRUNCATE TABLE rhun_dsa.d_situacion_laboral;
TRUNCATE TABLE rhun_dsa.d_tipo_cargo_asociado;
TRUNCATE TABLE rhun_dsa.d_tipo_grupo_concepto;
TRUNCATE TABLE rhun_dsa.d_tipo_planta;
TRUNCATE TABLE rhun_dsa.d_unidad_academica;
TRUNCATE TABLE rhun_dsa.ft_cargo_liquidado;
TRUNCATE TABLE rhun_dsa.ft_cargos_planta;
TRUNCATE TABLE rhun_dsa.ft_datos_personales_planta;
TRUNCATE TABLE rhun_dsa.ft_detalle_liquidacion_haberes;
TRUNCATE TABLE rhun_dsa.ft_detalle_liquidacion_haberes_por_grupo;
TRUNCATE TABLE rhun_tmp.ft_cargos_liq;
TRUNCATE TABLE rhun_tmp.ft_cargos_planta;
TRUNCATE TABLE rhun_tmp.ft_datos_personales_planta;
TRUNCATE TABLE rhun_tmp.ft_detalles_liquidaciones_haberes;
TRUNCATE TABLE rhun_tmp.ft_detalles_liquidaciones_haberes_por_grupos;
TRUNCATE TABLE rhun_tmp.lt_agrupamientos_nd;
TRUNCATE TABLE rhun_tmp.lt_categorias_univ;
TRUNCATE TABLE rhun_tmp.lt_conceptos_liq;
TRUNCATE TABLE rhun_tmp.lt_conicet;
TRUNCATE TABLE rhun_tmp.lt_datos_personales_liq;
TRUNCATE TABLE rhun_tmp.lt_equivalencias_cargos;
TRUNCATE TABLE rhun_tmp.lt_escalafones;
TRUNCATE TABLE rhun_tmp.lt_estados_cargos;
TRUNCATE TABLE rhun_tmp.lt_estados_civiles;
TRUNCATE TABLE rhun_tmp.lt_estados_laborales;
TRUNCATE TABLE rhun_tmp.lt_fuentes_financiamiento;
TRUNCATE TABLE rhun_tmp.lt_instituciones;
TRUNCATE TABLE rhun_tmp.lt_nacionalidades;
TRUNCATE TABLE rhun_tmp.lt_niveles_educacion;
TRUNCATE TABLE rhun_tmp.lt_niveles_ensenianza;
TRUNCATE TABLE rhun_tmp.lt_objeto_del_gasto;
TRUNCATE TABLE rhun_tmp.lt_ona_jerarquias;
TRUNCATE TABLE rhun_tmp.lt_ona_tipos_titulos;
TRUNCATE TABLE rhun_tmp.lt_ona_titulos;
TRUNCATE TABLE rhun_tmp.lt_ona_unidades_academicas;
TRUNCATE TABLE rhun_tmp.lt_rango_antiguedad;
TRUNCATE TABLE rhun_tmp.lt_rango_antiguedad_docente;
TRUNCATE TABLE rhun_tmp.lt_sexos;
TRUNCATE TABLE rhun_tmp.lt_sistema_previsional;
TRUNCATE TABLE rhun_tmp.lt_situaciones_laborales;
TRUNCATE TABLE rhun_tmp.lt_tipo_cargo_asociado;
TRUNCATE TABLE rhun_tmp.lt_tipos_conceptos;
TRUNCATE TABLE rhun_tmp.lt_tipos_grupos_conceptos;
TRUNCATE TABLE rhun_tmp.lt_tipos_planta;


-- ----------------------------
-- version
-- ----------------------------

INSERT INTO public.version ("version",descripcion,fechacarga) VALUES('051000','actualizada',now());

