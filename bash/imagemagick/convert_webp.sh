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

  find "$directory" -type f \( -iname "*.avif" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) -print0 | while IFS= read -r -d $'\0' file; do
    echo "Converting ${file}..."
    new_file="${file%.*}.webp"
    magick "$file" "$new_file"
    rm "$file"
  done

  echo "Conversion for directory $directory completed."
done

echo "All conversions completed."
