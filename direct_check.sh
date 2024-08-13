#!/bin/bash

current_directory=$(pwd)

if [ ! -d "$current_directory/backup" ]; then
  mkdir "$current_directory/backup"
  echo "Directory created: backup"
else
  echo "Directory already exists: backup"   
fi