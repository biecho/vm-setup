#!/bin/bash

# Constants for the hugetlbfs
MOUNT_POINT="/mnt/huge"
PAGE_SIZE_BYTES="1073741824" # 1GB
LIMIT_SIZE="1G"

# Create the mount point if it doesn't exist.
if [ ! -d "$MOUNT_POINT" ]; then
    echo "Creating mount point: $MOUNT_POINT"
    mkdir -p "$MOUNT_POINT"
fi

# Current user's UID and GID
CURRENT_UID=$(id -u)
CURRENT_GID=$(id -g)

# Mount the hugetlbfs.
echo "Mounting hugetlbfs with UID=$CURRENT_UID, GID=$CURRENT_GID..."

sudo mount -t hugetlbfs \
      -o uid=$CURRENT_UID,gid=$CURRENT_GID,mode=1777,pagesize=$PAGE_SIZE_BYTES,size=$LIMIT_SIZE \
      none \
      "$MOUNT_POINT"

# Check if the mount was successful.
if [ $? -eq 0 ]; then
    echo "hugetlbfs mounted successfully at $MOUNT_POINT"
else
    echo "Failed to mount hugetlbfs at $MOUNT_POINT"
fi

