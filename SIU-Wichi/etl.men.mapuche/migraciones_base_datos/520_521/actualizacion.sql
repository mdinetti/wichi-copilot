-- --------------------------------
-- carga de categoria de incentivos
-- --------------------------------

INSERT INTO mapuche.d_categoria_incentivo (categoria_incentivo_id, categoria_incentivo_codigo, categoria_incentivo_desc, orden, fechadesde, fechahasta, version, vigente, fechaact) SELECT -1, '-1', 'VALOR ERRONEO', 97, '2013-11-22', '2199-12-31', 1, 'Y', '2013-11-22 06:43:03.292992'
    WHERE '-1' NOT IN (SELECT categoria_incentivo_codigo FROM mapuche.d_categoria_incentivo);

INSERT INTO mapuche.d_categoria_incentivo (categoria_incentivo_id, categoria_incentivo_codigo, categoria_incentivo_desc, orden, fechadesde, fechahasta, version, vigente, fechaact) SELECT 0, '0', 'VACIO/NULO', 98, '2013-11-22', '2199-12-31', 1, 'Y', '2013-11-22 06:43:03.292992'
    WHERE '0' NOT IN (SELECT categoria_incentivo_codigo FROM mapuche.d_categoria_incentivo);

INSERT INTO mapuche.d_categoria_incentivo (categoria_incentivo_id, categoria_incentivo_codigo, categoria_incentivo_desc, orden, fechadesde, fechahasta, version, vigente, fechaact) SELECT 10, '1', 'Categoria 1', 1, '2013-11-22', '2199-12-31', 1, 'Y', '2013-11-22 06:49:50.260176'
    WHERE '1' NOT IN (SELECT categoria_incentivo_codigo FROM mapuche.d_categoria_incentivo);

INSERT INTO mapuche.d_categoria_incentivo (categoria_incentivo_id, categoria_incentivo_codigo, categoria_incentivo_desc, orden, fechadesde, fechahasta, version, vigente, fechaact) SELECT 5, 'A', 'Categoria A', 2, '2013-11-22', '2199-12-31', 1, 'Y', '2013-11-22 06:49:50.260176'
    WHERE 'A' NOT IN (SELECT categoria_incentivo_codigo FROM mapuche.d_categoria_incentivo);

INSERT INTO mapuche.d_categoria_incentivo (categoria_incentivo_id, categoria_incentivo_codigo, categoria_incentivo_desc, orden, fechadesde, fechahasta, version, vigente, fechaact) SELECT 11, '2', 'Categoria 2', 3, '2013-11-22', '2199-12-31', 1, 'Y', '2013-11-22 06:49:50.260176'
    WHERE '2' NOT IN (SELECT categoria_incentivo_codigo FROM mapuche.d_categoria_incentivo);

INSERT INTO mapuche.d_categoria_incentivo (categoria_incentivo_id, categoria_incentivo_codigo, categoria_incentivo_desc, orden, fechadesde, fechahasta, version, vigente, fechaact) SELECT 9, 'B', 'Categoria B', 4, '2013-11-22', '2199-12-31', 1, 'Y', '2013-11-22 06:49:50.260176'
    WHERE 'B' NOT IN (SELECT categoria_incentivo_codigo FROM mapuche.d_categoria_incentivo);

INSERT INTO mapuche.d_categoria_incentivo (categoria_incentivo_id, categoria_incentivo_codigo, categoria_incentivo_desc, orden, fechadesde, fechahasta, version, vigente, fechaact) SELECT 8, '3', 'Categoria 3', 5, '2013-11-22', '2199-12-31', 1, 'Y', '2013-11-22 06:49:50.260176'
    WHERE '3' NOT IN (SELECT categoria_incentivo_codigo FROM mapuche.d_categoria_incentivo);

INSERT INTO mapuche.d_categoria_incentivo (categoria_incentivo_id, categoria_incentivo_codigo, categoria_incentivo_desc, orden, fechadesde, fechahasta, version, vigente, fechaact) SELECT 4, 'C', 'Categoria C', 6, '2013-11-22', '2199-12-31', 1, 'Y', '2013-11-22 06:49:50.260176'
    WHERE 'C' NOT IN (SELECT categoria_incentivo_codigo FROM mapuche.d_categoria_incentivo);

INSERT INTO mapuche.d_categoria_incentivo (categoria_incentivo_id, categoria_incentivo_codigo, categoria_incentivo_desc, orden, fechadesde, fechahasta, version, vigente, fechaact) SELECT 3, '4', 'Categoria 4', 7, '2013-11-22', '2199-12-31', 1, 'Y', '2013-11-22 06:49:50.260176'
    WHERE '4' NOT IN (SELECT categoria_incentivo_codigo FROM mapuche.d_categoria_incentivo);

INSERT INTO mapuche.d_categoria_incentivo (categoria_incentivo_id, categoria_incentivo_codigo, categoria_incentivo_desc, orden, fechadesde, fechahasta, version, vigente, fechaact) SELECT 7, 'D', 'Categoria D', 8, '2013-11-22', '2199-12-31', 1, 'Y', '2013-11-22 06:49:50.260176'
    WHERE 'D' NOT IN (SELECT categoria_incentivo_codigo FROM mapuche.d_categoria_incentivo);

INSERT INTO mapuche.d_categoria_incentivo (categoria_incentivo_id, categoria_incentivo_codigo, categoria_incentivo_desc, orden, fechadesde, fechahasta, version, vigente, fechaact) SELECT 6, '5', 'Categoria 5', 9, '2013-11-22', '2199-12-31', 1, 'Y', '2013-11-22 06:49:50.260176'
    WHERE '5' NOT IN (SELECT categoria_incentivo_codigo FROM mapuche.d_categoria_incentivo);

-- ----------------------------
-- version
-- ----------------------------

-- inserta nueva version
INSERT INTO public.version ("version",descripcion,fechacarga) VALUES('050201','actualizada',now());

