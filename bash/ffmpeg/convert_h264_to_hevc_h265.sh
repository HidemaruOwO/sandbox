#!/bin/bash
input_file="$1"

if [ $# -eq 0 ]; then
  echo "Error: Please specify the input file."
  echo "Command: $0 input.mp4"
  exit 1
fi

file_name=$(basename "$input_file")
output_file="${file_name%.*}_compressed.mkv"

bitrate=$(ffprobe -i "$input_file" -show_entries format=bit_rate -v quiet -of csv="p=0")
half_bitrate=$(awk "BEGIN {printf \"%.0f\", $bitrate / 2000}")

ffmpeg -i "$input_file" -c:v hevc_amf -b:v "${half_bitrate}k" -c:a aac -b:a 128k "$output_file"

echo "Reduced the bit rate to half and re-encoded to HEVC. Output file: $output_file"

