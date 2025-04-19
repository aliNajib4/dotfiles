#!/bin/bash

# Fixed starting temperature (in Kelvin)
START_TEMP=5000

# Temperature step (in Kelvin)
STEP=500

# Minimum and maximum temperature limits (in Kelvin)
MIN_TEMP=1000
MAX_TEMP=25000

# File to store the current temperature
TEMP_FILE="/tmp/current_temp.txt"

# Read the current temperature from the file, or use the starting temperature if the file doesn't exist
if [ -f "$TEMP_FILE" ]; then
    CURRENT_TEMP=$(cat "$TEMP_FILE")
else
    CURRENT_TEMP=$START_TEMP
fi

# Function to validate temperature
validate_temp() {
    if [ "$1" -lt "$MIN_TEMP" ]; then
        echo "Temperature cannot be below $MIN_TEMP K. Setting to $MIN_TEMP K."
        NEW_TEMP=$MIN_TEMP
    elif [ "$1" -gt "$MAX_TEMP" ]; then
        echo "Temperature cannot be above $MAX_TEMP K. Setting to $MAX_TEMP K."
        NEW_TEMP=$MAX_TEMP
    else
        NEW_TEMP=$1
    fi
}

# Check for arguments
if [ "$1" == "inc" ]; then
    NEW_TEMP=$((CURRENT_TEMP - STEP))
    validate_temp $NEW_TEMP
    echo "Increasing temperature to $NEW_TEMP K"
    redshift -x
    redshift -O $NEW_TEMP -m randr
elif [ "$1" == "dec" ]; then
    NEW_TEMP=$((CURRENT_TEMP + STEP))
    validate_temp $NEW_TEMP
    echo "Decreasing temperature to $NEW_TEMP K"
    redshift -x
    redshift -O $NEW_TEMP -m randr
elif [ "$1" == "reset" ]; then
    NEW_TEMP=$START_TEMP
    validate_temp $NEW_TEMP
    echo "Resetting temperature to $NEW_TEMP K"
    redshift -x
    redshift -O $NEW_TEMP -m randr
else
    echo "Usage: $0 [inc|dec|reset]"
    echo "Current temperature: $CURRENT_TEMP K"
    exit 1
fi

# Save the new temperature to the file
echo "$NEW_TEMP" > "$TEMP_FILE"
