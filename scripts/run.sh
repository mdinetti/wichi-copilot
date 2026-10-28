if [ ! -f ".pentaho_pgconfig" ]; then
   bash -x $PENTAHO_HOME/scripts/setup_pentaho.sh
   HOSTNAME=$(`echo hostname`)

   sed -i "s/node1/${HOSTNAME}/g" ${PENTAHO_SERVER}/pentaho-solutions/system/jackrabbit/repository.xml
   touch .pentaho_pgconfig
fi
bash -x $PENTAHO_HOME/scripts/plugin_hanyaj.sh

sh ${PENTAHO_SERVER}/start-pentaho.sh
