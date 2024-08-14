#!/bin/bash

echo "Please provide the path to your file"

read file

if [ -f "$file" ]; then
    file_permissions=$(stat -c %A $file| awk -F '-' '{print $2}')
    if [[ $file_permissions =~ "rwxr" ]]; then
        echo "The file is readable, writable, and executable"
    else
        echo "The file is not readable, writable, and executable"
    fi
    
else
    echo "the file does not exist at the path provided"
fi 
