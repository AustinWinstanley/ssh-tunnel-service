#!/bin/bash

# Check for root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Validate Service Name argument
if [ "$#" -ne 1 ]
then
  echo "Please provide a service name."
  exit 1
fi

# Set the Service Name from the provided argument
SERVICE_NAME=$1

# Stop the service
systemctl stop $SERVICE_NAME.service

# Disable the service
systemctl disable $SERVICE_NAME.service

# Delete the service
rm /etc/systemd/system/$SERVICE_NAME.service

# Delete the conf directory
if [ -d /etc/systemd/system/$SERVICE_NAME.service.d ]
  then
    rm -R /etc/systemd/system/$SERVICE_NAME.service.d
fi