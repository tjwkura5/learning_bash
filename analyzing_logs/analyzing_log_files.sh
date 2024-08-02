#!/bin/bash

# Define the source and destination file paths
source_file="/var/log/auth_log.log"
destination_file="/var/log/suspicious_activity.log"
# Suspiscious keywords list
keywords=("Authentication failure" "Unauthorized" "Failed" "invalid" "error")


# Check if the destination file exists
if [ ! -f "$destination_file" ]; then
  # Create the destination file if it doesn't exist
  touch "$destination_file"
  echo "File created: $destination_file"
else
  # Inform the user if the file already exists
  echo "File already exists: $destination_file" 
fi


# Open the source file for reading and process each line
while IFS= read -r line; do
  # Iterate through each keyword in the list
  for keyword in "${keywords[@]}"; do
    # Check if the current line contains the keyword
    if [[ "$line" =~ "$keyword" ]]; then
      # Write the line containing the keyword to the destination file
      echo "$line" >> "$destination_file"
      # Print a message indicating the found keyword and line
      echo "Found keyword '$keyword' in line: $line"
      # Exit the inner loop since the keyword has been found
      break
    fi
  done
done < "$source_file"

#The last part of the script redirects the input of the while loop to the content of the file specified by the $source_file variable.
#It tells the while loop to read its input from the file instead of the standard input (keyboard).
#This is a common way to process the contents of a file line by line in Bash scripts.







