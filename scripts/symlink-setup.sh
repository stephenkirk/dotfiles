create_symlink() {
    local source=$1
    local target=$2
    ln -nsf "$source" "$target"
    echo "Created symlink: $target -> $source"
}

# ln -nsf puts links inside real directories. Move the directory to
# <target>.pre-private before replacing it with a symlink.
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

# Private dotfiles
if [ -d ~/dotfiles-private ]; then
    echo "Private dotfiles found — wiring."

    create_symlink ~/dotfiles-private/.env.private ~/.env.private
    create_symlink ~/dotfiles-private/.zshrc.private ~/.zshrc.private
    create_symlink ~/dotfiles-private/.gitconfig.local ~/.gitconfig.local

    # conf.d is auto-sourced by fish, so private PATH entries need no other hook.
    mkdir -p ~/.config/fish/conf.d
    create_symlink ~/dotfiles-private/.config/fish/conf.d/private.fish ~/.config/fish/conf.d/private.fish

    # private.el is loaded by .doom.d/config.el and gitignored here.
    create_symlink ~/dotfiles-private/.doom.d/private.el ~/dotfiles/.doom.d/private.el

    mkdir -p ~/.ssh
    create_symlink ~/dotfiles-private/.ssh/config ~/.ssh/config

    # Warp reads ~/.warp/settings.toml, not ~/.config/warp.
    mkdir -p ~/.warp
    create_symlink ~/dotfiles-private/.config/warp/settings.toml ~/.warp/settings.toml
    replace_symlink ~/dotfiles-private/.config/fish/functions ~/.config/fish/functions

    # ~/.claude is personal; claude-work selects ~/.claude-work.
    # Link config children so each profile keeps its own sessions and history.
    mkdir -p ~/.claude ~/.claude-work
    for profile in .claude .claude-work; do
        create_symlink  ~/dotfiles-private/$profile/settings.json ~/$profile/settings.json
        create_symlink  ~/dotfiles-private/$profile/statusline.sh ~/$profile/statusline.sh
        replace_symlink ~/dotfiles-private/$profile/themes ~/$profile/themes
        # Both profiles share these directories, owned by dotfiles-private.
        for shared in skills agents memories output-styles; do
            replace_symlink ~/dotfiles-private/$shared ~/$profile/$shared
        done
    done
else
    echo "No ~/dotfiles-private — skipping private config."
fi

echo "Symlink creation completed."
