#!/bin/bash

# Display total number of huge pages
echo "Total Number of Huge Pages:"
cat /proc/sys/vm/nr_hugepages
echo

# Display the default huge page size
echo "Huge Page Size:"
cat /proc/meminfo | grep Hugepagesize | awk '{print $2, $3}'
echo

# Display the total, free, and used huge pages
echo "Huge Pages Info:"
cat /proc/meminfo | grep -E "HugePages_(Total|Free|Used)"
echo


