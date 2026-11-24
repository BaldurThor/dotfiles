# My Dotfiles

This repository holds my personal configuration files for Linux. The setup is designed to be highly portable, safe, and entirely self-contained.

## 📦 Prerequisites

Before running the install script, ensure you have the required packages installed. The script will check for these and fail safely if they are missing.

Look at `packages.txt` for the full list

## 🚀 Installation

Clone the repository anywhere on your system. The install script dynamically resolves paths, so it doesn't matter where it lives (e.g., `~/dotfiles` or `~/extras/dotfiles`).

```bash
# 1. Clone the repo and initialize the submodules (for Zsh plugins)
git clone --recurse-submodules https://github.com/BaldurThor/dotfiles.git ~/dotfiles

# 2. Enter the directory
cd ~/dotfiles

# 3. Install packages
sudo pacman -S --needed - < packages.txt

# 4. Make the script executable (first time only)
chmod +x install.sh

# 5. Run the installer
./install.sh
