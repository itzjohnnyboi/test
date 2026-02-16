#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt update

# Upgrade installed packages
echo "Upgrading packages..."
sudo apt upgrade -y

# Install DKMS and build tools
echo "Installing build-essential and dkms..."
sudo apt install -y build-essential dkms

# Install kernel headers for the current kernel
echo "Installing kernel headers for $(uname -r)..."
sudo apt install -y linux-headers-$(uname -r)

# Install Broadcom STA DKMS driver
echo "Installing broadcom-sta-dkms..."
sudo apt install -y broadcom-sta-dkms

# Ensure all DKMS modules are built for current kernel
echo "Running dkms autoinstall..."
sudo dkms autoinstall

# Load the driver
echo "Loading wl module..."
sudo modprobe wl

echo "Broadcom STA installation complete."