#! /bin/sh

# Maven git id plugin doesn't like .git files
if [ -f ./uaa/.git ] ; then
  rm ./uaa/.git
  ln -s ../.git/modules/uaa ./uaa/.git
fi

if [ -f ./login-server/.git ] ; then
  rm ./login-server/.git
  ln -s ../.git/modules/login-server ./login-server/.git
fi

psql -d postgres -c 'create database uaadb;'
psql -d postgres -c "create user uaa password 'password';"
psql -d postgres -c "grant all on database uaadb to uaa;"

echo "Building UAA"
pushd uaa
mvn install -DskipTests
popd

echo "Building login-server"
pushd login-server
mvn install -DskipTests
popd

echo "Copying files to tomcat"
cp -f uaa/uaa/target/cloudfoundry-identity-uaa*.war ./tomcat/webapps/uaa.war
cp -f login-server/target/cloudfoundry-login-server*.war ./tomcat/webapps/ROOT.war

