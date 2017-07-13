# SSH Tunnel Service

Simple SSH Tunnel service for systemd to launch at startup and run an SSH tunnel in the background

## Install

````bash
git clone git@github.com:CadyIO/ssh-tunnel-service.git
cd ./ssh-tunnel-service
sudo chmod +x ./install.sh
sudo ./install.sh
````

Enter credentials and SSH settings and the conf file will be generated and the service registered.

## Uninstall

````bash
sudo chmod +x ./uninstall.sh
sudo ./uninstall.sh
````