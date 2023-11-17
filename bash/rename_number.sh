#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

directory="$1"

if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' not found."
    exit 1
fi

IFS=$'\n'

image_files=($(find "$directory" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.gif" -o -iname "*.bmp" -o -iname "*.webp" \) | sort))

if [ ${#image_files[@]} -eq 0 ]; then
    echo "Error: No image files found in the specified directory."
    exit 1
fi

counter=1

for file in "${image_files[@]}"; do
    extension="${file##*.}"
    new_name=$(printf "%05d.%s" $counter "$extension")
    mv "$file" "$directory/$new_name"
    ((counter++))
done

echo "Renaming complete."

