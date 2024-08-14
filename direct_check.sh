#!/bin/bash

current_directory=$(pwd)

echo "what directory are you looking for?" 
read dir

if [ ! -d "$current_directory/$dir" ]; then
  echo "Creating directory $dir"
  mkdir "$current_directory/$dir"
  echo "Directory created: $dir"
else
  echo "Directory already exists: $dir"   
fi