if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_greeting

# Environment variables
set -gx DOTNET_CLI_TELEMETRY_OPTOUT 1
set -gx LC_ALL en_US.UTF-8
set -gx LANG en_US.UTF-8
set -gx EDITOR vim
set -gx DOTNET_ROOT $HOME/.dotnet/dotnet

# Paths
set -Ua fish_user_paths $HOME/bin
set -Ua fish_user_paths /opt/homebrew/bin
set -Ua fish_user_paths $HOME/.dotnet/dotnet
set -Ua fish_user_paths $HOME/.dotnet/tools
set -Ua fish_user_paths $HOME/.config/emacs/bin
set -Ua fish_user_paths $HOME/Library/Python/3.8/bin
set -Ua fish_user_paths $HOME/Library/Python/3.8/bin
set -Ua fish_user_paths $HOME/go

# vi mode in shell
set -U fish_escape_delay_ms 10
set -g fish_key_bindings fish_vi_key_bindings
set -g fish_cursor_insert line

# fzf config
set -gx FZF_DEFAULT_OPTS "--height 50% --layout=reverse --border --inline-info"
set -gx FZF_DEFAULT_COMMAND 'rg --files'
set -gx FZF_CTRL_T_COMMAND "rg --files --hidden --follow --no-messages"

# aliases
alias dir='pwd'
alias where='grealpath'
alias tree='tree -C' # Colored trees by default
alias pt='papertrail'
alias rc='vim ~/.config/fish/config.fish'
alias em='open -a Emacs'

alias ga='git add'
alias gs='git status'
alias gca='git commit -a'
alias gc='git commit'
alias grc='git rebase --continue'
alias gpl='git pull'

alias grid='cd ~/src/grid && ./run.sh'

alias whisperer='cd ~/src/whisperer && sh ./run.sh'

# Fetch a list of pull requests where I am requested for review, format it as Markdown links, and copy to clipboard.
function to_review
	gh pr list -S "review-requested:@me" --json title,url,author --jq 'map("[\\"@\\(.author.login): \\(.title)\\"](\\(.url))") | .[]' 
end

# Created by `pipx` on 2024-11-28 14:13:39
set PATH $PATH /Users/stephenkirk/.local/bin

# add zoxide / z
zoxide init fish | source
