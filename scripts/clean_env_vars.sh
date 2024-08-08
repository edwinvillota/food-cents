#!/bin/bash

# Define color codes
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored and formatted messages
print_message() {
    local color=$1
    local message=$2
    echo -e "${color}[INFO] ${message}${NC}"
}

# Function to print a horizontal line
print_line() {
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

# Script start
print_line

print_message "$BLUE" "Environment Variable Cleanup Script"
print_message "$BLUE" "Started at $(date)"

# Change directory
script_dir=$(dirname "$0")
print_message "$YELLOW" "Changing to directory: $script_dir/.."
cd "$script_dir/.." || { print_message "$RED" "Failed to change directory. Exiting."; exit 1; }

# List variables to be unset
print_message "$YELLOW" "Preparing to unset the following variables:"
grep -v '^#' .env | sed -E 's/(.*)=.*/\1/' | sed 's/^/  - /'

# Count variables to be unset
var_count=$(grep -v '^#' .env | wc -l)

# Unset variables
print_message "$YELLOW" "Unsetting $var_count environment variables..."
unset $(grep -v '^#' .env | sed -E 's/(.*)=.*/\1/' | xargs)

print_message "$RED" "Enviro