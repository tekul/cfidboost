

Simple UAA/login server environment with Postgres and nginx.

Run `git submodule update --init` to get the UAA and login server code.

A single tmux script `start-all.sh` can be used to start everything at once.
Nginx, tomcat and postgres will be started in separate tmux windows.
Nginx runs on port 80, so will ask for your password if required.

Once the servers are running, open a separate window and run `build.sh` to
build and deploy the apps in tomcat. This also creates the necessary postgres
database and user for the UAA.

The login server is deployed as the tomcat root application and the uaa at `/uaa`.

The system uses the domain `cf.com`, so `/etc/hosts` should be modified to add

    127.0.0.1       localhost uaa.cf.com login.cf.com

It uses a wild-carded SSL certificate and all access should be over HTTPS.
The certificate is issued by the CA in `config/certs/CA`. 
