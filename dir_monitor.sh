#!/bin/bash

# Prompt the user to provide the directory path
echo "Please provide the directory path"

# Read the user input into the 'directory' variable
read directory

# Check if the provided input is a valid directory
if [ -d "$directory" ]; then
    # If it is a valid directory, calculate the size in MB using 'du' and store the result in the 'size' variable
    size=$(du -sm "$directory" | awk '{print $1}')
    
    # Check if the size of the directory is greater than 100MB
    if [ "$size" -gt 100 ]; then
        # Extract the directory name from the path (basename of the directory)
        dir_name=$(basename "$directory")
        # If the directory size exceeds 100MB, print a warning message
        echo "Warning: Directory exceeds 100MB"
        
        # Compress the directory into a zip file named 'output.zip'
        zip -r "${dir_name}.zip" "$directory"
        
        # Inform the user that the directory has been zipped
        echo "We just zipped the dir for you!"
    else
        # If the directory size is 100MB or less, print a message indicating everything is fine
        echo "You are good!"
    fi
else
    # If the provided input is not a valid directory, print an error message
    echo "The directory provided does not exist"
fi
