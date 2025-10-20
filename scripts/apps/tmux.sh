#!/usr/bin/env bash

set -euo pipefail

tmux::install() {
    local os_type
    os_type="$(uname -s)"
    
    if command -v tmux &>/dev/null; then
        printf "tmux already installed\n"
        return 0
    fi
    
    case "$os_type" in
        Darwin)
            if ! command -v brew &>/dev/null; then
                printf "Error: Homebrew required on macOS\n"
                return 1
            fi
            brew install tmux
            ;;
        Linux)
            if [[ -f /etc/os-release ]]; then
                . /etc/os-release
                case "$ID" in
                    ubuntu|debian|linuxmint|pop)
                        sudo apt update && sudo apt install -y tmux
                        ;;
                    arch|manjaro|endeavouros|cachyos|garuda)
                        sudo pacman -S --noconfirm tmux
                        ;;
                    *)
                        printf "Error: Unsupported distro. Install tmux manually.\n"
                        return 1
                        ;;
                esac
            else
                printf "Error: Cannot detect distro. Install tmux manually.\n"
                return 1
            fi
            ;;
        *)
            printf "Error: Unsupported OS\n"
            return 1
            ;;
    esac
}

tmux::install
