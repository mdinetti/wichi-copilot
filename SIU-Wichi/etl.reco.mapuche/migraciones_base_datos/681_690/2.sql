-- Este script es parte de la migracion de SIU-Wichi 6.8.1 a 6.9.0

-- ----------------------------
-- version
-- ----------------------------

-- inserta nueva version
INSERT INTO public.version ("version",descripcion,fechacarga) VALUES('060900','actualizada',now());
