#!/bin/bash

# Check if genisoimage is installed
if ! command -v genisoimage &> /dev/null; then
    echo "genisoimage not found. Installing it now..."
    sudo apt update
    sudo apt install -y genisoimage
fi

# Create the ISO for cloud-init
genisoimage -output cloud-init.iso -volid CIDATA -joliet -rock user-data meta-data

echo "cloud-init.iso has been created."