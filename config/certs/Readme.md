Test CA and certificate files for test cf.com domain

* CA/CA.pem the CA certificate
* CA/privkey.pem the CA private key
* cf.pem the server certificate
* cf.key the server private key
* cf.com.pem both the server and CA certificates in a single file for nginx.

Creating the CA
---------------

(Already done, only needed if you want a new one).

    openssl req -out CA.pem -new -x509 -days 1000

    openssl pkcs12 -export -out CA.pfx -inkey privkey.pem -in CA.pem 

Add to a Java keystore using

keytool -importcert -trustcacerts -alias "My Certificate Authority or Whatever" -file <path_to_ CA.pem> -keystore <keystore_filename>

Generating New Server Key
-------------------------

    openssl genrsa -out cf.key 1024

    openssl req -key cf.key -new -out cf.req

    openssl x509 -req -in cf.req -CA ./CA/CA.pem -CAkey ./CA/privkey.pem -CAserial ./CA/file.srl -extfile ./CA/server.cnf -extensions dir_sect -out cf.pem -days 1000

    rm cf.req
