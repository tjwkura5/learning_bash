#!/bin/bash

# Write a script that lists all 
# running processes and allows the 
# user to kill a process by entering its PID.


echo "The following are all of your running processes"
ps -aux


while true; do
    echo "Please provide the PID for the process you would like to kill: "

    read process

    if [[ "$process" =~ ^[0-9]+$ ]]; then
        if ps -p "$process" &> /dev/null; then
            break 
        else
            echo "The process with PID: $process does not exit. Please try again."
        fi
    else
        echo "Invalid input. Please enter a number."
    fi
done 


# Attempt to kill the process gracefully
if kill "$process" &> /dev/null; then
    echo "Successfully sent termination signal to process $process."

    # If the process is still running, force kill
    sleep 2
    if ps -p "$process" &> /dev/null; then
        echo "Process $process did not terminate. Forcibly killing..."
        kill -9 "$process"
        echo "Process $process has been forcefully killed."
    fi
else
    echo "Failed to send termination signal to process $process."
fi