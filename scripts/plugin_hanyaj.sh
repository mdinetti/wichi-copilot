#!/bin/bash

#echo "$(date +"[%F %T %Z] -") inicio plugin_hanyaj3" >> hc.log


if [ ! "$HANYAJ_PAGE" ]; then
        HANYAJ_PAGE=http://localhost:9999/hanyaj.php
fi

# Los cp se pasaron al Dockerfile
#cp $PENTAHO_HOME/tools/plugin_hanyaj_SIU-Hanyaj_20.ico $PENTAHO_SERVER/pentaho-solutions/system/common-ui/resources/themes/images/SIU-Hanyaj_20.ico
#cp $PENTAHO_HOME/tools/plugin_hanyaj_SIU-Hanyaj_32.ico $PENTAHO_SERVER/pentaho-solutions/system/common-ui/resources/themes/images/SIU-Hanyaj_32.ico
#cp $PENTAHO_HOME/tools/plugin_hanyaj_globalCrystal.css $PENTAHO_SERVER/pentaho-solutions/system/common-ui/resources/themes/crystal/globalCrystal.css
#cp $PENTAHO_HOME/tools/plugin_hanyaj_browser.js $PENTAHO_SERVER/tomcat/webapps/pentaho/mantle/browse/js/browser.js
#cp $PENTAHO_HOME/tools/plugin_hanyaj_index.js $PENTAHO_SERVER/tomcat/webapps/pentaho/mantle/browse/index.js
#cp $PENTAHO_HOME/tools/plugin_hanyaj_home.js $PENTAHO_SERVER/tomcat/webapps/pentaho/mantle/home/js/home.js
sed -i "s|HANYAJ_PAGE|$HANYAJ_PAGE|g" $PENTAHO_SERVER/tomcat/webapps/pentaho/mantle/browser/js/browser.js
sed -i "s|HANYAJ_PAGE|$HANYAJ_PAGE|g" $PENTAHO_SERVER/tomcat/webapps/pentaho/mantle/browser/index.jsp
sed -i "s|HANYAJ_PAGE|$HANYAJ_PAGE|g" $PENTAHO_SERVER/tomcat/webapps/pentaho/mantle/home/js/home.js
sed -i "s|HANYAJ_PAGE|$HANYAJ_PAGE|g" $PENTAHO_SERVER/pentaho-solutions/system/cda/static/hanyaj.html

#echo "$(date +"[%F %T %Z] -") fin plugin_hanyaj3" >> hc.log


# Se debe definir la variable de entorno en el archivo pentaho.env HANYAJ_PAGE=http://ip:puerto/hanyaj/hanyaj.php

