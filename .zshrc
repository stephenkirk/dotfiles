export DOTNET_CLI_TELEMETRY_OPTOUT=1
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=vim
export DOTNET_ROOT=$HOME/.dotnet/dotnet

path+=("$HOME/bin")
path+=("$HOME/.dotnet/dotnet")
path+=("$HOME/.dotnet/tools")
path+=("$HOME/.emacs.d/bin")
export PATH

source ~/.profile

# Antigen pre-config
export ALIEN_SECTION_TIME_FORMAT=%H:%M:%S # default is %r
export ALIEN_THEME="gruvbox"

# Antigen
source $(brew --prefix)/share/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle git
antigen theme eendroroy/alien alien
antigen bundle paulirish/git-open
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle agkozak/zsh-z
antigen apply

# z nice completions
zstyle ':completion:*' menu select
# vi mode in shell
bindkey -v
KEYTIMEOUT=1 # 10ms for key sequences

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border --inline-info"
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="rg --files --hidden --follow --no-messages"

# Aliases
alias rc="$EDITOR $HOME/.zshrc"
alias stat="stat -x"
alias dir='pwd'
alias where='grealpath'
alias tree='tree -C' # Colored trees by default
alias pt='papertrail'

alias gs='git status'
alias gca='git commit -a'
alias gc='git commit'
alias grc='git rebase --continue'
alias gpl='git pull'
## https://github.com/stephenkirk/dotfiles.git expands into `git clone https://github.com/stephenkirk/dotfiles.git`
alias -s git="git clone" 

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

# Todoist - tasks completed today or yesterday
cl() {
	todoist cl -f 'today|yesterday' \
		| tail -r \
		| awk '!($1="")'
}

# Schedule sleep in ARG minutes
function sleep-in() {
  local minutes=$1
  local datetime=local datetime="`date -v+${minutes}M +"%m/%d/%y %H:%M:%S"`"
  sudo pmset schedule sleep "$datetime"
}

# Safari flickers on the integated graphics card when playing some full screen video with subtitles
# Apparently this can be fixed by changing the cursor size in accessibility settings
# Let's automate that
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

# Push todoist tasklists into clipboard 
function td-today() {
	todoist sync
	ITEMS=$(todoist --csv --header l -f 'today|overdue' \
		| csvcut -c Content \
		| tail -n +2 \
		| awk '{print "\t" $0}')
	(echo "[[Todoist - Today]]"; echo $ITEMS ) | pbcopy
}

function td-inbox() {
	todoist sync
	ITEMS=$(todoist --csv --header l -f "#Inbox" \
		| csvcut -c Content \
		| csvformat -D " " \
		| tr -d '"' \
		| tail -n +2 \
		| awk '{print "\t" $0}')
	(echo "[[Todoist - Inbox]]"; echo $ITEMS ) | pbcopy
}

function twitch-latest-stream() {
	youtube-dl 'https://www.twitch.tv/owlsteph/videos/all' --max-downloads 1
}

######################

JOURNAL_DIR="$HOME/journal"

function me-query() {
	local search=$1;
	rg ${search} $JOURNAL_DIR
}

function me-new() {
	local NOTE=$1
	local TODAY=$(date +%d.%m.%y)
	local FILENAME="$JOURNAL_DIR/$TODAY.md"
	echo "# $NOTE" >> $FILENAME
	subl $FILENAME
}

