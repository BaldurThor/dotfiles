# My Dotfiles

This repository holds my personal configuration files for Linux. The setup is designed to be highly portable, safe, and entirely self-contained.

## 📦 Prerequisites

Before running the install script, ensure you have the required packages installed. The script will check for these and fail safely if they are missing.

Look at `packages.txt` for the full list

## 🚀 Installation

Clone the repository anywhere on your system. The install script dynamically resolves paths, so it doesn't matter where it lives (e.g., `~/dotfiles` or `~/extras/dotfiles`).

### 1. Clone the repo and initialize the submodules (for Zsh plugins)
```bash
git clone --recurse-submodules https://github.com/BaldurThor/dotfiles.git /usr/local/share/dotfiles
```
### 2. Enter the directory
```bash
cd /usr/local/share/dotfiles
```
### 3. Install packages
```bash
pacman -S --needed - < packages.txt
```
### 4. Make the script executable (first time only)
```bash
chmod +x install.sh
```
### 5. Run the installer
```bash
./install.sh
```
