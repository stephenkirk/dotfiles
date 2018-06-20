# Lazy dotfile syncing until I can get something going that might not accidentally blow up my computer

# Symlink all dotfiles
ln -s ~/dotfiles/.* ~/
rm -rf ~/.git # Remove accidental git folder committing

# Symlink VS Code bindings
ln -s "~/dotfiles/vscode_settings.json" "~/Library/Application Support/Code/User/settings.json"
ln -s "~/dotfiles/vscode_keybindings.json" "~/Library/Application Support/Code/User/keybindings.json"
