#!/bin/bash

echo "Please provide the path to your file"

read file

if [ -f "$file" ]; then
 # Initialize an empty string for permissions feedback
    permissions="The file is"

    # Check for readability, writability, and executability
    if [ -r "$file" ]; then
        permissions+=" readable"
    else
        permissions+=" not readable"
    fi

    if [ -w "$file" ]; then
        permissions+=", writable"
    else
        permissions+=", not writable"
    fi

    if [ -x "$file" ]; then
        permissions+=", and executable."
    else
        permissions+=", and not executable."
    fi

    echo "$permissions"
else
    echo "the file does not exist at the path provided"
fi 

# /home/ubuntu/sys_info.sh

