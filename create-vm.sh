#!/bin/bash

virt-install \
  --name biecho \
  --ram 1024 \
  --disk path=focal-server-cloudimg-amd64.img,format=qcow2 \
  --disk path=cloud-init.iso,device=cdrom \
  --import \
  --network bridge:virbr0 \
  --graphics none \
  --os-variant=ubuntu20.04 \
  --console pty,target_type=serial

