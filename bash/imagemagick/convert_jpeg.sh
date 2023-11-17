#!/bin/bash

if ! command -v magick &> /dev/null; then
  echo "Error: 'magick' command not found. Please install ImageMagick."
  exit 1
fi

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <directory1> [directory2 ...]"
  exit 1
fi

for directory in "$@"; do
  if [ ! -d "$directory" ]; then
    echo "Specified directory does not exist: $directory"
    exit 1
  fi

  find "$directory" -type f \( -iname "*.avif" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" \) -print0 | while IFS= read -r -d $'\0' file; do
    echo "Converting ${file} to JPEG..."
    new_file="${file%.*}.jpeg"
    magick "$file" "$new_file"
    rm "$file"
  done

  echo "Conversion for directory $directory completed."
done

echo "All conversions completed."
