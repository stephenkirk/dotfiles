export DOTNET_CLI_TELEMETRY_OPTOUT=1
export LC_ALL=C
export LANG=""

# Aliases
alias gs='git status'
alias gca='git commit -a'
alias gc='git commit'
alias grc='git rebase --continue'
alias gpl='git pull'

alias stat="stat -x"
alias dir='pwd'
alias where='grealpath'

# Activate z
. /usr/local/opt/z/etc/profile.d/z.sh

# Colored trees by default
alias tree='tree -C'

# Vim bindings
bindkey -v

# Antigen setup
source $(brew --prefix)/share/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle git
antigen theme robbyrussell
antigen bundle paulirish/git-open
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
