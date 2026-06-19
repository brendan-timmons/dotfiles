# macOS-specific shell profile settings

eval "$(/opt/homebrew/bin/brew shellenv)"

# Prepend ~/.local/bin so user-installed binaries take precedence over version-manager shims.
export PATH="$HOME/.local/bin:$PATH"
