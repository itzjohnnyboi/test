#!/bin/bash
set -e

# ----------------------
# Basic system setup
# ----------------------

echo "Updating and upgrading system..."
sudo apt update && sudo apt upgrade -y

echo "Installing CUPS..."
sudo apt install -y cups

echo "Adding current user to lpadmin group..."
sudo usermod -a -G lpadmin "$(whoami)"

echo "Enabling remote access for CUPS..."
sudo cupsctl --remote-any

echo "Restarting CUPS service..."
sudo systemctl restart cups

# ----------------------
# Samba setup
# ----------------------

echo "Installing Samba..."
sudo apt install -y samba

echo "Updating Samba config..."
# Update guest ok in [printers] block
sudo sed -i '/^\[printers\]/,/^\[/{s/guest ok = no/guest ok = yes/}' /etc/samba/smb.conf

echo "Restarting Samba service..."
sudo systemctl restart smbd

# ----------------------
# HPLIP and HP printer setup
# ----------------------

echo "Installing HPLIP..."
sudo apt install -y hplip

echo "Setup complete! CUPS, Samba, and HPLIP are ready."
