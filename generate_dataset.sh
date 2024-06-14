#!/bin/bash

# Define the folder paths
DATA_FOLDER="data"
EXTRACTED_FOLDER="extracted_data"

# Function to check if a command exists
command_exists () {
    command -v "$1" >/dev/null 2>&1 ;
}

# Check for unzip command
if ! command_exists unzip; then
    echo "unzip command is not found. Do you want to install it? (yes/no)"
    read response
    if [[ "$response" == "yes" ]]; then
        sudo apt-get update
        sudo apt-get install unzip
    else
        echo "unzip is required to run this script. Exiting."
        exit 1
    fi
fi

# Check for zip command
if ! command_exists zip; then
    echo "zip command is not found. Do you want to install it? (yes/no)"
    read response
    if [[ "$response" == "yes" ]]; then
        sudo apt-get update
        sudo apt-get install zip
    else
        echo "zip is required to run this script. Exiting."
        exit 1
    fi
fi

# Create the extracted folder if it doesn't exist
mkdir -p "$EXTRACTED_FOLDER"

# Navigate to the data folder
cd "$DATA_FOLDER"

# Combine the multi-part zip files
cat dataset.zip.* > combined_dataset.zip

# Unzip the combined zip file
unzip combined_dataset.zip -d "../$EXTRACTED_FOLDER"

# Clean up the combined zip file
rm combined_dataset.zip

echo "Extraction completed. Files are available in the '$EXTRACTED_FOLDER' folder."
