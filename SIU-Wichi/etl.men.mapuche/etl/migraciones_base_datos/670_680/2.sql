-- Este script es parte de la migracion de SIU-Wichi 6.7.0 a 6.8.0
-- Correr solo en el caso de tener datos de mapuche, sino pasar al 3.sql

-- ---------------------------------------------
-- migracion de datos mapuche de 6.7.0 a 6.8.0
-- ---------------------------------------------

INSERT INTO mapuche_nuevo.d_activo(activo_id, activo_codigo, activo_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
SELECT activo_id, activo_id_map, activo_desc, fechadesde, fechahasta, version, vigente, fechaact
FROM mapuche.map_dw_lt_activo;
INSERT INTO mapuche_nuevo.d_activo(activo_id, activo_codigo, activo_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
VALUES (0,'-2','VACIO/NULO','1900-01-01','2199-12-31',1,'Y',current_date);
UPDATE mapuche_nuevo.d_activo SET activo_desc = 'VALOR ERRONEO' WHERE activo_codigo = '-1';


INSERT INTO mapuche_nuevo.d_agrupamiento(agrupamiento_id, agrupamiento_codigo, agrupamiento_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
SELECT agrupamiento_id, agrupamiento_id_map, agrupamiento_desc, fechadesde, fechahasta, version, vigente, fechaact
  FROM mapuche.map_dw_lt_agrupamiento;
INSERT INTO mapuche_nuevo.d_agrupamiento(agrupamiento_id, agrupamiento_codigo, agrupamiento_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
   VALUES (0,'0','VACIO/NULO','1900-01-01','2199-12-31',1,'Y',current_date);
UPDATE mapuche_nuevo.d_agrupamiento SET agrupamiento_desc='VALOR ERRONEO' WHERE agrupamiento_codigo= '-1';


INSERT INTO mapuche_nuevo.d_antiguedad(antiguedad_id, rangoantiguedad_desc, anios, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
SELECT antiguedad_id, rangoantiguedad_desc, anios, fechadesde, fechahasta, version, vigente, fechaact
  FROM mapuche.map_dw_lt_antiguedad;
INSERT INTO mapuche_nuevo.d_antiguedad(antiguedad_id, rangoantiguedad_desc, anios, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
VALUES (0,'VACIO/NULO','-2','1900-01-01','2199-12-31',1,'Y',current_date);
UPDATE mapuche_nuevo.d_antiguedad SET rangoantiguedad_desc = 'VALOR ERRONEO' WHERE anios= '-1';

INSERT INTO mapuche_nuevo.d_asociado(asociado_id, asociado_codigo, asociado_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
SELECT asociado_id, asociado_id_map, asociado_desc, fechadesde, fechahasta, version, vigente, fechaact
  FROM mapuche.map_dw_lt_asociado;
INSERT INTO mapuche_nuevo.d_asociado(asociado_id, asociado_codigo, asociado_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
VALUES (0,'-2','VACIO/NULO','1900-01-01','2199-12-31',1,'Y',current_date);
UPDATE mapuche_nuevo.d_asociado SET asociado_desc = 'VALOR ERRONEO' WHERE asociado_codigo = '-1';


INSERT INTO mapuche_nuevo.d_categoriascargo(categoria_id, categoria_codigo, categoria_desc, escalafon_codigo, escalafon_desc, dedicacion_codigo, dedicacion_desc, estadolaboral_codigo, 
estadolaboral_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
SELECT categoria_id, categoria_id_map,  trim(rtrim(categoria_desc, '('||categoria_id_map||')')) as categoria_desc, escalafon_id_map, escalafon_desc, dedicacion_id_map, trim(rtrim(dedicacion_desc, '('||dedicacion_id_map||')')) as dedicacion_desc, estadolaboral_id_map, 
       estadolaboral_desc, fechadesde, fechahasta, version, vigente, fechaact
  FROM mapuche.map_dw_lt_categoriascargo;
INSERT INTO mapuche_nuevo.d_categoriascargo(categoria_id, categoria_codigo, categoria_desc, escalafon_codigo, escalafon_desc, dedicacion_codigo, dedicacion_desc, estadolaboral_codigo, 
estadolaboral_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
   VALUES (0,'0','VACIO/NULO','0','VACIO/NULO','0','VACIO/NULO','0','VACIO/NULO','1900-01-01','2199-12-31',1,'Y',current_date);
UPDATE mapuche_nuevo.d_categoriascargo SET (categoria_desc,escalafon_desc,dedicacion_desc,estadolaboral_desc)=('VALOR ERRONEO','VALOR ERRONEO','VALOR ERRONEO','VALOR ERRONEO') WHERE categoria_codigo= '-1';


INSERT INTO mapuche_nuevo.d_concepto(concepto_id, concepto_codigo, concepto_desc, conceptotipo_codigo, conceptotipo_desc, fecha_desde, fecha_hasta, version, vigente, 
            fecha_actualizacion)
SELECT concepto_id, concepto_id_map, concepto_desc, conceptotipo_id_map, conceptotipo_desc, fechadesde, fechahasta, version, vigente, fechaact
  FROM mapuche.map_dw_lt_conceptos;
INSERT INTO mapuche_nuevo.d_concepto(concepto_id, concepto_codigo, concepto_desc, conceptotipo_codigo, conceptotipo_desc, fecha_desde, fecha_hasta, version, vigente, 
            fecha_actualizacion)
VALUES (0,'0','VACIO/NULO','0','VACIO/NULO','1900-01-01','2199-12-31',1,'Y',current_date);
UPDATE mapuche_nuevo.d_concepto SET (concepto_desc,conceptotipo_desc) = ('VALOR ERRONEO','VALOR ERRONEO') WHERE concepto_codigo = '-1';


INSERT INTO mapuche_nuevo.d_condicion(condicion_id, condicion_codigo, condicion_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
    VALUES (1, '1', 'Legajos con Cargos Liquidados', '1900-01-01','2199-12-31',1,'Y',current_date);
INSERT INTO mapuche_nuevo.d_condicion(condicion_id, condicion_codigo, condicion_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
    VALUES (2, '2', 'Cargos Sin Liquidar', '1900-01-01','2199-12-31',1,'Y',current_date);
INSERT INTO mapuche_nuevo.d_condicion(condicion_id, condicion_codigo, condicion_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
    VALUES (3, '3', 'Legajos Sin Liquidar', '1900-01-01','2199-12-31',1,'Y',current_date);


INSERT INTO mapuche_nuevo.d_dedicacion_incentivo(dedicacion_incentivo_id, dedicacion_incentivo_codigo, dedicacion_incentivo_desc, 
            fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
    VALUES (0,'0','VACIO/NULO','1900-01-01','2199-12-31',1,'Y',current_date);
INSERT INTO mapuche_nuevo.d_dedicacion_incentivo(dedicacion_incentivo_id, dedicacion_incentivo_codigo, dedicacion_incentivo_desc, 
            fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
    VALUES (-1,'-1','VALOR ERRONEO','1900-01-01','2199-12-31',1,'Y',current_date);


INSERT INTO mapuche_nuevo.d_dependenciadesemp(dependenciadesemp_id, dependenciadesemp_codigo, dependenciadesemp_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
SELECT dependenciadesemp_id, dependenciadesemp_id_map, dependenciadesemp_desc, 
       fechadesde, fechahasta, version, vigente, fechaact
  FROM mapuche.map_dw_lt_dependenciadesemp;
INSERT INTO mapuche_nuevo.d_dependenciadesemp(dependenciadesemp_id, dependenciadesemp_codigo, dependenciadesemp_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
VALUES (0,'0','VACIO/NULO','1900-01-01','2199-12-31',1,'Y',current_date);
UPDATE mapuche_nuevo.d_dependenciadesemp SET dependenciadesemp_desc = 'VALOR ERRONEO' WHERE dependenciadesemp_codigo = '-1';


INSERT INTO mapuche_nuevo.d_dependenciadesig(dependenciadesign_id, dependenciadesign_codigo, dependenciadesign_desc, instalacion_id, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
SELECT dependenciadesign_id, dependenciadesign_id_map, dependenciadesign_desc,  instalacion_id, fechadesde, fechahasta, version, vigente, fechaact
  FROM mapuche.map_dw_lt_dependenciadesig;
INSERT INTO mapuche_nuevo.d_dependenciadesig(dependenciadesign_id, dependenciadesign_codigo, dependenciadesign_desc, instalacion_id, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
VALUES (0,'0','VACIO/NULO',0,'1900-01-01','2199-12-31',1,'Y',current_date);
UPDATE mapuche_nuevo.d_dependenciadesig SET dependenciadesign_desc = 'VALOR ERRONEO' WHERE dependenciadesign_codigo = '-1';


INSERT INTO mapuche_nuevo.d_discapacidad(discapacidad_id, discapacidad_codigo, discapacidad_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
SELECT discapacidad_id, discapacidad_id_map, discapacidad_desc, fechadesde, fechahasta, version, vigente, fechaact
  FROM mapuche.map_dw_lt_discapacidad;
INSERT INTO mapuche_nuevo.d_discapacidad(discapacidad_id, discapacidad_codigo, discapacidad_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
VALUES (0,'-2','VACIO/NULO','1900-01-01','2199-12-31',1,'Y',current_date);
UPDATE mapuche_nuevo.d_discapacidad SET discapacidad_desc = 'VALOR ERRONEO' WHERE discapacidad_codigo = '-1';


INSERT INTO mapuche_nuevo.d_estadocivil(estadocivil_id, estadocivil_codigo, estadocivil_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
SELECT estadocivil_id, estadocivil_id_map, estadocivil_desc, fechadesde, fechahasta, version, vigente, fechaact
  FROM mapuche.map_dw_lt_estadocivil;
INSERT INTO mapuche_nuevo.d_estadocivil(estadocivil_id, estadocivil_codigo, estadocivil_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
VALUES (0,'0','VACIO/NULO','1900-01-01','2199-12-31',1,'Y',current_date);
UPDATE mapuche_nuevo.d_estadocivil SET estadocivil_desc = 'VALOR ERRONEO' WHERE estadocivil_codigo = '-1';


INSERT INTO mapuche_nuevo.d_estadodelcargo(estadodelcargo_id, estadodelcargo_codigo, estadodelcargo_desc, cargoactivo_codigo, cargoactivo_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
SELECT estadodelcargo_id, estadodelcargo_id_map, estadodelcargo_desc, cargoactivo_id_map, cargoactivo_desc, fechadesde, fechahasta, version, vigente, fechaact
  FROM mapuche.map_dw_lt_estadodelcargo;
INSERT INTO mapuche_nuevo.d_estadodelcargo(estadodelcargo_id, estadodelcargo_codigo, estadodelcargo_desc, cargoactivo_codigo, cargoactivo_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
VALUES (0,'-2','VACIO/NULO','-2','VACIO/NULO','1900-01-01','2199-12-31',1,'Y',current_date);
UPDATE mapuche_nuevo.d_estadodelcargo SET (estadodelcargo_desc,cargoactivo_desc) = ('VALOR ERRONEO','VALOR ERRONEO') WHERE estadodelcargo_codigo = '-1';


INSERT INTO mapuche_nuevo.d_finalidad_funcion(finalidad_funcion_id, finalidad_codigo, finalidad_desc, funcion_codigo, funcion_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
    VALUES (0,'0','VACIO/NULO','0','VACIO/NULO','1900-01-01','2199-12-31',1,'Y',current_date);
INSERT INTO mapuche_nuevo.d_finalidad_funcion(finalidad_funcion_id, finalidad_codigo, finalidad_desc, funcion_codigo, funcion_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
    VALUES (-1,'-1','VALOR ERRONEO','-1','VALOR ERRONEO','1900-01-01','2199-12-31',1,'Y',current_date);


INSERT INTO mapuche_nuevo.d_grupo_presupuestario(grupo_presupuestario_id, grupo_presupuestario_codigo, grupo_presupuestario_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
    VALUES (0,'0','VACIO/NULO','1900-01-01','2199-12-31',1,'Y',current_date);
INSERT INTO mapuche_nuevo.d_grupo_presupuestario(grupo_presupuestario_id, grupo_presupuestario_codigo, grupo_presupuestario_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
    VALUES (-1,'-1','VALOR ERRONEO','1900-01-01','2199-12-31',1,'Y',current_date);


INSERT INTO mapuche_nuevo.d_hsdedicacion(hsdedicacion_id, horas, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
SELECT hsdedicacion_id, horas, fechadesde, fechahasta, version, vigente,fechaact
  FROM mapuche.map_dw_lt_hsdedicacion;
INSERT INTO mapuche_nuevo.d_hsdedicacion( hsdedicacion_id, horas, fecha_desde, fecha_hasta, version, vigente,  fecha_actualizacion)
    VALUES (0, -2, '1900-01-01', '2199-12-31', 1, 'Y', current_date);


INSERT INTO mapuche_nuevo.d_imppresupfuente(imppresupfuente_id, imppresupfuente_codigo, imppresupfuente_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
SELECT imppresupfuente_id, imppresupfuente_id_map, imppresupfuente_desc, fechadesde, fechahasta, version, vigente, fechaact
  FROM mapuche.map_dw_lt_imppresupfuentes;
UPDATE mapuche_nuevo.d_imppresupfuente SET (imppresupfuente_desc,imppresupfuente_id) = ('VACIO/NULO',0) WHERE imppresupfuente_codigo = '0';
UPDATE mapuche_nuevo.d_imppresupfuente SET imppresupfuente_desc = 'VALOR ERRONEO' WHERE imppresupfuente_codigo = '-1';


INSERT INTO mapuche_nuevo.d_liquidacion(liquidacion_id, liquidacion_codigo, liquidacion_desc, es_cerrada, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
SELECT liquidacion_id, liquidacion_id_map, liquidacion_desc, 'Cerrada',fechadesde, fechahasta, version, vigente, fechaact
  FROM mapuche.map_dw_lt_liquidaciones;
INSERT INTO mapuche_nuevo.d_liquidacion(liquidacion_id, liquidacion_codigo, liquidacion_desc, es_cerrada, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
VALUES (0,'0','VACIO/NULO','VACIO/NULO','1900-01-01','2199-12-31',1,'Y',current_date);
UPDATE mapuche_nuevo.d_liquidacion  SET (liquidacion_desc,es_cerrada)= ('VALOR ERRONEO','VALOR ERRONEO')
 WHERE liquidacion_id= -1;


INSERT INTO mapuche_nuevo.d_nivelestudio(nivelestudio_id, nivelestudio_codigo, nivelestudio_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
SELECT nivelestudio_id, nivelestudio_id_map, nivelestudio_desc, fechadesde, fechahasta, version, vigente, fechaact
  FROM mapuche.map_dw_lt_nivelestudios;
INSERT INTO mapuche_nuevo.d_nivelestudio(nivelestudio_id, nivelestudio_codigo, nivelestudio_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
VALUES (0,'-2','VACIO/NULO','1900-01-01','2199-12-31',1,'Y',current_date);
UPDATE mapuche_nuevo.d_nivelestudio SET nivelestudio_desc = 'VALOR ERRONEO' WHERE nivelestudio_codigo = '-1';

INSERT INTO mapuche_nuevo.d_objetodelgasto(objetodelgasto_id, objetodelgasto_codigo, resumen_desc, inciso_desc, partidappal_desc, partidaparcial_desc, orden, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
SELECT objetodelgasto_id, objetodelgasto_id_map, resumen_desc, inciso_desc, partidappal_desc, partidaparcial_desc, orden, fechadesde, fechahasta, version, vigente, fechaact
  FROM mapuche.map_dw_lt_objetodelgasto;
INSERT INTO mapuche_nuevo.d_objetodelgasto(objetodelgasto_id, objetodelgasto_codigo, resumen_desc, inciso_desc, partidappal_desc, partidaparcial_desc, orden, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
VALUES (0,'0','VACIO/NULO','VACIO/NULO','VACIO/NULO','VACIO/NULO',0,'1900-01-01','2199-12-31',1,'Y',current_date);
UPDATE mapuche_nuevo.d_objetodelgasto  SET (resumen_desc,inciso_desc, partidappal_desc, partidaparcial_desc) = ('VALOR ERRONEO','VALOR ERRONEO','VALOR ERRONEO','VALOR ERRONEO')
 WHERE objetodelgasto_codigo='-1';


INSERT INTO mapuche_nuevo.d_periodo_retroactivo(periodo_retroactivo_id, periodo_retroactivo_codigo, anio_codigo, 
            anio_desc, mes_codigo, mes_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion, es_retroactivo)
    VALUES (-1, '-1', '-1', 'VALOR ERRONEO','-1', 'VALOR ERRONEO','1900-01-01','2199-12-31', 1, 'Y', current_date, 'VALOR ERRONEO');
INSERT INTO mapuche_nuevo.d_periodo_retroactivo(periodo_retroactivo_id, periodo_retroactivo_codigo, anio_codigo, 
            anio_desc, mes_codigo, mes_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion, es_retroactivo)
    VALUES (0,'0', '0', 'Normal', '0', 'Normal', '1900-01-01','2199-12-31', 1, 'Y', current_date,'Normal');


INSERT INTO mapuche_nuevo.d_persona(persona_id, legajo_codigo, cuil, apellido, nombre, apellidonombre_desc, fecha_nacimiento, correo_electronico, fecha_desde, fecha_hasta, 
version, vigente, fecha_actualizacion)
SELECT persona_id, legajo_id_map, cuil, apellido, nombre, apellidonombre_desc, fecha_nacimiento, '',fechadesde, fechahasta,  version, vigente, fechaact
  FROM mapuche.map_dw_lt_persona;
INSERT INTO mapuche_nuevo.d_persona(persona_id, legajo_codigo, cuil, apellido, nombre, apellidonombre_desc, fecha_nacimiento, correo_electronico, fecha_desde, fecha_hasta, 
version, vigente, fecha_actualizacion)
VALUES (0,'0','VACIO/NULO','VACIO/NULO','VACIO/NULO','VACIO/NULO',null,'','1900-01-01','2199-12-31',1,'Y',current_date);
UPDATE mapuche_nuevo.d_persona  SET (cuil, apellido, nombre, apellidonombre_desc)= ('VALOR ERRONEO','VALOR ERRONEO','VALOR ERRONEO','VALOR ERRONEO') WHERE legajo_codigo = '-1';


INSERT INTO mapuche_nuevo.d_porcreduchoraria(porcentaje_id, porcentaje_codigo, fecha_desde, fecha_hasta, version,vigente, fecha_actualizacion)
SELECT porcentaje_id, porcentaje_map, fechadesde, fechahasta, version, vigente, fechaact  FROM mapuche.map_dw_lt_porcreduchoraria;
INSERT INTO mapuche_nuevo.d_porcreduchoraria(porcentaje_id, porcentaje_codigo, fecha_desde, fecha_hasta, version,vigente, fecha_actualizacion)
    VALUES (0,'0','1900-01-01','2199-12-31',1,'Y',current_date);


INSERT INTO mapuche_nuevo.d_porctrabajado(porcentaje_id, porcentaje_codigo, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
SELECT porcentaje_id, porcentaje_map, fechadesde, fechahasta, version, vigente, fechaact  FROM mapuche.map_dw_lt_porctrabajado;
INSERT INTO mapuche_nuevo.d_porctrabajado(porcentaje_id, porcentaje_codigo, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
    VALUES (0,'0','1900-01-01','2199-12-31',1,'Y',current_date);


INSERT INTO mapuche_nuevo.d_rangoedad(edad_id, rangoedad_desc, edad, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
SELECT edad_id, rangoedad_desc, edad, fechadesde, fechahasta, version, vigente, fechaact
  FROM mapuche.map_dw_lt_rangoedades;
INSERT INTO mapuche_nuevo.d_rangoedad(edad_id, rangoedad_desc, edad, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
VALUES(0,'VACIO/NULO',0,'1900-01-01','2199-12-31',1,'Y',current_date);
UPDATE mapuche_nuevo.d_rangoedad SET rangoedad_desc = 'VALOR ERRONEO' WHERE edad = -1;


INSERT INTO mapuche_nuevo.d_redprogramatica(red_programatica_id, red_programatica_codigo, programa_desc,  subprograma_desc,  proyecto_desc,  actividad_desc,  
            obra_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
SELECT programa_id, programa_id_map, programa_desc, subprograma_desc, proyecto_desc, actividad_desc, obra_desc, fechadesde, fechahasta, version, vigente, fechaact
  FROM mapuche.map_dw_lt_redprogramatica;
UPDATE mapuche_nuevo.d_redprogramatica SET (programa_codigo,subprograma_codigo,proyecto_codigo,actividad_codigo, obra_codigo) = (substring(red_programatica_codigo from 1 for 2) , substring(red_programatica_codigo from 3 for 2) , substring(red_programatica_codigo from 5 for 2) , substring(red_programatica_codigo from 7 for 2) , substring(red_programatica_codigo from 9 for 2));
UPDATE mapuche_nuevo.d_redprogramatica SET (programa_codigo, programa_desc, subprograma_codigo, subprograma_desc, proyecto_codigo, proyecto_desc, actividad_codigo, actividad_desc, obra_codigo, obra_desc) = ('-1','VALOR ERRONEO','-1','VALOR ERRONEO','-1','VALOR ERRONEO','-1','VALOR ERRONEO','-1','VALOR ERRONEO') WHERE red_programatica_codigo = '-1';
INSERT INTO mapuche_nuevo.d_redprogramatica(red_programatica_id, red_programatica_codigo, programa_codigo, programa_desc, subprograma_codigo, subprograma_desc, proyecto_codigo, proyecto_desc, actividad_codigo, actividad_desc, obra_codigo, 
            obra_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
VALUES(0,'0','0','VACIO/NULO','0','VACIO/NULO','0','VACIO/NULO','0','VACIO/NULO','0','VACIO/NULO','1900-01-01','2199-12-31',1,'Y',current_date);


INSERT INTO mapuche_nuevo.d_regional(regional_id, regional_codigo, regional_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
    VALUES (0,'0','VACIO/NULO','1900-01-01','2199-12-31',1,'Y',current_date);
INSERT INTO mapuche_nuevo.d_regional(regional_id, regional_codigo, regional_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
    VALUES (-1,'-1','VALOR ERRONEO','1900-01-01','2199-12-31',1,'Y',current_date);
            

INSERT INTO mapuche_nuevo.d_sexo(sexo_id, sexo_codigo, sexo_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
SELECT sexo_id, sexo_id_map, sexo_desc, fechadesde, fechahasta, version, vigente, fechaact
  FROM mapuche.map_dw_lt_sexo;
INSERT INTO mapuche_nuevo.d_sexo(sexo_id, sexo_codigo, sexo_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
VALUES(0,'0','VACIO/NULO','1900-01-01','2199-12-31',1,'Y',current_date);
UPDATE mapuche_nuevo.d_sexo SET sexo_desc = 'VALOR ERRONEO' WHERE sexo_codigo = '-1';


INSERT INTO mapuche_nuevo.d_subrogancia(subrogancia_id, subrogancia_codigo, subrogancia_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
SELECT subrogancia_id, subrogancia_id_map, subrogancia_desc, fechadesde, fechahasta, version, vigente, fechaact
  FROM mapuche.map_dw_lt_subrogancia;
INSERT INTO mapuche_nuevo.d_subrogancia(subrogancia_id, subrogancia_codigo, subrogancia_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
VALUES(0,'-2','VACIO/NULO','1900-01-01','2199-12-31',1,'Y',current_date);
UPDATE mapuche_nuevo.d_subrogancia SET subrogancia_desc = 'VALOR ERRONEO' WHERE subrogancia_codigo = '-1';


INSERT INTO mapuche_nuevo.d_tipo_ejercicio(tipo_ejercicio_id, tipo_ejercicio_codigo, tipo_ejercicio_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
 VALUES (0,'0','VACIO/NULO','1900-01-01','2199-12-31',1,'Y',current_date);
INSERT INTO mapuche_nuevo.d_tipo_ejercicio(tipo_ejercicio_id, tipo_ejercicio_codigo, tipo_ejercicio_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
    VALUES (-1,'-1','VALOR ERRONEO','1900-01-01','2199-12-31',1,'Y',current_date);


INSERT INTO mapuche_nuevo.d_tipoplantacaracter(plantacarac_id, tipoplanta_codigo, tipoplanta_desc, caracter_codigo, caracter_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
SELECT plantacarac_id, tipoplanta_id_map, tipoplanta_desc, caracter_id_map, caracter_desc, fechadesde, fechahasta, version, vigente, fechaact
  FROM mapuche.map_dw_lt_tipoplantacaracter;
INSERT INTO mapuche_nuevo.d_tipoplantacaracter(plantacarac_id, tipoplanta_codigo, tipoplanta_desc, caracter_codigo, caracter_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
VALUES(0,'0','VACIO/NULO','0','VACIO/NULO','1900-01-01','2199-12-31',1,'Y',current_date);
UPDATE mapuche_nuevo.d_tipoplantacaracter SET (tipoplanta_desc,caracter_desc ) = ('VALOR ERRONEO','VALOR ERRONEO') WHERE tipoplanta_codigo = '-1';

INSERT INTO mapuche_nuevo.d_titulo(titulo_id, titulo_codigo, titulo_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
     VALUES (0,'0','VACIO/NULO','1900-01-01','2199-12-31',1,'Y',current_date);
INSERT INTO mapuche_nuevo.d_titulo(titulo_id, titulo_codigo, titulo_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
 VALUES (-1,'-1','VALOR ERRONEO','1900-01-01','2199-12-31',1,'Y',current_date);


INSERT INTO mapuche_nuevo.d_categoria_incentivo(categoria_incentivo_id, categoria_incentivo_codigo, categoria_incentivo_desc, orden, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
SELECT categoria_incentivo_id, categoria_incentivo_codigo, categoria_incentivo_desc, orden, fechadesde, fechahasta, version, vigente, fechaact
  FROM mapuche.d_categoria_incentivo;


INSERT INTO mapuche_nuevo.d_unidad_presupuestaria(unidad_presupuestaria_id, unidad_presupuestaria_codigo, unidad_presupuestaria_desc, subunidad_presupuestaria_desc, subsubunidad_presupuestaria_desc, 
            fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
SELECT imppresupsubdependencia_id as unidad_presupuestaria_id, imppresupsubdependencia_id_map||'000' as unidad_presupuestaria_codigo, substring(imppresupsubdependencia_id_map from 1 for 2) || ' - ' || imppresupdependencia_desc as unidad_presupuestaria_desc, 
       substring(imppresupsubdependencia_id_map from 3 for 3) || ' - ' || imppresupsubdependencia_desc as subunidad_presupuestaria_desc, '000 - Sin SubSubUnidad' as subsubunidad_presupuestaria_desc, fechadesde, fechahasta, version, vigente, fechaact
  FROM mapuche.map_dw_lt_imppresupsubdependencia WHERE imppresupsubdependencia_id <> -1
  ORDER BY 1;
INSERT INTO mapuche_nuevo.d_unidad_presupuestaria(unidad_presupuestaria_id, unidad_presupuestaria_codigo, unidad_presupuestaria_desc, subunidad_presupuestaria_desc, subsubunidad_presupuestaria_desc, 
            fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
VALUES(0,'0','VACIO/NULO','VACIO/NULO','VACIO/NULO','1900-01-01','2199-12-31',1,'Y',current_date);
INSERT INTO mapuche_nuevo.d_unidad_presupuestaria(unidad_presupuestaria_id, unidad_presupuestaria_codigo, unidad_presupuestaria_desc, subunidad_presupuestaria_desc, subsubunidad_presupuestaria_desc, 
            fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
VALUES(-1,'-1','VALOR ERRONEO','VALOR ERRONEO','VALOR ERRONEO','1900-01-01','2199-12-31',1,'Y',current_date);
UPDATE mapuche_nuevo.d_unidad_presupuestaria SET subunidad_presupuestaria_desc = '000 - Sin SubUnidad'
WHERE subunidad_presupuestaria_desc= '000 - Sin Subdependencia';

INSERT INTO mapuche_nuevo.d_licencia(licencia_id, licencia_codigo, licencia_desc, fecha_desde, fecha_hasta, version, vigente, fecha_actualizacion)
 VALUES (0,'0','VACIO/NULO','1900-01-01','2199-12-31',1,'Y',current_date);
INSERT INTO mapuche_nuevo.d_licencia(licencia_id, licencia_codigo, licencia_desc, fecha_desde, fecha_hasta, version, vigente,  fecha_actualizacion)
    VALUES (-1,'-1','VALOR ERRONEO','1900-01-01','2199-12-31',1,'Y',current_date);

CREATE OR REPLACE FUNCTION mapuche.crear_tabla(periodo integer,tabla character varying, anio_id integer, mes_id integer)
RETURNS void AS
$BODY$
	DECLARE crear text = 'CREATE TABLE IF NOT EXISTS ' || $2 ||'(
						  id serial NOT NULL,
						  importacion_id integer,
						  unidad_generica_id integer,
						  periodo_id integer NOT NULL,
						  anio_id integer,
						  mes_id integer,
						  condicion_id SMALLINT NOT NULL,
						  liquidacion_id SMALLINT NOT NULL,
						  concepto_id integer NOT NULL,
						  persona_id integer NOT NULL,
						  nro_cargo_base integer,
						  nro_cargo integer,
						  unidad_presupuestaria_id SMALLINT,
						  tipo_ejercicio_id SMALLINT,
						  grupo_presupuestario_id SMALLINT,
						  finalidad_funcion_id SMALLINT,
						  imppresupfuente_id SMALLINT,
						  objetogasto_id SMALLINT,
						  red_programatica_id SMALLINT,
						  antiguedadliq_id SMALLINT,
						  dias_trabajados SMALLINT,
						  importe_liq numeric(15,2),
						  porc_imppresup character varying,
						  nro_recibo integer,
						  nro_orimp SMALLINT,
						  importenetocargo numeric(15,2),
						  importebrutocargo numeric(15,2),
						  importegastototalcargo numeric(15,2),
						  importedescuentoscargo numeric(15,2),
						  importeaportescargo numeric(15,2),
						  importeasigfam numeric(15,2),
						  importeremconap numeric(15,2),
						  importeremsinap numeric(15,2),
						  importeotrosrem numeric(15,2),
						  dependenciadesigncargo_id SMALLINT,
						  categoria_id SMALLINT,
						  nudo character varying,
						  estadodelcargo_id SMALLINT,
						  plantacarac_id SMALLINT,
						  agrupamiento_id SMALLINT,
						  subrogancia_id SMALLINT,
						  categoria_subrogada_id SMALLINT,
						  asociado_id SMALLINT,
						  antiguedadescalafon_id SMALLINT,
						  hsdedicacion_id SMALLINT,
						  porctrabajado_id SMALLINT,
						  porcreduccionhoraria_id SMALLINT,
						  regional_id SMALLINT,
						  fechaalta date,
						  fechabaja date,
						  dependenciadesemp_id SMALLINT,
						  nivelestudio_id SMALLINT,
						  estadocivil_id SMALLINT,
						  activo_id SMALLINT,
						  sexo_id SMALLINT,
						  discapacidad_id SMALLINT,
						  edad_id SMALLINT,
						  titulo_id SMALLINT,
						  nivel_estudio_liq_id SMALLINT,
						  cargahorariahs SMALLINT,
						  categoria_incentivo_id SMALLINT DEFAULT 0,
						  dedicacion_incentivo_id SMALLINT,
						  fechacarga date,
						  periodo_retroactivo_id SMALLINT,
						  regional_cabecera_id SMALLINT,
						  dependencia_cabecera_id SMALLINT,
						  dependenciadesign_id SMALLINT,
						  es_migrado character varying(2),
						  licencia_id SMALLINT,
						  CONSTRAINT ft_personal_' || $1 ||'_periodo CHECK (periodo_id = ' || $1 ||'),
						  CONSTRAINT ft_personal_' || $1 ||'_anio CHECK (anio_id = ' || $3 ||'),
						  CONSTRAINT ft_personal_' || $1 ||'_mes CHECK (mes_id = ' || $4 ||')
						)
						INHERITS (mapuche_nuevo.ft_personal)
						WITH (fillfactor = 100,
						OIDS=FALSE);';

			BEGIN
			EXECUTE crear;
			END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION mapuche.crear_tabla(integer,character varying,integer,integer)
  OWNER TO postgres;



CREATE OR REPLACE FUNCTION mapuche.insertar_datos(periodo integer,tabla character varying)
RETURNS void AS
$BODY$
	DECLARE crear text =	'INSERT INTO ' || $2 || '(condicion_id,anio_id, mes_id,  liquidacion_id, concepto_id,
					nro_cargo, nro_cargo_base,persona_id,  periodo_id,  unidad_presupuestaria_id, imppresupfuente_id,objetogasto_id, red_programatica_id, 
				     tipo_ejercicio_id, finalidad_funcion_id,  grupo_presupuestario_id,   antiguedadliq_id, dias_trabajados, 
								    periodo_retroactivo_id,  nro_recibo, 
								    nro_orimp, importe_liq,  importenetocargo, importebrutocargo, importegastototalcargo, 
								    porc_imppresup, importedescuentoscargo, importeaportescargo, importeasigfam, 
								    importeremconap, importeremsinap, importeotrosrem, dependenciadesigncargo_id, 
								    categoria_id, nudo, estadodelcargo_id, plantacarac_id, agrupamiento_id, 
								    subrogancia_id, categoria_subrogada_id, asociado_id, antiguedadescalafon_id, 
								    hsdedicacion_id, porctrabajado_id, porcreduccionhoraria_id, regional_id, 
								    fechaalta, fechabaja, dependenciadesemp_id, nivelestudio_id, 
								    estadocivil_id, unidad_generica_id, activo_id, sexo_id, discapacidad_id, edad_id, 
								    cargahorariahs, categoria_incentivo_id, 
								    dedicacion_incentivo_id, titulo_id, nivel_estudio_liq_id, fechacarga,importacion_id,regional_cabecera_id, dependencia_cabecera_id, dependenciadesign_id,es_migrado,licencia_id)
    
			 SELECT     1 as condicion_id,
			    extract(year from map_dw_ft_liqconceptosxcargos.periodoinfo) as anio_id,
			    extract(month from map_dw_ft_liqconceptosxcargos.periodoinfo) as mes_id,
			    map_dw_ft_liqconceptosxcargos.liquidacion_id,
			    map_dw_ft_liqconceptosxcargos.concepto_id,
			    map_dw_lt_personacargo.cargo_id_map::INTEGER as nro_cargo,
			    null::INTEGER as nro_cargo_base, 
			    map_dw_lt_personacargo.persona_id,
			    extract(year from map_dw_ft_liqconceptosxcargos.periodoinfo)*100 + extract(month from map_dw_ft_liqconceptosxcargos.periodoinfo) as periodo_id,
			    map_dw_ft_liqconceptosxcargos.imppresupcodunicosujeto_id as unidad_presupuestaria_id,
			    map_dw_ft_liqconceptosxcargos.imppresupfuente_id,
			    map_dw_ft_liqconceptosxcargos.objetogasto_id,
			    map_dw_ft_liqconceptosxcargos.programa_id as red_programatica_id,
			    0 as tipo_ejercicio_id,
			    0 as finalidad_funcion_id,
			    0 as grupo_presupuestario_id,
			    map_dw_ft_lt_cargos.antiguedadliq_id,
			    0 as dias_trabajados,
			    0 as periodo_retroactivo_id,
			    0 as nro_recibo,
			    0 as nro_orimp,
			    map_dw_ft_liqconceptosxcargos.importe_liq,
			    map_dw_ft_liqconceptosxcargos.importenetocargo,
			    map_dw_ft_liqconceptosxcargos.importebrutocargo,
			    map_dw_ft_liqconceptosxcargos.importegastototalcargo,
			    0 as porc_imppresup,
			    case when c.conceptotipo_id_map = ''D'' then map_dw_ft_liqconceptosxcargos.importe_liq
				else 0
				end as importedescuentoscargo,
			    case when c.conceptotipo_id_map = ''A'' then map_dw_ft_liqconceptosxcargos.importe_liq
				else 0
				end as importeaportescargo,
			    case when c.conceptotipo_id_map = ''F'' then map_dw_ft_liqconceptosxcargos.importe_liq
				else 0
				end as importeasigfam,
			    case when c.conceptotipo_id_map = ''C'' then map_dw_ft_liqconceptosxcargos.importe_liq
				else 0
				end as importeremconap,
			    case when c.conceptotipo_id_map = ''S'' then map_dw_ft_liqconceptosxcargos.importe_liq
				else 0
				end as importeremsinap,
			    case when c.conceptotipo_id_map = ''O'' then map_dw_ft_liqconceptosxcargos.importe_liq
				else 0
				end as importeotrosrem,
			    map_dw_ft_lt_cargos.dependenciadesign_id as dependenciadesigncargo_id,
			    map_dw_ft_lt_cargos.categoria_id,
			    map_dw_ft_lt_cargos.nudo,
			    map_dw_ft_lt_cargos.estadodelcargo_id,
			    map_dw_ft_lt_cargos.plantacarac_id,
			    map_dw_ft_lt_cargos.agrupamiento_id,
			    map_dw_ft_lt_cargos.subrogancia_id,
			    0 as categoria_subrogada_id, 
			    map_dw_ft_lt_cargos.asociado_id,
			    map_dw_ft_lt_cargos.antiguedadescalafon_id,
			    map_dw_ft_lt_cargos.hsdedicacion_id,
			    map_dw_ft_lt_cargos.porctrabajado_id,
			    map_dw_ft_lt_cargos.porcreduccionhoraria_id,
			    map_dw_ft_lt_cargos.sede_id as regional_id,
			    map_dw_ft_lt_cargos.fechaalta,
			    map_dw_ft_lt_cargos.fechabaja,
			    map_dw_ft_lt_cargos.dependenciadesemp_id,
			    map_dw_ft_lt_legajos.nivelestudio_id,
			    map_dw_ft_lt_legajos.estadocivil_id,
			    map_dw_ft_lt_cargos.unidad_generica_id,
			    map_dw_ft_lt_legajos.activo_id,
			    map_dw_ft_lt_legajos.sexo_id,
			    map_dw_ft_lt_legajos.discapacidad_id,
			    map_dw_ft_lt_legajos.edad_id,
			    map_dw_ft_lt_legajos.cargahorariahs,
			    map_dw_ft_lt_legajos.categoria_incentivo_id,
			    0 as dedicacion_incentivo_id,
			    0 as titulo_id ,
			    0 as nivel_estudio_liq_id,
			    map_dw_ft_liqconceptosxcargos.fechacarga,
			    0 as importacion_id,
			    0 as regional_cabecera_id, 
			    0 as dependencia_cabecera_id, 
			    map_dw_ft_lt_cargos.dependenciadesign_id as dependenciadesign_id,
			    ''SI'' as es_migrado,
			    0 as licencia_id
			   FROM mapuche.map_dw_ft_liqconceptosxcargos LEFT JOIN mapuche.map_dw_lt_conceptos c  ON (c.concepto_id = map_dw_ft_liqconceptosxcargos.concepto_id AND c.vigente=''Y''),
			    mapuche.map_dw_ft_lt_cargos,
			    mapuche.map_dw_ft_lt_legajos,
			    mapuche.map_dw_lt_personacargo
			  WHERE map_dw_ft_lt_cargos.personacargo_id = map_dw_ft_liqconceptosxcargos.personacargo_id AND map_dw_ft_lt_cargos.periodoinfo = map_dw_ft_liqconceptosxcargos.periodoinfo AND map_dw_lt_personacargo.personacargo_id = map_dw_ft_lt_cargos.personacargo_id AND map_dw_ft_lt_legajos.periodoinfo = map_dw_ft_lt_cargos.periodoinfo AND map_dw_ft_lt_legajos.persona_id = map_dw_lt_personacargo.persona_id
			AND (extract(year from map_dw_ft_liqconceptosxcargos.periodoinfo)*100 + extract(month from map_dw_ft_liqconceptosxcargos.periodoinfo))::INTEGER = ' || $1 ||  
			'UNION ALL
			 SELECT 2 as condicion_id,
				 extract(year from ft_cargos.periodoinfo) as anio_id,
				extract(month from ft_cargos.periodoinfo) as mes_id,
					0, 
					0, 
				 lt_personacargo.cargo_id_map::INTEGER as nro_cargo,
				 null::INTEGER as nro_cargo_base, 
				 lt_personacargo.persona_id,
				 extract(year from ft_cargos.periodoinfo)*100 + extract(month from ft_cargos.periodoinfo) as periodo_id, 
				 0, 
				 0, 
				 0, 
				 0, 
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
				 0,
				 ft_cargos.importenetocargo, 
				 ft_cargos.importebrutocargo,
				 ft_cargos.importegastototalcargo,
					 ''0'',
					 0,
					 0,
					 0,
					 0,
				 0,
				 0, 
				 ft_cargos.dependenciadesign_id as dependenciadesigncargo_id, 
				 ft_cargos.categoria_id, 
				 ft_cargos.nudo, 
				 ft_cargos.estadodelcargo_id, 
				 ft_cargos.plantacarac_id, 
				 ft_cargos.agrupamiento_id, 
				 ft_cargos.subrogancia_id, 
				 0 as categoria_subrogada_id, 
				 ft_cargos.asociado_id, 
				 ft_cargos.antiguedadescalafon_id, 
				 ft_cargos.hsdedicacion_id, 
				 ft_cargos.porctrabajado_id,
				 ft_cargos.porcreduccionhoraria_id, 
				 ft_cargos.sede_id as regional_id, 
				 ft_cargos.fechaalta, 
				 ft_cargos.fechabaja, 
				 ft_cargos.dependenciadesemp_id, 
				 ft_legajos.nivelestudio_id, 
				 ft_legajos.estadocivil_id, 
				 ft_cargos.unidad_generica_id,
				 ft_legajos.activo_id, 
				 ft_legajos.sexo_id,
				 ft_legajos.discapacidad_id, 
				 ft_legajos.edad_id,
				 ft_legajos.cargahorariahs, 
				 ft_legajos.categoria_incentivo_id ,
				 0 as dedicacion_incentivo_id,
				 0 as titulo_id ,
				 0 as nivel_estudio_liq_id,
				 ft_legajos.fechacarga,
				0 as importacion_id,
			   	0 as regional_cabecera_id, 
			    	0 as dependencia_cabecera_id, 
			    	ft_cargos.dependenciadesign_id as dependenciadesign_id,
	   		        ''SI'' as es_migrado,
      			        0 as licencia_id
			 FROM mapuche.map_dw_ft_lt_cargos ft_cargos  LEFT JOIN mapuche.map_dw_lt_personacargo lt_personacargo ON (ft_cargos.personacargo_id = lt_personacargo.personacargo_id)
			 LEFT JOIN mapuche.map_dw_ft_lt_legajos ft_legajos ON (ft_legajos.periodoinfo = ft_cargos.periodoinfo AND ft_legajos.persona_id = lt_personacargo.persona_id )
			 WHERE  (extract(year from ft_cargos.periodoinfo)*100 + extract(month from ft_cargos.periodoinfo))::INTEGER = ' || $1 || 'AND cargo_id_map NOT IN (SELECT DISTINCT cargo_id_map FROM mapuche.map_dw_ft_liqconceptosxcargos ft LEFT JOIN mapuche.map_dw_lt_personacargo lt_personacargo 
											ON (ft.personacargo_id = lt_personacargo.personacargo_id) WHERE (extract(year from ft.periodoinfo)*100 + extract(month from ft.periodoinfo))::INTEGER = ' || $1 || ') 

			UNION ALL
			 SELECT 3 as condicion_id,
				extract(year from ft_legajos.periodoinfo) as anio_id,
				extract(month from ft_legajos.periodoinfo) as mes_id,
				0, 
				0, 
				 null::INTEGER as nro_cargo, 
				 null::INTEGER as nro_cargo_base, 
				 ft_legajos.persona_id,
				 extract(year from ft_legajos.periodoinfo)*100 + extract(month from ft_legajos.periodoinfo) as periodo_id,  
				 0, 
				 0, 
				 0, 
				 0,
				0,
				0, 
				0,
				0,
				0,
				0,
				0,
				0,
				 0,
				 0, 
				 0, 
				 0,
				''0'',
				0,
				0,
				0,
				0,
				 0, 
				 0, 
				 0, 
				 0, 
				 ''0'', 
				 0, 
				 0,
				 0, 
				 0, 
				 0, 
				 0, 
				 0, 
				 0, 
				 0, 
				 0, 
				 0, 
				''2119-12-31''::date, 
				 ''2119-12-31''::date, 
				 0, 
				 ft_legajos.nivelestudio_id, 
				 ft_legajos.estadocivil_id, 
				 ft_legajos.unidad_generica_id,
				 ft_legajos.activo_id, 
				 ft_legajos.sexo_id,
				 ft_legajos.discapacidad_id, 
				 ft_legajos.edad_id,
				 ft_legajos.cargahorariahs, 
				 ft_legajos.categoria_incentivo_id ,
				0 as dedicacion_incentivo_id,
				 0 as titulo_id ,
				 0 as nivel_estudio_liq_id,
				 ft_legajos.fechacarga,
				0 as importacion_id,
			    	0 as regional_cabecera_id, 
			    	0 as dependencia_cabecera_id, 
			    	0 as dependenciadesign_id,
			        ''SI'' as es_migrado,
			        0 as licencia_id
			 FROM mapuche.map_dw_ft_lt_legajos ft_legajos WHERE  (extract(year from ft_legajos.periodoinfo)*100 + extract(month from ft_legajos.periodoinfo))::INTEGER = ' || $1 ||
			 'AND persona_id NOT IN (SELECT DISTINCT persona_id FROM mapuche.map_dw_ft_lt_cargos ft_cargos LEFT JOIN mapuche.map_dw_lt_personacargo lt_personacargo 
												ON (ft_cargos.personacargo_id = lt_personacargo.personacargo_id)
												WHERE (extract(year from ft_cargos.periodoinfo)*100 + extract(month from ft_cargos.periodoinfo))::INTEGER = ' || $1 || ');';

  BEGIN
			EXECUTE crear;
			END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION mapuche.insertar_datos(integer,character varying)
  OWNER TO postgres;

CREATE OR REPLACE FUNCTION mapuche.crear_indices(periodo integer,tabla character varying)
RETURNS void AS
$BODY$
	DECLARE crear text = 'CREATE INDEX idx_ft_periodo'|| $1 || ' ON mapuche_nuevo.ft_personal_'|| $1 || ' USING btree (periodo_id) WITH (FILLFACTOR=100);
				CREATE INDEX idx_ft_unidadgenericaid'|| $1 || ' ON mapuche_nuevo.ft_personal_'|| $1 || ' USING btree (unidad_generica_id) WITH (FILLFACTOR=100);
				CREATE INDEX idx_ft_liquidacion'|| $1 || ' ON mapuche_nuevo.ft_personal_'|| $1 || ' USING btree (liquidacion_id) WITH (FILLFACTOR=100);
				CREATE INDEX idx_ft_concepto'|| $1 || ' ON mapuche_nuevo.ft_personal_'|| $1 || ' USING btree (concepto_id) WITH (FILLFACTOR=100);
				CREATE INDEX idx_ft_categoria_escalafon'|| $1 || ' ON mapuche_nuevo.ft_personal_'|| $1 || ' USING btree (categoria_id) WITH (FILLFACTOR=100);
				CREATE INDEX idx_ft_persona_periodo'|| $1 || ' ON mapuche_nuevo.ft_personal_'|| $1 || ' USING btree (persona_id) WITH (FILLFACTOR=100);';

			BEGIN
			EXECUTE crear;
			END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION mapuche.crear_indices(integer,character varying)
  OWNER TO postgres; 


CREATE OR REPLACE FUNCTION mapuche.migrar_periodos()
RETURNS void AS
$BODY$
			DECLARE
				tabla character varying;
				periodo RECORD;	
				cur_periodo CURSOR FOR SELECT distinct (extract(year from periodoinfo)*100 + extract(month from periodoinfo))::INTEGER as periodoinfo, 
				extract(year from periodoinfo)::INTEGER AS anio_id, extract(month from periodoinfo)::INTEGER as mes_id	
				FROM mapuche.map_dw_ft_liqconceptosxcargos  order by 1;
			BEGIN
				
				FOR periodo IN cur_periodo LOOP
				tabla = 'mapuche_nuevo.ft_personal_' || periodo.periodoinfo;
				PERFORM mapuche.crear_tabla(periodo.periodoinfo,tabla, periodo.anio_id,periodo.mes_id);
				PERFORM mapuche.insertar_datos(periodo.periodoinfo,tabla);
				PERFORM mapuche.crear_indices(periodo.periodoinfo,tabla);

				END LOOP;
			END;
			$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION mapuche.migrar_periodos()
  OWNER TO postgres;

SELECT  mapuche.migrar_periodos();

--Actualizo id Vacios/Nulos
UPDATE mapuche_nuevo.ft_personal SET liquidacion_id = 0  WHERE liquidacion_id = -1;
UPDATE mapuche_nuevo.ft_personal SET concepto_id = 0  WHERE concepto_id = -1;
UPDATE mapuche_nuevo.ft_personal SET objetogasto_id = 0  WHERE objetogasto_id = -1;
UPDATE mapuche_nuevo.ft_personal SET red_programatica_id = 0  WHERE red_programatica_id = -1;
UPDATE mapuche_nuevo.ft_personal SET agrupamiento_id = 0  WHERE agrupamiento_id = -1;
UPDATE mapuche_nuevo.ft_personal SET subrogancia_id = 0  WHERE subrogancia_id = -1;
UPDATE mapuche_nuevo.ft_personal SET asociado_id = 0  WHERE asociado_id = -1;
UPDATE mapuche_nuevo.ft_personal SET hsdedicacion_id = 0  WHERE hsdedicacion_id = -1;
UPDATE mapuche_nuevo.ft_personal SET porctrabajado_id = 0  WHERE porctrabajado_id = -1;
UPDATE mapuche_nuevo.ft_personal SET porcreduccionhoraria_id = 0  WHERE porcreduccionhoraria_id = -1;
UPDATE mapuche_nuevo.ft_personal SET regional_id = 0  WHERE regional_id = -1;
UPDATE mapuche_nuevo.ft_personal SET dependenciadesemp_id = 0  WHERE dependenciadesemp_id = -1;
UPDATE mapuche_nuevo.ft_personal SET discapacidad_id = 0  WHERE discapacidad_id = -1;
UPDATE mapuche_nuevo.ft_personal SET nivelestudio_id = 0  WHERE nivelestudio_id = -1;
UPDATE mapuche_nuevo.ft_personal SET estadocivil_id = 0  WHERE estadocivil_id = -1;


--INSERTO PARAMETROS PARA CONEXION A BASE MAPUCHE
INSERT INTO public.parametro_instalacion(instalacion_id, nombre, valor)  (SELECT max(instalacion_id), 'host', null FROM public.d_instalacion  where fuente_dato_id =2);
INSERT INTO public.parametro_instalacion(instalacion_id, nombre, valor)  (SELECT max(instalacion_id), 'nombre', null FROM public.d_instalacion  where fuente_dato_id =2);
INSERT INTO public.parametro_instalacion(instalacion_id, nombre, valor)  (SELECT max(instalacion_id), 'puerto', null FROM public.d_instalacion  where fuente_dato_id =2);
INSERT INTO public.parametro_instalacion(instalacion_id, nombre, valor)  (SELECT max(instalacion_id), 'usuario', null FROM public.d_instalacion  where fuente_dato_id =2);
INSERT INTO public.parametro_instalacion(instalacion_id, nombre, valor)  (SELECT max(instalacion_id), 'clave', null FROM public.d_instalacion  where fuente_dato_id =2);
INSERT INTO public.parametro_instalacion(instalacion_id, nombre, valor)  (SELECT max(instalacion_id), 'motor', 'Sin motor' FROM public.d_instalacion  where fuente_dato_id =2 );
INSERT INTO public.parametro_instalacion(instalacion_id, nombre, valor)  (SELECT max(instalacion_id), 'plataforma', 'Sin plataforma' FROM public.d_instalacion  where fuente_dato_id =2);

