cd /opt/pentaho/data-integration
./kitchen.sh \
 -file="/opt/pentaho/SIU-Wichi/etl/carga_de_datos/rhun/importacion_rhun.kjb" \
-param="base_usuario=postgres" \
-param="base_clave=xxxxxxx" \
-param="base_nombre=siu_wichi" \
-param="base_host=localhost" \
-param="base_puerto=5432" \
-param="rutatxt=/opt/pentaho/cargas/rhun" \
-param="instalacion=4-261" \
-param="observaciones=ejemplo" \
-param="periodo=AAAAMM" \
-param="actualizacion=0"
