#!/bin/bash

# Define the file to store the value
HISTORY_FILE="$HOME/.DIMAN_PATH"

# Check if the user provided the second argument
if [ -z "$2" ]; then
    # Use the stored value from the file if it exists
    if [ -f "$HISTORY_FILE" ]; then
        DIMAN_PATH=$(cat "$HISTORY_FILE")
        echo "Using the stored value: $DIMAN_PATH"
    else
        echo "No stored value found."
    fi
else
    # Save the second argument for future use
    DIMAN_PATH="$2"
    echo "$DIMAN_PATH" > "$HISTORY_FILE"
    echo "Storing the value: $DIMAN_PATH"
fi

# # Directory where the files to be organized are located
echo "Final is "$DIMAN_PATH"."
cd "$DIMAN_PATH"
