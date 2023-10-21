#!/bin/bash

# Function to display information
show_info() {
    local description=$1
    local file_path=$2
    local filter_pattern=$3

    echo "==> $description (from $file_path)"
    if [[ -z "$filter_pattern" ]]; then
        cat "$file_path"
    else
        grep -E "$filter_pattern" "$file_path"
    fi
    echo
}

# Display total number of huge pages
show_info "Total Number of Huge Pages" "/proc/sys/vm/nr_hugepages"

# Display the default huge page size
show_info "Huge Page Size" "/proc/meminfo" "Hugepagesize"

# Display the total, free, and used huge pages
show_info "Huge Pages Info" "/proc/meminfo" "HugePages_(Total|Free|Used)"


