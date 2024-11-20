create_symlink() {
    local source=$1
    local target=$2
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

# Config files in .config directory
mkdir -p ~/.config/
mkdir -p ~/.config/fish

create_symlink ~/dotfiles/.config/config.fish ~/.config/fish/config.fish
create_symlink ~/dotfiles/.config/karabiner ~/.config/karabiner
create_symlink ~/dotfiles/.config/amethyst ~/.config/amethyst
create_symlink ~/dotfiles/.config/linearmouse ~/.config/linearmouse

create_symlink ~/dotfiles/.config/zed/keymap.json ~/.config/zed/keymap.json
create_symlink ~/dotfiles/.config/zed/settings.json ~/.config/zed/settings.json

# Private dotfiles
create_symlink ~/Documents/dotfiles_private ~/dotfiles_private
create_symlink ~/Documents/dotfiles_private/.profile ~/.profile
create_symlink ~/Documents/dotfiles_private/bin ~/bin

echo "Symlink creation completed."
