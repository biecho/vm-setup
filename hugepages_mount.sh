#!/bin/bash

# Configuration variables
MOUNT_POINT="/mnt/huge"
HUGE_PAGE_SIZE_GB=1
HUGE_PAGE_SIZE_BYTES=$((HUGE_PAGE_SIZE_GB * 1024 * 1024 * 1024))
LIMIT_SIZE="1G"  # This can be adjusted if you want to set a different size limit

# Ensure the mount point exists
if [ ! -d "$MOUNT_POINT" ]; then
    echo "Creating mount point: $MOUNT_POINT"
    mkdir -p "$MOUNT_POINT"
fi

# Mount the hugetlbfs
# This will use the UID and GID of the user running the script.
# It sets the huge page size based on configuration and limits the size based on LIMIT_SIZE.
mount -t hugetlbfs \
      -o uid=$(id -u),gid=$(id -g),mode=1777,pagesize=$HUGE_PAGE_SIZE_BYTES,size=$LIMIT_SIZE \
      none \
      "$MOUNT_POINT"

# Check if the mount was successful
if [ $? -eq 0 ]; then
    echo "hugetlbfs mounted successfully at $MOUNT_POINT"
else
    echo "Failed to mount hugetlbfs at $MOUNT_POINT"
fi

