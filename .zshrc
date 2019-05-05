# Aliases
## Make git great again
alias gs='git status'
alias gca='git commit -a'
alias gc='git commit'
alias grc='git rebase --continue'
alias gpl='git pull'

## Remapping
alias stat="stat -x"
alias dir='pwd'
alias where='grealpath'

## Other aliases
alias pt=papertrail

# Activate z
. /usr/local/opt/z/etc/profile.d/z.sh

# Colored trees
alias tree='tree -C'

# Vim bindings
bindkey -v

# Antigen setup
source $(brew --prefix)/share/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle git
antigen theme amuse
antigen bundle paulirish/git-open
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# env variables
export DOTNET_CLI_TELEMETRY_OPTOUT=1
