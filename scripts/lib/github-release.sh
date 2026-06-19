#!/usr/bin/env bash

github_release::apiUrl() {
    local repo="$1"
    local tag="${2:-latest}"

    if [[ "$tag" == "latest" ]]; then
        printf "https://api.github.com/repos/%s/releases/latest\n" "$repo"
    else
        printf "https://api.github.com/repos/%s/releases/tags/%s\n" "$repo" "$tag"
    fi
}

github_release::fetchRelease() {
    local repo="$1"
    local tag="${2:-latest}"
    local api_url
    local curl_args=()

    api_url="$(github_release::apiUrl "$repo" "$tag")"
    curl_args=(
        -fsSL
        -H "Accept: application/vnd.github+json"
        -H "X-GitHub-Api-Version: 2022-11-28"
    )

    if [[ -n "${GITHUB_TOKEN:-}" ]]; then
        curl_args+=(-H "Authorization: Bearer ${GITHUB_TOKEN}")
    fi

    curl "${curl_args[@]}" "$api_url"
}

github_release::assetUrlFromJson() {
    local asset_name="$1"
    local release_json
    local download_url

    release_json="$(cat)"

    if command -v jq &>/dev/null; then
        download_url="$(
            printf "%s" "$release_json" |
                jq -r --arg name "$asset_name" '.assets[] | select(.name == $name) | .browser_download_url' |
                head -n 1
        )"
    elif command -v python3 &>/dev/null; then
        download_url="$(
            printf "%s" "$release_json" |
                python3 -c 'import json, sys
asset = sys.argv[1]
data = json.load(sys.stdin)
for item in data.get("assets", []):
    if item.get("name") == asset:
        print(item.get("browser_download_url", ""))
        break
' "$asset_name"
        )"
    else
        download_url="$(
            printf "%s" "$release_json" |
                awk -v asset="$asset_name" '
                    /"name":/ {
                        name = $0
                        sub(/^.*"name":[[:space:]]*"/, "", name)
                        sub(/".*$/, "", name)
                    }
                    /"browser_download_url":/ {
                        url = $0
                        sub(/^.*"browser_download_url":[[:space:]]*"/, "", url)
                        sub(/".*$/, "", url)
                        if (name == asset) {
                            print url
                            exit
                        }
                    }
                '
        )"
    fi

    if [[ -z "$download_url" || "$download_url" == "null" ]]; then
        printf "Error: release asset not found: %s\n" "$asset_name" >&2
        return 1
    fi

    printf "%s\n" "$download_url"
}

github_release::assetUrl() {
    local repo="$1"
    local asset_name="$2"
    local tag="${3:-latest}"
    local release_json

    release_json="$(github_release::fetchRelease "$repo" "$tag")" || return 1
    printf "%s" "$release_json" | github_release::assetUrlFromJson "$asset_name"
}

github_release::downloadAsset() {
    local repo="$1"
    local asset_name="$2"
    local dest="$3"
    local tag="${4:-latest}"
    local download_url

    download_url="$(github_release::assetUrl "$repo" "$asset_name" "$tag")"
    curl -fL --retry 3 --output "$dest" "$download_url"
}
