# Work-specific configuration

# ALIASES - Claude Commands
alias claude="AWS_PROFILE= \
AWS_ACCESS_KEY_ID= \
AWS_REGION=us-east-1 \
CLAUDE_CODE_USE_BEDROCK=1 \
CLAUDE_CODE_MAX_OUTPUT_TOKENS=32000 \
ANTHROPIC_MODEL='us.anthropic.claude-sonnet-4-5-20250929-v1:0' \
ANTHROPIC_SMALL_FAST_MODEL='us.anthropic.claude-haiku-4-5-20251001-v1:0' \
/opt/homebrew/bin/claude"

alias claudeopus="AWS_PROFILE= \
AWS_ACCESS_KEY_ID= \
AWS_REGION=us-east-1 \
CLAUDE_CODE_USE_BEDROCK=1 \
CLAUDE_CODE_MAX_OUTPUT_TOKENS=32000 \
ANTHROPIC_MODEL='us.anthropic.claude-opus-4-1-20250805-v1:0' \
ANTHROPIC_SMALL_FAST_MODEL='us.anthropic.claude-3-5-haiku-20241022-v1:0' \
/opt/homebrew/bin/claude"

alias cdgit='cd /Users/brendantimmons/Documents/dev/git_repos'
