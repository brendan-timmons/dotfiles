# MISE (replaces nvm and pyenv)
eval "$(mise activate zsh)"

# STARSHIP PROMPT
eval "$(starship init zsh)"

# FZF - Fuzzy Finder
eval "$(fzf --zsh)"

# ZSH OPTIONS & HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY          # Share history between sessions
setopt HIST_IGNORE_ALL_DUPS   # Remove older duplicate entries
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks
setopt HIST_VERIFY            # Show command with history expansion before running

# Better directory navigation
setopt AUTO_PUSHD             # Push directories onto stack
setopt PUSHD_IGNORE_DUPS      # Don't push duplicates
setopt PUSHD_SILENT           # Don't print directory stack
setopt INTERACTIVE_COMMENTS   # Allow comments in interactive shells

# Docker completions
FPATH="$HOME/.docker/completions:$FPATH"

# Bun completions
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"

# COMPLETIONS (cached, rebuilds once per day)
# Force rebuild: rm -f ~/.zcompdump && compinit
autoload -Uz compinit
zcompdump_files=(~/.zcompdump(N.mh+24))
if (( $#zcompdump_files )); then
  compinit
else
  compinit -C
fi
unset zcompdump_files

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Kubectl completion (lazy-loaded)
if command -v kubectl &> /dev/null; then
  kubectl() {
    if ! type __start_kubectl &>/dev/null; then
      source <(command kubectl completion zsh)
    fi
    command kubectl "$@"
  }
fi

# ENVIRONMENT VARIABLES
# Azure Functions Telemetry Opt Out
export FUNCTIONS_CORE_TOOLS_TELEMETRY_OPTOUT=1

# Tenv auto install
export TENV_AUTO_INSTALL=true

# Prepend ~/.local/bin so user-installed binaries take precedence over version-manager shims.
export PATH="$HOME/.local/bin:$PATH"
# Custom scripts path
export PATH="$HOME/.local/scripts:$PATH"

# Editor aliases
alias vim="nvim"

# Aliases using eza for ls functionality
alias ll='eza -lbhF --git --icons'
alias lt='eza --tree --level=2 --icons'
alias lla='eza -la'

#lazygit alias
alias lg='lazygit'

# ALIASES - Terraform/Terragrunt
alias tfrm='rm -rf .terraform .terragrunt-cache; rm .terraform.lock.hcl; rm tf.plan'
alias tfinit='terraform init'
alias tfapply='terraform apply tf.plan'
alias tga='terragrunt apply'
alias tgp='terragrunt plan'

# ALIASES - Directory Navigation
alias cdroot='cd $(git rev-parse --show-toplevel)'

# KEY BINDINGS
# Force the emacs keymap. zsh picks vi mode automatically when $EDITOR or $VISUAL
# contains the substring "vi" -- and "nvim" does. That broke ^A/^E (they became
# self-insert) and made any ESC-prefixed key drop the line editor into vicmd.
bindkey -e

# Tmux sessionizer
bindkey -s ^f "tmux-sessionizer\n"

# Better history search
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

# Line start/end (emacs keymap gives ^A/^E for free; these cover Home/End too)
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line

# Word jumps. Multiple encodings so this works whether Option is sent as a
# modifier (CSI 1;3) or as Meta (ESC-prefixed), in Ghostty and inside tmux.
bindkey '^[[1;3D' backward-word      # Option+Left
bindkey '^[[1;3C' forward-word       # Option+Right
bindkey '^[[1;5D' backward-word      # Ctrl+Left
bindkey '^[[1;5C' forward-word       # Ctrl+Right
bindkey '^[^[[D'  backward-word      # ESC ESC [ D fallback
bindkey '^[^[[C'  forward-word
bindkey '^[b' backward-word          # Option+B
bindkey '^[f' forward-word           # Option+F

# Word deletion
bindkey '^[^?' backward-kill-word    # Option+Backspace
bindkey '^[[3;3~' kill-word          # Option+Delete
bindkey '^W' backward-kill-word

# SOURCE ENVIRONMENT-SPECIFIC CONFIGS
[[ -f ~/.zsh/macos.zsh ]] && source ~/.zsh/macos.zsh
[[ -f ~/.zsh/linux.zsh ]] && source ~/.zsh/linux.zsh
[[ -f ~/.zsh/work.zsh ]] && source ~/.zsh/work.zsh
[[ -f ~/.zsh/personal.zsh ]] && source ~/.zsh/personal.zsh

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# LOCAL OVERRIDES
# Source ~/.extra last so machine-specific/private settings can override defaults.
[[ -f ~/.extra ]] && source ~/.extra
