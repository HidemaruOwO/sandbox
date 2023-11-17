#!/bin/bash

if ! command -v 7z &> /dev/null; then
    echo "Error: 7z command not found. Please install 7zip."
    exit 1
fi

if [ "$#" -eq 0 ]; then
    echo "Error: Missing folder argument. Please provide at least one folder to convert."
    echo "Usage: $0 <directory1> [<directory2> ...]"
    exit 1
fi

script_directory=$(dirname "$(realpath "$0")")
echo -e "Converten:"

for folder_to_convert in "$@"; do
    find "$folder_to_convert" -type d | while IFS= read -r folder; do
        zip_file="$folder.zip"
        7z a "$zip_file" "./$folder"/* > /dev/null
        cbz_file="${zip_file%.*}.cbz"
        mv "$zip_file" "$cbz_file"
        echo "-- $cbz_file"
    done
done

echo -e "Finished"
