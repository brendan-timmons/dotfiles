# Work-specific configuration

alias plugin="cd ~/Documents/dev/claudeplugin/"
# Keep company/project-specific paths, aliases, and credentials in ~/.extra.

# aws-vault reads its own config; ~/.aws/config holds the wrappers other tools use
alias aws-vault='AWS_CONFIG_FILE=$HOME/.aws/vault-config aws-vault'
