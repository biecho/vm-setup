#!/bin/bash

sudo apt-get update

echo "Installing cpu-checker..."
sudo apt install -y cpu-checker

echo "Checking KVM support..."
if kvm-ok > /dev/null 2>&1; then
    echo "KVM is supported on this machine."
else
    echo "KVM is NOT supported on this machine. Exiting..."
    exit 1
fi

echo "Installing qemu-kvm and libvirt-daemon-system..."
sudo apt install qemu-kvm libvirt-daemon-system -y

echo "Adding user to the necessary groups..."
YOURUSERNAME=$(whoami)
sudo usermod -aG libvirt $YOURUSERNAME
sudo usermod -aG kvm $YOURUSERNAME

echo "User added to groups. You may need to re-login for changes to take effect."

echo "libvirtd status:"
sudo systemctl is-active libvirtd --quiet && echo "Active" || echo "Inactive"

echo "Setup complete!"
