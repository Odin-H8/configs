#!/bin/bash

DOTFILES_DIR="$(pwd)"
CONFIG_DIR="$HOME/.config"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Dotfiles Installation Script${NC}"
echo -e "${YELLOW}==========================${NC}\n"

# Function to install dependencies from a file
install_dependencies() {
    local file=$1
    local command=$2
    local sudo_prefix=$3

    if [ -f "$file" ]; then
        echo -e "\n${YELLOW}Found $file${NC}"
        echo -n "Do you want to install dependencies from $file? [y/N] "
        read answer

        if [[ "$answer" =~ ^[Yy]$ ]]; then
            echo -e "${GREEN}Installing dependencies from $file...${NC}"
            if [ -n "$sudo_prefix" ]; then
                $sudo_prefix $command -S --needed - < "$file"
            else
                $command -S --needed - < "$file"
            fi
            echo -e "${GREEN}Dependencies installation completed!${NC}"
        else
            echo -e "${YELLOW}Skipping dependencies installation from $file.${NC}"
        fi
    else
        echo -e "${RED}$file not found. Skipping.${NC}"
    fi
}

# pacman dependencies
install_dependencies "$DOTFILES_DIR/pacmanDependencies.txt" "pacman" "sudo"

# yay dependencies
install_dependencies "$DOTFILES_DIR/yayDependencies.txt" "yay" ""

# Create symlinks for config directories
echo -e "\n${YELLOW}Creating symlinks in $CONFIG_DIR${NC}"
echo -n "Do you want to create symlinks for configuration files? [y/N] "
read answer

if [[ "$answer" =~ ^[Yy]$ ]]; then
    for item in "$DOTFILES_DIR"/*; do
        base_name=$(basename "$item")

        # Skip the dependency files and installation scripts
        if [[ "$base_name" == "pacmanDependencies.txt" ||
              "$base_name" == "yayDependencies.txt" ||
              "$base_name" == "$(basename "$0")" ||
              "$base_name" == "gnomesetup.sh" ]]; then
            continue
        fi

        if [[ "$base_name" == "bubbles.json" ]]; then
            target="$CONFIG_DIR/$base_name"
            ln -s "$item" "$target"
            echo -e "${GREEN}Created symlink: $target -> $item${NC}"
        fi

        # Only create symlinks for directories
        if [ -d "$item" ]; then
            target="$CONFIG_DIR/$base_name"

            # Check if target already exists
            if [ -e "$target" ]; then
                echo -e "${YELLOW}$target already exists. Skipping.${NC}"
                continue
            fi

            # Create the symlink
            ln -s "$item" "$target"
            echo -e "${GREEN}Created symlink: $target -> $item${NC}"
        fi
    done
    echo -e "${GREEN}Symlink creation completed!${NC}"
else
    echo -e "${YELLOW}Skipping symlink creation.${NC}"
fi

echo -e "\n${GREEN}Installation script finished!${NC}"
