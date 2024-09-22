#!/bin/bash

# Reads the content of access.log.
# Extracts only the IP addresses.
# Counts the occurrences of each IP address to identify how many requests came from each IP.(unique addresses)
# Sorts the list by the number of requests in descending order.Saves the sorted list to a file called ip_counts.txt.

file="/home/ubuntu/access.log"

if [ -f "$file" ]; then
    echo "file exists."
    
    cat access.log | awk '{print $(NF-2)}' | sort | uniq -c | sort -r| > ip_count.txt

    cat ip_count.txt
else
    echo "file does not exist please run the file on github"
fi