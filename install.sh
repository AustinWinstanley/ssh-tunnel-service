#!/bin/bash

# Check for root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Get the conf settings
read -p "SSH Private Key File: "  SSH_PRIVATE_KEY
read -p "SSH Port: "  SSH_PORT
read -p "SSH Tunnel Username: "  SSH_TUNNEL_USERNAME
read -p "SSH Tunnel Host: "  SSH_TUNNEL_HOST

# Remove the current conf
rm "$(pwd)/ssh-tunnel-service.conf"

# Create a new conf
touch "$(pwd)/ssh-tunnel-service.conf"

# Write the settings to the conf file
echo "SSH_PRIVATE_KEY=$SSH_PRIVATE_KEY" >> "$(pwd)/ssh-tunnel-service.conf"
echo "SSH_PORT=$SSH_PORT" >> "$(pwd)/ssh-tunnel-service.conf"
echo "SSH_TUNNEL_USERNAME=$SSH_TUNNEL_USERNAME" >> "$(pwd)/ssh-tunnel-service.conf"
echo "SSH_TUNNEL_HOST=$SSH_TUNNEL_HOST" >> "$(pwd)/ssh-tunnel-service.conf"

# Copy the service
cp "$(pwd)/ssh-tunnel-service.service" /etc/systemd/system/ssh-tunnel-service.service

# Create the conf directory
mkdir /etc/ssh-tunnel-service

# Copy the conf file
cp "$(pwd)/ssh-tunnel-service.conf" /etc/ssh-tunnel-service/ssh-tunnel-service.conf

# Reload the systemd daemon
systemctl daemon-reload

# Enable the service
systemctl enable ssh-tunnel-service.service

# Start the service
systemctl start ssh-tunnel-service.service