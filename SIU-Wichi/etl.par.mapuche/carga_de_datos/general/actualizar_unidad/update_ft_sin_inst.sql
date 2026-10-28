update ${esquema}.${tabla_ft} ft
set unidad_generica_id = coalesce(
    (select distinct unidad_generica_id
    from d_unidad u, ${esquema}.${tabla_dimension} dim ,d_instalacion i
    where dim.${campo_dim_id} = ft.${campo_ft_id}
    and i.instalacion_id = u.instalacion_id
    and u.unidad_desc = dim.${campo_desc}
    and i.fuente_dato_id = ${sistema_fuente})
  , 0)
where ${forzar_ft}=1 or coalesce(ft.unidad_generica_id, 0) = 0;

