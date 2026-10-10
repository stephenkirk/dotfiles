if status is-interactive
end

set -U fish_greeting

# Environment variables
set -gx DOTNET_CLI_TELEMETRY_OPTOUT 1
set -gx LC_ALL en_US.UTF-8
set -gx LANG en_US.UTF-8
set -gx EDITOR vim

# Paths
# fish_add_path skips entries already present; removing a line leaves its path.
# Run scripts/fish-paths-reset.fish to remove stale entries.
fish_add_path -a $HOME/dotfiles/tools
fish_add_path -a /opt/homebrew/bin
fish_add_path -a $HOME/.config/emacs/bin
fish_add_path -a $HOME/Library/Python/3.8/bin
fish_add_path -a $HOME/go

# vi mode in shell
set -U fish_escape_delay_ms 10
set -g fish_key_bindings fish_vi_key_bindings
set -g fish_cursor_insert line

# fzf config
set -gx FZF_DEFAULT_OPTS "--height 50% --layout=reverse --border --inline-info"
set -gx FZF_DEFAULT_COMMAND 'rg --files'
set -gx FZF_CTRL_T_COMMAND "rg --files --hidden --follow --no-messages"

# Work account uses its own Codex configuration and credentials.
function codex-work --wraps codex
    env CODEX_HOME="$HOME/.codex-work" codex $argv
end

# aliases
alias dir='pwd'
alias where='grealpath'
alias tree='tree -C'
alias pt='papertrail'
alias rc='vim ~/.config/fish/config.fish'
alias em='open -a Emacs'

alias ga='git add'
alias gs='git status'
alias gca='git commit -a'
alias gc='git commit'
alias grc='git rebase --continue'
alias gpl='git pull'



# Shared with zsh: .env.private must contain plain KEY=value lines, without export.
if test -f ~/.env.private
    for line in (string match -rv '^\s*(#|$)' < ~/.env.private)
        set -gx (string split -m1 '=' -- $line)
    end
end

function shell --argument-names param
	llm -t shell "$param"
end

zoxide init fish | source

# Load machine-specific config (personal or work)
if test -f ~/.machine-work
    source ~/.config/fish/config.work.fish
else if test -f ~/.machine-personal
    source ~/.config/fish/config.personal.fish
end


# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
