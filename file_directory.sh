#!/bin/bash

target_dir="/home/HQ"  # Use root  home directory

# States 
states=("New_York" "Florida" "Cali" "Texas" "Nevada" "Ohio")

# Departments
departments=("Engineers" "HR" "Accountants" "Directors")

# Create HQ directory 
mkdir "$target_dir"

# Loop through states and create subdirectories
for state in "${states[@]}"; do
  mkdir "$target_dir/$state"  
done

# Create Branch_A and Branch_B in California directory
cd "$target_dir/Cali"  # Change directory only once
mkdir Branch_A Branch_B

# Create department directories within Branch_A
cd Branch_A
for department in "${departments[@]}"; do
  mkdir "$department"
done

# Make 500 payroll directories that look like Payroll_1
mkdir $target_dir/Cali/Branch_A/HR/Payroll_{1..500}

# Create a pay.txt file in a random payroll directory
touch $target_dir/Cali/Branch_A/HR/Payroll_$(shuf -i 1-500 -n 1)/pay.txt

# Starting at the target directory find the path to the pay.txt file and store it in a variable
file_path=$(find $target_dir -name "pay.txt")

# Print the file path variable to the terminal
echo $file_path

# Move the pay.txt file to the payroll_1 dir and change the name
mv $file_path $target_dir/Cali/Branch_A/HR/Payroll_1/"pay_"$(date +%Y-%m-%d).txt

# List contents of payroll_1 dir
ls $target_dir/Cali/Branch_A/HR/Payroll_1