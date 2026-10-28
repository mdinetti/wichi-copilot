-- Este script es parte de la migración de SIU-Wichi 5.6.0 a 6.0.0.

-- ----------------------------------
-- Mapuche
-- ----------------------------------
-- Cambia las descripciones de antiguedades que poseian apostrofes por error en los ETL y se los saca, 
-- quedando duplicadas con las que ya existen sin apostrofes, ejemplo Menos de 1 y 'Menos de 1',
-- en algun momento habria que pensar en unificar ambas pero hay que tener cuidado. 

UPDATE mapuche.map_dw_lt_antiguedad
SET rangoantiguedad_desc = trim(both '''' from rangoantiguedad_desc);

-- Se agrega la sede en el cubo de Cargos - Legajos.
DROP VIEW mapuche.v_ft_acreditaciones;
CREATE OR REPLACE VIEW mapuche.v_ft_acreditaciones AS 
 SELECT c.personacargo_id,
    c.periodoinfo,
    c.dependenciadesign_id,
    c.categoria_id,
    c.estadodelcargo_id,
    c.plantacarac_id,
    c.antiguedadescalafon_id,
    c.hsdedicacion_id,
    c.antiguedadliq_id,
    c.dependenciadesemp_id,
    c.cantcargosliq,
    c.cantcargosactivos,
    c.sede_id,
    cc.importenetocargo,
    cc.importebrutocargo,
    cc.importegastototalcargo,
    cc.importedescuentoscargo,
    cc.importeaportescargo,
    c.rango_neto_codigo,
    c.rango_bruto_codigo,
    per.legajo_id_map,
    pc.cargo_id_map,
    l.persona_id,
    l.nivelestudio_id,
    l.activo_id,
    l.sexo_id,
    l.edad_id,
    l.legajosliq,
    l.categoria_incentivo_id,
    cc.imppresupfuente_id,
    cc.imppresupcodunicosujeto_id AS imppresupsubdependencia_id,
    c.unidad_generica_id
   FROM mapuche.map_dw_ft_lt_cargos c,
    mapuche.map_dw_ft_lt_legajos l,
    mapuche.map_dw_lt_personacargo pc,
    mapuche.map_dw_ft_liqconceptosxcargos cc,
    mapuche.map_dw_lt_persona per
  WHERE c.personacargo_id = pc.personacargo_id AND pc.persona_id = l.persona_id AND per.persona_id = pc.persona_id AND c.periodoinfo = l.periodoinfo AND c.personacargo_id = cc.personacargo_id AND c.periodoinfo = cc.periodoinfo;


-- Se cambia el tipo de dato de cant_hs_dedicacion y horas de entero a decimal


ALTER TABLE mapuche.map_dw_lt_hsdedicacion ALTER COLUMN horas TYPE numeric(11,2);

ALTER TABLE mapuche_dsa.map_dsa_ids_lt_hsdedicacion ALTER COLUMN horas TYPE numeric(11,2);

ALTER TABLE mapuche_tmp.map_dsa_ft_lt_cargos ALTER COLUMN cant_hs_dedicacion TYPE numeric(11,2);

-- ----------------------------------
-- Guarani
-- ----------------------------------
-- Guarani 3: Agrega el legajo en la tabla temporal
DROP TABLE guarani_tmp.gua_dsa_ft_alumnosarau;
CREATE TABLE guarani_tmp.gua_dsa_ft_alumnosarau
(
  anioacademico integer NOT NULL,
  unidadacademica_id character varying,
  carrera_id character varying,
  tituloaraucanocarrera_id character varying,
  sexo_id integer,
  anioingresocarrera integer,
  colegiosecundario_id integer,
  materiasrendidasanioanterior integer,
  materiasaprobadasanioanterior integer,
  totalmateriasrendidas integer,
  totalmateriasaprobadas integer,
  horastrabajadas_id character varying,
  tipoingreso_id character varying,
  edad integer, -- edad en el año académico considerado
  procesoaraucanook character varying, -- Indica si el proceso de generacion de datos para informar a SIU-Araucano fue exitoso para el/los registro/s considerado/s
  nuevosinscriptos integer, -- cantidad de nuevos inscriptos
  reinscriptos integer, -- cantidad de reinscriptos
  egresados integer, -- cantidad de egresados
  legajo integer
)
WITH (
  OIDS=FALSE
);
ALTER TABLE guarani_tmp.gua_dsa_ft_alumnosarau
  OWNER TO postgres;
COMMENT ON TABLE guarani_tmp.gua_dsa_ft_alumnosarau
  IS 'Corresponde al cubo 05';
COMMENT ON COLUMN guarani_tmp.gua_dsa_ft_alumnosarau.edad IS 'edad en el año académico considerado';
COMMENT ON COLUMN guarani_tmp.gua_dsa_ft_alumnosarau.procesoaraucanook IS 'Indica si el proceso de generacion de datos para informar a SIU-Araucano fue exitoso para el/los registro/s considerado/s';
COMMENT ON COLUMN guarani_tmp.gua_dsa_ft_alumnosarau.nuevosinscriptos IS 'cantidad de nuevos inscriptos';
COMMENT ON COLUMN guarani_tmp.gua_dsa_ft_alumnosarau.reinscriptos IS 'cantidad de reinscriptos';
COMMENT ON COLUMN guarani_tmp.gua_dsa_ft_alumnosarau.egresados IS 'cantidad de egresados';

-- ----------------------------------
-- Pilaga
-- ----------------------------------
-- Por ticket #617
ALTER TABLE pilaga_tmp.d_fondo DROP CONSTRAINT pk_d_fondo;




