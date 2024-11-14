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
mkdir -p ~/.config/fish
create_symlink ~/dotfiles/config.fish ~/.config/fish/config.fish
create_symlink ~/dotfiles/karabiner ~/.config
create_symlink ~/dotfiles/amethyst ~/.config

# Private dotfiles
create_symlink ~/Documents/dotfiles_private ~/dotfiles_private
create_symlink ~/Documents/dotfiles_private/.profile ~/.profile
create_symlink ~/Documents/dotfiles_private/bin ~/bin

echo "Symlink creation completed."
