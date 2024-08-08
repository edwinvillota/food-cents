#!/bin/bash

# Define color codes
GREEN='\033[0;32m'
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

print_message "$BLUE" "Script execution started at $(date)"

# Change directory
script_dir=$(dirname "$0")
print_message "$YELLOW" "Entering directory: $script_dir/.."
cd "$script_dir/.." || exit

# Display .env file contents
print_message "$BLUE" "Contents of .env file:"
print_line
cat .env
print_line

# Load environment variables
print_message "$YELLOW" "Loading environment variables..."
export $(grep -v '^#' .env | xargs)

# Count loaded variables
var_count=$(grep -v '^#' .env | wc -l)

print_message "$GREEN" "Successfully loaded $var_count environment variables"

print_line
print_message "$BLUE" "Script execution completed at $(date)"
print_line