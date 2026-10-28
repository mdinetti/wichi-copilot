-- Este script es parte de la migracion de SIU-Wichi 6.8.0 a 6.8.1

-- ----------------------------
-- version
-- ----------------------------

-- inserta nueva version
INSERT INTO public.version ("version",descripcion,fechacarga) VALUES('060801','actualizada',now());
