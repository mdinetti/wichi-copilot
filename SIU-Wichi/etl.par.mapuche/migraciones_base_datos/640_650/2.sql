-- Este script es parte de la migracion de SIU-Wichi 6.4.0 a 6.5.0

-- ----------------------------
-- version
-- ----------------------------

-- inserta nueva version
INSERT INTO public.version ("version",descripcion,fechacarga) VALUES('060500','actualizada',now());
