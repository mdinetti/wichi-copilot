-- Este script es parte de la migracion de SIU-Wichi 6.1.0 a 6.2.0.

-- ----------------------------
-- version
-- ----------------------------

-- inserta nueva version
INSERT INTO public.version ("version",descripcion,fechacarga) VALUES('060200','actualizada',now());
