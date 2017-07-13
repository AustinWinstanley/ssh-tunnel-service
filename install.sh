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

# Get the conf settings
read -p "SSH Private Key File (full path): "  SSH_PRIVATE_KEY
read -p "SSH Port: "  SSH_PORT
read -p "SSH Tunnel Username: "  SSH_TUNNEL_USERNAME
read -p "SSH Tunnel Host: "  SSH_TUNNEL_HOST

# Remove the current conf
rm "$(pwd)/$SERVICE_NAME.conf"

# Create a new conf
touch "$(pwd)/$SERVICE_NAME.conf"

# Write the settings to the conf file
echo "[Service]" >> "$(pwd)/$SERVICE_NAME.conf"
echo "ExecStart=/bin/sh -c \"/usr/bin/ssh -N -D $SSH_PORT -o StrictHostKeyChecking=no -i $SSH_PRIVATE_KEY $SSH_TUNNEL_USERNAME@$SSH_TUNNEL_HOST &\"" >> "$(pwd)/$SERVICE_NAME.conf"
echo "ExecStop=/bin/kill \$(pgrep -f $SSH_TUNNEL_USERNAME@$SSH_TUNNEL_HOST)" >> "$(pwd)/$SERVICE_NAME.conf"

# Copy the service
cp "$(pwd)/ssh-tunnel-service.service" /etc/systemd/system/$SERVICE_NAME.service

# Create the conf directory
if [ ! -d /etc/systemd/system/$SERVICE_NAME.service.d ]
  then
    mkdir /etc/systemd/system/$SERVICE_NAME.service.d
fi


# Copy the conf file
cp "$(pwd)/$SERVICE_NAME.conf" /etc/systemd/system/$SERVICE_NAME.service.d/$SERVICE_NAME.conf

# Reload the systemd daemon
systemctl daemon-reload

# Enable the service
systemctl enable $SERVICE_NAME

# Start the service
systemctl start $SERVICE_NAME