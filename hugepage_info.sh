#!/bin/bash

# Read and display information from a specific path
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

# Total number of huge pages
read_info "/proc/sys/vm/nr_hugepages"

# Huge page size
read_info "/proc/meminfo" "Hugepagesize"

# Total, free, and used huge pages info
read_info "/proc/meminfo" "HugePages_"

