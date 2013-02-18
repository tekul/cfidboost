#! /bin/sh
PWD=`pwd`
export CLOUD_FOUNDRY_CONFIG_PATH="$PWD/config"

mkdir logs

# Use our custom truststore so that calls from the login server to the UAA over
# HTTPS are seen as having a server certificate signed by a valid CA

export CATALINA_OPTS="-Djavax.net.ssl.trustStore=$PWD/config/certs/truststore.jks -Djavax.net.ssl.trustStorePassword=\"password\""

if [ ! -d tomcat ]; then
  if [ ! -f tomcat.tar.gz ]; then
    curl http://www.mirrorservice.org/sites/ftp.apache.org/tomcat/tomcat-7/v7.0.35/bin/apache-tomcat-7.0.35.tar.gz > tomcat.tar.gz
  fi
  tar -xzf tomcat.tar.gz
  mv apache-tomcat-7.0.35 tomcat
  cp -f ./config/tomcat.server.xml ./tomcat/conf/server.xml
fi


rm -R tomcat/webapps/ROOT
rm -R tomcat/webapps/uaa

sh ./tomcat/bin/catalina.sh run
