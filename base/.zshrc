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

# COMPLETIONS
autoload -Uz compinit
compinit

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

# Custom scripts path
export PATH="$HOME/.local/scripts:$PATH"

# Editor aliases
alias vim="nvim"

# Aliases using eza for ls functionality
alias ll='eza -lbhF --git --icons'
alias lt='eza --tree --level=2 --icons'

# lazygit alias
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
# Tmux sessionizer
bindkey -s ^f "tmux-sessionizer\n"

# Better history search
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

# SOURCE ENVIRONMENT-SPECIFIC CONFIGS
[[ -f ~/.zsh/macos.zsh ]] && source ~/.zsh/macos.zsh
[[ -f ~/.zsh/linux.zsh ]] && source ~/.zsh/linux.zsh
[[ -f ~/.zsh/work.zsh ]] && source ~/.zsh/work.zsh
[[ -f ~/.zsh/personal.zsh ]] && source ~/.zsh/personal.zsh

# LOCAL OVERRIDES
# Source ~/.extra for machine-specific/private settings
[[ -f ~/.extra ]] && source ~/.extra
