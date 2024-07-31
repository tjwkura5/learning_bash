#!/bin/bash

valid_operations=("addition" "subtraction" "multiplication" "division")

# Get first number with validation
while true; do
  echo "What is your first number?"
  read numberOne
  # Using regex to determine whether or not user input is an integer
  if [[ "$numberOne" =~ ^[0-9]+$ ]]; then
    echo "You have selected $numberOne"
    break
  else
    echo "Invalid input. Please enter an integer."
  fi
done

# Get second number with validation
while true; do
  echo "What is your second number?"
  read numberTwo
  if [[ "$numberTwo" =~ ^[0-9]+$ ]]; then
    echo "You have selected $numberTwo"
    break
  else
    echo "Invalid input. Please enter an integer."
  fi
done

function calculate {
  # Declare local variables for operation, numbers, and result
  local op="$1"
  local num1="$2"
  local num2="$3"
  local result

  # Use a case statement to perform the specified operation
  case "$op" in
    "addition")
      # Calculate the sum of num1 and num2 using bc
      # bc stands for Basic Calculator.
      # The output of the echo command (the arithmetic expression) is piped to the bc command.
      # The output of the bc command is captured and stored in the result variable.
      result=$(echo "$num1 + $num2" | bc)
      ;;
    "subtraction")
      # Calculate the difference between num1 and num2 using bc
      result=$(echo "$num1 - $num2" | bc)
      ;;
    "multiplication")
      # Calculate the product of num1 and num2 using bc
      result=$(echo "$num1 * $num2" | bc)
      ;;
    "division")
      # Check for division by zero
      if [ $num2 -eq 0 ]; then
        result="Division by zero is not allowed"
      else
        # Calculate the division with two decimal places using bc
        result=$(echo "scale=2; $num1 / $num2" | bc)
      fi
      ;;
    *)
      # Handle invalid operation
      result="Invalid operation"
      ;;
  esac

  # Return the calculated result
  echo "$result"
}

# Choose operation with validation
while true; do
  echo "Please choose from the following operations: ${valid_operations[@]}"
  read option
  # Convert user input to lower case
  lowercase_option=$(echo "$option" | tr '[:upper:]' '[:lower:]')

  # Iterate over valid options to check for a match
  for valid_op in "${valid_operations[@]}"; do
    if [[ "$lowercase_option" == "$valid_op" ]]; then
      echo "Valid option selected: $lowercase_option"
      result=$(calculate "$lowercase_option" "$numberOne" "$numberTwo")
      echo "The result is: $result"
      break 2  # Break out of both inner and outer loops
    fi
  done

  if [[ "$lowercase_option" != "${valid_operations[@]}" ]]; then
    echo "Invalid option!"
  fi
done
