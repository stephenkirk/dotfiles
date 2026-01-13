
# Set a huge history
HISTSIZE=50000
SAVEHIST=50000


# Immediately append to history file:
setopt INC_APPEND_HISTORY

# Record timestamp in history:
setopt EXTENDED_HISTORY

# Expire duplicate entries first when trimming history:
setopt HIST_EXPIRE_DUPS_FIRST

# Dont record an entry that was just recorded again:
setopt HIST_IGNORE_DUPS

# Delete old recorded entry if new entry is a duplicate:
setopt HIST_IGNORE_ALL_DUPS

# Dont record an entry starting with a space:
setopt HIST_IGNORE_SPACE

# Dont write duplicate entries in the history file:
setopt HIST_SAVE_NO_DUPS

# Share history between all sessions:
setopt SHARE_HISTORY

# Environment variables
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=vim
export DOTNET_ROOT=$HOME/.dotnet/dotnet

# Paths
path+=("$HOME/bin")
path+=("/opt/homebrew/bin")
path+=("$HOME/.dotnet/dotnet")
path+=("$HOME/.dotnet/tools")
path+=("$HOME/.emacs.d/bin")
path+=("$HOME/Library/Python/3.8/bin")
export PATH

source ~/.profile

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
alias -s git="git clone" # Expand urls into `git clone $URL` 

# Functions
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

# Load machine-specific config (personal or work)
if [[ -f ~/.machine-work ]]; then
    source ~/.zshrc.work
elif [[ -f ~/.machine-personal ]]; then
    source ~/.zshrc.personal
fi
