#!/bin/bash

# This is the diman wrapper script

# Download the main script using wget
wget https://github.com/rvikyada/direman/blob/28a681f77b44b55340ee8c6a49d77cfe249ef6d9/Download-cleaner.sh -o dir_manager.sh

# Make the script executable
chmod +x dir_manager.sh

# Run the main script
./dir_manager.sh
