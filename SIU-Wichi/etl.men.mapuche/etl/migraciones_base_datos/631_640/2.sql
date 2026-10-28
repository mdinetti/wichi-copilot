-- Este script es parte de la migracion de SIU-Wichi 6.3.1 a 6.4.0.

-- ----------------------------
-- version
-- ----------------------------

-- inserta nueva version
INSERT INTO public.version ("version",descripcion,fechacarga) VALUES('060400','actualizada',now());
