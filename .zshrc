# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export DOTNET_CLI_TELEMETRY_OPTOUT=1
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=vim

alias gs='git status'
alias gca='git commit -a'
alias gc='git commit'
alias grc='git rebase --continue'
alias gpl='git pull'
alias -s git="git clone" # https://github.com/stephenkirk/dotfiles.git becomes `git clone https://github.com/stephenkirk/dotfiles.git`
alias rc="$EDITOR $HOME/.zshrc"
alias stat="stat -x"
alias dir='pwd'
alias where='grealpath'

alias nvimrc="nvim ~/.config/nvim/init.vim"

# Colored trees by default
alias tree='tree -C'

# Antigen
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
path+=("$HOME/.dotnet/tools")
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

function resize-cursor() {
	osascript -e 'tell application "System Preferences"
	    reveal anchor "Seeing_Cursor" of pane id "com.apple.preference.universalaccess"
	    delay 0.2

	    tell application "System Events"
		set contentView to tab group 1 of group 1 of window "Accessibility" of application process "System Preferences"
		set theSlider to slider "Cursor size:" of contentView

		set stash to value of theSlider
		if value of theSlider is 1.0 then
		    set value of theSlider to 4.0
		else
		    set value of theSlider to 1.0
		end if
		stash
	    end tell
	end tell'
}

function toggle-cursor-size() {
	resize-cursor
	resize-cursor
}

function td-today() {
	todoist sync
	ITEMS=$(todoist --csv --header l -f 'today|overdue' \
		| csvcut -c Content,Project \
		| csvformat -D " " \
		| tr -d '"' \
		| tail -n +2 \
		| awk '{print "\t{{[[TODO]]}} " $0}')
	(echo "[[Todoist - Today]]"; echo $ITEMS ) | pbcopy
}

function td-inbox() {
	todoist sync
	ITEMS=$(todoist --csv --header l -f "#Inbox" \
		| csvcut -c Content \
		| csvformat -D " " \
		| tr -d '"' \
		| tail -n +2 \
		| awk '{print "\t{{[[TODO]]}} " $0}')
	(echo "[[Todoist - Inbox]]"; echo $ITEMS ) | pbcopy
}

function force-integrated-graphics-on-battery() {
 sudo pmset -b gpuswitch 0
}

