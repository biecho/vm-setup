#!/bin/bash

# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script as root or with sudo."
    exit 1
fi

# Check if virt-install is installed
if ! command -v virt-install &> /dev/null; then
    echo "virt-install not found. Installing it now..."
    apt update
    apt install -y virtinst
fi

# Set permissions to allow libvirt-qemu access
VM_PATH="/home/biecho/vm-setup"
chmod o+x /home/biecho
chown -R biecho:libvirt-qemu $VM_PATH
chmod 0750 $VM_PATH
find $VM_PATH -type f -exec chmod 0640 {} \;
find $VM_PATH -type d -exec chmod 0750 {} \;

# Create the VM using virt-install
virt-install \
  --name biecho \
  --ram 2048 \
  --disk path=${VM_PATH}/focal-server-cloudimg-amd64.img,format=qcow2 \
  --disk path=${VM_PATH}/cloud-init.iso,device=cdrom \
  --import \
  --network bridge:virbr0 \
  --graphics none \
  --os-variant=ubuntu20.04 \
  --console pty,target_type=serial

# Check the exit status of the virt-install command
if [ $? -eq 0 ]; then
    echo "Virtual machine 'biecho' has been created."
else
    echo "An error occurred while creating the virtual machine. Please check the error messages above."
fi
