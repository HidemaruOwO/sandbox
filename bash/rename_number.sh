#!/bin/bash

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <directory1> [<directory2> ...]"
    exit 1
fi

IFS=$'\n'

for directory in "$@"; do
    if [ ! -d "$directory" ]; then
        echo "Error: Directory '$directory' not found."
        exit 1
    fi

    files=($(find "$directory" -type f | sort))

    if [ ${#files[@]} -eq 0 ]; then
        echo "Error: No files found in the specified directory '$directory'."
        exit 1
    fi

    counter=1

    for file in "${files[@]}"; do
        extension="${file##*.}"
        new_name=$(printf "%05d.%s" $counter "$extension")
        mv "$file" "$directory/$new_name"
        ((counter++))
    done

    echo "Renaming complete for directory '$directory'."
done
