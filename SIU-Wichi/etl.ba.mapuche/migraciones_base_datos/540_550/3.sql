-- Este script es parte de la migración de SIU-Wichi 5.4.0 a 5.5.0.

-- Completa instalacion_id en las tablas de dimensión
-- y en la tabla importacion.


-- -------------
-- importacion
-- -------------

update public.importacion set instalacion_id = null;

update public.importacion u
set instalacion_id = (
    select instalacion_id
    from public.d_instalacion i
    where i.fuente_dato_id = u.fuente_dato_id
)
where fuente_dato_id in (3,7,2,4,6);

--acá se podría actualizar importacion.instalacion_id
--para las importaciones de guarani2 existentes

update public.importacion
set instalacion_id = -1
where fuente_dato_id <=0
or instalacion_id is null;

-- ----------------------------------
-- pilaga
-- ----------------------------------

UPDATE pilaga.d_unidad_presupuestaria
  SET instalacion_id = (SELECT instalacion_id FROM public.d_instalacion WHERE fuente_dato_id=3);

-- ----------------------------------
-- mapuche
-- ----------------------------------

UPDATE mapuche.map_dw_lt_dependenciadesig
  SET instalacion_id = (SELECT instalacion_id FROM public.d_instalacion WHERE fuente_dato_id=2);

-- ----------------------------------
-- kolla
-- ----------------------------------
INSERT INTO kolla.d_encuesta (encuesta_id, instalacion_id, encuesta_codigo, encuesta_desc, habilitacion, encuesta_periodo, unidad_gestion_desc) 
     VALUES (-1, -1, -1, 'VALOR INVALIDO', '0', 'VALOR INVALIDO', 'VALOR INVALIDO');
INSERT INTO kolla.d_encuesta (encuesta_id, instalacion_id, encuesta_codigo, encuesta_desc, habilitacion, encuesta_periodo, unidad_gestion_desc) 
     VALUES (0, -1, -1, 'VACIO / NULO', '0', 'VACIO / NULO', 'VACIO / NULO');

INSERT INTO kolla.d_pregunta_respuesta (pregunta_respuesta_id, instalacion_id, pregunta_codigo, pregunta_desc, respuesta_codigo, respuesta_desc, respuesta_codigo_combinado)
VALUES (-1, -1, -1, 'PREGUNTA INVALIDA', -1, 'RESPUESTA INVALIDA', 'RINV');
INSERT INTO kolla.d_pregunta_respuesta (pregunta_respuesta_id, instalacion_id, pregunta_codigo, pregunta_desc, respuesta_codigo, respuesta_desc, respuesta_codigo_combinado)
VALUES (0, -1, -1, 'VACIO / NULO', -1, 'VACIO / NULO', 'RV/N');


-- ----------------------------------
-- diaguita
-- ----------------------------------

UPDATE diaguita.d_area
  SET instalacion_id = (SELECT instalacion_id FROM public.d_instalacion WHERE fuente_dato_id=7);


-- ----------------------------------
-- guarani
-- ----------------------------------

create temp table temp_unidadesacademicas
(like guarani.gua_dw_lt_unidadesacademicas);

insert into temp_unidadesacademicas (
    unidadacademica_id,
    unidadacademica_id_gua,
    unidadacademica_desc,
    fechadesde,
    fechahasta,
    version,
    vigente,
    fechaact,
    instalacion_id
)
select
    dim.unidadacademica_id,
    dim.unidadacademica_id_gua,
    dim.unidadacademica_desc,
    dim.fechadesde,
    dim.fechahasta,
    dim.version,
    dim.vigente,
    dim.fechaact,
    u.instalacion_id
from guarani.gua_dw_lt_unidadesacademicas dim
left join (
  public.d_unidad u
  inner join public.d_instalacion i on u.instalacion_id = i.instalacion_id
) on dim.unidadacademica_desc = u.unidad_desc
where i.fuente_dato_id = 1;

insert into temp_unidadesacademicas (
    unidadacademica_id,
    unidadacademica_id_gua,
    unidadacademica_desc,
    fechadesde,
    fechahasta,
    version,
    vigente,
    fechaact,
    instalacion_id
)
select
    dim.unidadacademica_id,
    dim.unidadacademica_id_gua,
    dim.unidadacademica_desc,
    dim.fechadesde,
    dim.fechahasta,
    dim.version,
    dim.vigente,
    dim.fechaact,
    -1
from guarani.gua_dw_lt_unidadesacademicas dim
where dim.unidadacademica_id <= 0;

delete from guarani.gua_dw_lt_unidadesacademicas;

insert into guarani.gua_dw_lt_unidadesacademicas
select * from temp_unidadesacademicas;

