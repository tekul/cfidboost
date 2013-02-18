#! /bin/sh

rm -Rf openldap
mkdir -p openldap
/usr/libexec/slapd -h ldap://localhost:22389 -d -1 -f ./config/ldap/slapd.conf &
sleep 2
ldapadd -h localhost -p 22389 -D cn=admin,dc=cloudfoundry,dc=com -w password -x -f ./config/ldap/users.ldif
