-- Este script es parte de la migracion de SIU-Wichi 5.5.0 a 5.6.0.

-- ----------------------------
-- version
-- ----------------------------

-- inserta nueva version
INSERT INTO public.version ("version",descripcion,fechacarga) VALUES('050600','actualizada',now());
