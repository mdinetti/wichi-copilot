-- Este script es parte de la migración de SIU-Wichi 5.4.0 a 5.5.0.
-- 
-- Carga la tabla de importaciones con el siguiente criterio:
-- * Una instalación para Pilagá si hay datos de Pilagá cargados
-- * Una instalación para Diaguita si hay datos de Diaguita cargados
-- * Una instalación para cada unidad académica de Guaraní de
--   la cual se registren importaciones finalizadas
-- Además completa instalacion_id en la tabla d_unidad
-- Carga la tabla parametro_instalacion con las instalaciones
-- que requieran completar los parámetros de conexión


-- -------------
-- d_instalacion
-- -------------

insert into public.d_instalacion
    (instalacion_desc, fuente_dato_id)
select distinct 
    (SELECT fuente_dato_desc FROM public.d_fuente_dato WHERE fuente_dato_id=1) || ' - ' || d.unidad_desc || ' (unidad_id=' || d.unidad_id || ')',
    1
from (
    select distinct importacion_id, unidadacademica_id
    from guarani.gua_dw_ft_alumnosarau
    union
    select distinct importacion_id, unidadacademica_id
    from guarani.gua_dw_ft_cursado
    union
    select distinct importacion_id, unidadacademica_id
    from guarani.gua_dw_ft_equivalencia
    union
    select distinct importacion_id, unidadacademica_id
    from guarani.gua_dw_ft_examen
) fts
inner join guarani.gua_dw_lt_unidadesacademicas gu on gu.unidadacademica_id = fts.unidadacademica_id
inner join public.importacion i on i.importacion_id = fts.importacion_id
inner join public.d_unidad d on d.unidad_desc = gu.unidadacademica_desc
WHERE d.fuente_dato_id = 1
  and i.estado = 'finalizada'
UNION SELECT (SELECT fuente_dato_desc FROM public.d_fuente_dato WHERE fuente_dato_id=3), 3
WHERE (SELECT count(*)>0 from pilaga.ft_movimientos)
UNION SELECT (SELECT fuente_dato_desc FROM public.d_fuente_dato WHERE fuente_dato_id=7), 7
WHERE (SELECT count(*)>0 from diaguita.ft_patrimonio)
UNION SELECT (SELECT fuente_dato_desc FROM public.d_fuente_dato WHERE fuente_dato_id=2), 2
WHERE (SELECT count(*)>0 FROM mapuche.map_dw_ft_lt_legajos)
UNION SELECT (SELECT fuente_dato_desc FROM public.d_fuente_dato WHERE fuente_dato_id=4), 4
WHERE (SELECT count(*)>0 FROM araucano.academica_ft_cuadros1y2)
UNION SELECT (SELECT fuente_dato_desc FROM public.d_fuente_dato WHERE fuente_dato_id=6), 6
WHERE (SELECT count(*)>0 FROM rhun.ft_cargo_liquidado);

-- -------------
-- d_unidad
-- -------------

update public.d_unidad u
set instalacion_id = (
    select instalacion_id
    from public.d_instalacion i
    where i.fuente_dato_id = u.fuente_dato_id
)
where fuente_dato_id in (3,7,2,4,6);

update public.d_unidad u
set instalacion_id = (
    select instalacion_id
    from public.d_instalacion i
    where i.instalacion_desc = 'SIU-Guarani - ' || u.unidad_desc || ' (unidad_id=' || u.unidad_id || ')'
    and i.fuente_dato_id = 1
)
where fuente_dato_id = 1;

update public.d_unidad
set instalacion_id = -1
where fuente_dato_id <=0
or instalacion_id is null;


-- -------------
-- parametro_instalacion
-- -------------

insert into parametro_instalacion (select instalacion_id, nombre.*
from d_instalacion
		cross join (select 'nombre' union select 'clave' union select 'usuario' union select 'host' union select 'puerto') as nombre
where fuente_dato_id = 3 OR fuente_dato_id = 7 OR fuente_dato_id = 9 OR fuente_dato_id = 10
order by 1,2);
