# History: share sessions, retain timestamps, and discard duplicates.
# Leading spaces keep commands out of history.
HISTSIZE=50000
SAVEHIST=50000


setopt INC_APPEND_HISTORY

setopt EXTENDED_HISTORY

setopt HIST_EXPIRE_DUPS_FIRST

setopt HIST_IGNORE_DUPS

setopt HIST_IGNORE_ALL_DUPS

setopt HIST_IGNORE_SPACE

setopt HIST_SAVE_NO_DUPS

setopt SHARE_HISTORY

# Environment variables
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=vim
export DOTNET_ROOT=$HOME/.dotnet/dotnet

# Paths
path+=("$HOME/dotfiles/tools")
path+=("$HOME/.local/bin")
path+=("/opt/homebrew/bin")
path+=("$HOME/.dotnet/dotnet")
path+=("$HOME/.dotnet/tools")
path+=("$HOME/.emacs.d/bin")
path+=("$HOME/Library/Python/3.8/bin")
export PATH

if [ -f ~/.env.private ]; then
    set -a
    source ~/.env.private
    set +a
fi

[ -f ~/.zshrc.private ] && source ~/.zshrc.private

# Select completions from a menu
zstyle ':completion:*' menu select
# vi mode in shell
bindkey -v
KEYTIMEOUT=1 # 10ms for key sequences

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border --inline-info"
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="rg --files --hidden --follow --no-messages"

# Aliases
[ -f "$HOME/.codex-work/worky.zsh" ] && source "$HOME/.codex-work/worky.zsh"
alias rc="$EDITOR $HOME/.zshrc"
alias stat="stat -x"
alias dir='pwd'
alias where='grealpath'
alias tree='tree -C'
alias pt='papertrail'

alias gs='git status'
alias gca='git commit -a'
alias gc='git commit'
alias grc='git rebase --continue'
alias gpl='git pull'
alias -s git="git clone" # Expand urls into `git clone $URL` 

# Schedule sleep in ARG minutes
function sleep-in() {
  local minutes=$1
  local datetime=local datetime="`date -v+${minutes}M +"%m/%d/%y %H:%M:%S"`"
  sudo pmset schedule sleep "$datetime"
}

# Cursor-size workaround for Safari fullscreen video flicker on integrated graphics.
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
