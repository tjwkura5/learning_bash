#!/bin/bash


# Define the source file containing the web server access logs
source_file="/home/ubuntu/web-server-access-logs.log"

# Use grep to filter lines containing the pattern 'HTTP/1.1"" 404' from the source file
# This pattern matches HTTP requests that returned a 404 status code
grep 'HTTP/1.1"" 404' "$source_file" |

# Use awk to extract the second field from the matching lines, which represents the IP address
# -F '[ ,"]+' sets the field separator to spaces, commas, or quotes
awk -F '[ ,"]+' '{print $2}' |

# Use uniq with the -c option to count the occurrences of each unique IP address
# This gives the count of how many times each IP address encountered a 404 error
uniq -c

