# macOS-specific configuration

export EDITOR="nvim"

# Homebrew curl (newer version for AWS signature v4)
if [[ -d /opt/homebrew/opt/curl/bin ]]; then
  export PATH="/opt/homebrew/opt/curl/bin:$PATH"
fi

if command -v pbcopy &>/dev/null; then
  pwdc() { pwd | tr -d '\n' | pbcopy && pwd; }
fi

# CONDA (lazy-loaded; initialized on first use of conda/mamba)
if [[ -x /opt/homebrew/Caskroom/miniconda/base/bin/conda ]]; then
  conda() {
    unfunction conda mamba 2>/dev/null
    __conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
    if [[ $? -eq 0 ]]; then
      eval "$__conda_setup"
    elif [[ -f /opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh ]]; then
      . /opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh
    else
      export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
    unset __conda_setup
    conda "$@"
  }
  mamba() { conda; mamba "$@" }
fi
