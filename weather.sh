#!/bin/bash

echo "Please type todays weather"
read weather

if [[ "$weather" == "sunny" ]]; then
    echo "Today's weather is $weather"
else
    echo "Today's weather is not sunny it is $weather" 
fi