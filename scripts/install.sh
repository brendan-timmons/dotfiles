#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
APPS_DIR="${SCRIPT_DIR}/apps"

install::discoverApps() {
    find "$APPS_DIR" -name "*.sh" -type f | sort
}

install::getAppName() {
    basename "$1" .sh
}

install::selectApps() {
    local app_scripts
    local app_name
    local selection
    
    app_scripts=($(install::discoverApps))
    
    printf "\nAvailable applications:\n\n" >&2
    
    for script in "${app_scripts[@]}"; do
        app_name="$(install::getAppName "$script")"
        printf "  - %s\n" "$app_name" >&2
    done
    
    printf "\nEnter apps to install (space-separated, or 'all'): " >&2
    read -r selection </dev/tty
    
    if [[ "$selection" == "all" ]]; then
        printf "%s\n" "${app_scripts[@]}"
    else
        for app_name in $selection; do
            for script in "${app_scripts[@]}"; do
                if [[ "$(install::getAppName "$script")" == "$app_name" ]]; then
                    printf "%s\n" "$script"
                    break
                fi
            done
        done
    fi
}

install::runInstallers() {
    local failed=()
    
    while IFS= read -r script; do
        [[ -z "$script" ]] && continue
        
        local app_name
        app_name="$(install::getAppName "$script")"
        
        printf "\n==> Installing %s\n" "$app_name"
        
        if bash "$script"; then
            printf "✓ %s installed successfully\n" "$app_name"
        else
            printf "✗ %s installation failed\n" "$app_name"
            failed+=("$app_name")
        fi
    done
    
    if (( ${#failed[@]} > 0 )); then
        printf "\nFailed installations: %s\n" "${failed[*]}"
        return 1
    fi
    
    return 0
}

main() {
    cd "$DOTFILES_ROOT"
    
    printf "Dotfiles Installer\n"
    printf "==================\n"
    
    local selected_apps
    selected_apps="$(install::selectApps)"
    
    if [[ -z "$selected_apps" ]]; then
        printf "\nNo apps selected. Exiting.\n"
        exit 0
    fi
    
    printf "\n%s\n" "$selected_apps" | install::runInstallers
    
    printf "\nInstallation complete!\n"
    printf "Refer to README for stow commands based on your setup\n"
}

main
