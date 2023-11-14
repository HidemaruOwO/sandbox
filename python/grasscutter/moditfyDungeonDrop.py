import json
import sys

if len(sys.argv) != 2:
    print("Usage: python moditfyDungeonDrop.py <json_file>")
    sys.exit(1)

json_file_path = sys.argv[1]

with open(json_file_path, 'r', encoding='utf-8') as file:
    json_data = json.load(file)

def triple_counts(value):
    return max(value * 3, 3)

def process_counts(data):
    if isinstance(data, list):
        for item in data:
            process_counts(item)
    elif isinstance(data, dict):
        if "counts" in data:
            data["counts"] = [triple_counts(count) for count in data["counts"]]
        for key, value in data.items():
            process_counts(value)

process_counts(json_data)

with open(json_file_path, 'w', encoding='utf-8') as output_file:
    json.dump(json_data, output_file, indent=2, ensure_ascii=False)

print(f"The modified JSON data has been written to {json_file_path}! ✨")
