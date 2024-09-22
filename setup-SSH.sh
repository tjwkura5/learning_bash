#!/bin/bash

# Variables
# Path to the script that will be copied and executed on the remote server
FILE_PATH="/home/ubuntu/scripts/start_app.sh"

# IP address of the remote server (App server)
REMOTE_IP="10.0.132.86"

# Path to the SSH private key used for authentication
SSH_KEY="/home/ubuntu/.ssh/app-key.pem"

# Step 1: Securely copy the script to the remote server
# Using scp to transfer the file, with StrictHostKeyChecking set to "no" to avoid interactive key prompts
scp -i "${SSH_KEY}" -o StrictHostKeyChecking=no "${FILE_PATH}" ubuntu@"${REMOTE_IP}":"${FILE_PATH}"

# Check the exit status of the scp command
# $? holds the exit status of the last executed command (0 means success, non-zero means failure)
if [ $? -eq 0 ]; then
    echo "File copied successfully."
else
    echo "Failed to copy the file."
    exit 1  # Exit the script if the copy failed
fi

# Step 2: SSH into the remote server
# The '<< 'EOF'' syntax is used to create a "here document," which allows you to send multiple lines of input to a command
# Everything between 'EOF' and 'EOF' is treated as input to the SSH command
ssh -i "${SSH_KEY}" -o StrictHostKeyChecking=no ubuntu@"${REMOTE_IP}" << 'EOF'

    # Check if the SSH connection was successful
    if [ $? -ne 0 ]; then
        echo "Failed to connect to the remote server."
        exit 1  # Exit if the SSH connection failed
    fi

    # Print a message confirming the connection to the remote server
    echo "Connected to the remote server."

    # Print the IP address of the remote server using the hostname command
    echo "The IP address of this server is: $(hostname -I | awk '{print $1}')"

    # Run the start_app.sh script on the remote server
    echo "Running the Start App Script..."
    bash /home/ubuntu/scripts/start_app.sh  # Executes the script located on the remote server

EOF

# Exit the script successfully after completing all steps
exit 0
