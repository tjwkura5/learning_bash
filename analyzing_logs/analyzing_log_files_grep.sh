#!/bin/bash

# Define the source and destination file paths
source_file="/var/log/auth_log.log"
destination_file="/var/log/suspicious_activity.log"

# Check if the destination file exists
if [ ! -f "$destination_file" ]; then
  # Create the destination file if it doesn't exist
  touch "$destination_file"
  echo "File created: $destination_file"
else
  # Inform the user if the file already exists
  echo "File already exists: $destination_file" 
fi

# This command searches for specific patterns within a log file and appends the matching lines to another file.

grep -Ei 'Authentication failure|Unauthorized|Failed|invalid|error' "$source_file" >> "$destination_file"

# Here's a breakdown of the command:

# grep: This is the command used for searching text patterns within a file.

# -E: Enables extended regular expressions, allowing for more complex pattern matching.

# -i: Makes the search case-insensitive.

# 'Authentication failure|Unauthorized|Failed|invalid|error': This is the search pattern. 
# It looks for any of the listed words within a line. The | character is used as an OR operator.

# $source_file: Specifies the input file to be searched.

# >> $destination_file: Appends the output of the grep command to the specified destination file.






