# SSH Tunnel Service

Simple SSH Tunnel service for systemd to launch at startup and run an SSH tunnel in the background.

Capable of running multiple by defining the service name (as long as they don't share the same port of course).

## Install

````bash
git clone git@github.com:CadyIO/ssh-tunnel-service.git
cd ./ssh-tunnel-service
sudo chmod +x ./install.sh
sudo ./install.sh SERVICE_NAME
````

Replace SERVICE_NAME with the name of the service.

Enter credentials and SSH settings and the conf file will be generated and the service registered.

## Uninstall

````bash
sudo chmod +x ./uninstall.sh
sudo ./uninstall.sh SERVICE_NAME
````

Replace SERVICE_NAME with the name of the service.