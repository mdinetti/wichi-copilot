cd /opt/pentaho/data-integration
./kitchen.sh \
 -file="/opt/pentaho/SIU-Wichi/etl/carga_de_datos/querandies/principal_carga_querandies.kjb" \
-param="base_wichi_usuario=postgres" \
-param="base_wichi_clave=xxxxxxx" \
-param="base_wichi_nombre=siu_wichi" \
-param="base_wichi_host=localhost" \
-param="base_wichi_puerto=5432" \
-param="carga_directorioTemporal=/opt/pentaho/cargas/querandies" \
-param="carga_instalacion=x-yyyy"
