-- Este script es parte de la migracion de SIU-Wichi 6.5.0 a 6.6.0

-- ----------------------------
-- version
-- ----------------------------

-- inserta nueva version
INSERT INTO public.version ("version",descripcion,fechacarga) VALUES('060600','actualizada',now());
