#!/bin/bash

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to print colored and tagged output
print_tagged() {
    local tag=$1
    local message=$2
    local color=$3
    echo -e "${color}[${tag}]${NC} ${message}"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install stow if not already installed
install_stow() {
    if ! command_exists stow; then
        print_tagged "INSTALL" "Installing stow..." "${YELLOW}"
        if command_exists apt-get; then
            sudo apt-get update && sudo apt-get install -y stow
        elif command_exists pacman; then
            sudo pacman -Sy stow
        elif command_exists dnf; then
            sudo dnf install stow
        else
            print_tagged "ERROR" "Package manager not found. Please install stow manually." "${RED}"
            exit 1
        fi
    else
        print_tagged "INFO" "stow is already installed." "${BLUE}"
    fi
}

# Apply dotfiles using stow
apply_dotfiles() {
    local dotfiles_dir="$HOME/.dotfiles" 
    local packages=("base" "config" "fonts" "gtk-theme" "helix" "hypr" "kitty" "nvim" "wallpapers")

    print_tagged "APPLY" "Applying dotfiles..." "${CYAN}"
    cd "$dotfiles_dir" || exit 1

    for package in "${packages[@]}"; do
        print_tagged "STOW" "Applying ${package}..." "${YELLOW}"
        if stow -R -t "$HOME" "$package"; then
            print_tagged "SUCCESS" "${package} stowed successfully." "${GREEN}"
        else
            print_tagged "ERROR" "Failed to stow ${package}." "${RED}"
        fi
    done

    print_tagged "COMPLETE" "Dotfiles applied successfully. Backup created at ${backup_dir}" "${GREEN}"
}

# Main script execution
main() {
    print_tagged "START" "Beginning dotfiles bootstrap process..." "${BLUE}"
    install_stow
    apply_dotfiles
    print_tagged "WARNING" "SDDM Theme is not applied. Refer README for instructions" "${YELLOW}"
    print_tagged "END" "Bootstrap process completed." "${BLUE}"
}

main
