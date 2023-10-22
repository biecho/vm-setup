#!/bin/bash

# Define a function to display content from a specific file.
read_info() {
    local file_path=$1
    local grep_pattern=$2

    echo "Reading from: $file_path"
    if [ -z "$grep_pattern" ]; then
        cat "$file_path"
    else
        grep "$grep_pattern" "$file_path"
    fi
    echo "--------------------------------------------"
}

# Read information from /proc/sys/vm and /proc/meminfo
read_info "/proc/sys/vm/nr_hugepages"
read_info "/proc/meminfo" "Hugepagesize"
read_info "/proc/meminfo" "HugePages_"

# Define a function to read all files in a directory.
read_directory() {
    local dir_path=$1

    for file in $(ls $dir_path); do
        read_info "$dir_path/$file"
    done
}

# Read information from the hugepages directories.
read_directory "/sys/kernel/mm/hugepages/hugepages-1048576kB"
read_directory "/sys/kernel/mm/hugepages/hugepages-2048kB"


