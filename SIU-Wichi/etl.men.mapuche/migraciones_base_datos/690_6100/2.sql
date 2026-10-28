-- Este script es parte de la migracion de SIU-Wichi 6.9.0 a 6.10.0

-- ----------------------------
-- version
-- ----------------------------

-- inserta nueva version
INSERT INTO public.version ("version",descripcion,fechacarga) VALUES('061000','actualizada',now());
