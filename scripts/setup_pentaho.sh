#!/bin/bash

if [ "$PGHOST" ]; then
	if [ ! "$PGPORT" ]; then
	        PGPORT=5432
	fi
	if [ ! "$PGDATABASE" ]; then
	        PGDATABASE=postgres
	fi
	if [ ! "$PGUSER" ]; then
	        PGUSER=postgres
	fi
	if [ ! "$PGPASSWORD" ]; then
	        PGPASSWORD=postgres
	        
	fi
	export PGPASSWORD="$PGPASSWORD"
	echo "Checking PostgreSQL connection ..."

	nc -zv $PGHOST $PGPORT
	
	if [ "$?" -ne "0" ]; then
		echo "PostgreSQL connection failed."
		exit 0
	fi

	CHK_QUARTZ=`echo "$(psql -U $PGUSER  -h $PGHOST -p $PGPORT -d $PGDATABASE -l | grep quartz | wc -l)"`
	CHK_HIBERNATE=`echo "$(psql -U $PGUSER  -h $PGHOST -p $PGPORT -d $PGDATABASE -l | grep hibernate | wc -l)"`
	CHK_JCR=`echo "$(psql -U $PGUSER  -h $PGHOST -p $PGPORT -d $PGDATABASE -l | grep jackrabbit | wc -l)"`
        CHK_SIU_WICHI=`echo "$(psql -U $SIU_WICHI_USER  -h $SIU_WICHI_HOST -p $SIU_WICHI_PORT -d $SIU_WICHI_BASE -l | grep $SIU_WICHI_BASE | wc -l)"`


	echo "quartz: $CHK_QUARTZ"
	echo "hibernate: $CHK_HIBERNATE"
	echo "jcr: $CHK_JCR"
        echo "siu_wichi: $CHK_SIU_WICHI"

	if [ "$CHK_JCR" -eq "0" ]; then
	 psql -U $PGUSER  -h $PGHOST -p $PGPORT -d $PGDATABASE -f $PENTAHO_SERVER/data/postgresql/create_jcr_postgresql.sql
	fi
	if [ "$CHK_HIBERNATE" -eq "0" ]; then
	 cp $PENTAHO_HOME/config/create_repository_postgresql.sql $PENTAHO_SERVER/data/postgresql/create_repository_postgresql.sql
	 psql -U $PGUSER -h $PGHOST -p $PGPORT -d $PGDATABASE -f $PENTAHO_SERVER/data/postgresql/create_repository_postgresql.sql
	fi
	if [ "$CHK_QUARTZ" -eq "0" ]; then
         cp $PENTAHO_HOME/config/create_quartz_postgresql.sql $PENTAHO_SERVER/data/postgresql/create_quartz_postgresql.sql
	 psql -U $PGUSER -h $PGHOST -p $PGPORT -d $PGDATABASE -f $PENTAHO_SERVER/data/postgresql/create_quartz_postgresql.sql
        fi
        if [ "$CHK_SIU_WICHI" -eq "0" ]; then
	 cp $PENTAHO_HOME/config/crear_base_wichi.sql $PENTAHO_SERVER/data/postgresql/crear_base_wichi.sql
	 psql -U $SIU_WICHI_USER -h $SIU_WICHI_HOST -p $SIU_WICHI_PORT -d $PGDATABASE -f $PENTAHO_SERVER/data/postgresql/crear_base_wichi.sql
         cd /opt/pentaho/data-integration
         ./kitchen.sh  -file="/opt/pentaho/SIU-Wichi/etl/creacion_base_datos/principal_crear_siu_wichi.kjb" -param="base_clave=$SIU_WICHI_PASSWORD" -param="base_nombre=$SIU_WICHI_BASE" -param="base_host=$SIU_WICHI_HOST" -param="base_puerto=$SIU_WICHI_PORT" -param="base_usuario=$SIU_WICHI_USER"
        fi


	# Use postgresql for hibernate
	if grep -q postgresql $PENTAHO_SERVER/pentaho-solutions/system/hibernate/hibernate-settings.xml; then
	 sed -i s/hsql/postgresql/g $PENTAHO_SERVER/pentaho-solutions/system/hibernate/hibernate-settings.xml

         sed -i s/localhost:5432/$PGHOST:$PGPORT/g $PENTAHO_SERVER/pentaho-solutions/system/hibernate/postgresql.hibernate.cfg.xml

	 cp $PENTAHO_HOME/config/jdbc.properties $PENTAHO_SERVER/pentaho-solutions/system/simple-jndi/jdbc.properties
	 sed -i "s|postgresql://localhost:5432|postgresql://$PGHOST:$PGPORT|g" $PENTAHO_SERVER/pentaho-solutions/system/simple-jndi/jdbc.properties
	fi

	# Use postgreql for jackrabbit
	if grep -q java:comp/env/jdbc/jackrabbit $PENTAHO_SERVER/pentaho-solutions/system/jackrabbit/repository.xml; then
	 cp $PENTAHO_HOME/config/repository.xml $PENTAHO_SERVER/pentaho-solutions/system/jackrabbit/repository.xml
	 sed -i "s|postgresql://localhost:5432|postgresql://$PGHOST:$PGPORT|g" $PENTAHO_SERVER/pentaho-solutions/system/jackrabbit/repository.xml
	fi

	# Use postgresql for tomcat (quartz / hibernate / siu_wichi)
	if grep -q hsqldb $PENTAHO_SERVER/tomcat/webapps/pentaho/META-INF/context.xml; then
	 cp $PENTAHO_HOME/config/context.xml $PENTAHO_SERVER/tomcat/webapps/pentaho/META-INF/context.xml
	 sed -i "s|jdbc:postgresql://localhost:5432/hibernate|jdbc:postgresql://$PGHOST:$PGPORT/hibernate|g" $PENTAHO_SERVER/tomcat/webapps/pentaho/META-INF/context.xml
         sed -i "s|jdbc:postgresql://localhost:5432/quartz|jdbc:postgresql://$PGHOST:$PGPORT/quartz|g" $PENTAHO_SERVER/tomcat/webapps/pentaho/META-INF/context.xml
         sed -i "s|jdbc:postgresql://localhost:5432/siu_wichi|jdbc:postgresql://$SIU_WICHI_HOST:$SIU_WICHI_PORT/$SIU_WICHI_BASE|g" $PENTAHO_SERVER/tomcat/webapps/pentaho/META-INF/context.xml
	fi

	# Use postgresql for Spring Security
	if grep -q hsqldb $PENTAHO_SERVER/pentaho-solutions/system/applicationContext-spring-security-jdbc.properties; then
	 cp $PENTAHO_HOME/config/applicationContext-spring-security-jdbc.properties $PENTAHO_SERVER/pentaho-solutions/system/applicationContext-spring-security-jdbc.properties
	 sed -i "s|jdbc:postgresql://localhost:5432/|jdbc:postgresql://$PGHOST:$PGPORT/|g" $PENTAHO_SERVER/pentaho-solutions/system/applicationContext-spring-security-jdbc.properties
	fi

	# Use postgresql for Spring Security Hibernate
	if grep -q hsqldb $PENTAHO_SERVER/pentaho-solutions/system/applicationContext-spring-security-hibernate.properties; then	
	 cp $PENTAHO_HOME/config/applicationContext-spring-security-hibernate.properties $PENTAHO_SERVER/pentaho-solutions/system/applicationContext-spring-security-hibernate.properties
	 sed -i "s|jdbc:postgresql://localhost:5432/|jdbc:postgresql://$PGHOST:$PGPORT/|g" $PENTAHO_SERVER/pentaho-solutions/system/applicationContext-spring-security-hibernate.properties
	fi

	# Replace file webapps/pentaho/WEB-INF/web.xml
	cp $PENTAHO_HOME/config/web.xml $PENTAHO_SERVER/tomcat/webapps/pentaho/WEB-INF/web.xml

	# Replace file pentaho.xml
	cp $PENTAHO_HOME/config/pentaho.xml $PENTAHO_SERVER/pentaho-solutions/system/pentaho.xml

        # Replace file classic-engine.properties
        cp $PENTAHO_HOME/config/classic-engine.properties $PENTAHO_SERVER/tomcat/webapps/pentaho/WEB-INF/classes/classic-engine.properties

        # Create file mondrian-schema-mapping.properties
        cp $PENTAHO_HOME/config/mondrian-schema-mapping.properties $PENTAHO_SERVER/tomcat/webapps/pentaho/WEB-INF/classes/mondrian-schema-mapping.properties

        # Log de accesos file pentahoObjects.spring.xml
         sed -i "s|AuditFileEntry|AuditSQLEntry|g" $PENTAHO_SERVER/pentaho-solutions/system/pentahoObjects.spring.xml

        # Replace css ruby theme
        cp $PENTAHO_HOME/config/globalRuby.css $PENTAHO_SERVER/pentaho-solutions/system/common-ui/resources/themes/ruby/globalRuby.css

        # Replace icon favicon.ico
        cp $PENTAHO_HOME/config/favicon.ico $PENTAHO_SERVER/tomcat/webapps/pentaho-style/favicon.ico
        cp $PENTAHO_HOME/config/favicon.ico $PENTAHO_SERVER/tomcat/webapps/pentaho-style/favicon-16x16.png
        cp $PENTAHO_HOME/config/favicon.ico $PENTAHO_SERVER/tomcat/webapps/pentaho-style/favicon-32x32.png

        # Replace icon footer
        cp $PENTAHO_HOME/config/logo_wichi_footer.png $PENTAHO_SERVER/pentaho-solutions/system/common-ui/resources/themes/ruby/images/logo_wichi_footer.png

        # Replace screen icon
        #cp $PENTAHO_HOME/config/puc-login-logo.png $PENTAHO_SERVER/pentaho-solutions/system/common-ui/resources/themes/images/puc-login-logo.png

        # Replace wallpaper
        #cp $PENTAHO_HOME/config/login-crystal-bg.jpeg $PENTAHO_SERVER/pentaho-solutions/system/common-ui/resources/themes/crystal/images/login-crystal-bg.jpeg
        
        # Config page Welcome
        cp $PENTAHO_HOME/config/pantalla_welcome/index.html $PENTAHO_SERVER/tomcat/webapps/pentaho/mantle/home/content/welcome/index.html
        cp $PENTAHO_HOME/config/pantalla_welcome/main_wichi.js $PENTAHO_SERVER/tomcat/webapps/pentaho/mantle/home/content/welcome/js/main_wichi.js
        cp $PENTAHO_HOME/config/pantalla_welcome/angular.min.js $PENTAHO_SERVER/tomcat/webapps/pentaho/mantle/home/content/welcome/js/vendor/angular.min.js
        mkdir $PENTAHO_SERVER/tomcat/webapps/pentaho/mantle/home/content/welcome/img/wichi
        cp $PENTAHO_HOME/config/pantalla_welcome/img/* $PENTAHO_SERVER/tomcat/webapps/pentaho/mantle/home/content/welcome/img/wichi/
        cp $PENTAHO_HOME/config/pantalla_welcome/fecha_actualizacion.zip $PENTAHO_SERVER/pentaho-solutions/system/default-content/
fi
