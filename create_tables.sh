#!/bin/bash 

read -p "Enter the directory path: " directory
if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' not found."
    exit 1
fi
output_file="create"
rm -f "$directory/$output_file"
for file in "$directory"/*.sql; do
    filename=$(basename "$file")
    echo "\\i $filename" >> "$directory/$output_file"
done

echo "Files processed. Output written to $output_file"
