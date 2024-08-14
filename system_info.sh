#!/bin/bash

options=("IP Addresses" "Current User" "CPU Information" 
"Memory Information" "Top 5 Memory Processes" "Top 5 CPU Processes" 
"Network Connectivity" "Quit")

# Function to check network connectivity and print response
check_connectivity_response() {
    local host=$1
    # Send a single ping request to the host and suppress both standard output and error
    # - `ping -c 1 "$host"`: Sends a single ping packet (`-c 1`) to the specified host.
    # - `&> /dev/null`: Redirects both standard output and standard error to `/dev/null`, effectively silencing all output from the `ping` command.
    # - `if ...; then`: Checks the exit status of the `ping` command.
    #   - If the exit status is `0`, the host is reachable, and the code inside the `then` block will be executed.
    #   - If the exit status is non-zero, the host is not reachable, and the `else` block will be executed.
    if ping -c 1 "$host" &> /dev/null; then
        # Perform a ping test to host with 4 packets and capture the output
        # - `packet.*transmitted.*loss`: Matches lines that include "packet" followed by any text, then "transmitted" followed by any text, and finally "loss".
        stats=$(ping -c 4 $host | grep -E 'packet.*transmitted.*loss')
        # Extract the packet loss percentage from the captured statistics
        # - `echo $stats`: Outputs the captured ping statistics.
        # - `awk -F ',' '{print $4}'`: Splits the output by commas and prints the 4th field, which contains the packet loss information.
        # - `sed 's/^[[:space:]]*//;s/[[:space:]]*$//'`: Trims leading and trailing spaces from the extracted field.
        # - `awk '{print $2}'`: Extracts the second word (percentage value) from the trimmed string.
        time=$(echo $stats | awk -F ',' '{print $4}' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//'| awk '{print $ 2}')
        # Extract the packet loss percentage from the captured statistics
        # - `echo $stats`: Outputs the captured ping statistics.
        # - `awk -F ',' '{print $3}'`: Splits the output by commas and prints the 3rd field, which contains the packet loss percentage.
        # - `sed 's/^[[:space:]]*//;s/[[:space:]]*$//'`: Trims leading and trailing spaces from the extracted field.
        loss=$(echo $stats | awk -F ',' '{print $3}' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

        echo "It took $time to connect to $host and there was $loss"
    else
        echo "Host $host is not reachable. Please check the address and try again."
    fi
}

echo "Please choose from the following menu of system checks"

# The `select` command in Bash provides a simple way to create a menu-driven user interface
# - `select` generates a numbered list of options from the array provided.
# - The user can choose an option by entering the corresponding number.
# - The variable specified after `select` (in this case, `choice`) will store the selected option from the list.
# - The `do` block contains the code that will be executed based on the user's selection.
# - The script will repeatedly display the menu until a valid choice is made or the script is exited.
select choice in "${options[@]}"; do
    case $choice in
        "IP Addresses")
            echo "Displaying IP Addresses:"
            # Display the user's public and private IP addresses
            # - `curl -s ifconfig.me`: Uses `curl` to fetch the public IP address from `ifconfig.me`. The `-s` option suppresses progress and error messages, providing only the IP address.
            # - `$(...)`: Command substitution syntax used to execute the command inside the parentheses and insert its output into the string.
            # - `hostname -I`: Retrieves the private IP address(es) assigned to the local machine. The `-I` option prints all IP addresses associated with the hostname.
            # - `echo "Your public IP address is: $(...) and your private IP address is: $(...)"`: Combines both pieces of information into a single string and prints it to the terminal.
            echo "Your public IP address is: $(curl -s ifconfig.me), and your private IP address is: $(hostname -I)"
            ;;
        "Current User")
            echo "Displaying Current User:"
            # - `whoami`: A command that returns the username of the user currently logged in to the shell.
            echo "You are $(whoami)"
            ;;
        "CPU Information")
            echo "Displaying CPU Information:"
            # - `nproc`: A command that returns the number of processing units (CPUs) available to the current process.
            echo "The system has $(nproc) CPU(s)."
            ;;
        "Memory Information")
            echo "Displaying Memory Information:"
            # Get the amount of unused memory in Mebibytes
            # - `free -b`: Displays memory statistics in bytes.
            # - `grep Mem`: Filters the output to find the line starting with "Mem:", which contains memory usage statistics.
            # - `awk '{print $4 / 1048576}'`: Processes the filtered line to extract and convert the unused memory value.
            #   - `$4`: Refers to the 4th field in the "Mem:" line, which is the amount of unused memory in bytes.
            #   - `/ 1048576`: Divides the unused memory in bytes by 1,048,576 to convert it to mebibytes (MiB).
            unused_memory=$(free -b | grep Mem | awk '{print $4 / 1048576}')
            # Get the total amount of memory in Mebibytes
            total_memory=$(free -b | grep Mem | awk '{print $2 / 1048576}')
            echo "There is $unused_memory Mebibyte unused memory of total $total_memory Mebibyte."

            ;;
        "Top 5 Memory Processes")
            echo "Displaying Top 5 Memory-Consuming Processes:"
            ps aux --sort=-%mem | head -n 6
            ;;
        "Top 5 CPU Processes")
            echo "Displaying Top 5 CPU-Consuming Processes:"
            ps aux --sort=-%cpu | head -n 6
            ;;
        "Network Connectivity")
            # Ask user for a website or IP address to connect to first
            echo "Please provide a website or IP address"
            # Read input from the user
            read host
            # Check to see if its a valid host and get response
            check_connectivity_response "$host"
            ;;
        "Quit")
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
done