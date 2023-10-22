#!/bin/bash

# Define a function to retrieve content from a specific file.
get_info() {
    local file_path=$1
    cat "$file_path" 2>/dev/null || echo "N/A"
}

# Function to print info for a particular hugepages size directory.
print_hugepages_info() {
    local dir_path=$1
    local size=${dir_path##*-}  # Extract size from path, e.g., 2048kB

    echo "Hugepages Size: $size"
    echo "-----------------------"
    echo "Total: $(get_info "$dir_path/nr_hugepages")"
    echo "Free: $(get_info "$dir_path/free_hugepages")"
    echo "Reserved: $(get_info "$dir_path/resv_hugepages")"
    echo "Surplus: $(get_info "$dir_path/surplus_hugepages")"
    echo "Mempolicy: $(get_info "$dir_path/nr_hugepages_mempolicy")"
    echo "Overcommit: $(get_info "$dir_path/nr_overcommit_hugepages")"
    echo
}

# Print general hugepages info.
echo "General HugePages Info"
echo "----------------------"
echo "System HugePages Size: $(get_info "/proc/meminfo" | grep "Hugepagesize" | awk '{print $2, $3}')"
echo "Total: $(get_info "/proc/meminfo" | grep "HugePages_Total" | awk '{print $2}')"
echo "Free: $(get_info "/proc/meminfo" | grep "HugePages_Free" | awk '{print $2}')"
echo "Reserved: $(get_info "/proc/meminfo" | grep "HugePages_Rsvd" | awk '{print $2}')"
echo "Surplus: $(get_info "/proc/meminfo" | grep "HugePages_Surp" | awk '{print $2}')"
echo

# Print detailed info for each hugepages size.
print_hugepages_info "/sys/kernel/mm/hugepages/hugepages-1048576kB"
print_hugepages_info "/sys/kernel/mm/hugepages/hugepages-2048kB"
