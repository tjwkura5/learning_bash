#!/bin/bash

# Set a variable for password
psswd=password

# Define groups
groups=("Dev" "QA" "SysAd" "DBA" "Support" "Managers")

# Defines an array named directories containing elements in the format of path:group:permissions.
directories=(
    "/var/www:Dev:rwx"
    "/var/log:Dev:r"
    "/var/staging:QA:rx"
    "/:SysAd:rwx"
    "/var/lib/mysql:DBA:rwx"
    "/var/log/syslog:Support:r"
    "/var/reports/performance:Managers:r"
)


# Function to check if group exists and delete if necessary
# group_name=: Assigns the first command-line argument to the variable group_name
# id -g : Checks if the specified group exists.
# &> : This for redirection of both standard output and standard error
# /dev/null : A special file that discards all data written to it. That way there is not output to the counsel 
function check_and_delete_group() {
  group_name="$1"
  if getent group "$group_name" &> /dev/null; then
    groupdel "$group_name"
  fi
}

# Function to check if user exists and delete if necessary
# -r : Permanently delete the user's home directory and all its contents. 
# id -u : checks if a user exists 
function check_and_delete_user() {
  user_name="$1"
  if id -u "$user_name" &> /dev/null; then
    userdel -r "$user_name"
  fi
}
                                                                                                                 
# Delete and Create users, then set password, then set the user as the owner of their dir
users=("DevinDev" "KatyQA" "SaraSys" "DavidDBA" "SammySupport" "MaryManager")

for user in "${users[@]}"; do
  check_and_delete_user "$user" 
  useradd -m "$user"
  echo "$user:$psswd" | chpasswd
  chown "$user": /home/"$user"
Done

# Delete and Create groups
# Need to delete groups after users because if there are users still assigned to group the delete won't work
for group in "${groups[@]}"; do
  check_and_delete_group "$group" 
  groupadd "$group"
done

# Assign users to groups 
usermod -a -G Dev DevinDev
usermod -a -G QA KatyQA
usermod -a -G SysAd SaraSys
usermod -a -G DBA DavidDBA
usermod -a -G Support SammySupport
usermod -a -G Managers MaryManager

# Set ACLs
# Splits the current entry into three variables: path, group, and perms using the colon (:) as a delimiter. 
# Sets an ACL for the specified group with the given perms on the specified path
for entry in "${directories[@]}"; do
    IFS=':' read -r path group perms <<< "$entry"
    setfacl -m "g:$group:$perms" "$path"
done

# Display ACLs
paths=(
    "/"
    "/var/www"
    "/var/log"
    "/var/staging"
    "/var"
    "/var/lib/mysql"
    "/var/log/syslog"
    "/var/reports/performance"
)

for path in "${paths[@]}"; do
    getfacl "$path"
done