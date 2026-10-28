FROM alpine:latest as pentaho_builder
LABEL maintainer = "Baisi Sabrina sbaisi@siu.edu.ar"
# Based on work done by Miguel Neyra (https://gitlab.com/docker.public/pentaho-server/-/tree/master/)

ENV PENTAHO_HOME /opt/pentaho
ENV PENTAHO_SERVER ${PENTAHO_HOME}/server/pentaho-server

# Get support packages
RUN apk --no-cache add curl

WORKDIR /tmp

RUN curl -L -o pentaho-server.zip https://privatefilesbucket-community-edition.s3.us-west-2.amazonaws.com/9.4.0.0-343/ce/server/pentaho-server-ce-9.4.0.0-343.zip
RUN curl -L -o pdi.zip https://privatefilesbucket-community-edition.s3.us-west-2.amazonaws.com/9.4.0.0-343/ce/client-tools/pdi-ce-9.4.0.0-343.zip
RUN curl -L -o postgresql-42.6.0.jar https://jdbc.postgresql.org/download/postgresql-42.6.0.jar
COPY tools/ .

# Setup pentaho user
RUN mkdir -p ${PENTAHO_HOME}/server; mkdir ${PENTAHO_HOME}/.pentaho; adduser -s /bin/bash -h ${PENTAHO_HOME} -D pentaho; chown -R pentaho:pentaho ${PENTAHO_HOME}

USER pentaho

WORKDIR ${PENTAHO_HOME}/server

# Get Pentaho Server
RUN unzip -q /tmp/pentaho-server.zip -d ${PENTAHO_HOME}/server
RUN unzip -q /tmp/pdi.zip -d ${PENTAHO_HOME}
RUN cp /tmp/postgresql-42.6.0.jar ${PENTAHO_HOME}/server/pentaho-server/tomcat/lib/

# Delete the samples zip file from the ${PENTAHO_HOME}/server/pentaho-solutions/system/default-content
RUN rm -rf ${PENTAHO_HOME}/server/pentaho-solutions/system/default-content/samples.zip

# Disable first-time startup prompt
RUN rm ${PENTAHO_SERVER}/promptuser.sh

# Disable daemon mode for Tomcat
RUN sed -i -e 's/\(exec ".*"\) start/\1 run/' ${PENTAHO_SERVER}/tomcat/bin/startup.sh

#Install tool
RUN unzip /tmp/pivot4j-pentaho-1.0-plugin.zip -d ${PENTAHO_HOME}/server/pentaho-server/pentaho-solutions/system
RUN unzip /tmp/saiku.zip -d ${PENTAHO_HOME}/server/pentaho-server/pentaho-solutions/system
RUN unzip /tmp/languagePack_es-9_4.zip -d ${PENTAHO_HOME}/server/pentaho-server/pentaho-solutions/system
RUN cp /tmp/ImportHandlerMimeTypeDefinitions.xml ${PENTAHO_HOME}/server/pentaho-server/pentaho-solutions/system
RUN cp /tmp/importExport.xml ${PENTAHO_HOME}/server/pentaho-server/pentaho-solutions/system
RUN cp /tmp/messages_es.properties ${PENTAHO_HOME}/server/pentaho-server/pentaho-solutions/system/default-plugin/resources/messages
RUN cp /tmp/messages_supported_languages.properties ${PENTAHO_HOME}/server/pentaho-server/pentaho-solutions/system/default-plugin/resources/messages

# HANYAJ - inicio plugin
RUN cp /tmp/plugin_hanyaj_SIU-Hanyaj_20.ico ${PENTAHO_HOME}/server/pentaho-server/pentaho-solutions/system/common-ui/resources/themes/images/SIU-Hanyaj_20.ico
RUN cp /tmp/plugin_hanyaj_SIU-Hanyaj_32.ico ${PENTAHO_HOME}/server/pentaho-server/pentaho-solutions/system/common-ui/resources/themes/images/SIU-Hanyaj_32.ico
RUN cp /tmp/plugin_hanyaj_globalCrystal.css ${PENTAHO_HOME}/server/pentaho-server/pentaho-solutions/system/common-ui/resources/themes/crystal/globalCrystal.css
RUN cp /tmp/plugin_hanyaj_globalSapphire.css ${PENTAHO_HOME}/server/pentaho-server/pentaho-solutions/system/common-ui/resources/themes/sapphire/globalSapphire.css
RUN cp /tmp/plugin_hanyaj_index.jsp  ${PENTAHO_HOME}/server/pentaho-server/tomcat/webapps/pentaho/mantle/browser/index.jsp
RUN cp /tmp/plugin_hanyaj_home.js    ${PENTAHO_HOME}/server/pentaho-server/tomcat/webapps/pentaho/mantle/home/js/home.js
RUN cp /tmp/plugin_hanyaj_browser.js ${PENTAHO_HOME}/server/pentaho-server/tomcat/webapps/pentaho/mantle/browser/js/browser.js
RUN mkdir -p ${PENTAHO_HOME}/server/pentaho-server/pentaho-solutions/system/hanyaj
RUN mkdir -p ${PENTAHO_HOME}/server/pentaho-server/pentaho-solutions/system/hanyaj/ui
RUN cp /tmp/plugin_hanyaj_hanyaj.html ${PENTAHO_HOME}/server/pentaho-server/pentaho-solutions/system/cda/static/hanyaj.html
RUN cp /tmp/plugin_hanyaj_plugin.xml ${PENTAHO_HOME}/server/pentaho-server/pentaho-solutions/system/hanyaj/plugin.xml
RUN cp /tmp/plugin_hanyaj_settings.xml ${PENTAHO_HOME}/server/pentaho-server/pentaho-solutions/system/hanyaj/settings.xml
RUN cp /tmp/plugin_hanyaj_hanyajplugin.properties ${PENTAHO_HOME}/server/pentaho-server/pentaho-solutions/system/hanyaj/ui/hanyajplugin.properties
# HANYAJ - fin plugin

RUN sed -i -e "s|requestParameterAuthenticationEnabled=false|requestParameterAuthenticationEnabled=true|g" ${PENTAHO_HOME}/server/pentaho-server/pentaho-solutions/system/security.properties

# Copy scripts and fix permissions
USER root

COPY scripts ${PENTAHO_HOME}/scripts
COPY config ${PENTAHO_HOME}/config
RUN chown -R pentaho:pentaho ${PENTAHO_HOME}/scripts && chmod -R +x ${PENTAHO_HOME}/scripts

#Delete files /tmp
RUN rm /tmp/pentaho-server.zip
RUN rm /tmp/pdi.zip
RUN rm /tmp/postgresql-42.6.0.jar
RUN rm /tmp/pivot4j-pentaho-1.0-plugin.zip
RUN rm /tmp/saiku.zip
RUN rm /tmp/languagePack_es-9_4.zip
RUN rm /tmp/*.xml

#Configure lenguage
RUN cp -R ${PENTAHO_SERVER}/pentaho-solutions/system/languagePack_es/data/es/system/common-ui/lib/* ${PENTAHO_SERVER}/pentaho-solutions/system/common-ui/lib/
RUN cp -R ${PENTAHO_SERVER}/pentaho-solutions/system/languagePack_es/data/es/system/common-ui/lib/* ${PENTAHO_SERVER}/pentaho-solutions/system/karaf/lib/
RUN cp -R ${PENTAHO_SERVER}/pentaho-solutions/system/languagePack_es/data/es/system/common-ui/lib/* ${PENTAHO_SERVER}/pentaho-solutions/system/pentaho-cdf/lib/
RUN cp -R ${PENTAHO_SERVER}/pentaho-solutions/system/languagePack_es/data/es/system/common-ui/lib/* ${PENTAHO_SERVER}/pentaho-solutions/system/pentaho-cdf-dd/lib/
RUN cp -R ${PENTAHO_SERVER}/pentaho-solutions/system/languagePack_es/data/es/tomcat/webapps/pentaho/mantle/browser/* ${PENTAHO_SERVER}/tomcat/webapps/pentaho/mantle/browser/
RUN cp -R ${PENTAHO_SERVER}/pentaho-solutions/system/languagePack_es/data/es/tomcat/webapps/pentaho/mantle/home/properties/* ${PENTAHO_SERVER}/tomcat/webapps/pentaho/mantle/home/properties/
RUN cp -R ${PENTAHO_SERVER}/pentaho-solutions/system/languagePack_es/data/es/tomcat/webapps/pentaho/mantle/messages/* ${PENTAHO_SERVER}/tomcat/webapps/pentaho/mantle/messages/
RUN cp -R ${PENTAHO_SERVER}/pentaho-solutions/system/languagePack_es/data/es/tomcat/webapps/pentaho/WEB_INF/lib/* ${PENTAHO_SERVER}/tomcat/webapps/pentaho/WEB-INF/lib/


FROM openjdk:8-jre-slim

ENV PENTAHO_HOME /opt/pentaho
ENV PENTAHO_JAVA_HOME $JAVA_HOME
ENV PENTAHO_SERVER ${PENTAHO_HOME}/server/pentaho-server
ENV CATALINA_OPTS="-Djava.awt.headless=true -Xms4096m -Xmx8192m -XX:MaxPermSize=256m -Dsun.rmi.dgc.client.gcInterval=3600000 -Dsun.rmi.dgc.server.gcInterval=3600000"

RUN mkdir -p ${PENTAHO_HOME}/server; mkdir ${PENTAHO_HOME}/.pentaho; useradd -s /bin/bash -d ${PENTAHO_HOME} pentaho; chown -R pentaho:pentaho ${PENTAHO_HOME}
WORKDIR /opt/pentaho
COPY --from=pentaho_builder /opt/pentaho .

RUN apt-get update
RUN apt-get install -y  man wget curl zip unzip bash nano netcat gnupg gnupg2 postgresql-client

#Configure Timezone America/Argentina
RUN cp /usr/share/zoneinfo/America/Argentina/Buenos_Aires /etc/localtime
RUN echo "America/Argentina/Buenos_Aires" >  /etc/timezone

#Copy SIU-Wichi files
COPY SIU-Wichi/Paquete_SIU-Wichi.zip ${PENTAHO_HOME}
RUN mkdir ${PENTAHO_HOME}/SIU-Wichi
RUN unzip ${PENTAHO_HOME}/Paquete_SIU-Wichi.zip -d ${PENTAHO_HOME}/SIU-Wichi
RUN rm ${PENTAHO_HOME}/Paquete_SIU-Wichi.zip
RUN mkdir ${PENTAHO_HOME}/cargar_actualizar_datos
COPY SIU-Wichi/cargar_actualizar_datos/* ${PENTAHO_HOME}/cargar_actualizar_datos/
RUN cp ${PENTAHO_HOME}/cargar_actualizar_datos/variables_iniciales.txt ${PENTAHO_HOME}/SIU-Wichi/etl/carga_de_datos/mapuche
RUN mkdir ${PENTAHO_HOME}/cargas
RUN mkdir ${PENTAHO_HOME}/cargas/araucano
RUN mkdir ${PENTAHO_HOME}/cargas/diaguita
RUN mkdir ${PENTAHO_HOME}/cargas/guarani
RUN mkdir ${PENTAHO_HOME}/cargas/guarani3
RUN mkdir ${PENTAHO_HOME}/cargas/kolla
RUN mkdir ${PENTAHO_HOME}/cargas/mapuche
RUN mkdir ${PENTAHO_HOME}/cargas/moodle
RUN mkdir ${PENTAHO_HOME}/cargas/pilaga
RUN mkdir ${PENTAHO_HOME}/cargas/pilaga/txt
RUN mkdir ${PENTAHO_HOME}/cargas/pilaga/temp
RUN mkdir ${PENTAHO_HOME}/cargas/preinscripciones
RUN mkdir ${PENTAHO_HOME}/cargas/querandies
RUN mkdir ${PENTAHO_HOME}/cargas/rhun
RUN mkdir ${PENTAHO_HOME}/cargas/sq
RUN mkdir ${PENTAHO_HOME}/cargas/sudocu
RUN chown -R pentaho:pentaho ${PENTAHO_HOME}


# Correr gpg para activar clave de querandies
#RUN export GPG_TTY=$(tty)
#RUN chmod 777 ${PENTAHO_HOME}/SIU-Wichi/etl/carga_de_datos/querandies/QuerandiesWichi-priv.key
#RUN gpg --import ${PENTAHO_HOME}/SIU-Wichi/etl/carga_de_datos/querandies/QuerandiesWichi-priv.key 

USER pentaho

EXPOSE 8080
ENTRYPOINT ["sh", "-c", "$PENTAHO_HOME/scripts/run.sh"]
