#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <number_of_hugepages>"
    exit 1
fi

# Set the number of huge pages
echo $1 | sudo tee /proc/sys/vm/nr_hugepages

# Update /etc/sysctl.conf for persistence
sudo sed -i '/^vm.nr_hugepages/d' /etc/sysctl.conf
echo "vm.nr_hugepages=$1" | sudo tee -a /etc/sysctl.conf

echo "Updated Huge Pages Configuration to $1."

