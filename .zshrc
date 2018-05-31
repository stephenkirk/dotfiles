export ZSH=~/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(
  git git-open git-extras
)

source $ZSH/oh-my-zsh.sh

# Make git great again
alias gs='git status'
alias gca='git commit -a'
alias gc='git commit'
alias grc='git rebase --continue'
alias gpl='git pull'

# Command remapping
alias stat="stat -x"
alias dir='pwd'
alias where='grealpath'

# Activate z
. ~/z.sh 

# Colored trees
alias tree='tree -C'
eval $(thefuck --alias)
