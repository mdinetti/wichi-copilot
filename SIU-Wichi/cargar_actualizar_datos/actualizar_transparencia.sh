cd /opt/pentaho/data-integration
./kitchen.sh \
-file="/opt/pentaho/SIU-Wichi/etl/carga_de_datos/transparencia/main_carga_datos_portal_transparencia.kjb" \
-param="wichi_host=localhost" \
-param="wichi_puerto=5432" \
-param="wichi_base=siu_wichi" \
-param="wichi_usuario=postgres" \
-param="wichi_clave=postgres" \
-param="transparencia_host=localhost" \
-param="transparencia_puerto=5432" \
-param="transparencia_base=siu_wichi" \
-param="transparencia_usuario=postgres" \
-param="transparencia_clave=postgres"
