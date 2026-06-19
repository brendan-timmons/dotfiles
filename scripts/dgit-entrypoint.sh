#!/usr/bin/env bash

set -euo pipefail

git config --global --add safe.directory /dotfiles

if [[ -n "${GIT_NAME:-}" ]]; then
    git config --global user.name "$GIT_NAME"
fi

if [[ -n "${GIT_EMAIL:-}" ]]; then
    git config --global user.email "$GIT_EMAIL"
fi

if [[ -n "${GIT_USERNAME:-}" && -n "${GIT_TOKEN:-}" ]]; then
    git config --global credential.helper \
        '!f() { echo "username=${GIT_USERNAME}"; echo "password=${GIT_TOKEN}"; }; f'
fi

exec "$@"
