#!/usr/bin/env bash

# Get the absolute path to the dotfiles directory so the script works from anywhere
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create a timestamped backup directory (only created if needed)
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$DOTFILES_DIR/backups/backup_$TIMESTAMP"

# --- Step 0: Check Dependencies ---
PACKAGES_FILE="$DOTFILES_DIR/packages.txt"

if [ -f "$PACKAGES_FILE" ]; then
    echo "Checking dependencies..."
    MISSING_PACKAGES=()
    
    # Read the file line by line
    while IFS= read -r pkg || [ -n "$pkg" ]; do
        # Clean up whitespace and skip empty lines or comments
        pkg=$(echo "$pkg" | xargs)
        [[ -z "$pkg" || "$pkg" == \#* ]] && continue
        
        # Check if the command exists on the system
        if ! command -v "$pkg" &> /dev/null; then
            MISSING_PACKAGES+=("$pkg")
        fi
    done < "$PACKAGES_FILE"

    # If anything is missing, alert the user and kill the script
    if [ ${#MISSING_PACKAGES[@]} -ne 0 ]; then
        echo -e "\n❌ Missing required dependencies!"
        echo "Please install the following packages before running this script:"
        for missing in "${MISSING_PACKAGES[@]}"; do
            echo "  - $missing"
        done
        echo -e "\nExiting."
        exit 1
    fi
    echo -e "All dependencies met! ✅\n"
fi

# --- Step 1: Ensure required directories exist ---
echo "Creating required directories..."
mkdir -p "$HOME/.local/state/vim"
mkdir -p "$HOME/.cache/zsh"
mkdir -p "$HOME/.config"

# --- Initialize and update Git submodules ---
echo "Updating Git submodules..."
git -C "$DOTFILES_DIR" submodule update --init --recursive

# --- Helper function for symlinking and backing up ---
link_item() {
    local source_path="$1"
    local target_path="$2"

    # Check if the target is already a symlink
    if [ -L "$target_path" ]; then
        local current_target
        current_target=$(readlink "$target_path")
        
        if [ "$current_target" = "$source_path" ]; then
            echo "Skipping: $target_path is already correctly symlinked."
            return
        else
            echo "Replacing symlink: $target_path"
            echo "  Old target: $current_target"
            echo "  New target: $source_path"
            rm "$target_path"
        fi
    # If it is a real file or directory (not a symlink), back it up
    elif [ -e "$target_path" ]; then
        mkdir -p "$BACKUP_DIR"
        echo "Backing up existing file/dir $target_path to $BACKUP_DIR"
        mv "$target_path" "$BACKUP_DIR/"
    fi

    # Create the symlink
    echo "Symlinking: $target_path -> $source_path"
    ln -s "$source_path" "$target_path"
}

# --- Step 2: Symlink root files ---
echo -e "\nLinking root dotfiles..."
for file in "$DOTFILES_DIR"/*; do
    if [ -f "$file" ] && [ "$(basename "$file")" != "install.sh" ] && [ "$(basename "$file")" != ".gitignore" ] && [ "$(basename "$file")" != ".gitignore" ]; then
        filename="$(basename "$file")"
        link_item "$file" "$HOME/.$filename"
    fi
done

# --- Step 3: Symlink config items ---
echo -e "\nLinking config items..."
if [ -d "$DOTFILES_DIR/config" ]; then
    # Loop through all files AND folders inside dotfiles/config/
    for item in "$DOTFILES_DIR/config"/*; do
        if [ -e "$item" ]; then
            itemname="$(basename "$item")"
            link_item "$item" "$HOME/.config/$itemname"
        fi
    done
fi

echo -e "\nInstallation complete! 🚀"
