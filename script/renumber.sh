#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <type>"
  echo "       type: 'file' to rename files only, 'folder' to rename folders only, 'both' to rename both"
  exit 1
fi

# Initialize a counter
counter=1

# Get the type of items to rename from the argument
type=$1

# Loop through all items in the current directory
for item in *; do
  # Check if the item matches the specified type
  if [ "$type" == "file" ] && [ -f "$item" ]; then
    # Rename files only
    new_name="${counter}_${item}"
    mv "$item" "$new_name"
    counter=$((counter + 1))
  elif [ "$type" == "folder" ] && [ -d "$item" ]; then
    # Rename folders only
    new_name="${counter}_${item}"
    mv "$item" "$new_name"
    counter=$((counter + 1))
  elif [ "$type" == "both" ]; then
    # Rename both files and folders
    new_name="${counter}_${item}"
    mv "$item" "$new_name"
    counter=$((counter + 1))
  fi
done

echo "Renaming completed!"
