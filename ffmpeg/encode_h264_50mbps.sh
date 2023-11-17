#!/bin/bash

# Check if FFmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo "FFmpeg is not installed. Please install it and try again."
    exit 1
fi

# Error message if no arguments are provided
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <input file 1> [<input file 2> ...]"
    exit 1
fi

# Convert all specified files in the arguments
for input_file in "$@"; do
    # Get the input file's extension
    filename=$(basename -- "$input_file")
    extension="${filename##*.}"

    # Create the output file name
    output_file="${filename%.*}_h264.mp4"

    # Convert using FFmpeg
    ffmpeg -i "$input_file" -vb 50000k -c:v h264_amf -c:a copy -quality quality "$output_file"

    if [ $? -eq 0 ]; then
        echo "File $input_file has been converted to $output_file."
    else
        echo "An error occurred while converting file $input_file."
    fi
done

