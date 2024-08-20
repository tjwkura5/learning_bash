#!/bin/bash

echo "Please provide the path to your file"

read file

if [ -f "$file" ]; then
    if [ -r "$file" ] && [ -w "$file" ] && [ -x "$file" ]; then
        echo "The file is readable, writable, and executable"
    else
        echo "The file is not readable, writable, and executable"
    fi
    
else
    echo "the file does not exist at the path provided"
fi 

# /home/ubuntu/sys_info.sh

