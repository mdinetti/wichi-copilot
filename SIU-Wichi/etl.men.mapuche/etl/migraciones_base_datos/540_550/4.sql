-- Este script es parte de la migración de SIU-Wichi 5.4.0 a 5.5.0.


-- ----------------------------------
-- instalaciones y estructura general
-- ----------------------------------

alter table public.importacion
  drop column fuente_dato_id,
  add CONSTRAINT d_importacion_instalacion_id_fkey FOREIGN KEY (instalacion_id)
      REFERENCES d_instalacion (instalacion_id)
      ON UPDATE NO ACTION ON DELETE NO ACTION;

alter table public.d_unidad
  alter column instalacion_id set not null,
  drop constraint d_unidad_fuente_dato_id_key,
  drop column fuente_dato_id,
  add CONSTRAINT d_unidad_fuente_dato_id_key UNIQUE (instalacion_id, unidad_desc);


-- ----------------------------
-- version
-- ----------------------------

-- inserta nueva version
INSERT INTO public.version ("version",descripcion,fechacarga) VALUES('050500','actualizada',now());

