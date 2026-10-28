# Dotfiles

Clean dotfiles management using native GNU Stow with modular packages.

**Packages**: `base` (core configs for all machines), `macos`/`linux` (OS-specific), `work`/`personal` (context-specific)

## First Time Setup

1. Clone repository:

   ```bash
   git clone <repo-url> ~/.dotfiles
   cd ~/.dotfiles
   ```

2. Install applications:

   ```bash
   ./install.sh
   ```

   Interactive installer - choose which apps to install (`stow`, `nvim`, `tmux`, `ioskeley-font`, ...) or type `all`.

   The Ghostty config uses `IoskeleyMonoTerm Nerd Font`. Install it directly with the `ioskeley-font` app, or select `ghostty` and the Ghostty installer will install the font after Ghostty. The font installer downloads `IoskeleyMono-Term-NerdFont.zip` from the latest `ahatem/IoskeleyMono` GitHub release and skips installation when the font is already present.

3. Remove existing configs:

   Backup existing if needed:
   ```bash
   cp ~/.zshrc ~/.zprofile ~/.tmux.conf ~/.config/nvim \
   ~/.config/starship.toml ~/.config/ghostty \
   archive_dir
   ```

   ```bash
   rm ~/.zshrc ~/.zprofile ~/.tmux.conf
   rm -rf ~/.config/nvim ~/.config/starship.toml ~/.config/ghostty
   ```

4. Stow packages for your machine:

    ```bash
    # macOS work machine
    stow base macos work

    # macOS personal machine
    stow base macos personal

    # Linux personal machine
    stow base linux personal
    ```

## Common Commands

```bash
# View what packages are stowed
ls -la ~ | grep .dotfiles

# Add a new package
stow work

# Remove a package
stow -D work

# Restow (useful after pulling updates)
stow -R base macos work
```

## Private/Machine-Specific Settings

Create `~/.extra` for settings that shouldn't be in the repo:

```bash
# Example ~/.extra
export AWS_PROFILE="my-profile"
alias myalias="some command"
```

The `.zshrc` sources this automatically if it exists.

Keep company names, private repository paths, cloud account/profile details, and work-only aliases in `~/.extra`, not in tracked package files.

## How It Works

Each package mirrors the structure of `~/`. When you `stow` a package, it creates symlinks in your home directory.

The `base/.zshrc` conditionally sources environment files:

```bash
[[ -f ~/.zsh/macos.zsh ]] && source ~/.zsh/macos.zsh
[[ -f ~/.zsh/linux.zsh ]] && source ~/.zsh/linux.zsh
[[ -f ~/.zsh/work.zsh ]] && source ~/.zsh/work.zsh
[[ -f ~/.zsh/personal.zsh ]] && source ~/.zsh/personal.zsh
[[ -f ~/.extra ]] && source ~/.extra
```

Packages layer cleanly:

- `stow base` → creates `~/.zshrc`, `~/.tmux.conf`, `~/.config/nvim/`, etc.
- `stow macos` → creates `~/.zprofile` (homebrew init) and `~/.zsh/macos.zsh`
- `stow work` → creates `~/.zsh/work.zsh`

All files are symlinked - changes anywhere are immediately reflected.

## Migrating to a New Machine

1. Clone repo
2. Run `./install.sh` to ensure stow is installed
3. Remove existing configs (if any)
4. Stow appropriate packages: `stow base <os> <context>`
5. Done - all configs are live via symlinks, edit anywhere

## Tips

- Start with just `stow base` to test
- Add OS/context packages incrementally
- Use `stow -n` (dry run) to preview changes
- All files are symlinked - changes are immediate
- Commit and push changes from any machine
- Pull on other machines and `stow -R` to update symlinks
