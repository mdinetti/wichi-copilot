-- Este script es parte de la migracion de SIU-Wichi 6.2.0 a 6.3.0.

-- ----------------------------
-- version
-- ----------------------------

-- inserta nueva version
INSERT INTO public.version ("version",descripcion,fechacarga) VALUES('060300','actualizada',now());
