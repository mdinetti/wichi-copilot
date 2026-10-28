-- Este script es parte de la migracion de SIU-Wichi 6.7.0 a 6.8.0

-- ----------------------------
-- version
-- ----------------------------

-- inserta nueva version
INSERT INTO public.version ("version",descripcion,fechacarga) VALUES('060800','actualizada',now());
