#!/bin/bash

if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <directory1> [<directory2> ...]"
    exit 1
fi

for dir in "$@"; do
    if [ ! -d "$dir" ]; then
        echo "Error: Directory '$dir' does not exist. Skipping."
        continue
    fi

    cd "$dir" || exit 1

    for file in *; do
        extension="${file##*.}"

        new_name=$(printf "%05d.$extension" "${file%%.*}")

        mv "$file" "$new_name"
    done

    echo "Changes completed in directory '$dir'."
done
