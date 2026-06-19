#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "${SCRIPT_DIR}/../lib" && pwd)"

# shellcheck source=../lib/github-release.sh
source "${LIB_DIR}/github-release.sh"

IOSKELEY_FONT_REPO="ahatem/IoskeleyMono"
IOSKELEY_FONT_ASSET="IoskeleyMono-Term-NerdFont.zip"
IOSKELEY_FONT_FAMILY="IoskeleyMonoTerm Nerd Font"
IOSKELEY_FONT_SENTINEL="IoskeleyMonoTermNerdFont-Regular.ttf"
IOSKELEY_FONT_TAG="${IOSKELEY_FONT_TAG:-latest}"

ioskeley_font::targetDir() {
    case "$(uname -s)" in
        Darwin)
            printf "%s/Library/Fonts\n" "$HOME"
            ;;
        Linux)
            printf "%s/.local/share/fonts\n" "$HOME"
            ;;
        *)
            printf "Error: unsupported OS for font installation\n" >&2
            return 1
            ;;
    esac
}

ioskeley_font::installed() {
    local target_dir="$1"

    if [[ -f "${target_dir}/${IOSKELEY_FONT_SENTINEL}" ]]; then
        return 0
    fi

    if command -v fc-match &>/dev/null &&
        fc-match "$IOSKELEY_FONT_FAMILY" | grep -q "IoskeleyMonoTermNerdFont"; then
        return 0
    fi

    return 1
}

ioskeley_font::install() {
    local target_dir
    local tmp_dir
    local archive
    local extract_dir
    local font_list
    local font_file
    local installed_count=0

    if ! command -v curl &>/dev/null; then
        printf "Error: curl required to download %s\n" "$IOSKELEY_FONT_ASSET" >&2
        return 1
    fi

    if ! command -v unzip &>/dev/null; then
        printf "Error: unzip required to install %s\n" "$IOSKELEY_FONT_ASSET" >&2
        return 1
    fi

    target_dir="$(ioskeley_font::targetDir)"

    if [[ "${IOSKELEY_FONT_FORCE:-0}" != "1" ]] && ioskeley_font::installed "$target_dir"; then
        printf "%s already installed\n" "$IOSKELEY_FONT_FAMILY"
        return 0
    fi

    tmp_dir="$(mktemp -d)"
    archive="${tmp_dir}/${IOSKELEY_FONT_ASSET}"
    extract_dir="${tmp_dir}/extract"
    font_list="${tmp_dir}/fonts.txt"
    trap "rm -rf -- $(printf '%q' "$tmp_dir")" EXIT

    mkdir -p "$target_dir" "$extract_dir"

    printf "Downloading %s from %s\n" "$IOSKELEY_FONT_ASSET" "$IOSKELEY_FONT_REPO"
    github_release::downloadAsset "$IOSKELEY_FONT_REPO" "$IOSKELEY_FONT_ASSET" "$archive" "$IOSKELEY_FONT_TAG"

    unzip -q "$archive" -d "$extract_dir"

    find "$extract_dir" -type f \
        \( -name "IoskeleyMonoTermNerdFont-*.ttf" -o -name "IoskeleyMonoTermNerdFont-*.otf" \) \
        | sort > "$font_list"

    if [[ ! -s "$font_list" ]]; then
        printf "Error: no IoskeleyMonoTerm Nerd Font files found in %s\n" "$IOSKELEY_FONT_ASSET" >&2
        return 1
    fi

    while IFS= read -r font_file; do
        cp -f "$font_file" "$target_dir/"
        installed_count=$((installed_count + 1))
    done < "$font_list"

    if command -v fc-cache &>/dev/null; then
        fc-cache -f "$target_dir" >/dev/null 2>&1 || true
    fi

    printf "Installed %d %s files to %s\n" "$installed_count" "$IOSKELEY_FONT_FAMILY" "$target_dir"
}

ioskeley_font::install
