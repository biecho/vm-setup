# Ubuntu VM Setup Instructions

This document provides step-by-step instructions for setting up an Ubuntu VM using KVM and cloud-init.

## Prerequisites

Before you begin, make sure you have the following prerequisites:

- [KVM](https://www.linux-kvm.org/) installed and enabled on your system.
- Internet connectivity to download the necessary image.

## Steps

### 1. Generate cloud-init ISO

Before proceeding, make sure you have the `user-data` and `meta-data` configuration files
present in the current directory. These files define the settings for your virtual machine. 
Here's an example of what these files might look like:

**user-data**
```yaml
#cloud-config
chpasswd:
  list: |
    ubuntu:mysecretpassword
  expire: False
ssh_pwauth: True
console:
  output: ttyS0
```

**meta-data**
```yaml
instance-id: ubuntu-vm01
local-hostname: ubuntu-vm01
```

```bash
genisoimage -output cloud-init.iso -volid CIDATA -joliet -rock user-data meta-data
```

### 2. Download the Ubuntu Cloud Image

```bash
wget https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img
```

### 3. Create the VM

```bash
virt-install \
  --name myVM \
  --ram 1024 \
  --disk path=focal-server-cloudimg-amd64.img,format=qcow2 \
  --disk path=cloud-init.iso,device=cdrom \
  --import \
  --network bridge:virbr0 \
  --graphics none \
  --os-variant=ubuntu20.04 \
  --console pty,target_type=serial
```

