#!/usr/bin/env bash

set -euo pipefail

starship::install() {
    local os_type
    os_type="$(uname -s)"
    
    if command -v starship &>/dev/null; then
        printf "starship already installed\n"
        return 0
    fi
    
    case "$os_type" in
        Darwin)
            if ! command -v brew &>/dev/null; then
                printf "Error: Homebrew required on macOS\n"
                return 1
            fi
            brew install starship
            ;;
        Linux)
            if [[ -f /etc/os-release ]]; then
                . /etc/os-release
                case "$ID" in
                    ubuntu|debian|linuxmint|pop)
                        curl -sS https://starship.rs/install.sh | sh -s -- -y
                        ;;
                    arch|manjaro|endeavouros|cachyos|garuda)
                        sudo pacman -S --noconfirm starship
                        ;;
                    *)
                        printf "Error: Unsupported distro. Install starship manually.\n"
                        return 1
                        ;;
                esac
            else
                printf "Error: Cannot detect distro. Install starship manually.\n"
                return 1
            fi
            ;;
        *)
            printf "Error: Unsupported OS\n"
            return 1
            ;;
    esac
}

starship::install
