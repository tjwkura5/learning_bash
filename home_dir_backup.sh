#!/bin/bash

#Take all the files that are in our home directory and put them in a backup file and make sure all files are regular files
#Declare where and what we want to backup
#Make sure backup directory exist
#Every file into the backup directory
#check if its a regular file, copy file 
#If not skipping file

source="/home/ubuntu"
destination="/home/ubuntu/backup"

#if [ ! -d "$directory_path" ]; then: Checks if the directory doesn't exist (-d checks if it's a directory, ! negates the condition).
if [ ! -d "$destination" ]; then
  # mkdir -p "$directory_path": Creates the directory and any necessary parent directories if they don't exist (-p option).
  mkdir -p "$destination"
  echo "Directory created: $destination"
else
  echo "Directory already exists: $destination"   
fi

for file in "$source"/*; do
  if [ -f "$file" ]; then
    cp "$file" "$destination"
    echo "This file has been copied"
  else
    echo "Skipping, This $file is not a regular file"
  fi 
done