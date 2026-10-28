-- SOLO SI CARGA DATOS DE GUARANI3
PASO 1: Obtener valor de elemento mediante el siguiente query o bien ejecutando el etl de la carpeta obtener_actividades
SELECT 'UPDATE guarani3.d_actividad SET elemento=' || e.elemento || ' WHERE actividad_codigo=''' ||   e.codigo || ''' AND  actividad_desc='''
    || '(' || codigo || ') - '  || e.nombre || ''';'
   FROM negocio.sga_elementos e,
    negocio.sga_g3entidades_subtipos est,
    negocio.sga_elementos_revision er
  WHERE e.entidad_subtipo = est.entidad_subtipo AND er.elemento = e.elemento AND est.entidad_tipo = 2;
  
PASO 2: Copiar en un txt y reemplazar 
1) "UPDATE por UPDATE 
2) ;" por ;
3) "" por "
 
PASO 3: Ejecutar lo obtenido en la base de datos siu_wichi
 
En los casos en que la descripcion contenga una comilla simple ('), se debera agregar otra ' para que funcione:
EJEMEPLO
1) UPDATE guarani3.d_actividad SET elemento=3119 WHERE actividad_codigo='0765' AND  actividad_desc='(0765) - RC: SIMULATION D' ENTREPRISE (30HS)CE';
 modificar -->  UPDATE guarani3.d_actividad SET elemento=3119 WHERE actividad_codigo='0765' AND  actividad_desc='(0765) - RC: SIMULATION D'' ENTREPRISE (30HS)CE';

  

