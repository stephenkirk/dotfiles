# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export DOTNET_CLI_TELEMETRY_OPTOUT=1
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Aliases
alias gs='git status'
alias gca='git commit -a'
alias gc='git commit'
alias grc='git rebase --continue'
alias gpl='git pull'

alias stat="stat -x"
alias dir='pwd'
alias where='grealpath'

# Colored trees by default
alias tree='tree -C'

# Antigen setup
source $(brew --prefix)/share/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle git
antigen theme romkatv/powerlevel10k
antigen bundle paulirish/git-open
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle agkozak/zsh-z
antigen apply

# z nice completions
zstyle ':completion:*' menu select

# vi mode
bindkey -v
KEYTIMEOUT=1 # 10ms for key sequences

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border --inline-info"
export FZF_DEFAULT_COMMAND='rg --files'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source ~/.profile

path+=("$HOME/bin")
export PATH

toggle_desktop () {
	is_active=`defaults read com.apple.finder CreateDesktop`
	
	if ((is_active))
	then
		defaults write com.apple.finder CreateDesktop 0; killall Finder
		echo "Disabled desktop"
	fi

	if ! ((is_active))
	then 
		defaults write com.apple.finder CreateDesktop 1; killall Finder
		echo "Enabled desktop"
	fi
}

# TODO Only search org files once we have data processing
journal() {
	rg $1 ~/org
}

# completed-list
cl() {
	todoist cl -f 'today|yesterday' \
		| tail -r \
		| awk '!($1="")'
}
#
# Schedule sleep in X minutes
function sleep-in() {
  local minutes=$1
  local datetime=local datetime="`date -v+${minutes}M +"%m/%d/%y %H:%M:%S"`"
  sudo pmset schedule sleep "$datetime"

}
