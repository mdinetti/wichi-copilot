cd /opt/pentaho/data-integration
./kitchen.sh \
  -file="/opt/pentaho/SIU-Wichi/etl/carga_de_datos/guarani3/principal_carga_guarani.kjb" \
  -param="base_wichi_clave=xxxxxxx" \
  -param="base_wichi_host=localhost" \
  -param="base_wichi_nombre=siu_wichi" \
  -param="base_wichi_puerto=5432" \
  -param="base_wichi_usuario=postgres" \
  -param="carga_comentario=ejemplo" \
  -param="carga_moodle=NO" \
  -param="carga_directorioTemporal=/opt/pentaho/cargas/guarani3" \
  -param="carga_instalacion=5-631" \
  -param="carga_periodo=0"
