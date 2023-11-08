#!/bin/bash

echo "Kernel Boot Arguments:"
echo "----------------------"

# Split the arguments by spaces and display them line-by-line
cat /proc/cmdline | tr ' ' '\n'

