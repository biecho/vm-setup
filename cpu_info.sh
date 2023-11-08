#!/bin/bash

# Get CPU information using lscpu
lscpu_info=$(lscpu | grep "Model name" | awk -F: '{print $2}' | sed 's/^[ \t]*//;s/[ \t]*$//')

# Get CPU information using /proc/cpuinfo
cpuinfo_info=$(grep "model name" /proc/cpuinfo | head -n1 | awk -F: '{print $2}' | sed 's/^[ \t]*//;s/[ \t]*$//')

# Get CPU information using dmidecode
dmidecode_info=$(sudo dmidecode -t processor | grep "Version" | awk -F: '{print $2}' | sed 's/^[ \t]*//;s/[ \t]*$//')

# Get CPU information using lshw (if available)
lshw_info=$(sudo lshw -C processor 2>/dev/null | grep "product" | awk -F: '{print $2}' | sed 's/^[ \t]*//;s/[ \t]*$//')

# Get CPU information using inxi (if available)
inxi_info=$(sudo inxi -C 2>/dev/null | grep "CPU:" | awk -F: '{print $2}' | sed 's/^[ \t]*//;s/[ \t]*$//')

# Display CPU information with context
echo "CPU Information from Various Sources:"
echo "-------------------------------------"
echo "1. Using lscpu:"
echo "   - Description: Information retrieved from lscpu command"
echo "   - CPU Model: $lscpu_info"
echo ""
echo "2. Using /proc/cpuinfo:"
echo "   - Description: Information retrieved from /proc/cpuinfo file"
echo "   - CPU Model: $cpuinfo_info"
echo ""
echo "3. Using dmidecode:"
echo "   - Description: Information retrieved from dmidecode command"
echo "   - CPU Model: $dmidecode_info"
echo ""
echo "4. Using lshw (if available):"
echo "   - Description: Information retrieved from lshw command"
echo "   - CPU Model: $lshw_info"
echo ""
echo "5. Using inxi (if available):"
echo "   - Description: Information retrieved from inxi command"
echo "   - CPU Model: $inxi_info"

