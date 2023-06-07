#!/bin/bash

# Check if required tools are installed
command -v msfvenom >/dev/null 2>&1 || { echo >&2 "msfvenom is required but not installed. Aborting."; exit 1; }

# Read the PowerShell command from user input
read -p "Enter the PowerShell command: " powershell_command

# Convert PowerShell command to shellcode using msfvenom
shellcode=$(msfvenom -p windows/exec CMD="$powershell_command" -f raw)

# Check if shellcode generation was successful
if [ -z "$shellcode" ]; then
  echo "Failed to generate shellcode. Aborting."
  exit 1
fi

# Output the shellcode to a binary file
read -p "Enter the output file name (e.g., output.bin): " output_file
echo -n "$shellcode" > "$output_file"

echo "Shellcode successfully generated and saved to $output_file."
