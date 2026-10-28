-- Para que encuentre las tablas
SET search_path = public, pg_catalog;
﻿-- Borro datos de FT_Alumnos
DELETE FROM guarani.gua_dw_ft_alumnosarau WHERE importacion_id IN
(SELECT importacion_id from importacion
WHERE instalacion_id IN (SELECT instalacion_id  FROM d_instalacion  WHERE fuente_dato_id = 10));

-- Borro datos de FT_Cursado
DELETE FROM guarani.gua_dw_ft_cursado WHERE importacion_id IN
(SELECT importacion_id from importacion
WHERE instalacion_id IN (SELECT instalacion_id  FROM d_instalacion  WHERE fuente_dato_id = 10));

-- Borro datos de FT_Equivalencia
DELETE FROM guarani.gua_dw_ft_equivalencia WHERE importacion_id IN
(SELECT importacion_id from importacion
WHERE instalacion_id IN (SELECT instalacion_id  FROM d_instalacion  WHERE fuente_dato_id = 10));

-- Borro datos de FT_Examen
DELETE FROM guarani.gua_dw_ft_examen WHERE importacion_id IN
(SELECT importacion_id from importacion
WHERE instalacion_id IN (SELECT instalacion_id  FROM d_instalacion  WHERE fuente_dato_id = 10));

-- Borro datos de FT_Aspirantes
DELETE FROM guarani.gua_dw_ft_procedenciaaspirantes WHERE importacion_id IN
(SELECT importacion_id from importacion
WHERE instalacion_id IN (SELECT instalacion_id  FROM d_instalacion  WHERE fuente_dato_id = 10));

-- Borro datos de carreras correspondientes a unidades academicas de G3
DELETE FROM guarani.gua_dw_lt_carreras WHERE unidadacademica_id IN
(SELECT unidadacademica_id FROM guarani.gua_dw_lt_unidadesacademicas WHERE instalacion_id IN
(SELECT instalacion_id  FROM d_instalacion  WHERE fuente_dato_id = 10));

-- Borro datos de catedras correspondientes a unidades academicas de G3
DELETE FROM guarani.gua_dw_lt_catedras WHERE unidadacademica_id_gua IN
(SELECT unidadacademica_id_gua FROM guarani.gua_dw_lt_unidadesacademicas WHERE instalacion_id IN
(SELECT instalacion_id  FROM d_instalacion  WHERE fuente_dato_id = 10));

-- Borro datos de comisiones correspondientes a unidades academicas de G3
DELETE FROM guarani.gua_dw_lt_comision WHERE unidadacademica_id_gua IN
(SELECT unidadacademica_id_gua FROM guarani.gua_dw_lt_unidadesacademicas WHERE instalacion_id IN
(SELECT instalacion_id  FROM d_instalacion  WHERE fuente_dato_id = 10));

-- Borro datos de materias correspondientes a unidades academicas de G3
DELETE FROM guarani.gua_dw_lt_materias WHERE unidadacademica_id IN
(SELECT unidadacademica_id FROM guarani.gua_dw_lt_unidadesacademicas WHERE instalacion_id IN
(SELECT instalacion_id  FROM d_instalacion  WHERE fuente_dato_id = 10));

-- Borro datos de planes correspondientes a unidades academicas de G3
DELETE FROM guarani.gua_dw_lt_planes WHERE unidadacademica_id IN
(SELECT unidadacademica_id FROM guarani.gua_dw_lt_unidadesacademicas WHERE instalacion_id IN
(SELECT instalacion_id  FROM d_instalacion  WHERE fuente_dato_id = 10));

-- Borro datos de titulos correspondientes a unidades academicas de G3
DELETE FROM guarani.gua_dw_lt_titulosaraucano WHERE unidadacademica_id IN
(SELECT unidadacademica_id FROM guarani.gua_dw_lt_unidadesacademicas WHERE instalacion_id IN
(SELECT instalacion_id  FROM d_instalacion  WHERE fuente_dato_id = 10));

-- Borro datos correspondientes a unidades academicas de G3
DELETE FROM guarani.gua_dw_lt_unidadesacademicas WHERE instalacion_id IN
(SELECT instalacion_id  FROM d_instalacion  WHERE fuente_dato_id = 10);
