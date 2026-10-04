create_symlink() {
    local source=$1
    local target=$2
    ln -nsf "$source" "$target"
    echo "Created symlink: $target -> $source"
}

# Like create_symlink, but safe when the target is an existing REAL directory.
#
# `ln -nsf dir target` does NOT replace a real directory — it creates the link
# *inside* it (~/.claude/skills/skills), which is silent and confusing. So move
# any real directory aside first. Never deletes: the displaced copy is left at
# <target>.pre-private for you to remove once you trust the new wiring.
replace_symlink() {
    local source=$1
    local target=$2
    if [ -d "$target" ] && [ ! -L "$target" ]; then
        mv "$target" "$target.pre-private"
        echo "Moved aside: $target -> $target.pre-private"
    fi
    ln -nsf "$source" "$target"
    echo "Created symlink: $target -> $source"
}

echo "Creating symlinks..."

# Dotfiles in home directory
create_symlink ~/dotfiles/.hammerspoon ~/.hammerspoon
create_symlink ~/dotfiles/.ideavimrc ~/.ideavimrc
create_symlink ~/dotfiles/.doom.d ~/.doom.d
create_symlink ~/dotfiles/.tmux.conf ~/.tmux.conf
create_symlink ~/dotfiles/.vimrc ~/.vimrc
create_symlink ~/dotfiles/.zshrc ~/.zshrc
create_symlink ~/dotfiles/.zshrc.personal ~/.zshrc.personal
create_symlink ~/dotfiles/.zshrc.work ~/.zshrc.work
create_symlink ~/dotfiles/.gitconfig ~/.gitconfig

# Config files in .config directory
mkdir -p ~/.config/
mkdir -p ~/.config/fish

create_symlink ~/dotfiles/.config/fish/config.fish ~/.config/fish/config.fish
create_symlink ~/dotfiles/.config/fish/config.personal.fish ~/.config/fish/config.personal.fish
create_symlink ~/dotfiles/.config/fish/config.work.fish ~/.config/fish/config.work.fish
create_symlink ~/dotfiles/.config/karabiner ~/.config/karabiner
create_symlink ~/dotfiles/.config/amethyst ~/.config/amethyst
create_symlink ~/dotfiles/.config/linearmouse ~/.config/linearmouse
create_symlink ~/dotfiles/.config/nvim ~/.config/nvim

create_symlink ~/dotfiles/.config/zed/keymap.json ~/.config/zed/keymap.json
create_symlink ~/dotfiles/.config/zed/settings.json ~/.config/zed/settings.json

# ---------------------------------------------------------------------------
# Private dotfiles
#
# ---------------------------------------------------------------------------
if [ -d ~/dotfiles-private ]; then
    echo "Private dotfiles found — wiring."

    create_symlink ~/dotfiles-private/.env.private ~/.env.private
    create_symlink ~/dotfiles-private/.zshrc.private ~/.zshrc.private
    create_symlink ~/dotfiles-private/.gitconfig.local ~/.gitconfig.local

    # conf.d is auto-sourced by fish, so private PATH entries need no other hook.
    mkdir -p ~/.config/fish/conf.d
    create_symlink ~/dotfiles-private/.config/fish/conf.d/private.fish ~/.config/fish/conf.d/private.fish

    # Doom loads this itself if it exists. It lands inside the public repo's
    # .doom.d, which is why that path is gitignored there.
    create_symlink ~/dotfiles-private/.doom.d/private.el ~/dotfiles/.doom.d/private.el

    mkdir -p ~/.ssh
    create_symlink ~/dotfiles-private/.ssh/config ~/.ssh/config

    # Warp reads ~/.warp/settings.toml, not ~/.config/warp.
    mkdir -p ~/.warp
    create_symlink ~/dotfiles-private/.config/warp/settings.toml ~/.warp/settings.toml
    replace_symlink ~/dotfiles-private/.config/fish/functions ~/.config/fish/functions

    # Claude Code, two profiles. ~/.claude is the *personal* profile — it is the
    # default when CLAUDE_CONFIG_DIR is unset. ~/.claude-work is chosen
    # explicitly by the `claude-work` fish function. Same shape as codex /
    # codex-work: private is the bare command, work is the one you opt into.
    #
    # Per-file, NOT whole-directory: these dirs are Claude Code's own working
    # state (projects/, sessions/, history.jsonl) with a few authored files
    # mixed in. skills/ is the exception — see below.
    mkdir -p ~/.claude ~/.claude-work
    for profile in .claude .claude-work; do
        create_symlink  ~/dotfiles-private/$profile/settings.json ~/$profile/settings.json
        create_symlink  ~/dotfiles-private/$profile/statusline.sh ~/$profile/statusline.sh
        replace_symlink ~/dotfiles-private/$profile/themes ~/$profile/themes
        # One shared skill set for both profiles. Safe to symlink whole because
        # the private repo owns every entry — nothing else writes here.
        replace_symlink ~/dotfiles-private/skills ~/$profile/skills
    done
    replace_symlink ~/dotfiles-private/.claude/output-styles ~/.claude/output-styles
    replace_symlink ~/dotfiles-private/.claude/agents ~/.claude/agents
    replace_symlink ~/dotfiles-private/.claude/memories ~/.claude/memories
else
    echo "No ~/dotfiles-private — skipping private config."
fi

echo "Symlink creation completed."
