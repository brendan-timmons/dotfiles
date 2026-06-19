#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ghostty::install() {
    local os_type
    os_type="$(uname -s)"
    
    if command -v ghostty &>/dev/null; then
        printf "ghostty already installed\n"
        return 0
    fi
    
    case "$os_type" in
        Darwin)
            if ! command -v brew &>/dev/null; then
                printf "Error: Homebrew required on macOS\n"
                return 1
            fi
            brew install --cask ghostty
            ;;
        Linux)
            if [[ -f /etc/os-release ]]; then
                . /etc/os-release
                case "$ID" in
                    arch|manjaro|endeavouros|cachyos|garuda)
                        sudo pacman -S --noconfirm ghostty
                        ;;
                    *)
                        printf "Download ghostty from: https://ghostty.org\n"
                        return 1
                        ;;
                esac
            else
                printf "Download ghostty from: https://ghostty.org\n"
                return 1
            fi
            ;;
        *)
            printf "Error: Unsupported OS\n"
            return 1
            ;;
    esac
}

ghostty::install
bash "${SCRIPT_DIR}/ioskeley-font.sh"
