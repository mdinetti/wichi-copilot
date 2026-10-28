update ${esquema}.${tabla_ft} ft
set unidad_generica_id = coalesce(
    (select distinct unidad_generica_id
    from d_unidad u, ${esquema}.${tabla_dimension} dim
    where dim.${campo_dim_id} = ft.${campo_ft_id}
    and u.unidad_desc = dim.${campo_desc}
    and u.instalacion_id = dim.instalacion_id)
  , 0)
where ${forzar_ft}=1 or coalesce(ft.unidad_generica_id, 0) = 0;

