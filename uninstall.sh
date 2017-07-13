#!/bin/bash

# Check for root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Stop the service
systemctl stop ssh-tunnel-service.service

# Disable the service
systemctl disable ssh-tunnel-service.service

# Delete the conf directory
rm -R /etc/ssh-tunnel-service