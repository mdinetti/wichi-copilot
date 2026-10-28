-- Este script es parte de la migracion de SIU-Wichi 6.6.1 a 6.7.0

-- ----------------------------
-- version
-- ----------------------------

-- inserta nueva version
INSERT INTO public.version ("version",descripcion,fechacarga) VALUES('060700','actualizada',now());
