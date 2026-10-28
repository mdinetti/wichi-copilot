INSERT INTO public.d_unidad (unidad_generica_id, instalacion_id, unidad_desc)
SELECT DISTINCT 0, ${instalacion_id}, ${campo_desc} FROM ${esquema}.${tabla_dimension} dim
WHERE (${instalacion_id}, ${campo_desc}) NOT IN (SELECT instalacion_id,unidad_desc FROM public.d_unidad);

