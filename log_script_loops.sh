#!/bin/bash


# Define the source file containing the web server access logs
source_file="/home/ubuntu/web-server-access-logs.log"

if [ -f "$source_file" ] && [ -s "$source_file" ]; then
    errors=$(grep ' 404 ' "$source_file")    
    uniq_ips=$(echo "$errors" | awk '{print $1}'| cut -d'"' -f2| sort | uniq)

    # Convert the IP list to an array
    ip_array=($uniq_ips)

    # Iterate over the array of unique IPs and count occurrences
    for ip in "${ip_array[@]}"; do
        count=$(echo "$errors" | grep "$ip" | wc -l)
        echo "IP: $ip - Count: $count"
    done

else
    echo "The file is empty or does not exist."
fi

 # echo "$errors" | grep "66.249.66.194" |  wc -l

 # echo "$errors" | grep "151.239.241.163" |  wc -l

  # echo "$errors" | grep "86.105.136.196" |  wc -l
