#!/bin/bash

# Dotfiles installation script
# This script creates symlinks from your dotfiles repo to their proper locations

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# ============================================
# Configure your dotfiles here
# ============================================

# .config files (these go in ~/.config/)
CONFIG_FILES=(
    "hypr"
    "quickshell"
    "kitty"
    "dolphinrc"
)

# Home directory files (these go in ~/)
HOME_FILES=(
    ".zshrc"
    ".gitconfig"
)

# Get the directory where this script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Installing dotfiles from $DOTFILES_DIR"
echo ""

# Function to create a symlink
create_symlink() {
    local source="$1"
    local target="$2"
    
    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$target")"
    
    # Check if target already exists
    if [ -e "$target" ] || [ -L "$target" ]; then
        if [ -L "$target" ]; then
            # It's already a symlink
            local current_source=$(readlink "$target")
            if [ "$current_source" = "$source" ]; then
                echo -e "${GREEN}✓${NC} $target already linked correctly"
                return 0
            else
                echo -e "${YELLOW}!${NC} $target is a symlink to a different location"
            fi
        else
            echo -e "${YELLOW}!${NC} $target already exists (not a symlink)"
        fi
        
        # Ask user what to do
        read -p "  Backup and replace? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            mv "$target" "${target}.backup.$(date +%Y%m%d_%H%M%S)"
            echo -e "  ${GREEN}Backed up${NC} to ${target}.backup.*"
        else
            echo -e "  ${RED}Skipped${NC} $target"
            return 1
        fi
    fi
    
    # Create the symlink
    ln -s "$source" "$target"
    echo -e "${GREEN}✓${NC} Linked $target -> $source"
}

# ============================================
# Installation
# ============================================

echo "Creating symlinks for .config files..."
for file in "${CONFIG_FILES[@]}"; do
    source_path="$DOTFILES_DIR/$file"
    target_path="$HOME/.config/$file"
    
    if [ -e "$source_path" ]; then
        create_symlink "$source_path" "$target_path"
    else
        echo -e "${YELLOW}!${NC} $source_path not found, skipping"
    fi
done

echo ""
echo "Creating symlinks for home directory files..."
for file in "${HOME_FILES[@]}"; do
    source_path="$DOTFILES_DIR/$file"
    target_path="$HOME/$file"
    
    if [ -e "$source_path" ]; then
        create_symlink "$source_path" "$target_path"
    else
        echo -e "${YELLOW}!${NC} $source_path not found, skipping"
    fi
done

echo ""
echo -e "${GREEN}Done!${NC} Dotfiles installation complete."
echo ""
echo "Note: Any existing files were backed up with a timestamp."
