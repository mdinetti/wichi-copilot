-- Este script es parte de la migracion de SIU-Wichi 7.0.0 a 7.1.0

-- ----------------------------
-- version
-- ----------------------------

-- inserta nueva version
INSERT INTO public.version ("version",descripcion,fechacarga) VALUES('070100','actualizada',now());
