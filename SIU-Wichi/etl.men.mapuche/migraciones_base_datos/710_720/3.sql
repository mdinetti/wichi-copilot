-- Este script es parte de la migracion de SIU-Wichi 7.1.0 a 7.2.0

-- ----------------------------
-- version
-- ----------------------------

-- inserta nueva version
INSERT INTO public.version ("version",descripcion,fechacarga) VALUES('070200','actualizada',now());
