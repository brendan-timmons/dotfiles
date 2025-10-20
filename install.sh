#!/bin/bash

# Installs stow if needed

set -e

DOTFILES_DIR="$HOME/.dotfiles"
cd "$DOTFILES_DIR"

# Check if stow is installed
if ! command -v stow &>/dev/null; then
    echo "Installing GNU Stow..."
    case "$(uname -s)" in
    Darwin)
        if command -v brew &>/dev/null; then
            brew install stow
        else
            echo "Error: Homebrew not found. Install Homebrew first."
            exit 1
        fi
        ;;
    Linux)
        # Try to detect distro from /etc/os-release
        if [[ -f /etc/os-release ]]; then
            . /etc/os-release
            case "$ID" in
                ubuntu|debian|linuxmint|pop)
                    sudo apt update && sudo apt install -y stow
                    ;;
                fedora|rhel|centos|rocky|almalinux)
                    if command -v dnf &>/dev/null; then
                        sudo dnf install -y stow
                    else
                        sudo yum install -y stow
                    fi
                    ;;
                arch|manjaro|endeavouros|cachyos|garuda|arcolinux|artix)
                    sudo pacman -S --noconfirm stow
                    ;;
                opensuse*|sles)
                    sudo zypper install -y stow
                    ;;
                alpine)
                    sudo apk add stow
                    ;;
                *)
                    # Try ID_LIKE for derivative distros
                    case "$ID_LIKE" in
                        *debian*)
                            sudo apt update && sudo apt install -y stow
                            ;;
                        *rhel*|*fedora*)
                            if command -v dnf &>/dev/null; then
                                sudo dnf install -y stow
                            else
                                sudo yum install -y stow
                            fi
                            ;;
                        *arch*)
                            sudo pacman -S --noconfirm stow
                            ;;
                        *suse*)
                            sudo zypper install -y stow
                            ;;
                        *)
                            echo "Error: Unsupported distro. Install stow manually."
                            exit 1
                            ;;
                    esac
                    ;;
            esac
        else
            # Fallback: detect by available package manager
            if command -v apt &>/dev/null; then
                sudo apt update && sudo apt install -y stow
            elif command -v dnf &>/dev/null; then
                sudo dnf install -y stow
            elif command -v yum &>/dev/null; then
                sudo yum install -y stow
            elif command -v pacman &>/dev/null; then
                sudo pacman -S --noconfirm stow
            elif command -v zypper &>/dev/null; then
                sudo zypper install -y stow
            elif command -v apk &>/dev/null; then
                sudo apk add stow
            else
                echo "Error: Package manager not found. Install stow manually."
                exit 1
            fi
        fi
        ;;
    *)
        echo "Error: Unsupported OS. Install stow manually."
        exit 1
        ;;
    esac
fi

echo "Stow ready. See README.md for usage examples."
